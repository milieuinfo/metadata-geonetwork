//=============================================================================
//===	Copyright (C) 2001-2007 Food and Agriculture Organization of the
//===	United Nations (FAO-UN), United Nations World Food Programme (WFP)
//===	and United Nations Environment Programme (UNEP)
//===
//===	This program is free software; you can redistribute it and/or modify
//===	it under the terms of the GNU General Public License as published by
//===	the Free Software Foundation; either version 2 of the License, or (at
//===	your option) any later version.
//===
//===	This program is distributed in the hope that it will be useful, but
//===	WITHOUT ANY WARRANTY; without even the implied warranty of
//===	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
//===	General Public License for more details.
//===
//===	You should have received a copy of the GNU General Public License
//===	along with this program; if not, write to the Free Software
//===	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
//===
//===	Contact: Jeroen Ticheler - FAO - Viale delle Terme di Caracalla 2,
//===	Rome - Italy. email: geonetwork@osgeo.org
//==============================================================================

package org.fao.geonet.api.records;

import com.google.common.util.concurrent.ListeningExecutorService;
import com.google.common.util.concurrent.MoreExecutors;
import jeeves.server.context.ServiceContext;
import org.apache.commons.lang.StringUtils;
import org.fao.geonet.api.records.editing.InspireValidatorUtils;
import org.fao.geonet.domain.Metadata;
import org.fao.geonet.kernel.SchemaManager;
import org.fao.geonet.kernel.datamanager.IMetadataValidator;
import org.fao.geonet.kernel.setting.Settings;
import org.fao.geonet.repository.HarvestHistoryRepository;
import org.fao.geonet.repository.MetadataDraftRepository;
import org.fao.geonet.repository.MetadataValidationRepository;
import org.fao.geonet.schema.iso19139.ISO19139SchemaPlugin;
import org.fao.geonet.utils.Xml;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.output.XMLOutputter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.logging.LogLevel;
import org.springframework.context.ApplicationEvent;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.event.TransactionPhase;
import org.springframework.transaction.event.TransactionalEventListener;

import javax.xml.transform.TransformerFactoryConfigurationError;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.time.Duration;
import java.time.Instant;
import java.util.List;
import java.util.concurrent.CompletableFuture;

public class InspireValidationTask extends ValidationTask {

    /**
     * An XSLT process defined on a per-schema basis.
     * If the file is not found, no process applied.
     */
    private String xsltPostProcess;

    @Autowired
    MetadataDraftRepository metadataDraftRepository;

    @Autowired
    IMetadataValidator metadataValidator;

    @Autowired
    MetadataValidationRepository validationRepository;

    @Autowired
    HarvestHistoryRepository historyRepository;

    @Autowired
    InspireValidatorUtils inspireValidatorUtils;

    @Autowired
    SchemaManager schemaManager;

    public InspireValidationTask() {
    }

    public static class Event extends ApplicationEvent {

        private final int metadataId;

        public Event(Object source, int metadataId) {
            super(source);
            this.metadataId = metadataId;
        }

        public int getMetadataId() {
            return metadataId;
        }
    }

    @EventListener
    @Async
    @TransactionalEventListener(
        phase = TransactionPhase.AFTER_COMMIT,
        fallbackExecution = true)
    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public void apply(Event event) {
        Metadata metadata = metadataRepository.findOneById(event.metadataId);
        if(metadata!=null) {
            runInspireValidation(metadata);
            try {
                metadataIndexer.indexMetadata(List.of(String.valueOf(metadata.getId())));
            } catch (Exception e) {
                log(LogLevel.DEBUG, "{} / Error while indexing record: {}",
                    metadata.getUuid(), e.getMessage());
            }
            if (StringUtils.isNotEmpty(xsltPostProcess)) {
                applyXsltProcess(metadata);
            }
        }
    }

    private void runInspireValidation(Metadata metadata) {
        Instant start = Instant.now();

        log(LogLevel.DEBUG, "{} / INSPIRE validation started.",
            metadata.getUuid());

        String inspireValidatorUrl = settingManager.getValue(Settings.SYSTEM_INSPIRE_REMOTE_VALIDATION_URL);
        String inspireValidatorCheckUrl = settingManager.getValue(Settings.SYSTEM_INSPIRE_REMOTE_VALIDATION_URL_QUERY);
        if (StringUtils.isEmpty(inspireValidatorUrl)) {
            log(LogLevel.ERROR, "INSPIRE validator URL is missing. Configure it in the admin console or disable INSPIRE validation.");
            return;
        }

        if (StringUtils.isEmpty(inspireValidatorCheckUrl)) {
            inspireValidatorCheckUrl = inspireValidatorUrl;
        }

        try {
            Element xml = metadata.getXmlData(false);
            boolean isService = Xml.selectBoolean(xml,
                "gmd:hierarchyLevel/gmd:MD_ScopeCode/@codeListValue = 'service'",
                ISO19139SchemaPlugin.allNamespaces.asList());
            // TODO: Should this be configurable?
            String testsuite = isService
                ? "TG version 2.0 - Network services"
                : "TG version 2.0 - Data sets and series";

            InputStream metadataToTest = convertElement2InputStream(xml);

            ServiceContext context = ServiceContext.get();
            String testId = inspireValidatorUtils.submitFile(context, inspireValidatorUrl, inspireValidatorCheckUrl, metadataToTest, testsuite, metadata.getUuid());
            InspireValidationRunnable inspireValidationRunnable =
                new InspireValidationRunnable(context, inspireValidatorUrl, testId, metadata.getId());

            ListeningExecutorService executor = MoreExecutors.newDirectExecutorService();
            CompletableFuture.runAsync(inspireValidationRunnable, executor)
                .exceptionally((e) -> {
                    log(LogLevel.ERROR, "{} / INSPIRE validation {} exception ({}) in {}s.",
                        metadata.getUuid(), testsuite, e.getMessage(),
                        Duration.between(start, Instant.now()).toSeconds());
                    return null;
                })
                .thenRun(() -> log(LogLevel.DEBUG, "{} / INSPIRE validation {} done in {}s.",
                    metadata.getUuid(), testsuite,
                    Duration.between(start, Instant.now()).toSeconds()));
        } catch (Exception e) {
            log(LogLevel.DEBUG, "{} / INSPIRE validation error: {}",
                metadata.getUuid(), e.getMessage());
        }
    }

    private InputStream convertElement2InputStream(Element md)
        throws TransformerFactoryConfigurationError {
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        XMLOutputter xmlOutput = new XMLOutputter();
        try {
            xmlOutput.output(new Document(md), outputStream);
        } catch (IOException e) {
            log(LogLevel.ERROR, "Error in conversion of XML document to stream.", e);
        }
        return new ByteArrayInputStream(outputStream.toByteArray());
    }
}

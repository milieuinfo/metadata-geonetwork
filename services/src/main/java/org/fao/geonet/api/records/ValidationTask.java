package org.fao.geonet.api.records;

import org.fao.geonet.domain.Metadata;
import org.fao.geonet.kernel.SchemaManager;
import org.fao.geonet.kernel.datamanager.IMetadataIndexer;
import org.fao.geonet.kernel.setting.SettingManager;
import org.fao.geonet.repository.MetadataRepository;
import org.fao.geonet.utils.Xml;
import org.jdom.Element;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.logging.LogLevel;

import java.nio.file.Files;
import java.nio.file.Path;

abstract public class ValidationTask {

    @Autowired
    SchemaManager schemaManager;

    @Autowired
    MetadataRepository metadataRepository;

    @Autowired
    IMetadataIndexer metadataIndexer;

    @Autowired
    SettingManager settingManager;

    protected static org.slf4j.Logger logger = LoggerFactory.getLogger("geonetwork.tasks");

    /**
     * An XSLT process defined on a per-schema basis.
     * If the file is not found, no process applied.
     */
    protected String xsltPostProcess;

    protected void applyXsltProcess(Metadata metadata) {
        Path xslt = schemaManager.getSchemaDir(metadata.getDataInfo().getSchemaId())
            .resolve("process")
            .resolve(xsltPostProcess);

        if (Files.exists(xslt)) {
            try {
                log(LogLevel.DEBUG, "{} / Applying process {}",
                    metadata.getUuid(), xsltPostProcess);
                Element initial = metadata.getXmlData(false);
                Element transformed = Xml.transform(metadata.getXmlData(false), xslt);
                boolean changed = !transformed.equals(initial);
                if (changed) {
                    metadataRepository.update(metadata.getId(), entity -> entity.setDataAndFixCR(transformed));
                }
            } catch (Exception e) {
                log(LogLevel.DEBUG, "{} / Error while process {}: {}",
                    metadata.getUuid(), xsltPostProcess, e.getMessage());
            }
        }
    }

    protected void log(LogLevel logLevel, String message, Object... objects) {
        if(logLevel == LogLevel.DEBUG) {
            logger.debug(this.getClass().getSimpleName() + " / " + message, objects);
        } else if(logLevel == LogLevel.ERROR) {
            logger.error(this.getClass().getSimpleName() + " / " + message, objects);
        } else if(logLevel == LogLevel.INFO) {
            logger.info(this.getClass().getSimpleName() + " / " + message, objects);
        } else if(logLevel == LogLevel.WARN) {
            logger.warn(this.getClass().getSimpleName() + " / " + message, objects);
        } else {
            logger.error(this.getClass().getSimpleName() + " / could not process logLevel {}, outputting in debug instead.", logLevel);
            logger.debug(this.getClass().getSimpleName() + " / " + message, objects);
        }
    }
}

package be.vlaanderen.geonet.kernel.validation;

import org.fao.geonet.domain.AbstractMetadata;
import org.fao.geonet.domain.MetadataDraft;
import org.fao.geonet.domain.Pair;
import org.fao.geonet.kernel.DataManager;
import org.fao.geonet.repository.MetadataDraftRepository;
import org.fao.geonet.repository.MetadataRepository;
import org.fao.geonet.repository.MetadataValidationRepository;
import org.fao.geonet.utils.Xml;
import org.jdom.Element;
import org.springframework.beans.factory.annotation.Autowired;

import java.nio.file.Path;
import java.util.Map;

/**
 * Records validation result inside the metadata itself.
 * <p>
 * NOTE: the valTypeAndStatus map contains the validation summary, same as it is saved to the DB. Its structure is:
 * <p>
 * key : string. Name of validation type. E.g. "xsd", "schematron-rules-iso", "schematron-rules-inspire"
 * value: array of 3 integers where
 * value[0] : can be 1 or 0, meaning validation succeeded (1) or failed (0).
 * value[1] : only applicable to schematron validation types. Total number of asserts in this validation.
 * value[2] : only applicable to schematron validation types. Number of failed asserts in this validation.
 *
 * @author heikki doeleman
 */
public class VlaanderenPostValidationProcess {
    @Autowired
    private DataManager dm;

    @Autowired
    MetadataDraftRepository metadataDraftRepository;

    @Autowired
    MetadataRepository metadataRepository;

    @Autowired
    MetadataValidationRepository metadataValidationRepository;

    private static final String AFTER_VALIDATION_XSLT = "after-validation-process.xsl";

    /**
     * Invoked when validation has finished.
     *
     * @param metadata the record
     * @param save when true, persists the record
     * @return Pair containing a boolean (true if the metadata has changed, false otherwise) and the changed metadata
     * @throws ValidationHookException when any Exception occurs during the addition of the conform keywords
     */
    public Pair<Boolean, AbstractMetadata> addConformKeywords(AbstractMetadata metadata, boolean save) throws ValidationHookException {
        try {
            Pair<Boolean, Element> result = addConformKeywordsToElement(
                metadata.getXmlData(false),
                metadata.getDataInfo().getSchemaId(),
                metadata.getId()
            );

            if (result.one()) {
                if (save) {
                    if (metadata instanceof MetadataDraft) {
                        metadata = metadataDraftRepository.update(metadata.getId(), entity -> entity.setDataAndFixCR(result.two()));
                    } else {
                        metadata = metadataRepository.update(metadata.getId(), entity -> entity.setDataAndFixCR(result.two()));
                    }
                } else {
                    metadata.setDataAndFixCR(result.two());
                }
            }
            return Pair.read(result.one(), metadata);
        } catch (Exception x) {
            throw new ValidationHookException(x.getMessage(), x);
        }
    }

    /**
     * Invoked when validation has finished.
     *
     * @param metadataId id of the record
     * @param save when true, persists the record
     * @return Pair containing a boolean (true if the metadata has changed, false otherwise) and the changed metadata
     * @throws ValidationHookException when any Exception occurs during the addition of the conform keywords
     */
    public Pair<Boolean, AbstractMetadata> addConformKeywords(String metadataId, boolean save) throws ValidationHookException {
        return addConformKeywords(metadataRepository.findOneById(
                    Integer.parseInt(metadataId)), save);
    }


    public Pair<Boolean, Element> addConformKeywordsToElement(Element mdElement, String schema, int mdId) throws ValidationHookException {
        try {
            Element mdTemp = mdElement;

            mdElement = updateKeywordsBasedOnValidationStatus(mdElement, schema, mdId);

            boolean changed = !mdElement.equals(mdTemp);

            return Pair.read(changed, mdElement);
        } catch (Exception e) {
            throw new ValidationHookException(e.getMessage(), e);
        }
    }
    private Element updateKeywordsBasedOnValidationStatus(Element metadata, String schema, Integer mdId) throws Exception {
        return transformMd(metadata, schema, AFTER_VALIDATION_XSLT, mdId);
    }

    private Element transformMd(Element md, String schema, String styleSheet, Integer mdId) throws Exception {
        Path xslt = dm.getSchemaDir(schema).resolve("process").resolve(styleSheet);
        return Xml.transform(md, xslt, Map.of("mdId", mdId));
    }

}

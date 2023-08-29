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
     * Invoked when validation has finished. The arguments should be :
     * - the metadata
     * - a boolean if needs to update the database from within this function
     * @param metadata
     * @param save
     * @return Pair containing a boolean (true if the metadata has changed, false otherwise) and the changed metadata
     * @throws ValidationHookException hmm
     */
    public Pair<Boolean, AbstractMetadata> addConformKeywords(AbstractMetadata metadata, boolean save) throws ValidationHookException {
        try {
            Pair result = addConformKeywordsToElement(
                metadata.getXmlData(false),
                metadata.getDataInfo().getSchemaId(),
                metadata.getId()
            );

            if ((Boolean) result.one()) {
                if (save) {
                    if (metadata instanceof MetadataDraft) {
                        metadata = metadataDraftRepository.update(metadata.getId(), entity -> entity.setDataAndFixCR((Element) result.two()));
                    } else {
                        metadata = metadataRepository.update(metadata.getId(), entity -> entity.setDataAndFixCR((Element) result.two()));
                    }
                } else {
                    metadata.setDataAndFixCR((Element) result.two());
                }
            }
            return Pair.read((Boolean) result.one(), metadata);
        } catch (Exception x) {
            throw new ValidationHookException(x.getMessage(), x);
        }
    }

    /**
     * Invoked when validation has finished. The arguments should be :
     * - the metadata ID
     * - a boolean if needs to update the database from within this function
     * @param metadataId
     * @param save
     * @return Pair containing a boolean (true if the metadata has changed, false otherwise) and the changed metadata
     * @throws ValidationHookException hmm
     */
    public Pair<Boolean, AbstractMetadata> addConformKeywords(String metadataId, boolean save) throws ValidationHookException {
        return addConformKeywords(metadataRepository.findOneById(
                    Integer.parseInt(metadataId)), save);
    }


    public Pair<Boolean, Element> addConformKeywordsToElement(Element mdElement, String schema, int mdId) throws ValidationHookException {
        try {
            Element mdTemp = mdElement;

            mdElement = updateKeywordsBasedOnValidationStatus(mdElement, schema);

            boolean changed = !mdElement.equals(mdTemp);

            return Pair.read(changed, mdElement);
        } catch (Exception e) {
            throw new ValidationHookException(e.getMessage(), e);
        }
    }
    private Element updateKeywordsBasedOnValidationStatus(Element metadata, String schema) throws Exception {
        return transformMd(metadata, schema, AFTER_VALIDATION_XSLT);
    }

    private Element transformMd(Element md, String schema, String styleSheet) throws Exception {
        Path xslt = dm.getSchemaDir(schema).resolve("process").resolve(styleSheet);
        return Xml.transform(md, xslt);
    }

}

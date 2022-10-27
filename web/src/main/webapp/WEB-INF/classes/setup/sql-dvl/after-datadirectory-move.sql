
UPDATE metadata SET data = replace(data,
                                   '&amp;fname=',
                                   '/attachments/')
WHERE data LIKE '%&amp;fname=%' AND isharvested = 'n';

UPDATE metadata SET data = replace(data,
                                   '>https://dev.metadata.vlaanderen.be/srv/dut/resources.get?uuid=',
                                   '>https://dev.metadata.vlaanderen.be/srv/api/records/')
WHERE data LIKE '%>https://dev.metadata.vlaanderen.be/srv/dut/resources.get?uuid=%' AND isharvested = 'n';

UPDATE metadata SET data = replace(data,
                                   '>https://dev.metadata.vlaanderen.be/metadatacenter/srv/dut/resources.get?uuid=',
                                   '>https://dev.metadata.vlaanderen.be/metadatacenter/srv/api/records/')
WHERE data LIKE '%>https://dev.metadata.vlaanderen.be/metadatacenter/srv/dut/resources.get?uuid=%' AND isharvested = 'n';


UPDATE metadata SET data = replace(data,
                                   '>https://metadata.vlaanderen.be/srv/dut/resources.get?uuid=',
                                   '>https://metadata.vlaanderen.be/srv/api/records/')
WHERE data LIKE '%>https://metadata.vlaanderen.be/srv/dut/resources.get?uuid=%' AND isharvested = 'n';

UPDATE metadata SET data = replace(data,
                                   '>https://metadata.vlaanderen.be/metadatacenter/srv/dut/resources.get?uuid=',
                                   '>https://metadata.vlaanderen.be/metadatacenter/srv/api/records/')
WHERE data LIKE '%>https://metadata.vlaanderen.be/metadatacenter/srv/dut/resources.get?uuid=%' AND isharvested = 'n';



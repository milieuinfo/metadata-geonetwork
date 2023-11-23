# Migration Geonetwork 3 to Geonetwork 4

The following actions need to be taken when migrating to Geonetwork 4.

## languageCode codeList

Make sure the languageCode is defined by the right codeList. [Related PR](https://agiv.visualstudio.com/Metadata/_workitems/edit/178751/).

Database updates:
```sql
update metadata set
  data = replace(data, '<gmd:LanguageCode codeListValue="dut" codeList="http://standards.iso.org/iso/19139/resources/gmxCodelists.xml#LanguageCode">Nederlands</gmd:LanguageCode>', '<gmd:LanguageCode codeList="https://www.loc.gov/standards/iso639-2/" codeListValue="dut">Nederlands</gmd:LanguageCode>')
where data like '%<gmd:LanguageCode codeListValue="dut" codeList="http://standards.iso.org/iso/19139/resources/gmxCodelists.xml#LanguageCode">Nederlands</gmd:LanguageCode>%';
update metadata set
  data = replace(data, '<gmd:LanguageCode codeListValue="dut" codeList="http://standards.iso.org/iso/19139/resources/gmxCodelists.xml#LanguageCode">Nederlands; Vlaams</gmd:LanguageCode>', '<gmd:LanguageCode codeList="https://www.loc.gov/standards/iso639-2/" codeListValue="dut">Nederlands; Vlaams</gmd:LanguageCode>')
where data like '%<gmd:LanguageCode codeListValue="dut" codeList="http://standards.iso.org/iso/19139/resources/gmxCodelists.xml#LanguageCode">Nederlands; Vlaams</gmd:LanguageCode>%';

-- check other faulty occurrences?
select * from metadata where data like '%codeList="http://standards.iso.org/iso/19139/resources/gmxCodelists.xml#LanguageCode"%';
```

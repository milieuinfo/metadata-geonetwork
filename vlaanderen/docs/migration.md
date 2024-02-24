# Migration Geonetwork 3 to Geonetwork 4

See the [migration sql file](./assets/gn3-migration.sql) for details of the migration. There, a step-by-step description
is made of the whole
process.

Below, an overview is given of the steps and other necessities.

# Tools needed for the migration

- DBeaver
- kubectl

# Migration steps

Data are copied to `migration` schemas. This way, mdc and mdv original data is always available in the new database.
These data are used for the migration process itself, but can later also be referenced to check for potential errors.

## Groups

Groups are mapped from mdc and mdv to a fresh table. Each group gets a new id, and is looked up in the geosecure
table to enrich it with ovo code etc. The original id is stored in `mdcid` and `mdvid`. New group ids start from 100.

For each group, create a new DataPublicatie variant of the group. Based on the CSV document attached to the
ticket [#186360](https://agiv.visualstudio.com/Metadata/_workitems/edit/186360), assign each metadata to the correct
group variant.

## Users

Users are migrated in a similar fashion. They are precreated so they can be allocated to the right records and
groups. The original id of a user can be retrieved based on their email and the original `emails` table. Multiple
users with the same email address are present in GN3. Since we now rely on the mail address to map users
together from old to new, these users will be merged in the process. Technical users's ID is re-generated based on an
incrementing number starting from 100.

With ACM/IDM, users are identified based on their email address (to be later modified for stable ID ideally provided by
ACM/IDM).  
Create a `migrations.users` tables with an added `mdvid` and `mdcid` column.  
Based on email address, merged users from MDC & MDV and insert them with their corresponding ID into
the `migration.users` tables, making sure the username is modified to now be the email address.  
Users with no metadata owned are skipped for the sake of reducing eventual manual fix as much as possible, they should
be recreated automatically at first login.

## Metadata

Create a `migration.metadata` table and insert all metadata from both environments filtering out the harvested and
template records.  
Metadata `owner` and `groupowner` are mapped to their corresponding new ID's.
At this stage, all metadata are assigned to the "DV" group. We don't have a split just yet.

For the status, since GN3 MDV & GN3 MDC and GN4 all uses a different set of workflow status, we must map every old
status to new ones.  
To simplify the process, only 3 possible mapping will be possible:

- All status before the "approved and published" should be set to "draft" and non-public
- The "approved and published" and all submission or rejection for status changes is mapped to "approved and published"
  and the record is published
- The "un-published" records are mapped to "un-published" and are non-public

## Upload the migrated data

Now, the `migration` schema tables are converted into the actual geonetwork tables. The SQL script copies various
tables,
cross-matching mdc and mdv original tables.

### Thumbnails

Updating the metadata XML content is performed in two steps. See `MetadataDbOps` and the `186360-x` tasks where
script-based actions are executed.

1. the `metadata_data` folders of both `mdc` and `mdv` (gn3) environments are merged into one
2. the metadata is updated to point to the right hostname
3. the `metadata_thumbs` static folders are converted into actual gn4 attachments

# Post processing steps

Various fixes are performed to clean up the data, ranging from erroneous references to codelist to urls that do not
function properly in GeoNetwork4 anymore. See script for details.

# Identified issues

Also see issue https://agiv.visualstudio.com/Metadata/_workitems/edit/187226.

## Broken resources.get attachments url

Links to thumbnail urls that were functional in GN3 might not be functional anymore in GN4. Examples are shown below,
fixes should have been deployed during the migration process.

Examples:

- https://metadata.vlaanderen.be/srv/dut/resources.get?uuid=288be5c6-d70d-45d3-a31d-265c86cc9202/attachments/VHA_zones_metadata_1406814837398.jpg

Instead, the intended format should be:

- https://metadata.dev-vlaanderen.be/srv/api/records/288be5c6-d70d-45d3-a31d-265c86cc9202/attachments/VHA_zones_metadata_1406814837398.jpg

## Keyword rdf reference

old: https://metadata.vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden/KOSTELOOS
broken: https://metadata.dev-vlaanderen.be/id/GDI-Vlaanderen-Trefwoorden/KOSTELOOS

to be solved

## broken attachment

https://metadata.vlaanderen.be/srv/api/records/1ECA5D6F-1D62-4A4D-A7F4-46615DEAD10D/attachments/BE3VLBNK.png
file is present, but cannot be displayed?
https://metadata.dev-vlaanderen.be/srv/api/records/1ECA5D6F-1D62-4A4D-A7F4-46615DEAD10D/attachments/BE3VLBNK.png

https://metadata.vlaanderen.be/srv/api/records/2c70e1cf-48e3-458f-b213-09dcba89e5a9/attachments/voorbeeldweergave_pluviaal.jpg
https://metadata.dev-vlaanderen.be/srv/api/records/2c70e1cf-48e3-458f-b213-09dcba89e5a9/attachments/voorbeeldweergave_pluviaal.jpg

## originally broken links

not functioning in prod either
https://metadata.vlaanderen.be/srv/dut/resources.get?uuid=33ced40c-973f-4395-941b-39e89f0ecf0b&amp;fname=Brownfieldconvenanten_1486135916908.JPG
got to migrate to another format:
https://metadata.dev-vlaanderen.be/srv/api/records/33ced40c-973f-4395-941b-39e89f0ecf0b/attachments/Brownfieldconvenanten_1486135916908.JPG

## another broken type

https://metadata.vlaanderen.be/srv/dut/resources.get?uuid=288be5c6-d70d-45d3-a31d-265c86cc9202/attachments/VHA_zones_metadata_1406814837398.jpg

## metadatacenter references

### csw

https://metadata.vlaanderen.be/metadatacenter/srv/dut/csw?service=CSW&amp;request=GetRecordById&amp;version=2.0.2&amp;outputSchema=http://www.isotc211.org/2005/gmd&amp;elementSetName=full&amp;id=2B178D0C-7898-47B9-B134-29AC8C268287
https://metadata.dev-vlaanderen.be/srv/dut/csw?service=CSW&amp;request=GetRecordById&amp;version=2.0.2&amp;outputSchema=http://www.isotc211.org/2005/gmd&amp;elementSetName=full&amp;id=2B178D0C-7898-47B9-B134-29AC8C268287

```xml

<ows:ExceptionReport version="1.2.0"
                     xsi:schemaLocation="http://www.opengis.net/ows http://schemas.opengis.net/ows/1.0.0/owsExceptionReport.xsd">
  <ows:Exception exceptionCode="NoApplicableCode">
    <ows:ExceptionText>
      org.fao.geonet.csw.common.exceptions.InvalidParameterValueEx: code=InvalidParameterValue, locator=OutputSchema,
      message=OutputSchema 'gmd' not supported for metadata with '849' (iso19110). Corresponding XSL transformation
      'gmd-full.xsl' does not exist for this schema. The record will not be returned in response.
    </ows:ExceptionText>
  </ows:Exception>
</ows:ExceptionReport>
```

> That one make sense, we are trying to export a iso19110 metadata by casting it into a iso19139 metadata.
> We likely need to set the output format to the namespace "xmlns:gfc="http://standards.iso.org/iso/19110/gfc/1.1"" for
> feature catalogs.

### thesaurus

https://metadata.vlaanderen.be/metadatacenter/srv/eng/thesaurus.download?ref=external.theme.gemet
https://metadata.dev-vlaanderen.be/srv/eng/thesaurus.download?ref=external.theme.gemet

```json
{
  "error": {
    "message": "Service not found",
    "class": "ServiceNotFoundEx",
    "request": {}
  }
} 
```

Should be:
https://metadata.dev-vlaanderen.be/srv/api/registries/vocabularies/external.theme.GDI-Vlaanderen-trefwoorden
Instead of
https://metadata.dev-vlaanderen.be/srv/eng/thesaurus.download?ref=external.theme.GDI-Vlaanderen-trefwoorden

### metadata url

https://metadata.vlaanderen.be/metadatacenter/srv/dut/catalog.search#/metadata/54877caf-3024-42b6-ad98-91d8434b9cda
this could be just replaced with the right url
https://metadata.dev-vlaanderen.be/srv/dut/catalog.search#/metadata/b8e76bbd-8fa0-4804-a3a2-8cdeeed88896

### thumbnail with old syntax, but real &

https://metadata.dev-vlaanderen.be/srv/dut/resources.get?uuid=33ced40c-973f-4395-941b-39e89f0ecf0b&fname=Brownfieldconvenanten_1486135916908.JPG
https://metadata.dev-vlaanderen.be/srv/api/records/33ced40c-973f-4395-941b-39e89f0ecf0b/attachments/Brownfieldconvenanten_1486135916908.JPG
fixed in script




# Differences between gn3 and gn4

## pdf export links
https://metadata.beta-vlaanderen.be/srv/api/records/72848a38-5db1-4705-8fb2-74e8353b1186/formatters/xsl-view-default?output=pdf&language=dut&approved=true
becomes
https://metadata.beta-vlaanderen.be/srv/api/records/72848a38-5db1-4705-8fb2-74e8353b1186/formatters/xsl-view?output=pdf&language=dut&approved=true

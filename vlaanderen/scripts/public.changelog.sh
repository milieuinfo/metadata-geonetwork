#!/bin/bash
changesetFolder=../../liquibase/changesets
tempMdFile=/tmp/public.changelog.md
changelogFile=../CHANGELOG.md
publicChangeLogFile=$changesetFolder/public.changelog.html

# test we have the prerequisite binaries available
if ! command -v pandoc &> /dev/null
then
    echo "pandoc could not be found"
    exit 1
fi
if ! command -v sed &> /dev/null
then
    echo "sed could not be found"
    exit 1
fi

# prepare the changelog file, put it in the liquibase changesets folder so it can be picked up
sed -E 's/\s*\-\s*\[pr.*//g' $changelogFile > $tempMdFile
pandoc $tempMdFile -o $publicChangeLogFile --metadata title="Changelog Metadata Vlaanderen"

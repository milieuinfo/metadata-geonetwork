#!/bin/bash
sed -E 's/\s*\-\s*\[pr.*//g' ../CHANGELOG.md > /tmp/public.changelog.md
pandoc /tmp/public.changelog.md -o /tmp/public.changelog.html --metadata title="Changelog Metadata Vlaanderen"

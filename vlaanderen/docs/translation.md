# Translation
Translating Geonetwork happens through Transifex and additional local customisations.

# Translation Workflow
Below, the workflow of translating Geonetwork is described.

1. Execute the script `download-from-transifex-vl.sh`
  - This updates the relevant `nl-x.json` files
2. Check the files and modifications for missing values or undesired changes
  - If changes are still required, perform them on [transifex](https://www.transifex.com/)
  - Go back to `1.`
3. Commit the changes to the repo, building a new version of Geonetwork, to be deployed

# Transifex
After getting an account on Transifex and access to the project, the relevant pages are available:
- [core-geonetwork project](https://app.transifex.com/geonetwork/core-geonetwork)
- [nl_BE language](https://app.transifex.com/geonetwork/core-geonetwork/language/nl_BE/)

Filter on category `Angular_UI` to get access to the most used files:
- `nl-v4.json` - Angular UI - version 4 Strings 
- `nl-admin.json` - Angular UI Admin Strings
- `nl-core.json` - Angular UI Core Strings
- `nl-editor.json` - Angular UI Editor Strings
- `nl-search.json` - Angular UI Search

Click one of them, then the button `Translate`. This provides an overview of all available (un)translated strings. 

Multiple filters are present on this page, e.g.,
- filter on translated / untranslated strings using `status`
- search for a Dutch text with the following filter: `translation_text:'tekst'` 

After clicking one string, provide a translation in the input text field. Click `Save Changes` to persist the translation.

Suggestions are also provided, often from the `nl` (not to be confused with `nl_BE`) language. They can be easily used by clicking the 'copy' button. After setting the text, click `Save Changes` to persist the translation.

# Tools
A [git hook](./githooks.md) is provided to automatically pull the latest translations to this repository when checking out a feature branch. After checkout, the relevant files are modified and to be checked for correctness.



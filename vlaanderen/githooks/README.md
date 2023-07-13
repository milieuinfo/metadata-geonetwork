# Githooks

This folder contains .git/hooks that can be enabled locally by executing the following (in the main folder):

```bash
git config --local core.hooksPath vlaanderen/githooks/
```

To be enabled / disabled at your own discretion, but helps keeping track of things.

## post-checkout

Currently, the post-checkout hook will trigger whenever a new branch is created. This executes the `download-from-transifex-vl.sh` script automatically, updating the localisation files.

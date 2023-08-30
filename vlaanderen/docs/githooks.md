# Githooks

To be enabled / disabled at your own discretion, but helps keeping track of things and makes sure transifex is pulled 
once every so often.


# Setup

## Custom folder

This folder contains .git/hooks that can be enabled locally by executing the following (in the main folder).

```bash
git config --local core.hooksPath vlaanderen/githooks/
```

Drawback is that every time git syncs the folder, execute permissions are lost.

## Default folder

You can also use the default hooks folder, located in `.git/hooks`. Copy the relevant file there and make sure the 
permissions are set correctly.

```bash
cp vlaanderen/githooks/post-checkout .git/hooks/
chmod u+x .git/hooks/post-checkout
```


# The hooks

## post-checkout

Currently, the post-checkout hook will trigger whenever a new branch is created. This executes the `download-from-transifex-vl.sh` script automatically, updating the localisation files.

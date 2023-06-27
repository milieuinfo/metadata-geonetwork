#!/bin/bash
STR='some message containing skipci'
SUB='skipci'
echo "STR: $STR"
echo "SUB: $SUB"
if [[ "$STR" == *"$SUB"* ]]; then
  echo "Skipping pipeline, 'skipci' was found in the commit message."
  exit 1
fi
exit 0

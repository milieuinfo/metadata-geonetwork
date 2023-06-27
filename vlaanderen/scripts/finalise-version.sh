#!/bin/bash
# get user input
usage="$(basename "$0") [-h] [-b bump]
--------------------------------------------------
Bump the version and create the necessary commits.
This can be run from a SNAPSHOT version. In that case, it will remove the SNAPSHOT and produce a 'finalisation' commit.
Afterwards, it bumps the version and produces a 'starting' commit for the new SNAPSHOT version.

where:
    -h  show this help text
    -b  the desired bump (major, minor, patch)"
while getopts ':hb:' option; do
  case "$option" in
    h) echo "$usage"
       exit
       ;;
    b) bump=$OPTARG
       ;;
    :) printf "missing argument for -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
   \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
  esac
done
shift $((OPTIND - 1))

# where the pomfile lives
pomfile=../pom.xml
# what remote we push to
remote=origin

# check bump validity
valid_bumps=("major" "minor" "patch")
if { [[ ! "major" = ${bump} ]] && [[ ! "minor" = ${bump} ]] && [[ ! "patch" = ${bump} ]]; }; then
  echo "bump type should be either one of: ${valid_bumps[*]}"
  exit 1
fi
echo "Bump type: $bump"

# current branch
current_branch=$(git rev-parse --abbrev-ref HEAD)

# current version
current_version=$(mvn -f $pomfile help:evaluate -Dexpression=project.version -q -DforceStdout)
echo "Current version: $current_version"

# first step: finalise if we are on a snapshot
branch1=""
if [[ $current_version == *-SNAPSHOT ]]; then
  echo "We are on a snapshot."
  mvn -f $pomfile validate -Dremove-snapshot -DgenerateBackupPoms=false -q
  new_version=$(mvn -f $pomfile help:evaluate -Dexpression=project.version -q -DforceStdout)

  # switch to the 'finalise' branch and commit the pom with the new version set
  branch="feature/finalise-$new_version"
  echo "Created local branch $branch"
  git checkout -b "$branch"
  git add $pomfile
  git commit -m "Finalising $new_version"
  git push --set-upstream $remote "$branch"

  # go back to the original branch
  git checkout "$current_branch"
  # cleanup
  git branch -D "$branch"
fi

# second step: bump the version as desired
mvn -f $pomfile validate -D "bump-$bump" -q
mvn -f $pomfile validate -D "add-snapshot" -q
new_version=$(mvn -f $pomfile help:evaluate -Dexpression=project.version -q -DforceStdout)
branch="feature/started-$new_version"
echo "Created local branch $branch"
git checkout -b "$branch"
git add $pomfile
git commit -m "[skipci] Starting $new_version"
git push --set-upstream $remote "$branch"
git checkout "$current_branch"
# cleanup
git branch -D "$branch"

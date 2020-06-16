#!/bin/sh

WIKI="https://github.com/${GITHUB_REPOSITORY}.wiki.git"
WIKIP="https://${USERNAME}:${ACCESS_TOKEN}@github.com/${GITHUB_REPOSITORY}.wiki.git"

echo "Cloning WIKI Repo..."
git clone $WIKI /wiki
cd /wiki

echo "Cleaning..."
rm -r *

echo "Copy Files..."
cd /github/workspace
cp -a wiki/. /wiki

echo "Git Config..."
git config --global user.email "${USERNAME}@user.noreply.github.com"
git config --global user.name "${USERNAME}"

echo "Commit..."
if [[ -z ${COMMIT_MESSAGE} ]]; then
    echo "Commit Message not set"
else
    echo $COMMIT_MESSAGE
fi
cd /wiki
git add -A
git commit -m "Wiki Sync"
git push $WIKIP

echo "Finished!"
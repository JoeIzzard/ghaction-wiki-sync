#!/bin/sh

WIKI="https://github.com/${GITHUB_REPOSITORY}.wiki.git"
WIKIP="https://${USERNAME}:${ACCESS_TOKEN}@github.com/${GITHUB_REPOSITORY}.wiki.git"

echo "Cloning WIKI Repo..."
git clone $WIKI /wiki
cd /wiki

echo "Cleaning..."
rm -r *

echo "Workspace"
cd /github/workspace
cp -a wiki/. /wiki

cd /wiki
git add -A
git commit -m "Wiki Sync"
git push WIKIP 
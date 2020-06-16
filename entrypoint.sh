#!/bin/sh

WIKI="https://github.com/${GITHUB_REPOSITORY}.wiki.git"

echo "Cloning WIKI Repo..."
git clone $WIKI /wiki
cd /wiki

echo "Cleaning..."
rm -r *

echo "Copying new files"
cd /github
ls
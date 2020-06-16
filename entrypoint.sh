#!/bin/sh

WIKI="https://github.com/${GITHUB_REPOSITORY}.wiki.git"
WIKIP="https://${INPUT_USERNAME}:${INPUT_ACCESS_TOKEN}@github.com/${GITHUB_REPOSITORY}.wiki.git"

echo "Cloning WIKI Repo..."
git clone $WIKI /wiki
cd /wiki

echo "Cleaning..."
rm -r *

echo "Copy Files..."
cd /github/workspace
cp -a wiki/. /wiki

echo "Git Config..."
echo "-> User: ${INPUT_COMMIT_USERNAME}"
echo "-> Email: ${INPUT_COMMIT_EMAIL}"
git config --global user.email "${INPUT_COMMIT_EMAIL}"
git config --global user.name "${INPUT_COMMIT_USERNAME}"

echo "Commit..."
cd /wiki
git add -A
git commit -m "${INPUT_COMMIT_MESSAGE}"
git push $WIKIP

echo "Finished!"
#!/bin/sh

WIKI="https://github.com/${GITHUB_REPOSITORY}.wiki.git"
WIKIP="https://${INPUT_USERNAME}:${INPUT_ACCESS_TOKEN}@github.com/${GITHUB_REPOSITORY}.wiki.git"

echo "Cloning WIKI Repo..."
git clone $WIKI /wiki
cd /wiki

echo "Cleaning..."
rm -r *

echo "Copy Files..."
echo "-> Wiki Folder: ${INPUT_WIKI_FOLDER}"
cd /github/workspace

if [ ! -d "/github/workspace/${INPUT_WIKI_FOLDER}" ]; then
    echo "Specified Wiki Folder Missing"
    exit 1
fi
cp -a ${INPUT_WIKI_FOLDER}/. /wiki

if [ "${INPUT_IGNORE_SAFE_WARNINGS}" = "true" ]; then
    git config --global --add safe.directory /wiki
fi

echo "Git Config..."
echo "-> User: ${INPUT_COMMIT_USERNAME}"
echo "-> Email: ${INPUT_COMMIT_EMAIL}"
git config --global user.email "${INPUT_COMMIT_EMAIL}"
git config --global user.name "${INPUT_COMMIT_USERNAME}"

echo "Commit..."
echo "-> Message: ${INPUT_COMMIT_MESSAGE}"
cd /wiki
git add -A
git commit -m "${INPUT_COMMIT_MESSAGE}"
git push $WIKIP

echo "Finished!"

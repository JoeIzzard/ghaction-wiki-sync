#!/bin/sh

set -e
GITHUB_DOMAIN="$(echo "$GITHUB_SERVER_URL" | sed 's#https://\([\S]*\)#\1#')"
WIKI="https://${GITHUB_REPOSITORY_OWNER}:${INPUT_ACCESS_TOKEN}@${GITHUB_DOMAIN}/${GITHUB_REPOSITORY}.wiki.git"

WIKI_CHECKOUT_DIR="$(mktemp -d)"
trap 'rm -rf -- "$WIKI_CHECKOUT_DIR"' EXIT

echo "Cloning WIKI Repo..."
git clone "$WIKI" "$WIKI_CHECKOUT_DIR"
cd "$WIKI_CHECKOUT_DIR"

echo "Cleaning..."
rm -r -- *

echo "Copy Files..."
echo "-> Wiki Folder: ${INPUT_WIKI_FOLDER}"
cd "${GITHUB_WORKSPACE}"

if [ ! -d "${GITHUB_WORKSPACE}/${INPUT_WIKI_FOLDER}" ]; then
    echo "Specified Wiki Folder Missing"
    exit 1
fi
cp -a "${INPUT_WIKI_FOLDER}/." "$WIKI_CHECKOUT_DIR"

echo "Git Config..."
echo "-> User: ${INPUT_COMMIT_USERNAME}"
echo "-> Email: ${INPUT_COMMIT_EMAIL}"
git config --file "${WIKI_CHECKOUT_DIR}/.git/config" user.email "${INPUT_COMMIT_EMAIL}"
git config --file "${WIKI_CHECKOUT_DIR}/.git/config" user.name "${INPUT_COMMIT_USERNAME}"

echo "Commit..."
echo "-> Message: ${INPUT_COMMIT_MESSAGE}"
cd "$WIKI_CHECKOUT_DIR"
git add -A
if ! git diff --cached --exit-code > /dev/null; then
    git commit -m "${INPUT_COMMIT_MESSAGE}"
    git push "$WIKI"
else
    echo "No changes to commit."
fi

echo "Finished!"

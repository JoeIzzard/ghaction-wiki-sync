#!/bin/sh

WIKI="https://github.com/${GITHUB_REPOSITORY}.wiki.git"

echo "Cloning WIKI Repo..."
git clone $WIKI /wiki
cd /wiki

echo "Cleaning..."
rm -r *

echo "Workspace"
cd /github/workspace
ls

echo "Home"
cd /github/home
ls

echo "Workflow"
cd /github/workflow
ls
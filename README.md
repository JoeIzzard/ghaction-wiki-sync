# action-wiki-sync

This action is designed to sync a folder in your repo with the Wiki Repo, allowing for better contributor worklow and ease of editing the Wiki.

All changes made manually to the wiki will be overwritten with the state of the designated wiki
folder in your repository during the next sync.

## Example

```yaml
on:
    push:
        branches:
            - master
    pull_request:
        branches:
            - master
name: Wiki Sync
jobs:
    update-wiki:
        runs-on: ubuntu-latest
        steps:
          - uses: actions/checkout@master
          - name: Sync Wiki
            uses: joeizzard/ghaction-wiki-sync@master
            with:
                wiki_folder: wiki
                commit_username: 'Example Name'
                commit_email: 'example@users.noreply.github.com'
                commit_message: 'action: wiki sync'
```
In this example, the `wiki` folder will be synced with the wiki repo everytime a commit to the master branch occurs or when a pull request to the master branch is merged. This is a fully working example, just change the variables under the `with` section to get started.

## Inputs

| Input | Required | Info |
| :----- | :-----: | :----- |
| `access_token` | N | An access token to use when pushing to the Wiki repo. Usually doesn't need to be set as it defaults to `${{ github.token }}` |
| `wiki_folder` | N | The folder to sync to the Wiki. <br/> <i>Default: `wiki`</i> |
| `commit_username` | Y | The username to use when pushing to the wiki repo |
| `commit_email` | Y | The email address to use when pushing to the wiki repo. Our example uses the [annonymous email](https://help.github.com/en/github/setting-up-and-managing-your-github-user-account/setting-your-commit-email-address) from GitHub |
| `commit_message` | N | The commit message to use when pushing to the wiki repo <br/><i>Default: `action: wiki sync` |

## Outputs 

There are no outputs for this action.

## Requirements

The action requires that the wiki repository has been initialized beforehand.

## License

This project is licensed under [MIT](https://opensource.org/licenses/MIT). 

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

For the full License, Please see the file [LICENSE.md](LICENSE.md)

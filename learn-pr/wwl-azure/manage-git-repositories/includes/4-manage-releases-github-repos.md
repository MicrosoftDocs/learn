Part of the release process starts with your version control. You'll understand how to manage releases in the repository using GitHub.

In the following modules, you'll see details about deploying a piece of software after packaging your code, binary files, release notes, and related tasks.

Releases in GitHub are based on [Git tags](https://git-scm.com/book/en/Git-Basics-Tagging). You can think of a tag as a photo of your repository's current state. If you need to mark an essential phase of your code or your following deliverable code is done, you can create a tag and use it during the build and release process to package and deploy that specific version. For more information, see [Viewing your repository's releases and tags.](https://docs.github.com/repositories/releasing-projects-on-github/viewing-your-repositorys-releases-and-tags)

When creating new releases with release notes, it's possible to @mentions contributors, add links to binary files and edit or delete existing releases.

:::image type="content" source="../media/github-release-notes-b8ec3d9a.png" alt-text="Screenshot of release notes from GitHub.":::


*Image reference: [Releases · Microsoft/azure-pipelines-agent (github.com)](https://github.com/Microsoft/azure-pipelines-agent/releases)*

Also, you can:

 -  Publish an action from a specific release in GitHub Marketplace.
 -  Choose whether Git LFS objects are included in the ZIP files and tarballs GitHub creates for each release.
 -  Receive notifications when new releases are published in a repository.

## Creating a release

To create a release, use the gh release create command. Replace the ***tag*** with the desired tag name for the release and follow the interactive prompts.

```
gh release create tag

```

To create a prerelease with the specified title and notes.

```
gh release create v1.2.1 --title

```

If you @mention any GitHub users in the notes, the published release on GitHub.com will include a Contributors section with an avatar list of all the mentioned users.

You can check other commands and arguments from the [GitHub CLI manual](https://cli.github.com/manual/gh_release_create).

## Editing a release

You can't edit Releases with GitHub CLI.

To edit, use the Web Browser:

1.  Navigate to the main repository page on GitHub.com.
2.  Click **Releases** to the right of the list of files.
3.  Click on the **edit icon** on the right side of the page, next to the release you want to edit.
4.  Edit the details for the release, then click **Update release**.

## Deleting a release

To delete a release, use the following command, replace the ***tag*** with the release tag to delete, and use the -y flag to skip confirmation.

```
gh release delete tag -y

```

For more information, see:

 -  [Managing releases in a repository - GitHub Docs](https://docs.github.com/repositories/releasing-projects-on-github/managing-releases-in-a-repository) \- If you want to perform the same steps from Web Browser instead of GitHub CLI.
 -  [Publishing an action in the GitHub Marketplace](https://docs.github.com/actions/creating-actions/publishing-actions-in-github-marketplace).
 -  [Managing Git LFS objects in archives of your repository](https://docs.github.com/github/administering-a-repository/managing-git-lfs-objects-in-archives-of-your-repository).
 -  [Viewing your subscriptions](https://docs.github.com/github/managing-subscriptions-and-notifications-on-github/viewing-your-subscriptions).

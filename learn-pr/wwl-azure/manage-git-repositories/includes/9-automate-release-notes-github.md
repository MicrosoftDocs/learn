After learning how to create and manage release tags in your repository, you'll learn how to configure the automatically generated release notes template from your GitHub releases.

You can generate an overview of the contents of a release, and you can also customize your automated release notes.

It's possible to use labels to create custom categories to organize pull requests you want to include or exclude specific labels and users from appearing in the output.

## Creating automatically generated release notes

While configuring your release, you see the option Auto-generate release notes to include all changes between your tag and the last release. If you never created a release, it consists of all changes from your repository.

:::image type="content" source="../media/create-release-note-3cb0bee2.png" alt-text="Screenshot of how to create release notes from GitHub.":::


You can choose if you want to customize it or leave it as it is.

## Configuring automatically generated release notes template

You can customize the auto-generate release notes template by using the following steps.

1.  Navigate to your repository and create a new file.
    
    :::image type="content" source="../media/github-create-new-file-f3e1148b.png" alt-text="Screenshot of how to create a new file on GitHub.":::
    
2.  You can use the name **.github/release.yml** to create the **release.yml** file in the **.github** directory.
    
    :::image type="content" source="../media/github-release-file-creation-83568335.png" alt-text="Screenshot of how to create release.yml file on GitHub.":::
    
3.  Specify in YAML the pull request labels and authors you want to exclude from this release. You can also create new categories and list the pull request labels in each. For more information about configuration options, see [Automatically generated release notes - GitHub Docs.](https://docs.github.com/en/repositories/releasing-projects-on-github/automatically-generated-release-notes#configuration-options)
    
    **Example configuration:**
    
    ```YML
    # .github/release.yml
    
    changelog:
      exclude:
        labels:
        - ignore-for-release
        authors:
        - octocat
      categories:
        - title: Breaking Changes 🛠
          labels:
            - Semver-Major
            - breaking-change
        - title: Exciting New Features 🎉
          labels:
            - Semver-Minor
            - enhancement
        - title: Other Changes
          labels:
            - *
    ```
4.  Commit your new file.
    
    :::image type="content" source="../media/github-commit-new-file-56536fe6.png" alt-text="Screenshot of how to commit new file on GitHub.":::
    
5.  Try to create a new release and click **+ Auto-generate release notes** to see the template structure.

For more information, see:

 -  [About releases - GitHub Docs](https://docs.github.com/repositories/releasing-projects-on-github/about-releases)
 -  [Linking to releases - GitHub Docs](https://docs.github.com/repositories/releasing-projects-on-github/linking-to-releases)
 -  [Automation for release forms with query parameters - GitHub Docs](https://docs.github.com/repositories/releasing-projects-on-github/automation-for-release-forms-with-query-parameters)

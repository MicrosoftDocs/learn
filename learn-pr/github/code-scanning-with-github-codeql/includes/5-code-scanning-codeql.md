Depending on which tool you want to use for analysis and how you want to generate alerts, there are a few different options for setting up a code scanning workflow on your repository:

| Analysis tool | Alert generation |
| --- | --- |
| CodeQL | GitHub Actions |
| CodeQL | CodeQL in a third-party continuous integration (CI) system |
| Third-party | GitHub Actions |
| Third-party | Generated externally and then uploaded to GitHub |

In this unit, you'll learn how to set up code scanning with GitHub Actions, as well as how to perform bulk setup of code scanning for multiple repositories.

## Code scanning with GitHub Actions and CodeQL

To set up code scanning with GitHub Actions and CodeQL on a repository, do the following:

1. Go to the **Security** tab of your repository.

    :::image type="content" source="../media/security-tab.png" alt-text="Screenshot of the Security tab.":::

2. To the right of **Code scanning alerts**, click **Set up code scanning**. If code scanning is missing, this means you need to enable GitHub Advanced Security.
3. Under **Get started with code scanning**, click **Set up this workflow** on the CodeQL analysis workflow or on a third-party workflow.

   > [!Note]
   > Workflows are only displayed if they are relevant for the programming languages detected in the repository. The CodeQL analysis workflow is always displayed, but the "Set up this workflow" button is only enabled if CodeQL analysis supports the languages present in the repository.

4. To customize how code scanning scans your code, edit the workflow. Generally you can commit the CodeQL analysis workflow without making any changes to it. However, many of the third-party workflows require additional configuration, so read the comments in the workflow before committing.
5. Use the **Start commit** drop-down, and type a commit message.
6. Choose whether you'd like to commit directly to the default branch, or create a new branch and start a pull request.
7. Click **Commit new file** or **Propose new file**.

In the default CodeQL analysis workflow, code scanning is configured to analyze your code each time you either push a change to the default branch or any protected branches, or raise a pull request against the default branch. As a result, code scanning will now commence.

The `on:pull_request` and `on:push triggers` for code scanning are each useful for different purposes.

## Bulk setup of code scanning

You can set up code scanning in many repositories at once using a script. If you'd like to use a script to raise pull requests that add a GitHub Actions workflow to multiple repositories, reference the [jhutchings1/Create-ActionsPRs](https://github.com/jhutchings1/Create-ActionsPRs) repository for an example using PowerShell, or [nickliffen/ghas-enablement](https://github.com/NickLiffen/ghas-enablement) for an example using NodeJS.
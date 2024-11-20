Depending on which tool you want to use for analysis and how you want to generate alerts, there are a few different options for setting up code scanning in your repository. The three main ways are:

* Use the default setup to quickly configure CodeQL analysis for code scanning on your repository. Default setup automatically chooses the languages to analyze, query suite to run, and events that trigger scans. If you prefer, you can manually select the query suite to run and languages to analyze. After you enable CodeQL, GitHub Actions will execute workflow runs to scan your code. For more information, see "Configuring default setup for code scanning."
* Use advanced setup to add the CodeQL workflow to your repository. This generates a customizable workflow file which uses the github/codeql-action to run the CodeQL CLI. For more information, see "Configuring advanced setup for code scanning."
* Run the CodeQL CLI directly in an external CI system and upload the results to GitHub. For more information, see "Using code scanning with your existing CI system."<sup>[2]</sup>

Previously, we learned about getting started with the default setup and configurations. Now you'll learn how to set up code scanning with the advanced setup, as well as how to perform bulk setup of a code scanning workflow for multiple repositories.

## Code scanning with GitHub Actions and CodeQL

To set up code scanning with the advanced setup, do the following:

1. Go to the **Settings** tab of your repository.
2. In the left hand panel, navigate to **Code security and analysis**, click the **setup** dropdown and select **Advanced**. You may need to enable GitHub Advanced Security before enabling code scanning.
3. You'll be taken to a new page with a generated workflow file. This file is by default named `codeql.yml` and is a configurable workflow file that needs to be committed to your repository in order to begin running code scanning.
4. To customize how code scanning scans your code, edit the workflow. Generally you can commit the CodeQL analysis workflow without making any changes to it.
5. Use the **Commit changes...** button in the upper right hand corner and type a commit message in the pop-up box.
6. Choose whether you'd like to commit directly to the default branch or create a new branch and start a pull request.
7. Click **Commit changes**.

In the default CodeQL analysis workflow, code scanning is configured to analyze your code each time you either push a change to the default branch or any protected branches, or raise a pull request against the default branch. As a result, code scanning will now commence.

The `on:pull_request` and `on:push` triggers for code scanning are each useful for different purposes.

## Bulk setup of code scanning

You can set up code scanning in many repositories at once using a script. If you'd like to use a script to raise pull requests that add a GitHub Actions workflow to multiple repositories, reference the jhutchings1/Create-ActionsPRs<sup>[3]</sup> repository for an example using PowerShell, or nickliffen/ghas-enablement<sup>[4]</sup> for an example using NodeJS.

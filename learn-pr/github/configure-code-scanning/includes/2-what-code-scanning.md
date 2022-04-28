Code scanning uses CodeQL to analyze the code in a GitHub repository to find security vulnerabilities and coding errors. Code scanning is available for all public repositories, and for private repositories owned by organizations where GitHub Advanced Security is enabled. If code scanning finds a potential vulnerability or error in your code, GitHub displays an alert in the repository's Security tab. After you fix the code that triggered the alert, GitHub closes the alert.

You can use code scanning to find, triage, and prioritize fixes for existing problems in your code. Code scanning also prevents developers from introducing new problems. You can schedule scans for certain days and times, or trigger scans when a specific event occurs in the repository, such as a push.

In this unit, you'll learn about CodeQL, the two options for setting up code scanning, and how to add the CodeQL workflow to your repository.

## About code scanning with CodeQL

CodeQL is the code analysis engine developed by GitHub to automate security checks. You can analyze your code using CodeQL and display the results as code scanning alerts. There are two main ways to use CodeQL analysis for code scanning:

- Add the CodeQL workflow to your repository. This uses the [github/codeql-action](https://github.com/github/codeql-action/) to run the CodeQL CLI.
- Run the CodeQL CLI directly in an external CI system and upload the results to GitHub.  
  
CodeQL treats code like data, allowing you to find potential vulnerabilities in your code with greater confidence than traditional static analyzers. You generate a CodeQL database to represent your codebase, then you run CodeQL queries on that database to identify problems in the codebase. The query results are shown as code scanning alerts in GitHub when you use CodeQL with code scanning.

CodeQL supports both compiled and interpreted languages, and can find vulnerabilities and errors in code that's written in the following supported languages:
- C/C++
- C#
- Go
- Java
- JavaScript/TypeScript
- Python
- Ruby

The next section explains how to add the CodeQL workflow to your repository. You'll learn how to set up CodeQL using external tools in the "Enable code scanning with third party tools" unit.

## Add the CodeQL workflow to your repository

If you have write permissions to a repository, you can set up or configure code scanning for that repository. 

Follow these steps to set up code scanning using the CodeQL GitHub Actions workflow: 
  
1. On GitHub.com, navigate to the main page of the repository.

2. Under your repository name, click **Security**.

     :::image type="content" source="../media/2-security-tab-screenshot.png" alt-text="screenshot of the security tab":::

3. Click **Set up code scanning**. If this option is not available, ask an organization owner or repository administrator to enable GitHub Advanced Security. 
 
     :::image type="content" source="../media/3-set-up-code-scanning-button-screenshot.png" alt-text="screenshot of the set up code scanning button":::

4. In the "Get started with code scanning" section, click **Set up this workflow** on the CodeQL analysis workflow.

     :::image type="content" source="../media/4-set-up-this-workflow-button-screenshot.png" alt-text="screenshot of the set up workflow button":::

   Workflows are only displayed if they are relevant for the programming languages detected in the repository. The CodeQL analysis workflow is always displayed, but the **Set up this workflow** option is only enabled if CodeQL analysis supports the languages present in the repository.

5. To customize how code scanning scans your code, edit the workflow.

   Generally you can commit the CodeQL analysis workflow without making any changes to it.

6. Select the **Start commit** drop-down, and type a commit message.

     :::image type="content" source="../media/6-start-commit-screenshot.png" alt-text="screenshot of the start commit drop down":::

7. Choose whether you'd like to commit directly to the default branch, or create a new branch and start a pull request.

     :::image type="content" source="../media/7-choose-where-commit-screenshot.png" alt-text="screenshot of the choose where to commit drop down":::

8. Click **Commit new file** or **Propose new file**.

  In the default CodeQL analysis workflow, code scanning is configured to analyze your code each time you either push a change to the default branch or any protected branches, or   raise a pull request against the default branch. As a result, code scanning will now commence.

The `on:pull_request` and `on:push` triggers for code scanning are each useful for different purposes. You'll learn more about these triggers in the "Configure Code Scanning" unit. 

Running code scanning with GitHub Actions will affect your monthly billing minutes. If you want to use GitHub Actions beyond the storage or minutes included in your account, you'll be billed for additional usage.

## About Billing for Actions

GitHub Actions usage is free for both public repositories and self-hosted runners. For private repositories, each GitHub account receives a certain number of free minutes and storage, depending on the product used with the account. Any usage beyond the included amounts is controlled by spending limits. If you are a monthly billed customer, your account will have a default spending limit of 0 US dollars (USD), which prevents additional usage of minutes or storage for private repositories beyond the amounts included with your account. If you pay your account by invoice, your account will have an unlimited default spending limit. Minutes reset every month, while storage usage does not.


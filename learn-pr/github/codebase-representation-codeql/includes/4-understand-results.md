In previous units, you created a database and scanned the extracted file from your code. Now you can view the results and determine if there are security vulnerabilities to address.

## View code-scanning results from CodeQL analysis

Interpreted query results are automatically displayed in the source code in the CodeQL extension for VS Code. Output results that the CodeQL CLI generates can be in many formats for use with various tools.

You can control how analysis results are displayed in source code by modifying a query's `select` statement. You can make the results clear and easy for other users to understand while developing the query. When you write your own queries in the query console or in the CodeQL extension for VS Code, there are no constraints on what can be selected.

If you want to use a query to create alerts in GitHub code scanning or generate valid analysis results by using the CodeQL CLI, you need to make the `select` statement report results in the required format.

## Act on code-scanning alerts

You can set up code scanning to check the code in a repository. You can use the default CodeQL analysis, a non-Microsoft analysis, or other types of analysis. The resulting alerts are displayed alongside each other in the repository.

GitHub's default CodeQL analysis might include more properties for alerts than results from non-Microsoft tools or from custom queries. In a default workflow, code scanning analyzes your code periodically on the default branch and during pull requests.

Each alert includes the following information:

- The problem with the code and the name of the tool that identified it
- The line of code that triggered the alert
- Properties of the alert, such as the severity
- The security severity
- When the problem was introduced
- The nature of the problem

Information also includes how to fix the problem when CodeQL analysis identifies an alert. Additionally, code scanning through CodeQL can detect data-flow problems in your code.

:::image type="content" source="../media/code-scanning-alert-screenshot.png" alt-text="Screenshot that shows CodeQL analysis alerts." border="false":::

### Data-flow alerts

Data-flow analysis finds potential security issues in code, including:

- Using data in a way that compromises security.
- Passing dangerous arguments to functions.
- Leaking sensitive information.

GitHub shows you how data moves through the code when code scanning reports data-flow alerts. You can use these data-flow alerts to identify the areas of your code that leak sensitive information. This knowledge can help you identify the entry point for attacks by malicious users.

### Severity levels

Any code-scanning results that have a severity of `Error` cause check failure by default. Alert severity levels are `Error`, `Warning`, and `Note`. You can specify the severity level at which pull requests that trigger code-scanning alerts should fail.

### Security severity levels

Security queries that code scanning generates display security severity levels for alerts. Security severity levels are `Critical`, `High`, `Medium`, and `Low`. GitHub uses Common Vulnerability Scoring System (CVSS) data to calculate the security severity of an alert.

Any code-scanning results that have a security severity of `Critical` or `High` cause a check failure by default. You can specify which security severity level should cause a check failure for code-scanning results.

## Close a code-scanning alert

You have two ways to close an alert:

- Fix the problem in the code.
- Dismiss or delete the alert.

### Dismiss a code-scanning alert

Dismissing an alert is a way of closing an alert that you don't think needs to be fixed. One example is an error in code that's used only for testing. You might also dismiss an alert if the effort required to fix the error is greater than the potential benefit of improving the code.

You can dismiss alerts from code-scanning annotations in the code or from the summary list on the **Security** tab. To dismiss an alert from the list, select the **Dismiss alert** menu, select a reason for dismissal, and then select the **Dismiss alert** button.

:::image type="content" source="../media/code-scanning-alert-dismissal.gif" alt-text="Video that the dropdown menu and button for dismissing an alert." border="false":::

When you dismiss an alert:

- It's dismissed in all branches.
- It's removed from the number of current alerts for your project.
- It's moved to the **Closed** list in the summary of alerts. You can reopen it from here, if necessary.
- The reason why you closed the alert is recorded.
- The next time code scanning runs, the same code won't generate an alert.

### Delete a code-scanning alert

You can delete an alert if you have admin permissions for the repository. Deleting alerts is useful when:

- You set up a code-scanning tool but later decide to remove it.
- You configured CodeQL analysis with a larger set of queries than you want to continue using.
- You removed some queries from the tool.
- You want to clean up your code-scanning results.

You can delete alerts from the summary list on the **Security** tab.

When you delete an alert:

- It's deleted in all branches.
- It's removed from the number of current alerts for your project.
- It isn't added to the **Closed** list in the summary of alerts.
- If the code that generated the alert stays the same, and the same code-scanning tool runs again without any configuration changes, the alert appears again in your analysis results.

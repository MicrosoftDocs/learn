At the beginning of this module, you read case studies that showed how serious security breaches can be. In the example of the 2017 Equifax breach, a lack of proper dependency management by administrators was a root cause of the breach. Humans failed to respond when they received information that a dependency needed to be fixed quickly.

In this unit, you'll learn the importance of responding to security alerts and what that response should look like. You'll also learn about GitHub functionality that allows you to quickly react to these alerts.

## Evaluate security alerts

Although teams can't always avoid errors, quick action reduces risks. Failing to act promptly leaves your system or project open to exploitation by bad actors. You can reduce costs, retain customers, and protect your brand reputation when you avoid sensitive data leaks by quickly responding to security alerts.

### Triage security alerts

In Unit 2, you learned that GitHub's code scanning helps to identify vulnerabilities in your code. When the system identifies a problem, it notifies your team with alerts highlighting the issue. This helps you to quickly identify the issue. Once GitHub flags a vulnerability in your codebase, analyzing the flaw is the next step.

:::image type="content" source="../media/triage.png" alt-text="Screenshot showing menu options for resolving alerts." border="false":::

As shown in the preceding image, you control the code-scanning process. If the scan misunderstands your intent, you can dismiss the alert by identifying a reason for the dismissal. Indicate if the scan highlighted a false positive, code used in tests, or an irrelevant alert.

You can also interact with scanning alerts through pull requests. You can get details related to the alert if you have write permission to the repository. A check must pass before you can merge the pull request.

### Manage security alerts

:::image type="content" source="../media/code-scanning-filter-by-tool.png" alt-text="Screenshot of code-scanning alerts." border="false":::

GitHub provides you with an overview of your repository alerts along with the triage functionality. This summary facilitates the prioritization of security alerts. Navigate to the security tab of your repository and select **Code scanning alerts**. Use the free-text search box or the drop-down menus to filter alerts.

GitHub can also suggest fixes for errors in your code. This functionality is more than a simple convenience; the direction saves you valuable time. The time you save goes toward your goal of quickly reacting to vulnerabilities.

## Use security advisories

Imagine a scenario where you find a vulnerability. You don't want to announce the vulnerability to the world. In situations like these, security advisories can help.

Think of security advisories as a private forum that code maintainers use to discuss bugs or vulnerabilities found within their projects. With security in mind, maintainers keep these exchanges in this forum instead of using the standard method of GitHub issues for their conversations. When you use security advisories, you ensure that knowledge of any error or bug is not exposed to the public before you can fix it.

After you resolve the problem, the security advisory is published back into the GitHub Advisory Database so that affected external parties affected can take any necessary steps.

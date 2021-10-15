:::image type="content" source="../media/premium-support.png" alt-text="A graphic that shows a stylized support engineer, with icons that represent different times of day":::

In this unit, you'll learn about the enhanced support available with GitHub Enterprise, and common administrator duties when interacting with GitHub Enterprise Support. You can apply this knowledge whether you're operating a private copy of GitHub contained within a virtual appliance ("GitHub Enterprise Server") or you've deployed GitHub Enterprise services in GitHub's cloud ("GitHub Enterprise Cloud").

## Availability of GitHub Enterprise Support

The table below shows the availability of [GitHub Enterprise Support](https://enterprise.github.com/support).

| Availability                                        | GitHub Enterprise Support | Premium and Premium Plus Support |
| --------------------------------------------------- | ------------------------- | -------------------------------- |
| Days of operation                                   | Monday through Friday     | Every day                        |
| Time of initial response<br />(High-level issues)   | Within eight hours        | Within four hours                |
| Time of initial response<br />(Urgent-level issues) | Within eight hours        | Within 30 minutes                |

[Premium and Premium Plus Support](https://github.com/premium-support) customers also receive other benefits.

## Administrative responsibilities or GitHub Enterprise Support?

Knowing where to go for support when an issue arises can be confusing. Is this problem an issue for the organization's administrator or is it something that GitHub Support can handle? GitHub Support can help troubleshoot issues that arise on GitHub Enterprise Server for three areas; account, security, and abuse issues.

### Account

Human error-related authentication problems are an example of account issues. When a user is locked out of their account and failed to retain keys to back up their two-factor authentication process, GitHub technical support can help you prove the user's identity.

### Security

You can request GitHub support when responding to threat actors hacking an account. If the problem is a security issue, GitHub support technicians can provide help in rolling back damage to organization repositories and settings.

### Abuse

Abuse issues involve responding to violations of the site's terms of service or organizational policies in GitHub's social setting--someone is using GitHub's communication's features to abuse other users. GitHub support technicians can help you evaluate the situation and can remove harmful content or ban abusive actors.

On the other hand, you should deal with some issues internally. You'll administer tasks like integrating CI/CD servers or internal tools, hardware setup, writing scripts, configuring SAML or other external authentication systems, working with Open Source projects, resolving problems that require immediate intervention, and running command-line utilities (except `ghe-dbconsole`).

## Create and assign priority to a support ticket

Once you have determined that it's time to get help from GitHub Enterprise Support, use the [GitHub Enterprise Support Portal](https://enterprise.githubsupport.com/hc/en-us) to submit support tickets.

The goal of the support ticket submission process is to provide as much issue-related information as possible to GitHub support technicians. As with creating support tickets in other information technology environments, the most valuable information is:

- Steps to reproduce the issue
- Any special circumstances surrounding the discovery of the issue (for example, the first occurrence or occurrence after a specific event, frequency of occurrence, business impact of the problem, and suggested urgency)
- Exact wording of error messages

GitHub prioritizes support tickets in the following manner:

- **Urgent** tickets report critical system failure.
- **High**-tickets report problems impacting business operations or critical bugs, including removing sensitive data (commits, issues, pull requests, uploaded attachments) from your own accounts and organization restorations.
- **Normal**-tickets request account recovery or spam unflagging, report user login issues, and report non-critical bugs.
- **Low**-tickets ask general questions and submit requests for new features, purchases, training, or health checks.

## Other data that can accompany tickets

*Diagnostic files* and *support bundles* provide more information to GitHub support technicians about a server's settings, environment, statistics, and logs.

The settings and history of a GitHub Enterprise environment are helpful when GitHub Enterprise Support needs to assist the administration with rolling back the environment to a state before damage occurred (most often related to security problems).

Logs present in support bundles retain information from the past two days, but in cases when GitHub support technicians require more data, it is possible to generate an *extended support bundle* containing logs that retain information from the past seven days.

Creating a basic diagnostic file from the Management Console is as simple as logging into the Console, selecting **Support**, and selecting **Download diagnostics info**. You can also obtain a support bundle by choosing **Download support bundle** instead.

:::image type="content" source="../media/support-link.png" alt-text="Button to access Support area":::

The best way to provide this support bundle to GitHub Enterprise Support as an administrator is to select the relevant enterprise from **Your enterprises**, select **Enterprise licensing** under **Settings**, and then select **Upload a support bundle** in the GitHub Enterprise Help section of the webpage. This user-friendly direct line to GitHub Support is the interface you should use first when GitHub Enterprise Support requests a support bundle in response to your issue.

## Resolve and close support tickets

[The following information appears at the GitHub Doc "About GitHub Premium Support for GitHub Enterprise Cloud."](https://docs.github.com/en/github/working-with-github-support/about-github-premium-support-for-github-enterprise-cloud#resolving-and-closing-support-tickets)

GitHub Premium Support may consider a ticket solved after providing an explanation, recommendation, usage instructions, or workaround instructions.

If you use a custom or unsupported plug-in, module, or custom code, GitHub Premium Support may ask you to remove the unsupported plug-in, module, or code while attempting to resolve the issue. If the problem is fixed when the unsupported plug-in, module, or custom code is removed, GitHub Premium Support may consider the ticket solved.

GitHub Premium Support may close tickets if they're outside the scope of support or if multiple attempts to contact you have gone unanswered. If GitHub Premium Support closes a ticket due to lack of response, you can request that GitHub Premium Support reopen the ticket.
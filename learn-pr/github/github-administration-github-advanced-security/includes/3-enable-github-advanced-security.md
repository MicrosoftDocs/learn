You learned in the previous unit how GitHub Advanced Security fits into your software-development lifecycle and which features are included for different GitHub plans. It's now time to take the first step towards implementing GitHub Advanced Security in your organization.

In this unit, you'll learn how to enable GitHub Advanced Security at the organization level according to your enterprise plan.

## Enable GitHub Advanced Security for Enterprise Cloud

Enabling GitHub Advanced Security at the organization level automatically turns on GitHub Advanced Security for all private and internal repositories in your organization.

> [!NOTE]
> If you enable GitHub Advanced Security in your organization, committers to the organization repositories will use seats on your GitHub Advanced Security license.

Follow the steps below to enable GitHub Advanced Security for all the repositories in your organization:

1. In your organization, navigate to **Settings > Code security and analysis**.
2. Under **Configure security and analysis features**, click the **Enable all** button next to **GitHub Advanced Security**. The control for **GitHub Advanced Security** is disabled if you have no available seats in your GitHub Advanced Security license.
3. Review the impact of enabling Advanced Security on all repositories and click **Enable all**.

:::image type="content" source="../media/enable-org.png" alt-text="Screenshot of the screen for reviewing the impact of enabling Advanced Security on all repositories.":::

If you'd like to automatically enable GitHub Advanced Security on new private and internal repositories added to your organization, select the **Automatically enable for new private and internal repositories** checkbox under **GitHub Advanced Security**, review the impact of enabling Advanced Security on all new private and internal repositories, and click **Enable for new repositories**.

:::image type="content" source="../media/enable-org-2.png" alt-text="Screenshot of the screen for reviewing the effect of enabling Advanced Security on all new private and internal repositories.":::

GitHub also offers an advanced Code scanning feature called autofix (currently in open beta for GitHub Enterprise Cloud users) that can help automate some security fixes users by providing targeted recommendations to developers to fix code scanning alerts in pull requests so they can avoid introducing new security vulnerabilities. Autofix leverages AI to suggest code changes that address vulnerabilities identified by CodeQL during code review. While not a replacement for manual review, autofix can save developers time and effort. 

### Disabling Autofix for an Organization

If autofix is allowed at the enterprise level, organization administrators have the option to disable autofix for an organization. If you disable autofix for an organization, autofix cannot be enabled for any repositories within the organization. 
> [!NOTE]
> Disabling autofix at the organization level will remove all open autofix comments from open pull requests across all repositories in the organization.

Follow the steps below to disable Autofix for your organization:
1. In the upper-right corner of GitHub.com, select your profile photo, then click  Your organizations. 
2. Next to the organization, click Settings.
   
:::image type="content" source="../media/open-repo-settings-autofix.png" alt-text="Screenshot of the screen for clicking the repository settings icon for autofix.":::

3. In the "Security" section of the sidebar, click  Code security and analysis.
4. Under the "Code scanning" section, deselect Autofix for CodeQL.

### Disabling Autofix for a Repository
If autofix is allowed at the enterprise level and enabled at the organization level, repository administrators have the option to disable autofix for a repository. Disabling autofix at the repository level will remove all open autofix comments from all open pull requests across the repository. 
Follow the steps below to disable Autofix for your repository:

1. On GitHub.com, navigate to the main page of the repository. 
2. Under your repository name, click  Settings. If you cannot see the "Settings" tab, select the  dropdown menu, then click Settings. 
3. In the "Security" section of the sidebar, click  Code security and analysis. 
4. In the "Code scanning" section, deselect Autofix for CodeQL.

> [!NOTE]
> Disabling autofix at any level will close all open autofix comments from all open pull requests at the level that was disabled. If autofix is disabled and then subsequently enabled, autofix won't automatically suggest any fixes for pull requests that are already open.


## Enable GitHub Advanced security for Enterprise Server

Before you can enable GitHub Advanced Security for all the repositories in your organization on GitHub Enterprise Server, you must first enable Advanced Security for your GitHub Enterprise Server instance. You can do this in two ways: via the GitHub user interface or via the administrative shell (SSH).

Whether you plan on using the user interface or the administrative shell, make sure you meet the following prerequisites before completing one of the procedures described in the next sections:

- Your license for GitHub Enterprise Server has been upgraded to include GitHub Advanced Security and you've uploaded it to your GitHub Enterprise Server instance.
- You've reviewed the prerequisites for the features you plan to enable:
  - [Prerequisites for code scanning](https://docs.github.com/en/enterprise-server@3.11/admin/code-security/managing-github-advanced-security-for-your-enterprise/configuring-code-scanning-for-your-appliance)
  - [Prerequisites for secret scanning](https://docs.github.com/en/enterprise-server@3.11/admin/code-security/managing-github-advanced-security-for-your-enterprise/configuring-secret-scanning-for-your-appliance)
  - [Prerequisites for Dependabot](https://docs.github.com/en/enterprise-server@3.11/admin/configuration/configuring-github-connect/enabling-dependabot-for-your-enterprise)

> [!NOTE]
> Enabling GitHub Advanced Security features on your Enterprise Server instance will cause user-facing services on GitHub Enterprise Server to restart. You should time this change carefully to minimize downtime for users.

### Via the GitHub user interface

Follow the procedure below to enable the GitHub Advanced Security features on your GitHub Enterprise Server instance:

1. In the **Site admin** page of your GitHub Enterprise Server account, navigate to **Management Console**.
2. In the left sidebar, click **Security**.
3. Under **Security**, select the features that you want to enable.

    :::image type="content" source="../media/enable-github-enterprise-security.png" alt-text="Screenshot of the security features.":::

4. Under the left sidebar, click **Save settings** and wait for the configuration run to complete.

When GitHub Enterprise Server has finished restarting, follow the procedure described in the previous "Enable GitHub Advanced Security for Enterprise Cloud" section to enable GitHub Advanced Security for all the repositories in your organization.

### Via the administrative shell

You can enable or disable features programmatically on your GitHub Enterprise Server instance via the administrative shell and command-line utilities for GitHub Enterprise Server. For example, you can enable any GitHub Advanced Security feature with your infrastructure-as-code tooling when you deploy an instance for staging or disaster recovery.

Follow the procedure below to enable the GitHub Advanced Security features on your Enterprise Server instance:

1. SSH into your GitHub Enterprise Server instance.
2. Enable the GitHub Advanced Security features you want to implement in your instance:
    - To enable code scanning, enter `ghe-config app.minio.enabled true` followed by `ghe-config app.code-scanning.enabled true`.
    - To enable secret scanning, enter `ghe-config app.secret-scanning.enabled true`.
    - To enable the dependency graph, enter `ghe-config app.dependency-graph.enabled true`.
3. Apply the configuration by entering `ghe-config-apply`.

When GitHub Enterprise Server has finished restarting, follow the procedure described in the previous "Enable GitHub Advanced Security for Enterprise Cloud" section to enable GitHub Advanced Security for all the repositories in your organization.


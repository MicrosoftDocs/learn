In the previous unit, you learned about the different GitHub tools that work together to enable dependency management and how Dependabot helps to automate some of these processes. Now, you'll learn about Dependabot alerts. 

If your project relies on external dependencies, then you can use valuable resources trying to monitor them. This monitoring process is important because you have to be aware of any changes or vulnerabilities in the code. It can also be challenging because this code isn't a part of your project. GitHub helps to automate this process by monitoring your dependencies and then sending Dependabot alerts when vulnerabilities are detected in your repository.

Dependabot alerts are generated under two conditions:

- A new vulnerability is added to the GitHub Advisory Database.
- The dependency graph for a repository changes.

GitHub also reviews pull request attempts to merge changes into the main branch that contain dependency changes. A Dependabot alert is generated if this change would introduce a vulnerability.

:::image type="content" source="../media/dependabot-alert.png" alt-text="Screenshot of dependency alerts in the GitHub Security tab.":::

>[!NOTE]
> GitHub's security features do not claim to catch all vulnerabilities. Though we are always trying to update our vulnerability database and generate alerts with our most up-to-date information, we will not be able to catch everything or tell you about known vulnerabilities within a guaranteed time frame. These features are not substitutes for human review of each dependency for potential vulnerabilities or any other issues, and we recommend consulting with a security service or conducting a thorough vulnerability review when necessary.

## Set up Dependabot alerts

Dependabot alerts are enabled for public repositories by default. Repository administrators and owners can however, set up Dependabot alerts for private repositories and for some GitHub Enterprise Server repositories. Enabling these features grants GitHub permission to perform read-only analysis of those specific repositories.

### Set up Dependabot alerts for private repositories

To set up Dependabot alerts for private repositories, you need to enable both the dependency graph and Dependabot alerts. Follow the steps below for each feature:

1. Sign in to your GitHub account and select your profile photo from the upper right.
2. Select **Settings**, then select **Code security and analysis** under **Security** in the left-side menu.
3. Select **Enable all** to the right of the feature you want to enable.
4. If you would like these settings to be applied to all new repositories in your organization, then select the **Enable by default for new private repositories** checkbox.
5. Select **Enable FEATURE** to enable the feature for all the repositories you own.

### Set up Dependabot alerts for organizations

If you are an organization owner, then you can enable the dependency graph and Dependabot alerts for all repositories in your organization at once:

1. Sign in to your GitHub account and select your profile photo from the upper-right.
2. Select **Your organizations.**
3. Select **Settings** next to the organization for which you would like to enable Dependabot alerts.
4. Select **Code security and analysis** from the left sidebar.
5. On the **Configure security and analysis features** page, select **Enable all** next to the feature you want to turn on.
6. If you would like these settings to be applied to all new repositories in your organization, select the **Enable by default for new private repositories** checkbox.
7. Select **Enable FEATURE** to enable the feature for all the repositories in your organization.

### Set up Dependabot alerts for GitHub Enterprise Server with GitHub Connect 

GitHub Enterprise customers can also enable Dependabot alerts. If you're a GitHub Enterprise owner who is also an owner of the connected GitHub Cloud organization or enterprise account, you can use GitHub Connect to enable the dependency graph and Dependabot alerts for your GitHub Server instance. GitHub Connect lets you share certain features and data between your GitHub Enterprise Server instance and your GitHub Enterprise Cloud organization or enterprise account on GitHub.com.

For more information, see [Connect your enterprise account to GitHub Enterprise Cloud](https://docs.github.com/enterprise-server@3.1/admin/configuration/managing-connections-between-your-enterprise-accounts/connecting-your-enterprise-account-to-github-enterprise-cloud).

## View Dependabot alerts 

Dependabot alerts are displayed in the **Security** tab for the repository and in the repository's dependency graph. The alert includes a link to the affected file in the project, and information about a fixed version, if available. 

:::image type="content" source="../media/dependabot-alert-detail.png" alt-text="Screenshot of a portion of a Dependabot alert.":::

## Grant access to Dependabot alerts

By default, only repository owners and administrators are able to receive and dismiss Dependabot alerts for their repositories. Administrators and owners can also grant other teams and users with access to the repository, permissions to view and dismiss Dependabot alerts by following these steps:

1. Go to the main page of the repository.
2. In the left menu, select **Code security and analysis**.
3. In the `Access to alerts` section, type the name of the person or team that you would like to be able to manage Dependabot alerts in the search bar. Make your selection.
4. Select **Save changes**.

## Resolve Dependabot alerts

After Dependabot alerts are enabled, you should create a process to regularly review and resolve them.

The following steps explain how to resolve Dependabot alerts:

1. Go to the main page of the repository.
2. Select  the **Security** tab for the repository.
3. Select **Dependabot alerts** from the security sidebar. A list of the Dependabot alerts for that repository will display.
4. Select the alert you would like to view. 
5. Review the alert details. In some cases, the alert may contain a pull request with an automated security update. 
6. Resolve the alert by taking one of the following actions:
   - Review and merge the pull request.
   - Select **Create Dependabot security update** to manually fix the vulnerability.
   - Select the **Dismiss** dropdown and choose a reason for dismissing the vulnerability.

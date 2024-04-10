Now that the security for your project is set up, all you have to do is to monitor and manage the GitHub Advanced Security features and alerts for your project.

In this unit, you'll learn how to use the Security Overview to monitor the security risks in your project. This unit also covers how to use the GitHub Advanced Security endpoints to manage the GitHub Advanced Security features and alerts.

## Use the Security Overview



The Security Overview is available in the **Security** tab of organizations and repositories. You can use it to get a high-level view of the security status of your organization or to identify problematic repositories that require intervention.

- At the organization level, the Security Overview displays aggregate and repository-specific security information for repositories owned by your organization. You can also filter information per security feature.
- At the team level, the Security Overview displays repository-specific security information for repositories that the team has admin privileges for.
- At the repository level, the Security Overview shows which security features are enabled for the repository and offers the option to configure any available security features not currently in use. Risk and coverage information about Dependabot features and alerts is shown by default for all repositories.

:::image type="content" source="../media/security-overview.png" alt-text="Screenshot of the Security Overview at the organization level.":::


Thanks to its high level of interactivity and numerous filters, the Security Overview is useful for both broad and specific analyses of your organization's security status. For example, you can use it to monitor adoption of features by your organization or by a specific team as you roll out GitHub Advanced Security to your enterprise, or to review all alerts of a specific type and severity level across all repositories in your organization.

You can also download comma-separated values (CSV) files from the risk and coverage pages within the Security Overview. These downloadable files are beneficial for security research, in-depth data analysis, and can be easily integrated with external datasets.

Moreover, dedicated views for each type of security alert enhance the ability to conduct focused analyses. For instance, in the secret scanning alert view, you can utilize the "Secret type" filter to isolate secret scanning alerts related to a particular secret, such as a GitHub personal access token. This granularity allows for targeted analysis and management of security alerts, making it easier to address potential vulnerabilities within your organization or specific repositories effectively.

### Using Views in Security Overview:
Security overview has multiple views that provide different ways to explore enablement and alert data.
- Use "Overview" to view insights about your organization's security landscape and progress.
- Use "Coverage" to assess the adoption of code security features across repositories in the organization.
- Use "Risk" to assess the risk from security alerts of all types for one or more repositories in the organization.
- Use the individual security alert views to identify your risk from specific vulnerable dependencies, code weaknesses, or leaked secrets.

### Permissions to view data in Security Overview
- For an owner or security manager for an organization, you can see data for all the repositories in the organization in all views.
- For an organization member, you can view security overview for the organization and see data for repositories where you have access.


### Enabling Security Features using Security Overview:

You can enable or disable security features for all repositories visible on the "Security coverage" view in security overview for an organization.
To do that, use the checkboxes to select which repositories you want to include, or use the search bar to narrow down to a specific subset of repositories, and enable or disable security features for that group. This is useful if you want to introduce a feature to your organization gradually over time, or if your organization requires a complex security setup where different features are enabled in different repositories. For example, if you are enabling a feature across a group of repositories, you may find the following filtering options helpful.
- To exclude certain repositories from the selection, you can assign a topic such as `test` to these repositories, then exclude them from the results with a search like `-topic:test`. 
- If a team uses repositories that all require a certain feature, you can use the team: filter to search for repositories where a team has write or admin access.
- If you're enabling code scanning, you can see which repositories are eligible for default setup with the search code-scanning-default-setup:eligible. 

To enable security features using security overview:
1. Navigate to the main page of the organization on GitHub.com.
2. Navigate to the Security tab.
:::image type="content" source="../media/security-tab-on-org.png" alt-text="Screenshot of the Security tab at the organization level.":::
3. Click on Coverage in the sidebar to display the "Security coverage" view.
:::image type="content" source="../media/security-coverage-dashboard.png" alt-text="Screenshot of the Security Coverage at the organization level.":::
4. Use the search bar to filter repositories in the "Security coverage" view by name or by the activation status of security features.
5. Choose each repository from the list whose security feature enablement you wish to change. To select every repository displayed on the page, click the checkbox next to "NUMBER Active." For selecting all repositories fitting your current search criteria, click the checkbox next to "NUMBER Active" and then click "Select all NUMBER repos."
6. Click Security settings next to NUMBER selected.
7. In the side panel, next to all the security features you want to enable or disable, select Enable or Disable. The security features that you can enable and disable in this view are:
- Dependency graph
- Dependabot alerts
- Dependabot security updates
- GitHub Advanced Security
- Code scanning default setup
- Secret scanning alerts
- Secret scanning as a push protection

As you make changes, the Apply changes button will report the number of security features you have edited. To confirm the changes, click Apply changes NUMBER. To close the panel without making any changes, click  “X”.

:::image type="content" source="../mediafeatures-apply-changes-org.png" alt-text="Screenshot of the features and apply changes sidebar at the organization level.":::

> [!NOTE]
> Enabling code scanning default setup will not override any existing configurations of advanced setup for the selected repositories, but it will override any existing configurations of default setup. 
> Also, enabling "Alerts" for secret scanning enables high-confidence alerts. If you want to enable non-provider alerts, you need to edit the repository, organization, or enterprise settings.



## Use the GitHub Advanced Security endpoints

The following table explains what endpoints are available for each Advanced Security feature with links to their documentation.

|    **Feature**    |                                                                                                     **Endpoints**                                                                                                     |                                                                              **Documentation**                                                                              |
|:-----------------:|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|
|   Code scanning   | Retrieve and update code scanning alerts from a repository. <br/> Create automated reports for code scanning alerts in an organization. <br/> Upload analysis results generated using offline code scanning tools. |                                                [Code Scanning API](https://docs.github.com/en/rest/reference/code-scanning)                                                 |
|  Secret scanning  |                                           Enable or disable secret scanning for a repository. <br/> Retrieve and update secret scanning alerts from a private repository.                                           | [Repos API](https://docs.github.com/en/rest/reference/repos#update-a-repository) <br/> [Secret Scanning API](https://docs.github.com/en/rest/reference/secret-scanning)  |
| Dependency review |                                                 Enable and disable dependency alerts and the dependency graph for a repository. <br/> Enable and disable security fixes for a repository. <br/> View dependency information.                                                  |            [Repos API](https://docs.github.com/en/rest/reference/repos) <br/> [GraphQL API](https://docs.github.com/en/graphql)             |

If you decide to use GitHub Actions to automate your security workflows, it's important to correctly set the permissions for the `GITHUB_TOKEN` used to make authenticated API calls. The `GITHUB_TOKEN` has default permissions depending on scope:

| **Scope**         | **Default access (permissive)** | **Default access (restricted)** | **Maximum access by forked repos** |
|:---------------:|:-----------------------------:|:-----------------------------:|:--------------------------------:|
| actions       | read/write  | none | read |
| checks        | read/write  | none | read |
| contents      | read/write  | read | read |
| deployments   | read/write  | none | read |
| id-token      | read/write  | none | read |
| issues        | read/write  | none | read |
| metadata      | read        | read | read |
| packages      | read/write  | none | read |
| pull-requests | read/write  | none | read |
| repository-projects | read/write | none | read |
| security-events     | read/write | none | read |
| statuses      | read/write  | none | read |

You can modify the permissions for the `GITHUB_TOKEN` in individual workflow files. If the default permissions for the `GITHUB_TOKEN` are restrictive, you might have to increase the permissions to allow some actions and commands to run successfully. If the default permissions are permissive, you can edit the workflow file to remove some permissions from the `GITHUB_TOKEN`. As a good security practice, you should grant the `GITHUB_TOKEN` the least required access.

You can also use the `permissions` key in your workflow files to modify permissions for the `GITHUB_TOKEN` for an entire workflow or for individual jobs. This key allows you to configure the minimum required permissions for a workflow or job. When the `permissions` key is used, all unspecified permissions are set to no access, except for the metadata scope, which always gets read access.

```yaml
name: Create issue on commit

on: [ push ]

jobs:
  create_commit:
    runs-on: ubuntu-latest
    permissions:
      issues: write
    steps:
      - name: Create issue using REST API
        run: |
          curl --request POST \
          --url http(s)://[hostname]/api/v3/repos/${{ github.repository }}/issues \
          --header 'authorization: Bearer ${{ secrets.GITHUB_TOKEN }}' \
          --header 'content-type: application/json' \
          --data '{
            "title": "Automated issue for commit: ${{ github.sha }}",
            "body": "This issue was automatically created by the GitHub Action workflow **${{ github.workflow }}**. \n\n The commit hash was: _${{ github.sha }}_."
            }' \
          --fail
```

In the preceding example, write access is granted for one scope for a single job.

Additionally, you can use the `permissions` key to add and remove read permissions for forked repositories, but typically you can't grant write access. The exception to this behavior is if you selected the **Send write tokens to workflows from pull requests** option in the GitHub Actions settings.

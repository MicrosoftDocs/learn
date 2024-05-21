Now that the security for your project is set up, all you have to do is to monitor and manage the GitHub Advanced Security features and alerts for your project.

In this unit, you learn how to use the Security Overview to monitor the security risks in your project. This unit also covers how to use the GitHub Advanced Security endpoints to manage the GitHub Advanced Security features and alerts.

## Use the Security Overview

> [!NOTE]
> The Security Overview is currently in beta and subject to change.

The Security Overview is available in the **Security** tab of organizations and repositories. You can use it to get a high-level view of the security status of your organization or to identify problematic repositories that require intervention.

- At the organization level, the Security Overview displays aggregate and repository-specific security information for repositories owned by your organization. You can also filter information per security feature.
- At the team level, the Security Overview displays repository-specific security information for repositories that the team has admin privileges for.
- At the repository level, the Security Overview shows which security features are enabled for the repository and offers the option to configure any available security features not currently in use.

:::image type="content" source="../media/security-overview.png" alt-text="Screenshot of the Security Overview at the organization level.":::

Thanks to its high level of interactivity and numerous filters, the Security Overview is useful for both broad and specific analyses of your organization's security status. For example, you can use it to monitor the adoption of features by your organization or by a specific team as you roll out GitHub Advanced Security to your enterprise. Or, use it to review all alerts of a specific type and severity level across all repositories in your organization.

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
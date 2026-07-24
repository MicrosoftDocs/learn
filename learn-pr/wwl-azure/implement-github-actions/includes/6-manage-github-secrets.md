Secrets are variables you create in an organization, repository, or repository environment. The secrets are available to use in GitHub Actions workflows. GitHub Actions can only read a secret if you explicitly include the secret in a workflow.

For secrets stored at the organization-level, you can use access policies to control which repositories can use organization secrets. Organization-level secrets let you share secrets between multiple repositories. This reduces the need for creating duplicate secrets. Updating an organization secret in one location also ensures that the change takes effect in all repository workflows that use that secret.

For secrets stored at the environment level, you can enable required reviewers to control access to the secrets. A workflow job can't access environment secrets unless approved by required approvers.

> [!NOTE]
> You can configure your workflows to authenticate directly to Azure to access resources.

## Define secret names

Secret names must follow GitHub's restrictions and clearly identify the credential or value they contain. Consistent names help workflow maintainers distinguish secrets from nonsensitive configuration variables. The following rules apply to secret names:

* Names can only contain alphanumeric characters (`[a-z]`, `[A-Z]`, `[0-9]`) or underscores (`_`). Spaces aren't allowed.
* Names must not start with the `GITHUB_` prefix.
* Names must not start with a number.
* Names are case insensitive.
* Names must be unique at the level they're created at.

To help ensure that GitHub redacts your secret in logs, avoid using structured data as the values of secrets. For example, avoid creating secrets that contain JSON or encoded Git blobs.

## Access secrets

Set the secret as an input or environment variable in the workflow file to make it available to an action. You can use and read secrets in a workflow file if you have access to edit the file. For more information, visit [Access permissions on GitHub](https://docs.github.com/get-started/learning-about-github/access-permissions-on-github).

GitHub Actions reads organization and repository secrets when it queues a workflow run. It reads environment secrets when a job that references the environment starts. You can also manage secrets using the REST API.

GitHub doesn't pass secrets, except for `GITHUB_TOKEN`, to workflows triggered from forked repositories. GitHub also withholds secrets from workflows triggered by Dependabot events and doesn't automatically pass them to reusable workflows. You can explicitly pass only the required secrets to a reusable workflow.

## Limit credential permissions

You can reduce credential exposure by granting the minimum permissions possible. For example, you can use deploy keys or a service account instead of personal credentials. You can grant read-only permissions when the workflow doesn't need to modify resources.

When generating a personal access token (classic), select the fewest scopes necessary. When generating a fine-grained personal access token, select the minimum permissions and repository access required.

For cloud providers that support OpenID Connect (OIDC), use OIDC to request short-lived, scoped access tokens instead of storing long-lived cloud credentials as secrets. OIDC reduces the impact of credential exposure and removes the need to rotate stored cloud credentials.

## Create secrets

To create repository secrets in a personal account repository, you must be a repository collaborator. For an organization repository, you must have `write` access. Environment secrets require repository owner access for a personal account repository or `admin` access for an organization repository. Only organization owners can create organization-level secrets. REST API requirements depend on the secret scope, endpoint, and token permissions.

You can create a repository secret by following these steps:

1. You can select **Settings** in the top navigation bar of your repository.
1. In the **Security** section of the left navigation pane, you can select the **Secrets and variables** dropdown.
1. You can select **Actions** to access the **Actions secrets and variables** page.

## Use secrets in a workflow

To provide an action with a secret as an input or environment variable, you can use the `secrets` context to access secrets created in your repository. The following example provides a fine-grained token to a GitHub-maintained action input and makes another token available to a shell command through an environment variable.

```yml
steps:
  - name: Check out a private tools repository
    uses: actions/checkout@v7
    with:
      repository: octo-org/private-tools
      token: ${{ secrets.REPO_ACCESS_TOKEN }}
      path: private-tools
      persist-credentials: false
  - name: Query the GitHub API
    env:
      GH_TOKEN: ${{ secrets.API_ACCESS_TOKEN }}
    run: gh api user
```

Secrets can't be directly referenced in `if:` conditionals. Consider setting secrets as job-level environment variables, then referencing the environment variables to conditionally run steps in the job.

If the value of a secret isn't set, the return value of an expression referencing the secret (such as `${{ secrets.API_ACCESS_TOKEN }}` in the example) is an empty string.


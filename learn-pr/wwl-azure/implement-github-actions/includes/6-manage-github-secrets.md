Secrets are variables you create in an organization, repository, or repository environment. The secrets are available to use in GitHub Actions workflows. GitHub Actions can only read a secret if you explicitly include the secret in a workflow.

For secrets stored at the organization-level, you can use access policies to control which repositories can use organization secrets. Organization-level secrets let you share secrets between multiple repositories. This reduces the need for creating duplicate secrets. Updating an organization secret in one location also ensures that the change takes effect in all repository workflows that use that secret.

For secrets stored at the environment level, you can enable required reviewers to control access to the secrets. A workflow job can't access environment secrets unless approved by required approvers.

> [!NOTE]
> You can configure your workflows to authenticate directly to Azure to access resources.

## Naming your secrets

The following rules apply to secret names:

* Names can only contain alphanumeric characters (`[a-z]`, `[A-Z]`, `[0-9]`) or underscores (`_`). Spaces aren't allowed.
* Names must not start with the `GITHUB_` prefix.
* Names must not start with a number.
* Names are case insensitive.
* Names must be unique at the level they're created at.

To help ensure that GitHub redacts your secret in logs, avoid using structured data as the values of secrets. For example, avoid creating secrets that contain JSON or encoded Git blobs.

## Accessing your secrets

Set the secret as an input or environment variable in the workflow file to make it available to an action. You can use and read secrets in a workflow file if you have access to edit the file. For more information, visit [Access permissions on GitHub](https://docs.github.com/get-started/learning-about-github/access-permissions-on-github).

Organization and repository secrets are read when a workflow run is queued, and environment secrets are read when a job referencing the environment starts. You can also manage secrets using the REST API.

## Limiting credential permissions

It's recommended to grant the minimum permissions possible. For example, instead of using personal credentials, use deploy keys or a service account. Consider granting read-only permissions if that's all that is needed, and limit access as much as possible.

When generating a personal access token (classic), select the fewest scopes necessary. When generating a fine-grained personal access token, select the minimum permissions and repository access required.

## Creating secrets

To create secrets or variables on GitHub for a personal account repository, you must be the repository owner. To create secrets or variables on GitHub for an organization repository, you must have `admin` access. Lastly, to create secrets or variables for a personal account repository or an organization repository through the REST API, you must have collaborator access.

Secrets can be created by:

* Select **Settings** in the top nav bar of your repository.
* In the **Security** section of the left-nav, select the **Secrets and variables** drop down.
* Select **Actions** to access the **Actions secrets and variables** page.

## Using secrets in a workflow

To provide an action with a secret as an input or environment variable, you can use the `secrets` context to access secrets created in your repository. The following code shows an example of accessing secrets in a workflow.

```yml
steps:
  - name: Hello world action
    with: # Set the secret as an input
      super_secret: ${{ secrets.SuperSecret }}
    env: # Or as an environment variable
      super_secret: ${{ secrets.SuperSecret }}
```

Secrets can't be directly referenced in `if:` conditionals. Consider setting secrets as job-level environment variables, then referencing the environment variables to conditionally run steps in the job.

If the value of a secret isn't set, the return value of an expression referencing the secret (such as `${{ secrets.SuperSecret }}` in the example) is an empty string.


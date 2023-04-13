Secret scanning is now enabled and configured on your private repositories and you were just notified of an alert. Your response to the alert mainly depends on the type of secret that got committed into the repository.

This unit walks you through the different ways to respond to a secret scanning alert. It also explores how you can create your own patterns to scan for the secrets that GitHub does not automatically detect.

## Respond to an alert

Once a secret has been committed into a repository, you should consider the secret compromised. GitHub recommends the following actions for compromised secrets:

- For a compromised GitHub personal access token, delete the compromised token, create a new token, and update any services that use the old token.
- For all other secrets, first verify that the secret committed to GitHub is valid. If so, create a new secret, update any services that use the old secret, and then delete the old secret.

Once you have taken the appropriate actions for the secret, you can resolve the alert by clicking it under **Security > Secret scanning alerts**, and choosing a reason for resolving it in the **Close as** drop-down:

:::image type="content" source="../media/mark-alert-as.png" alt-text="Screenshot of an alert with Mark as drop-down displayed.":::

## Create a custom pattern

As mentioned earlier on in the "What is secret scanning?" unit of this module, GitHub automatically scans public and private repositories for secret patterns provided by GitHub and GitHub partners. However, for private repositories with GitHub Advanced Security, you can also scan for other secret patterns, such as those that are internal to your organization.

For these situations, you can define custom secret scanning patterns in your enterprise, organization, or private repository. You can define up to 500 custom patterns for each organization or enterprise account, and up to 100 custom patterns per private repository.

After you create a custom pattern, secret scanning scans for the custom secret in private repositories in your organization. This scan includes the repository's entire Git history on all branches, and alerts repository administrators the same way as for any other secret.

The following sections cover how to create custom patterns for organizations and private repositories.

### For a private repository

Follow the steps below to create a custom pattern for a private repository:

1. In your repository, navigate to **Settings > Code security & analysis**.
2. Under **GitHub Advanced Security > Secret scanning**, click **New pattern**.
3. Provide the following details for your custom pattern:
    - The name of the pattern
    - The pattern of the secret specified as Hyperscan regex
    - A sample test string to make sure your configuration is matching the patterns you expect

:::image type="content" source="../media/create-custom-pattern.png" alt-text="Screenshot of New custom pattern screen.":::

4. Optionally provide other surrounding content or additional match requirements for the secret format by using the **More options** drop-down, and click **Create pattern**.

### For an organization

Follow the steps below to create a custom pattern for an organization:

1. In your organization, navigate to **Settings > Code security & analysis**.
2. Under **GitHub Advanced Security > Secret scanning**, click **New pattern**.
3. Provide the following details for your custom pattern:
    - The name of the pattern
    - The pattern of the secret specified as Hyperscan regex
    - A sample test string to make sure your configuration is matching the patterns you expect
4. Optionally provide other surrounding content or additional match requirements for the secret format by using the **More options** drop-down, and click **Create pattern**.

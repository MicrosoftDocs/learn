In GitHub, secrets are any authentication credentials, like tokens or private keys, you might be using in a project to connect to an external service. If you commit a secret into a repository, anyone with read access to the repository can use it to access the external service with your privileges. That's where secret scanning comes into play.

Secret scanning is a GitHub Advanced Security feature that scans repositories for known types of secrets. It prevents the fraudulent use of secrets that were committed accidentally.

## How does secret scanning work?

Secret scanning automatically scans your entire Git history on all branches present in your GitHub repository for any secrets. When a secret with a known pattern is committed into a private or public repository in your project, secret scanning sends a notification to all repository administrators about the commit that contains the secret. Repository administrators can then view the list of all detected secrets in the **Security** tab of the repository.

:::image type="content" source="../media/detected-secrets-overview.png" alt-text="Screenshot of secrets detected by secret scanning.":::

GitHub also notifies the service provider who issued the secret. The service provider can then take any appropriate action like revoking the secret, issuing a new secret or reaching out to you directly depending on the associated risks to you or them.

For a list of the service providers and patterns automatically detected by GitHub in public and private repositories, please check out [About secret scanning](https://docs.github.com/en/code-security/secret-scanning/about-secret-scanning).

If you cannot see the secrets used in your organization in the list, you may be able to create custom patterns for them that will be detected by secret scanning. This module covers custom patterns later on in the "Use secret scanning" unit.

## Who is secret scanning available to?

Secret scanning is available for all public repositories, and for private repositories owned by organizations on an enterprise plan where GitHub Advanced Security is enabled.

This means that:

- Secret scanning is enabled by default on public repositories and **cannot be configured or turned off**. If you want to configure or disable secret scanning on a public repository, you must switch the repository to a private one with GitHub Advanced Security.
- Secret scanning **must be enabled manually** on private repositories. The "Configure secret scanning" unit of this module covers how to do this.

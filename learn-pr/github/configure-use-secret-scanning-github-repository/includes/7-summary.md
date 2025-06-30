The goal of this module was to help you understand how secret scanning works so you can configure and use it efficiently in your project.

Secret scanning is enabled by default on all public repositories and can be enabled at the organization or private repository level on an enterprise plan with a GitHub Advanced Security license. Secret scanning scans:

- Entire git histories on all branches present in a GitHub repository
- Descriptions and comments in issues
- Titles, descriptions, and comments, in open and closed historical issues
- Titles, descriptions, and comments in pull requests
- Titles, descriptions, and comments in GitHub Discussions

GitHub will alert you when secrets are detected so the appropriate actions can be taken to secure your code according to the type of secret that was committed. And with push protection enabled, secret leaks can be prevented by blocking commits that contain known secrets.

For private repositories, the secret scanning configuration options also enable you to exclude specific files from scans, choose the people to notify of alerts, and create custom patterns for the secrets in your project not automatically detected by GitHub.

Alongside secret scanning, GitHub Advanced Security offers other features to improve your software security posture:

- **Dependency Graph:** Understand how your project depends on open-source libraries and get notified when vulnerable packages are detected.
- **Dependabot Security Updates:** Automatically open pull requests that fix vulnerabilities in your dependencies.
- **Dependabot Version Updates:** Keep dependencies up to date with automatic PRs for the latest versions.
- **Code Scanning:** Scan your code for security vulnerabilities and coding errors using CodeQL and other engines.

With secret scanning in GitHub, you can be aware of exposed secrets and respond accordingly to protect your assets.

## Learn more

Here are some links to more information on the topics we discussed in this module:

- [GitHub Security Features Overview](https://docs.github.com/code-security/getting-started/github-security-features) — What security tools are available in GitHub.
- [About Secret Scanning](https://docs.github.com/code-security/secret-scanning/about-secret-scanning) — Learn what secret scanning does and why it's important.
- [Enabling Secret Scanning Features](https://docs.github.com/code-security/secret-scanning/enabling-secret-scanning-features) — How to turn on secret scanning in your repos.
- [Managing Alerts from Secret Scanning](https://docs.github.com/code-security/secret-scanning/managing-alerts-from-secret-scanning) — What to do when secrets are found.
- [Defining Custom Patterns for Secret Scanning](https://docs.github.com/code-security/secret-scanning/defining-custom-patterns-for-secret-scanning) — Scan for custom or company-specific secrets.
- [Supported Secret Scanning Patterns](https://docs.github.com/code-security/secret-scanning/introduction/supported-secret-scanning-patterns) — See what GitHub can detect out-of-the-box.
- [Granting Access to Security Alerts](https://docs.github.com/repositories/managing-your-repositorys-settings-and-features/enabling-features-for-your-repository/managing-security-and-analysis-settings-for-your-repository#granting-access-to-security-alerts) — Let the right people review and resolve security alerts.

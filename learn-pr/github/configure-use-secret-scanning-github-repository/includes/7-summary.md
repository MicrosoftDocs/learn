The goal of this module is to help you understand how secret scanning works so you can configure and use it efficiently in your project.

Secret scanning is enabled by default for all public repositories. For private repositories, you can enable secret scanning at the organization level or for individual repositories if your enterprise plan includes a GitHub Advanced Security license.

Secret scanning scans the following locations:

* Entire Git histories on all branches present in a GitHub repository
* Descriptions and comments in issues
* Titles, descriptions, and comments in open and closed historical issues
* Titles, descriptions, and comments in pull requests
* Titles, descriptions, and comments in GitHub Discussions

When secrets are detected, GitHub alerts you so you can take the appropriate actions to secure your code, based on the type of secret that was committed. If push protection is enabled, secret scanning can also block commits that contain known secrets, preventing leaks before they occur.

For private repositories, secret scanning configuration options allow you to:

* Exclude specific files from scans
* Select who should receive alerts
* Create custom patterns for secrets in your project that are not automatically detected by GitHub

Alongside secret scanning, GitHub Advanced Security offers additional features to improve your software security posture:

* **Dependency Graph** – Understand how your project depends on open-source libraries and receive alerts when vulnerable packages are detected.
* **Dependabot Security Updates** – Automatically open pull requests to fix vulnerabilities in your dependencies.
* **Dependabot Version Updates** – Keep dependencies up to date with automatic pull requests for the latest versions.
* **Code Scanning** – Scan your code for security vulnerabilities and coding errors using CodeQL and other engines.

With secret scanning in GitHub, you can detect exposed secrets early and respond quickly to protect your assets.

## Learn more

Here are some links to more information on the topics covered in this module:

* [GitHub Security Features Overview](https://docs.github.com/code-security/getting-started/github-security-features) — Overview of the security tools available in GitHub.
* [About Secret Scanning](https://docs.github.com/code-security/secret-scanning/about-secret-scanning) — What secret scanning does and why it’s important.
* [Enabling Secret Scanning Features](https://docs.github.com/code-security/secret-scanning/enabling-secret-scanning-features) — How to turn on secret scanning in your repositories.
* [Managing Alerts from Secret Scanning](https://docs.github.com/code-security/secret-scanning/managing-alerts-from-secret-scanning) — How to respond when secrets are found.
* [Defining Custom Patterns for Secret Scanning](https://docs.github.com/code-security/secret-scanning/defining-custom-patterns-for-secret-scanning) — How to scan for custom or organization-specific secrets.
* [Supported Secret Scanning Patterns](https://docs.github.com/code-security/secret-scanning/introduction/supported-secret-scanning-patterns) — Patterns GitHub can detect by default.
* [Granting Access to Security Alerts](https://docs.github.com/repositories/managing-your-repositorys-settings-and-features/enabling-features-for-your-repository/managing-security-and-analysis-settings-for-your-repository#granting-access-to-security-alerts) — How to give the right people access to review and resolve security alerts.

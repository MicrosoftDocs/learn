The goal of this module is to help you understand how secret scanning works so you can configure and use it effectively in your project.

Secret scanning is turned on by default for all public repositories. In private repositories, you can enable it at the organization level or for individual repositories if your enterprise plan includes a GitHub Advanced Security license.

Secret scanning checks for exposed secrets in:

* All Git histories on every branch in a repository
* Descriptions and comments in issues
* Titles, descriptions, and comments in both open and closed issues
* Titles, descriptions, and comments in pull requests
* Titles, descriptions, and comments in GitHub Discussions

When GitHub detects a secret, it alerts you so you can take the right actions to secure your code. The response depends on the type of secret that was committed. If push protection is enabled, secret scanning can also block commits that contain known secrets, preventing leaks before they happen.

In private repositories, secret scanning configuration options let you:

* Exclude specific files from scans
* Choose who should receive alerts
* Create custom patterns for secrets in your project that GitHub doesn’t detect automatically

GitHub Advanced Security also includes other features to improve your software security posture:

* **Dependency Graph**—See how your project depends on open-source libraries and get alerts for vulnerable packages.
* **Dependabot Security Updates**—Automatically open pull requests to fix vulnerabilities in dependencies.
* **Dependabot Version Updates**—Keep dependencies current with automated pull requests for the latest versions.
* **Code Scanning**—Detect security vulnerabilities and coding errors using CodeQL and other scanning engines.

With secret scanning in GitHub, you can find exposed secrets early and act quickly to protect your assets.

## Learn more

* [GitHub Security Features Overview](https://docs.github.com/code-security/getting-started/github-security-features)—Overview of the security tools available in GitHub.
* [About Secret Scanning](https://docs.github.com/code-security/secret-scanning/about-secret-scanning)—What secret scanning does and why it’s important.
* [Enabling Secret Scanning Features](https://docs.github.com/code-security/secret-scanning/enabling-secret-scanning-features)—How to turn on secret scanning in your repositories.
* [Managing Alerts from Secret Scanning](https://docs.github.com/code-security/secret-scanning/managing-alerts-from-secret-scanning)—How to respond when secrets are found.
* [Defining Custom Patterns for Secret Scanning](https://docs.github.com/code-security/secret-scanning/defining-custom-patterns-for-secret-scanning)—How to scan for custom or organization-specific secrets.
* [Supported Secret Scanning Patterns](https://docs.github.com/code-security/secret-scanning/introduction/supported-secret-scanning-patterns)—Patterns GitHub can detect by default.
* [Granting Access to Security Alerts](https://docs.github.com/repositories/managing-your-repositorys-settings-and-features/enabling-features-for-your-repository/managing-security-and-analysis-settings-for-your-repository#granting-access-to-security-alerts)—How to give the right people access to review and resolve security alerts.

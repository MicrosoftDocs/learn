The goal of this module was to help you understand how secret scanning works so you can configure and use it efficiently in your project.

Secret scanning is enabled by default on all public repositories and can be enabled at the organization or private repository level on an enterprise plan with a GitHub Advanced Security license. Secret scanning scans:

- Entire git histories on all branches present in a GitHub repository
- Descriptions and comments in issues
- Titles, descriptions, and comments, in open and closed historical issues
- Titles, descriptions, and comments in pull requests
- Titles, descriptions, and comments in GitHub Discussions

GitHub will alert you when secrets are detected so the appropriate actions can be taken to secure your code according to the type of secret that was committed. And with push protection enabled, secret leaks can be prevented by blocking commits that contain known secrets. 

For private repositories, the secret scanning configuration options also enable you to exclude specific files from scans, choose the people to notify of alerts, and create custom patterns for the secrets in your project that aren't automatically detected by GitHub.

With secret scanning in GitHub, you can be aware of exposed secrets and respond accordingly to protect your assets.

## Learn more

Here are some links to more information on the topics we discussed in this module:

- [Keeping secrets secure with secret scanning](https://docs.github.com/code-security/secret-scanning)
- [Learning about GitHub security features](https://docs.github.com/code-security/getting-started/github-security-features)
- [Learning about secret scanning](https://docs.github.com/code-security/secret-scanning/about-secret-scanning)
- [Configuring secret scanning for your repositories](https://docs.github.com/code-security/secret-scanning/configuring-secret-scanning-for-your-repositories)
- [Learning about the  filter pattern cheat sheet](https://docs.github.com/actions/learn-github-actions/workflow-syntax-for-github-actions#filter-pattern-cheat-sheet)
- [Granting access to security alerts](https://docs.github.com/repositories/managing-your-repositorys-settings-and-features/enabling-features-for-your-repository/managing-security-and-analysis-settings-for-your-repository#granting-access-to-security-alerts)
- [Managing alerts from secret scanning](https://docs.github.com/code-security/secret-scanning/managing-alerts-from-secret-scanning)
- [Defining custom patterns for secret scanning](https://docs.github.com/code-security/secret-scanning/defining-custom-patterns-for-secret-scanning)
- [Learning about Hyperscan Pattern Support](http://intel.github.io/hyperscan/dev-reference/compilation.html#pattern-support)
- [Secret scanning patterns](https://docs.github.com/code-security/secret-scanning/secret-scanning-patterns)
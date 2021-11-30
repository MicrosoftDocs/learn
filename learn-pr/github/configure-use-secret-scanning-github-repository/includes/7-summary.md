The goal of this module was to help you understand how secret scanning works so you can configure and use it efficiently in your project.

Secret scanning is enabled by default on all public repositories and can be enabled at the organization or private repository level on an enterprise plan with an Advanced Security license. Secret scanning scans the code on all branches present in your GitHub repository and alerts you every time a secret is accidentally committed into a repository. You are then able to take the appropriate actions to secure your code according to the type of secret that was committed.

For private repositories, secret scanning's configuration options also enable you to exclude specific files from scans, choose the people to notify of alerts, and create custom patterns for the secrets in your project that are not automatically detected by GitHub.

## Learn more

Here are some links to more information on the topics we discussed in this module:

- [GitHub security features](https://docs.github.com/en/code-security/getting-started/github-security-features)
- [About secret scanning](https://docs.github.com/en/code-security/secret-scanning/about-secret-scanning)
- [Configuring secret scanning for your repositories](https://docs.github.com/en/code-security/secret-scanning/configuring-secret-scanning-for-your-repositories)
- [Filter pattern cheat sheet](https://docs.github.com/en/actions/learn-github-actions/workflow-syntax-for-github-actions#filter-pattern-cheat-sheet)
- [Granting access to security alerts](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/enabling-features-for-your-repository/managing-security-and-analysis-settings-for-your-repository#granting-access-to-security-alerts)
- [Managing alerts from secret scanning](https://docs.github.com/en/code-security/secret-scanning/managing-alerts-from-secret-scanning)
- [Defining custom patterns for secret scanning](https://docs.github.com/en/code-security/secret-scanning/defining-custom-patterns-for-secret-scanning)
- [Hyperscan Pattern Support](http://intel.github.io/hyperscan/dev-reference/compilation.html#pattern-support)

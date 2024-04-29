The goal of this module was to explain how you can use GitHub tools to help manage your dependencies and identify vulnerabilities that can affect the security of your project. 

GitHub Dependabot is enabled by default for all public repositories. You can also use the Dependabot features in private repositories by enabling the dependency graph and Dependabot. When enabled, Dependabot alerts notify you of vulnerabilities in your dependencies and security updates will automatically generate pull requests that try to fix them. Version updates will also automatically generate pull requests to update your dependencies to the latest non-breaking version.

You learned how to configure your notifications based on how you want to receive alerts about vulnerabilities in your repository. You also learned how to use the security digest email as a concise way to receive a daily or weekly summary of alerts. 

Finally, you learned about dependency review and how to configure the dependency review action to analyze dependency changes on every pull request. Leveraging these tools makes it easier to understand and manage your dependencies to better protect your projects on GitHub.

### Learn more

Use these links to learn more about the information covered in this module:

- [Securing your software supply chain](https://docs.github.com/en/code-security/supply-chain-security)
- [Keeping your supply chain secure with Dependabot](https://docs.github.com/en/code-security/dependabot)
- [About the Dependency graph](https://docs.github.com/en/code-security/supply-chain-security/understanding-your-software-supply-chain/about-the-dependency-graph)
- [Supported package ecosystems](https://docs.github.com/en/enterprise-server@3.8/code-security/supply-chain-security/understanding-your-software-supply-chain/about-the-dependency-graph#supported-package-ecosystems)
- [Exporting a software bill of materials for your repository](https://docs.github.com/en/code-security/supply-chain-security/understanding-your-software-supply-chain/exporting-a-software-bill-of-materials-for-your-repository)
- [What is Dependabot](https://docs.github.com/en/code-security/supply-chain-security/understanding-your-software-supply-chain/about-supply-chain-security#what-is-dependabot)
- [About supply chain security](https://docs.github.com/en/code-security/supply-chain-security/understanding-your-software-supply-chain/about-supply-chain-security)
- [About Dependabot alerts](https://docs.github.com/en/code-security/dependabot/dependabot-alerts/about-dependabot-alerts)
- [Configuring Dependabot alerts](https://docs.github.com/en/code-security/dependabot/dependabot-alerts/configuring-dependabot-alerts)
- [Viewing and updating Dependabot alerts](https://docs.github.com/en/code-security/dependabot/dependabot-alerts/viewing-and-updating-dependabot-alerts)
- [Managing security and analysis settings for your repository](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/enabling-features-for-your-repository/managing-security-and-analysis-settings-for-your-repository)
- [Dependabot quickstart guide](https://docs.github.com/en/code-security/getting-started/dependabot-quickstart-guide)
- [Managing pull requests for dependency updates](https://docs.github.com/en/code-security/dependabot/working-with-dependabot/managing-pull-requests-for-dependency-updates)
- [About Dependabot version updates](https://docs.github.com/en/code-security/dependabot/dependabot-version-updates/about-dependabot-version-updates)
- [Configuring Dependabot version updates](https://docs.github.com/en/code-security/dependabot/dependabot-version-updates/configuring-dependabot-version-updates)
- [Listing dependencies configured for version updates](https://docs.github.com/en/code-security/dependabot/dependabot-version-updates/listing-dependencies-configured-for-version-updates)
- [Configuration options for the dependabot.yml file](https://docs.github.com/en/code-security/dependabot/dependabot-version-updates/configuration-options-for-the-dependabot.yml-file)
- [Configuring notifications for vulnerable dependencies](https://docs.github.com/en/code-security/supply-chain-security/managing-vulnerabilities-in-your-projects-dependencies/configuring-notifications-for-vulnerable-dependencies)
- [About Dependabot security updates](https://docs.github.com/en/code-security/supply-chain-security/managing-vulnerabilities-in-your-projects-dependencies/about-dependabot-security-updates)
- [Configuring Dependabot security updates](https://docs.github.com/en/code-security/supply-chain-security/managing-vulnerabilities-in-your-projects-dependencies/configuring-dependabot-security-updates)
- [Managing security and analysis settings for your organization](https://docs.github.com/en/organizations/keeping-your-organization-secure/managing-security-and-analysis-settings-for-your-organization)
- [GitHub GraphQL API](https://docs.github.com/en/graphql)
- [Configuring notifications for Dependabot alerts](https://docs.github.com/en/code-security/dependabot/dependabot-alerts/configuring-notifications-for-dependabot-alerts)
- [Configuring notifications](https://docs.github.com/en/account-and-profile/managing-subscriptions-and-notifications-on-github/setting-up-notifications/configuring-notifications)
- [About Dependabot auto-triage rules](https://docs.github.com/en/code-security/dependabot/dependabot-auto-triage-rules/about-dependabot-auto-triage-rules)
- [Using GitHub preset rules to prioritize Dependabot alerts](https://docs.github.com/en/code-security/dependabot/dependabot-auto-triage-rules/using-github-preset-rules-to-prioritize-dependabot-alerts)
- [Customizing auto-triage rules to prioritize Dependabot alerts](https://docs.github.com/en/code-security/dependabot/dependabot-auto-triage-rules/customizing-auto-triage-rules-to-prioritize-dependabot-alerts)
- [Managing alerts that have been automatically dismissed by a Dependabot auto-triage rule](https://docs.github.com/en/code-security/dependabot/dependabot-auto-triage-rules/managing-automatically-dismissed-alerts)
- [About the GraphQL API](https://docs.github.com/en/graphql/overview/about-the-graphql-api)
- [Introduction to GraphQL](https://docs.github.com/en/graphql/guides/introduction-to-graphql)
- [Using the Explorer](https://docs.github.com/en/graphql/guides/using-the-explorer)
- [Forming calls with GraphQL](https://docs.github.com/en/graphql/guides/forming-calls-with-graphql)
- [Configuring dependency review](https://docs.github.com/en/code-security/supply-chain-security/understanding-your-software-supply-chain/configuring-dependency-review)
- [dependency-review-action](https://github.com/actions/dependency-review-action)
- [GitHub Action - Dependency Review](https://github.com/marketplace/actions/dependency-review)
- [Reviewing dependency changes in a pull request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests/reviewing-dependency-changes-in-a-pull-request)

### Resource Links

1. [GitHub Advisory Database](https://github.com/advisories)
2. [Common Vulnerability Scoring System (CVSS), Section 5](https://www.first.org/cvss/v3.1/specification-document)
3. [SPDX](https://spdx.github.io/spdx-spec/v2.3/)
4. [Executive Order 14028](https://www.gsa.gov/technology/technology-products-services/it-security/executive-order-14028-improving-the-nations-cybersecurity)
5. [Managing GitHub Connect](https://docs.github.com/en/enterprise-server@3.12/admin/configuration/configuring-github-connect/managing-github-connect)
6. [GraphiQL App](https://github.com/skevy/graphiql-app)
7. [GitHub marketplace](https://github.com/marketplace/)
8. [dependency-review-action](https://github.com/marketplace/actions/dependency-review)
9. [Dependency review configuration options](https://github.com/marketplace/actions/dependency-review#configuration-options)

GitHub has many features that help you improve and maintain the quality of your code. Some of these are included in all plans, such as dependency graph and Dependabot alerts. Others only run in a limited functionality mode on public repositories. There are also others that require a GitHub Advanced Security license to run on private repositories.

In this unit, you'll learn more about GitHub Advanced Security. You'll also discover what a project with GitHub Advanced Security looks like.

## The GitHub Advanced Security features

The table below summarizes the availability of GitHub Advanced Security features on public and private repositories.

## GitHub Security Feature Comparison Table: Open Source vs. Private Repositories

| Feature | Public Repositories (All Plans) | Private Repositories (Free & Pro) | Private Repositories (Team & Enterprise) | GitHub Advanced Security (Enterprise Cloud) |
|---|---|---|---|---|
| **Dependabot** | Full functionality | Limited (version updates only) | Full functionality | Full functionality + Security updates, automated PRs |
| **Secret Scanning** | Basic (public secrets & partner integrations) | No | No | Yes (100+ token types, custom patterns) |
| **Code Scanning** | No | No | No | Yes (vulnerability detection, prioritization) |
| **Security Overview** | Beta (limited access) | No | No | Yes (security posture visualization, insights) |
| **Dependency Review** | No | No | No | Yes (dependency risk scoring, security advisories) |
| **Security Updates** | No | No | Automated for Dependabot alerts | Automated for Dependabot & code scanning alerts |
| **Automated Pull Request Creation** | Yes | No | Yes | Yes (for Dependabot & security alerts) |



As outlined in the preceding table, all GitHub Advanced Security features except for the Security Overview are enabled by default for all public repositories on GitHub.com. To access these features on private and internal repositories, you need a GitHub enterprise account with a GitHub Advanced Security license.

A GitHub Advanced Security license provides the following additional features for private and internal repositories:

- **Code scanning**: Automatically detect common vulnerabilities and coding errors
- **Secret scanning**: Receive alerts when secrets or keys are checked in, exclude files from scanning, and define up to 100 custom patterns
- **Dependency review**: Show the full impact of changes to dependencies and see details of any vulnerable versions before you merge a pull request
- **Dependabot* security*: Automatically check for updates and security vulnerabilities in existing dependencies and suggest updates through pull requests.

- **Security Overview**: Review the security configuration and alerts for an organization and identify the repositories at greatest risk

## GitHub Advanced Security in the software development lifecycle

So what difference do these GitHub Advanced Security features make in your software-development lifecycle? Let's have a look at a basic security scenario first.

:::image type="content" source="../media/basic-scenario.png" alt-text="Image representing the different stages of the software development lifecycle in a traditional security approach.":::

This example illustrates a traditional "security as a gate" approach in which a single security test or a series of security tests take place during the quality-assurance phase. In this scenario, security usually ends up being a bottleneck to shipping the software. This is what your company wants to fix by shifting security left.

Now let's look at the same software development lifecycle with GitHub Advanced Security.

:::image type="content" source="../media/github-advanced-security-scenario.png" alt-text="Image representing the different stages of the software development lifecycle with GitHub Advanced Security.":::

In this scenario, security is set up right from the beginning via security policies at the project configuration stage. Developers then get alerted of potential security issues at every step of the development process:

- Code scanning scans for potential vulnerabilities and coding errors at every commit and merge.
- Secret scanning also scans for tokens and private keys that might have been accidentally committed at every commit and merge.
- Dependabot proactively suggests security updates for dependencies with known vulnerabilities and version updates for outdated dependencies, helping address potential security vulnerabilities and version-related issues.
- Dependency review prevents new vulnerable dependencies from being added to repositories by checking what changes have occurred in manifest files compared to the current state of the repo at the pull request stage.

In addition, the Security Overview offers administrators a high-level view of the project's security status. This lets administrators identify problematic repositories that require intervention.

When it's time for quality assurance, your code's security has already been reviewed multiple times. There's less chance for a bottleneck right before shipping and less technical debt.

GitHub has many features that help you improve and maintain the quality of your code. Some of these features are included in all plans, such as dependency graph and Dependabot alerts. Others only run in a limited functionality mode on public repositories. There are also others that require a GitHub Advanced Security license to run on private repositories.

In this unit, you learn more about GitHub Advanced Security, and discover what a project with GitHub Advanced Security looks like.

## The GitHub Advanced Security features

The following table summarizes the availability of GitHub Advanced Security features on public and private repositories.

| **Feature**         | **Public repository**           | **Private repository without Advanced Security** | **Private repository with Advanced Security** |
| :-----------------: | :---------------------------: | :--------------------------------------------: | :-----------------------------------------: |
| Code scanning     | Yes                         | No                                           | Yes                                        |
| Secret scanning   | Yes (limited functionality only) | No                                           | Yes                                       |
| Dependency review | Yes                         | No                                           | Yes                                       |
| Security Overview | No                          | No                                           | Yes                                          |

As outlined in the preceding table, all GitHub Advanced Security features except for the Security Overview are enabled by default for all public repositories on GitHub.com. To access these features on private and internal repositories, you need a GitHub enterprise account with a GitHub Advanced Security license.

A GitHub Advanced Security license provides these features for private and internal repositories:

- **Code scanning**: Automatically detects common vulnerabilities and coding errors.
- **Secret scanning**: Receives alerts when secrets or keys are checked in, excludes files from scanning, and defines up to 100 custom patterns.
- **Dependency review**: Shows the full effect of changes to dependencies and sees details of any vulnerable versions before you merge a pull request.
- **Security Overview**: Reviews the security configuration and alerts for an organization and identifies the repositories at greatest risk.

## GitHub Advanced Security in the software development lifecycle

So what difference do the GitHub Advanced Security features make in your software-development lifecycle? Let's have a look at a basic security scenario first.

:::image type="content" source="../media/basic-scenario.png" alt-text="Image representing the different stages of the software development lifecycle in a traditional security approach.":::

This example illustrates a traditional *security as a gate* approach in which a single security test or a series of security tests take place during the quality-assurance phase. In this scenario, security usually ends up being a bottleneck to shipping the software. This situation is what your company wants to fix by shifting security left.

Now let's look at the same software development lifecycle with GitHub Advanced Security.

:::image type="content" source="../media/github-advanced-security-scenario.png" alt-text="Image representing the different stages of the software development lifecycle with GitHub Advanced Security.":::

In this scenario, security is set up right from the beginning through security policies at the project configuration stage. Developers are alerted of potential security issues at every step of the development process:

- **Code scanning**: Scans at every commit and merge for potential vulnerabilities and coding errors.
- **Secret scanning**: Scans at every commit and merge for tokens and private keys that were accidentally committed.
- **Dependency review**: Keeps track of the project dependency changes and their effect on project security. It compares the repository manifest files to the databases of known vulnerabilities at every pull request.

In addition, the **Security Overview** offers administrators a high-level view of the project's security status. This view lets administrators identify problematic repositories that require intervention.

The security of your code is reviewed multiple times before you get to the quality assurance stage, so there's less chance for a bottleneck right before shipping, and less technical debt.
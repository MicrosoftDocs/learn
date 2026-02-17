GitHub provides a comprehensive suite of security and code quality tools that help you protect your code, manage vulnerabilities, and maintain a healthy codebase. Before diving into secret scanning specifics, it's helpful to understand where secret scanning fits within GitHub's broader security ecosystem.

## Overview of GitHub's security and code quality tools

GitHub organizes its security and code quality features into several categories: supply chain security, secret security, code security, and code quality. Some features are available on all GitHub plans, while others require a paid add-on product: **GitHub Secret Protection** or **GitHub Code Security**. Many of the paid features are also available for free on public repositories.

### Supply chain security

Supply chain security features help you understand and protect the dependencies your project relies on.

#### Dependency graph

The dependency graph allows you to explore the packages and ecosystems that your repository depends on, and the repositories and packages that depend on your repository. It provides visibility into your project's full dependency tree, helping you understand where your code has external dependencies.

#### Software Bill of Materials (SBOM)

You can export the dependency graph of your repository as an SPDX-compatible Software Bill of Materials (SBOM). An SBOM provides a formal, machine-readable inventory of your project's components and dependencies, which is increasingly required for compliance and auditing purposes.

#### GitHub Advisory Database

The GitHub Advisory Database is a curated list of known security vulnerabilities that you can browse, search, and filter. When a vulnerability is discovered in one of your dependencies, you can check this database for details about the vulnerability and its impact.

#### Dependabot alerts and security updates

Dependabot monitors your dependencies for known security vulnerabilities. When a vulnerability is found, Dependabot creates an alert and can automatically generate pull requests to update the affected dependency to a secure version. Default auto-triage rules curated by GitHub help filter out false positives.

#### Dependabot version updates

Dependabot can also keep your dependencies up-to-date by automatically creating pull requests when newer versions are available. Keeping dependencies current makes it easier to apply security patches and reduces your exposure to vulnerabilities.

#### Dependency review

Dependency review shows the full impact of dependency changes in a pull request. Before merging a pull request, you can review what dependencies were added, removed, or updated, and see whether any vulnerable versions are introduced. Dependency review requires **GitHub Code Security** for private repositories, but is available for free on public repositories.

### Secret security

Secret security features detect and prevent the exposure of credentials in your codebase.

#### Secret scanning alerts for partners

For public repositories, GitHub automatically scans for known secret patterns from over 200 service providers. When a leaked secret is detected, GitHub notifies the relevant service provider so they can revoke or rotate the compromised credential. This feature is enabled by default on all public repositories at no cost.

#### Push protection for users

Push protection for users is a personal security feature that automatically blocks you from accidentally committing secrets to public repositories, regardless of whether the repository has secret scanning enabled. This feature is on by default for all users and can be managed through personal account settings.

#### Secret scanning alerts for users

Secret scanning alerts for users extend the detection capabilities to notify repository administrators and security teams when secrets are found in a repository. You can view alerts in the repository's Security tab with details about the secret type, location, and validity. This feature requires **GitHub Secret Protection** for private repositories, but is available for free on public repositories.

#### Copilot secret scanning

Copilot secret scanning uses AI-powered generic secret detection to identify unstructured secrets (like passwords) in your source code that don't match a specific known pattern. This feature expands detection beyond the structured patterns that standard secret scanning identifies.

#### Push protection (repository-level)

Push protection blocks commits containing high-confidence secret patterns before they're pushed to a repository. If a contributor bypasses the block, GitHub creates an alert. For private repositories, push protection requires **GitHub Secret Protection**. It's available for free on public repositories.

#### Delegated bypass for push protection

Delegated bypass lets you control which individuals, roles, and teams can bypass push protection. It implements a review and approval process for pushes that contain secrets, adding an extra layer of governance.

#### Custom patterns for secret scanning

Organizations can define custom patterns for secret scanning to detect credentials and tokens that are specific to their internal systems and not covered by the default patterns.

### Code security

Code security features help you find and fix security vulnerabilities in your codebase.

#### Code scanning

Code scanning uses static analysis to automatically detect security vulnerabilities and coding errors in new or modified code. Potential problems are highlighted with detailed information so you can fix them before merging into the default branch. Code scanning requires **GitHub Code Security** for private repositories, but is available for free on public repositories.

#### CodeQL CLI

The CodeQL CLI lets you run CodeQL analysis locally on your software projects and generate code scanning results for upload to GitHub. It's the same analysis engine behind GitHub's code scanning feature.

#### Copilot Autofix for code scanning

Copilot Autofix automatically generates suggested fixes for code scanning alerts. When code scanning detects a vulnerability, Copilot Autofix provides a remediation suggestion that you can review and apply, significantly reducing the time needed to fix issues.

#### Custom auto-triage rules for Dependabot

Custom auto-triage rules let you control how Dependabot alerts are managed at scale. You can configure rules to automatically dismiss, snooze, or trigger security updates for specific alerts based on your organization's priorities.

#### Security campaigns

Security campaigns enable organizations to fix security alerts at scale by creating coordinated efforts to reduce the security backlog. Security campaigns help organize and prioritize remediation work across multiple repositories.

### Code quality

Code quality features help you maintain a healthy, reliable, and maintainable codebase.

#### GitHub Code Quality

GitHub Code Quality uses CodeQL rule-based analysis and AI-powered analysis to flag code quality issues in pull requests and repository scans. Code Quality identifies reliability and maintainability issues, provides Copilot-powered autofixes, and enables you to set up rulesets that enforce code quality standards on pull requests.

> [!NOTE]
> GitHub Code Quality is currently in public preview and is available for organization-owned repositories on GitHub Team and GitHub Enterprise Cloud plans.

### General security features

GitHub also provides foundational security features that support your overall security posture.

#### Security policy

You can add a security policy to your repository that provides instructions for users to confidentially report security vulnerabilities they discover in your project.

#### Security advisories

Security advisories let you privately discuss and fix security vulnerabilities in your public repository's code, then publish an advisory to alert your community and encourage upgrades.

#### Repository rulesets

Repository rulesets enforce consistent code standards, security requirements, and compliance policies across branches and tags in your repositories.

#### Artifact attestations

Artifact attestations create unfalsifiable provenance and integrity guarantees for the software you build, establishing a verifiable link between your build artifacts and the source code and build process that produced them.

#### Security overview

Security overview provides a centralized dashboard to review the overall security landscape of your organization. It shows trends, insights, and security configurations, making it easy to monitor your organization's security status and identify the repositories at greatest risk. Security overview is available with **GitHub Secret Protection** and **GitHub Code Security**.

## GitHub security tools by plan availability

The following table summarizes GitHub's security and code quality tools, the minimum GitHub plan required to use them, and whether the GitHub Secret Protection or GitHub Code Security add-on is needed.

> [!NOTE]
> GitHub Secret Protection and GitHub Code Security are paid add-on products that can be purchased by organizations on **GitHub Team** and **GitHub Enterprise Cloud** plans. Many features included in these add-on products are also available for free on public repositories, as indicated in the table below.

| Tool | Minimum GitHub plan | Public repos | Private repos | GitHub Secret Protection | GitHub Code Security |
|---|---|---|---|---|---|
| **Supply chain security** | | | | | |
| Dependency graph | All plans | &#x2705; | &#x2705; | &mdash; | &mdash; |
| Software Bill of Materials (SBOM) | All plans | &#x2705; | &#x2705; | &mdash; | &mdash; |
| GitHub Advisory Database | All plans | &#x2705; | &#x2705; | &mdash; | &mdash; |
| Dependabot alerts and security updates | All plans | &#x2705; | &#x2705; | &mdash; | &mdash; |
| Dependabot version updates | All plans | &#x2705; | &#x2705; | &mdash; | &mdash; |
| Dependency review | All plans (public) / GitHub Team (private) | &#x2705; | &mdash; | &mdash; | &#x2705; |
| Custom auto-triage rules for Dependabot | All plans (public) / GitHub Team (private) | &#x2705; | &mdash; | &mdash; | &#x2705; |
| **Secret security** | | | | | |
| Secret scanning alerts for partners | All plans | &#x2705; | &mdash; | &mdash; | &mdash; |
| Push protection for users | All plans | &#x2705; | &mdash; | &mdash; | &mdash; |
| Secret scanning alerts for users | All plans (public) / GitHub Team (private) | &#x2705; | &mdash; | &#x2705; | &mdash; |
| Push protection (repository-level) | All plans (public) / GitHub Team (private) | &#x2705; | &mdash; | &#x2705; | &mdash; |
| Copilot secret scanning | GitHub Team | &mdash; | &mdash; | &#x2705; | &mdash; |
| Delegated bypass for push protection | GitHub Team | &mdash; | &mdash; | &#x2705; | &mdash; |
| Custom patterns for secret scanning | GitHub Team | &mdash; | &mdash; | &#x2705; | &mdash; |
| **Code security** | | | | | |
| Code scanning | All plans (public) / GitHub Team (private) | &#x2705; | &mdash; | &mdash; | &#x2705; |
| CodeQL CLI | All plans (public) / GitHub Team (private) | &#x2705; | &mdash; | &mdash; | &#x2705; |
| Copilot Autofix for code scanning | All plans (public) / GitHub Team (private) | &#x2705; | &mdash; | &mdash; | &#x2705; |
| Security campaigns | GitHub Team | &mdash; | &mdash; | &mdash; | &#x2705; |
| **Code quality** | | | | | |
| GitHub Code Quality | GitHub Team \* | &mdash; | &mdash; | &mdash; | &#x2705; |
| **General security** | | | | | |
| Security policy | All plans | &#x2705; | &#x2705; | &mdash; | &mdash; |
| Security advisories | All plans | &#x2705; | &#x2705; | &mdash; | &mdash; |
| Repository rulesets | All plans | &#x2705; | &#x2705; | &mdash; | &mdash; |
| Artifact attestations | All plans (public) / GitHub Enterprise Cloud (private) | &#x2705; | &#x2705; \*\* | &mdash; | &mdash; |
| Security overview | GitHub Team | &mdash; | &mdash; | &#x2705; | &#x2705; |

\* GitHub Code Quality is currently in public preview.

\*\* Artifact attestations for private repositories require GitHub Enterprise Cloud.

In the table above, "All plans" means the tool is available at no extra cost on every GitHub plan, including the free plans (GitHub Free for personal accounts and GitHub Free for organizations). "GitHub Team" means the minimum required plan is GitHub Team or GitHub Enterprise Cloud, both of which are paid plans that also support purchasing the GitHub Secret Protection and GitHub Code Security add-on products. Detailed pricing information is available from GitHub.

## How GitHub's security tools work together

GitHub's security and code quality tools are designed to work as complementary layers, providing comprehensive protection across different dimensions of your codebase.

- **Supply chain security** (Dependabot, dependency graph, dependency review) protects you from vulnerable third-party packages.
- **Secret security** (secret scanning, push protection) prevents credential exposure.
- **Code security** (code scanning, CodeQL) identifies security vulnerabilities in your own code.
- **Code quality** helps maintain reliable and maintainable code to reduce technical debt.

Together, these tools create a security-in-depth approach that addresses vulnerabilities from multiple angles. For example, secret scanning might detect a leaked API key, Dependabot alerts you to a vulnerable dependency that the API key accesses, and code scanning identifies an SQL injection vulnerability in the code that uses that dependency. Each layer fills a gap the others don't cover.

In this module, you'll focus on **secret scanning** and **push protection**, which form the cornerstone of GitHub's secret security capabilities.

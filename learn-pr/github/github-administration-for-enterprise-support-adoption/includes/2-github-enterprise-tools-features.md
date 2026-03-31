As a GitHub Enterprise administrator, you're responsible for establishing development environments that are both secure and scalable. This unit explores how to distinguish between GitHub Enterprise’s *upkeep* and *automation* features, and how to configure your organization for efficient collaboration.

We also introduce standards-based developer workflows and rulesets—powerful tools for centralized policy enforcement.


## GitHub Enterprise: Upkeep vs. Automation

GitHub Enterprise includes all features from GitHub Team, plus enterprise-specific capabilities categorized as:

- **Upkeep**: Features that improve security, access, and support.
- **Automation**: Features that reduce manual workload for developers and improve code quality at scale.

### Practical Example

Imagine your organization has brought in an external contractor team to deliver a new product feature. As an administrator, your responsibilities might include:

- Enabling private GitHub Pages for controlled documentation sharing (an upkeep feature).
- Monitoring GitHub Actions usage to ensure efficient automation across the expanding team (an automation feature).

:::image type="content" source="../media/enterprise-features-dichotomy.png" alt-text="Diagram of GitHub Enterprise features categories split between Upkeep and Automation.":::


## Establishing Developer Workflow Standards

To ensure consistency, security, and scalability, GitHub Enterprise organizations should follow these workflow standards:

### 1. Collaboration Models

| Workflow             | When to Use                                             |
|----------------------|---------------------------------------------------------|
| **Fork-and-Pull**    | Open source or cross-organization collaboration.        |
| **Branching**        | Internal team development within shared repositories.   |

### 2. Branching Conventions

- Adopt a consistent naming scheme (e.g., `feature/*`, `bugfix/*`).
- Use `main` or `develop` as stable integration branches for CI/CD pipelines.


## 3. Rulesets: Modern Policy Enforcement

**Rulesets** are GitHub's recommended mechanism for enforcing policy at scale. Unlike traditional branch protection rules, rulesets allow you to centrally manage policies across multiple repositories and teams.

:::image type="content" source="../media/ruleset-primary-focus.png" alt-text="Screenshot of Rulesets overview.":::

### Benefits of Rulesets

- **Centralized control** over repository policies.
- **Consistency** in enforcement across teams.
- **Scalability** for growing organizations.
- **Granular flexibility** through layered combinations.

### Example Policies

- Require pull request reviews.
- Enforce CI/CD checks before merge.
- Restrict access to protected branches.

:::image type="content" source="../media/example-ruleset-policies.png" alt-text="Screenshot of the ruleset enforcement dashboard.":::

#### Combining Rulesets and Branch Protection (Legacy Support)

- Use rulesets as the **primary mechanism**.
- Layer branch protection rules for **repository-specific exceptions**.
- Avoid overlap between both to reduce policy conflicts.


## Upkeep Features: Supporting Secure Access and Operations

Upkeep features reduce friction in user experience, ensure secure access control, and support hybrid-cloud environments.

### Key Upkeep Features

| Feature                              | Description                                                                 |
|--------------------------------------|-----------------------------------------------------------------------------|
| **Enterprise Support**               | Direct support from GitHub.                                                |
| **SAML/SCIM Authentication**         | Centralizes identity and access management.                                |
| **GitHub Connect**                   | Enables integration between Enterprise Cloud and Server.                   |
| **Access Controls for GitHub Pages** | Restricts documentation visibility to internal collaborators.              |

### Configuration Walkthrough

#### Enable SAML SSO

1. Connect your identity provider (IdP) to GitHub.
2. In your organization settings, select **Require SAML authentication**.
3. Provide your sign-on URL, issuer, and certificate.

#### Restrict GitHub Pages Access

1. Go to your private repository settings.
2. Set **GitHub Pages visibility** to *Private*.
3. Confirm no public URLs are accessible.

#### Enable GitHub Connect

1. Sign in to both GitHub Enterprise Server and GitHub.com.
2. In Server settings, select **Enable GitHub Connect**.
3. Choose organizations to link for unified search and contributions.


## Automation Features: Secure and Scalable Workflows

Automation features help reduce human error, enforce coding standards, and streamline CI/CD.

### Core Automation Features

| Feature                              | Description                                                                 |
|--------------------------------------|-----------------------------------------------------------------------------|
| **GitHub Advanced Security (GHAS)**  | Scans code for vulnerabilities and secrets.                                |
| **GitHub Actions Minutes**           | Automate builds, tests, and deployments.                                   |
| **Automatic Security Updates**       | Keeps dependencies secure and up-to-date.                                  |

### Track Automation Usage

#### GitHub Advanced Security (GHAS)

1. Navigate to **Your enterprises > Settings**.
2. Review user usage under **GitHub Advanced Security**.
3. If nearing limits, evaluate usage by team and prioritize.

:::image type="content" source="../media/enterprise-licensing-tab-ghas.png" alt-text="Screenshot of GHAS usage dashboard.":::

#### GitHub Actions

1. Navigate to **Your enterprises > Settings > Billing > GitHub Actions**.
2. Monitor usage against your monthly 50,000 minutes and 50 GB storage.
3. Note runner usage costs:
   - Linux: baseline.
   - Windows: 2x Linux rate.
   - macOS: 10x Linux rate.

:::image type="content" source="../media/actions-minutes.png" alt-text="Screenshot of GitHub Actions minutes usage.":::


## CI/CD Strategy in GitHub Enterprise

GitHub Enterprise enables secure and scalable CI/CD practices using **GitHub Actions** and integrations with external tools.

### Key Capabilities

- **GitHub Actions**: Define workflows in YAML to automate builds, tests, and deployments triggered by GitHub events (e.g., pushes, pull requests).
- **Build Pipelines**: Automate code compilation, unit testing, artifact creation, and PR validation.
- **Automated Testing**: Integrate unit, integration, and security tests to ensure quality before merge.
- **Continuous Deployment (CD)**: Automatically release to staging or production with optional approvals.
- **Toolchain Flexibility**: Support for Jenkins, CircleCI, Azure Pipelines, and more via webhooks and GitHub Marketplace apps.
- **Release Automation**: Trigger tagged releases with changelogs and versioned artifacts from CI workflows.
- **Security in CI/CD**: Integrate Dependabot, secret scanning, and compliance checks directly into pipelines.
- **Monitoring & Notifications**: Configure alerts and integrate observability tools to track deployment health and performance.

> [!TIP]
> Define reusable workflows and environments (e.g., staging, production) to ensure consistency and control.

### Getting Started

To automate deployment:
1. Create a `.github/workflows/` directory in your repository.
2. Define a CI/CD pipeline using GitHub Actions YAML (e.g., `ci-cd.yml`).
3. Use secrets to manage credentials securely.
4. Leverage environments and manual approvals for deployment gating.



## Monitoring Organizational Health

Use insights to identify usage trends, collaboration patterns, and risk areas:

### Organization Activity Insights

- View trends in pull requests, issues, and code languages.
- Evaluate team distribution and developer engagement.

### Dependency Insights

- Identify vulnerabilities in third-party dependencies.
- Review license risks and assess security posture.


## Tooling: Extending GitHub Workflows

Administrators can approve, configure, and maintain third-party tools and GitHub Marketplace integrations.

### Responsibilities

- Approve apps at the org/repo level.
- Monitor permission changes.
- Prefer tools with **Verified Creator** badges for higher trust.

:::image type="content" source="../media/apps-with-verified-publisher-badge-tooltip.png" alt-text="Screenshot of Verified Creator badge in GitHub Marketplace.":::

### Marketplace Guidelines

| Category             | Criteria                                                                 |
|----------------------|--------------------------------------------------------------------------|
| **CI/CD Tools**       | Portable, dynamic, open standards-compliant tools for automation.       |
| **Verified Creators** | Require 2FA, verified domains, and GitHub partnership.                  |


## CI/CD Tools: What to Look For

Choose tools that support continuous integration, delivery, or deployment with:

- **Open standards**: Easy to adopt and train.
- **Dynamic variables**: Centralized control for scaling workflows.
- **Flexibility**: Adaptable across hybrid or cloud-native environments.


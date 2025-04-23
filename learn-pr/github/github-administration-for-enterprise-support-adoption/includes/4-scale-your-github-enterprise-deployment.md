As your GitHub Enterprise organization grows—whether due to team expansion or new contractor engagements—administrators are responsible for ensuring secure access, managing identity lifecycles, monitoring compliance, and optimizing deployment pipelines. This unit introduces key GitHub Enterprise features and governance tools to help you scale securely and efficiently.


## Secure Access with Single Sign-On (SSO)

To maintain centralized identity control and streamline user management, enable SAML-based Single Sign-On (SSO) with your identity provider (IdP), such as Okta or Microsoft Entra ID.

> [!TIP] 
> From your organization’s **People** tab, you can review and revoke individual SAML credentials under the **SAML identity linked** section.

> [!IMPORTANT] 
> If you use team synchronization, revoking a user’s SSO identity automatically removes them from any teams mapped to IdP groups.


## Automate Identity Management with SCIM and APIs

Leverage GitHub APIs to automate user provisioning and deprovisioning, enforce security policies, and monitor access across your enterprise.

### Use the SCIM API for Lifecycle Automation

The SCIM standard streamlines identity workflows through RESTful JSON requests. It is supported by:

- Microsoft Entra ID
- Okta
- OneLogin

This allows automatic updates to user access without manual intervention, reducing risk and improving efficiency.

### Responsible API Usage

Avoid inefficient polling patterns. Use webhooks, GitHub Apps, or GitHub Actions to trigger automation. When using the Audit Log API:

```bash
curl -H "Authorization: Bearer YOUR_TOKEN" \
https://api.github.com/enterprises/YOUR_ENTERPRISE/audit-log
```

Store logs in external SIEM systems like Splunk or ELK for long-term retention and compliance reporting.


## Monitor Compliance with Enterprise Audit and GraphQL APIs

Use the Enterprise Accounts API and Audit Log API (GraphQL only) to track sensitive changes:

- Repository or settings access
- User or role changes
- App permission updates

GraphQL enables you to fetch only the data you need or mutate enterprise settings programmatically.


## Simplify Team Management with Enterprise Teams (Preview)

**Enterprise Teams** allow centralized team creation and management across multiple organizations.

### Setup Overview:

| Platform | Steps |
|----------|-------|
| **Enterprise Cloud** | Navigate to **Organization Settings** → **Teams**, then create or manage team memberships. |
| **Enterprise Server** | Use the **Management Console** to configure teams and assign permissions at the org level. |

**Benefits:**

- Centralize role assignment across organizations
- Improve visibility into team structure and contributions
- Standardize access control at scale



## Control App Governance with Enterprise Apps (Preview)

Enterprise Apps enhance oversight and control over GitHub Apps installed across your organizations.

### Setup Overview

| Platform | Steps |
|----------|-------|
| **Enterprise Cloud** | Go to **Developer settings** → **GitHub Apps**, install or create custom apps, and configure permissions. |
| **Enterprise Server** | Use the **Management Console** to create and manage GitHub Apps with custom scopes and webhook settings. |

**Benefits:**

- Centralized app management
- Simplified app deployment and access control
- Visibility into app usage and permissions across all orgs


## Extend Capabilities with GitHub Marketplace Tools

:::image type="content" source="../media/marketplace-interface.png" alt-text="A screenshot of the GitHub marketplace interface":::

The [GitHub Marketplace](https://github.com/marketplace) offers reusable automation tools that simplify CI/CD, enhance collaboration, and extend GitHub functionality at scale. These tools include **GitHub Actions** and **GitHub Apps**—two core integration types with different scopes, lifecycles, and use cases.

### Choosing Between Actions and Apps

| Feature         | GitHub Actions                            | GitHub Apps                                   |
|-----------------|--------------------------------------------|-----------------------------------------------|
| **Use case**    | Automate workflows (CI/CD, linting, etc.)  | Extend GitHub via APIs, UI, and permissions   |
| **Execution**   | Per-trigger on GitHub-hosted/self-hosted runners | Runs as a service; responds to webhook events |
| **Auth Model**  | Uses temporary `GITHUB_TOKEN`              | Uses JWT + installation token                 |
| **Billing**     | Billed per Action minute                   | SaaS-based (subscription/licensing)           |

> [!TIP] 
> Use GitHub Actions for ephemeral, event-based automation. Choose GitHub Apps when building persistent services with deeper API interactions or advanced permission scopes.


### How Marketplace Tools Work Under the Hood

Understanding how these tools interact with GitHub helps you make informed decisions and troubleshoot more effectively.

#### GitHub Actions Workflow

1. **Setup**: Define a YAML workflow in `.github/workflows/`.
2. **Trigger**: A GitHub event (e.g., `push`) initiates the workflow.
3. **Runner**: GitHub spins up a runner (cloud or self-hosted).
4. **Execution**: Steps run commands, use Actions, and access the `GITHUB_TOKEN`.
5. **Results**: Logs and statuses are pushed back to GitHub.

**Flow:**  
`Repository Event → Workflow Triggered → Runner Executes Jobs → Output Returned to GitHub`

#### GitHub Apps Workflow

1. **Setup**: App is installed with specific repo/org-level permissions.
2. **Webhooks**: GitHub sends events (e.g., `issues.opened`) to the app’s server.
3. **Authentication**: The app uses its private key + installation token to authenticate.
4. **Interaction**: The app makes API calls to act on the repository (e.g., add a label, comment).

**Flow:**  
`Repository Event → Webhook Sent → App Server Receives → Authenticates → GitHub API Call → Action Taken`


### Practical Examples

#### GitHub App: Azure Pipelines

**Use Case:** Automate deployment pipelines across environments.

**Steps:**
1. Find [Azure Pipelines](https://github.com/marketplace/azure-pipelines) in the Marketplace.
2. Install the app and grant repository access.
3. Configure a pipeline:

```yaml
trigger:
  - main
pool:
  vmImage: 'ubuntu-latest'
steps:
  - script: echo "Deploying via Azure Pipelines"
```

#### GitHub Action: Node.js CI/CD

**Use Case:** Automate build and test for a Node.js project.

**Steps:**
1. Create `.github/workflows/nodejs.yml`:

```yaml
name: Node.js CI/CD

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-node@v2
        with:
          node-version: '14'
      - run: npm install && npm test
```


### Marketplace Search Tips

- **Determine Tool Type:** Use **Apps** for broad capabilities; **Actions** for task-specific automation.
- **Set Budget Preferences:** Filter by **Free**, **Free Trial**, or **Paid** apps.
- **Refine by Category:** Choose a category like **CI/CD** to match your project goals.
- **Focus on Enterprise Support:** Use the **GitHub Enterprise** filter for tailored tools.


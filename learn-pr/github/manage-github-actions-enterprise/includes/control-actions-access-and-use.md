## Control access to actions within the enterprise
Access control in GitHub Actions determines:

- **Who can run workflows that use actions.**
- **Which actions can be used within an organization.**
- **How self-hosted runners execute workflows securely.**
- **Who can modify and update shared GitHub Actions.**

Enterprise administrators need to **strike a balance** between giving developers flexibility and ensuring security and governance over automation workflows.

### Organization-wide policies for controlling actions

GitHub Enterprise enables administrators to set **organization-wide policies** that control how actions are used across all repositories within an organization. These policies help organizations **restrict the use of third-party actions, enforce security measures, and standardize automation workflows.**

## Repository-level permissions for actions

While organization-wide settings apply globally, **repository-level permissions** provide fine-grained control over **who can run workflows and modify actions**.

## Managing repository-level workflow permissions

Each repository can define **who can create, edit, and execute workflows**.

| **Permission Level** | **Capabilities**                                 |
| -------------------- | ------------------------------------------------ |
| **Read**             | View workflows, but cannot trigger or edit them. |
| **Write**            | Edit workflows, but cannot create new ones.      |
| **Admin**            | Create, edit, and manage workflow permissions.   |

By default, GitHub sets workflow permissions to **"Read and Write"**, but enterprises should **restrict it to "Read" unless explicitly required** to prevent unauthorized modifications.


### Restricting who can modify organization-owned actions

If an organization hosts **reusable GitHub Actions** in a dedicated repository, access should be **limited to authorized users**.

- Use **branch protection rules** to prevent unauthorized modifications.
- Require **pull request approvals** for updates to actions.
- Restrict write access using **GitHub Teams & Role-Based Access Control (RBAC)**.

This ensures that any modifications to **core automation actions** are **reviewed before deployment**.

### Restricting access to external actions

GitHub Actions allows the use of **third-party actions**, but external actions **can pose security risks** if not properly vetted. Organizations should control which external actions can be used.

### Risks of using external actions

- **Malicious Code Execution**: An untrusted external action could introduce vulnerabilities.
- **Dependency Tampering**: A third-party action may introduce **supply chain attacks**.
- **Secrets Exposure**: External actions may inadvertently log secrets.

### Configuring external action restrictions

Administrators can **allow or block external actions** in **Organization Settings → Actions → Policies**.

Options include:

1. **Allow only GitHub-verified actions** (recommended for security).
2. **Allow specific external actions** via an allowlist.
3. **Block all external actions** (strictest security approach).

Example: **Allowing Only Verified External Actions**

- Navigate to **Organization Settings → Actions → Policies**.
- Under **"Allowed actions and reusable workflows"**, select:
    - **Allow only actions created by GitHub**.
    - **Manually approve any third-party actions before use**.
- Save the settings.

### Implementing an allowlist for external actions

Organizations that need specific third-party actions can **create an allowlist** by specifying trusted repositories.

Example: Allow only GitHub’s official `checkout` action:

```yaml
- name: Checkout Repository
  uses: actions/checkout@v4
```

Administrators can define this allowlist in **Organization Settings → Actions → Policies**.


### Securing self-hosted runners

Enterprises that use **self-hosted runners** to execute GitHub Actions need to enforce **additional security measures**.

### Risks of self-hosted runners

|**Risk**|**Description**|**Mitigation**|
|---|---|---|
|**Unauthorized Access**|Attackers could hijack runners to execute malicious actions.|Restrict access using **IP allow lists**.|
|**Secret Exposure**|Sensitive credentials may be leaked to compromised runners.|Store secrets in **GitHub Secrets Management** instead of environment variables.|
|**Runner Compromise**|If runners are not isolated, workflows from different teams could interfere.|Use **ephemeral runners** that reset after each job.|

### Restricting access to self-hosted runners

1. **Navigate to Organization Settings → Actions → Runners**.
2. **Create a Runner Group** to limit access.
3. **Restrict runner usage**:
    - Allow runners only for internal repositories.
    - Restrict usage to specific teams.

## Configure organizational use policies for GitHub actions

This guide provides a detailed explanation of how to configure organizational use policies for GitHub Actions, covering:

1. Allowed actions and reusable workflows.
2. Workflow permissions and security policies.
3. Self-hosted runner restrictions.
4. Secrets management and access control.
5. Monitoring and auditing workflows.

### Allowed actions and reusable workflows

One of the **primary security policies** enterprises should enforce is controlling **which GitHub Actions can be used within an organization**. Administrators can configure policies to:

- **Allow or block third-party actions**.
- **Restrict usage to organization-owned actions**.
- **Create an allowlist for approved external actions**.

![alt text](image.png)

## Configuring allowed actions policy

1. Navigate to Organization Settings → Actions → Policies.

2. Under "Allowed Actions and Reusable Workflows", choose one of the following:
   
   - Allow all actions and reusable workflows (default, least restrictive).
   - Allow only actions created by GitHub (prevents third-party actions).
   - Allow only actions created within the organization (recommended for security).
   - Block all actions except those on an allowlist (strictest control).
3. If using an allowlist, specify the external actions that are permitted:
   
    ```yaml
    - actions/checkout@v4
    - actions/setup-node@v3
    ```
   
4. Save the settings.
   
## Configuring workflow permissions and security policies

Workflow permissions define **what access levels GitHub Actions workflows have in repositories**. These settings determine whether workflows **can modify repository content** or **only read** repository data.

### Configuring default workflow permissions

GitHub provides two options:

1. **Read-only (Recommended for Security)**
    - Workflows can **read** repository content but **cannot make changes**.
    - Prevents actions from **accidentally or maliciously modifying code**.
2. **Read and Write (Higher Risk)**
    - Workflows **can push commits, create issues, and modify settings**.
    - Should only be enabled for **trusted workflows**.

#### Steps to configure default workflow permissions

1. **Navigate to Organization Settings → Actions → General**.
2. **Under "Workflow Permissions"**, choose:
    - **Read-only** (Recommended).
    - **Read and write** (Only for specific cases).
3. **Save the settings**.

### Enforcing approval for workflow runs

To **prevent unauthorized workflow executions**, administrators can **require manual approval** before workflows run in **forked repositories**.

#### Steps to require approval for external contributions

1. **Navigate to Organization Settings → Actions → Policies**.
2. **Under "Fork Pull Request Workflows"**, select:
    - Require approval for workflows running from forks.
    - Allow automatic execution of forked workflows (not recommended).
3. **Save the settings**.

This policy **prevents security risks** associated with running workflows from **untrusted forks**.

### Self-hosted runner restrictions

Self-hosted runners provide more control over CI/CD execution but **introduce security risks** if not properly configured. Organizations should enforce policies to:

- **Restrict which repositories can use self-hosted runners**.
- **Limit access to specific teams**.
- **Use ephemeral (temporary) runners** for security.

### Configuring runner access

Administrators can **limit which repositories** have access to self-hosted runners.

#### Steps to Restrict Self-Hosted Runner Usage

1. **Navigate to Organization Settings → Actions → Runners**.
2. **Select the Runner Group**.
3. **Set the access level**:
    - Allow only selected repositories to use self-hosted runners.
    - Do not allow public repositories to use enterprise runners.
4. **Save the settings**.


### Managing secrets and access control

GitHub Actions often require **API keys, credentials, and environment variables**. These should be **securely stored using GitHub Secrets Management**.

#### Organizational secrets vs. repository secrets

|**Type**|**Scope**|**Best Use Case**|
|---|---|---|
|**Repository Secrets**|Specific to one repository.|For repository-specific credentials.|
|**Organization Secrets**|Available to multiple repositories.|For shared enterprise credentials.|

### Configuring organizational secrets

1. **Navigate to Organization Settings → Secrets and Variables → Actions**.
2. **Click "New Secret"**.
3. **Enter a Secret Name and Value**.
4. **Choose Repository Access**:
    - All repositories.
    - Selected repositories.
5. **Save the secret**.

### Best practices for managing secrets

- **Use environment variables carefully** to prevent secret exposure.
- **Rotate secrets regularly** to enhance security.
- **Use third-party secret managers** (e.g., AWS Secrets Manager, HashiCorp Vault).

### Monitoring and Auditing GitHub Actions Usage

Organizations must **monitor** the usage of GitHub Actions to ensure compliance and detect unauthorized activity.

#### Enabling audit logs for GitHub actions

Audit logs provide insights into:

- Who ran workflows.
- Which actions were executed.
- What permissions workflows used.

#### Steps to enable audit logs

1. Navigate to Organization Settings → Security → Audit Log.
2. Filter logs by "actions" to see workflow execution history.

### Enforcing log retention policies

Enterprises should configure **log retention** to comply with security policies. Retaining logs ensures that organizations can review historical workflow executions, detect suspicious activities, and comply with industry regulations.

#### Steps to configure log retention policies

1. Navigate to Organization Settings → Security → Audit Log.
2. Set the log retention period to match compliance requirements:
    - 30 days (default).
    - 90 days (recommended for security-conscious organizations).
    - Custom period (as per legal and compliance needs).
3. Save the settings.

Alternatively, use GitHub’s API to set the log retention period.


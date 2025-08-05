If your company uses Microsoft Entra ID or Okta as your identity provider (IdP), you can manage GitHub team membership through **team synchronization**. When enabled, team sync automatically reflects changes in IdP groups on GitHub—reducing the need for manual updates or custom scripts. This centralized approach simplifies onboarding, permissions management, and access revocation.

| Feature               | Description                                                                 |
|-----------------------|-----------------------------------------------------------------------------|
| Sync Users            | Keep GitHub `Teams` aligned with IdP (for example, Active Directory) group membership |
| Sync on New Team      | Automatically populate teams at creation                                    |
| Custom Team Mapping   | Use `syncmap.yml` to define custom mappings between team slugs and group names |
| Dynamic Config        | Use a `settings` file to derive sync settings from your directory structure  |

## Team Synchronization Use Cases

Team sync is ideal for enterprises looking to streamline membership management within GitHub organizations. Admins can map GitHub teams to IdP groups and manage memberships automatically. This is useful for:

- Onboarding new employees
- Adjusting access as users move between teams
- Removing users who leave the organization

> ⚠️ To use team sync, your IdP admin must enable **SAML SSO** and **SCIM**.

## Enterprise Managed Users and GitHub Enterprise Server

Team synchronization is also available for organizations and enterprise accounts that use GitHub Enterprise Cloud or [GitHub Enterprise Server (GHE.com)](https://github.com/enterprise), which is the preferred solution in regions where it is available or required for compliance reasons.

**Enterprise Managed Users (EMUs)** are a GitHub Enterprise Cloud feature that gives enterprises complete control over user identity and account lifecycle. With EMUs, GitHub accounts are fully managed by the enterprise’s identity provider (IdP). This means users do not sign up for GitHub manually—all user provisioning, access, and offboarding is automated through tools like Microsoft Entra ID or Okta.

EMUs are ideal for organizations with strict compliance, audit, or user governance needs. They help ensure that:

* All accounts are owned by the enterprise
* Access is automatically granted or removed based on IdP membership
* No external collaboration happens unintentionally

When using EMUs:

* Managed users cannot push code to or fork repositories outside the enterprise
* They can only interact with other users and resources inside the enterprise

You can manage EMU-based organization and team membership using groups in your IdP, and optionally integrate [team synchronization](#enable-team-synchronization) to automate group-to-team mapping.

For organizations with requirements around self-hosting or specific regional regulations, **GitHub Enterprise Server (GHE.com)** offers an on-premises solution that allows you to maintain full control of your GitHub environment.

For more details, see [Getting started with GitHub Enterprise Cloud](https://docs.github.com/get-started/onboarding/getting-started-with-github-enterprise-cloud) and [About GitHub Enterprise Server](https://docs.github.com/en/enterprise-server@latest).

## Team Synchronization vs. SCIM for GHES 

In GitHub Enterprise Server (GHES), managing user access and team memberships can be achieved through various methods, including team synchronization and System for Cross-domain Identity Management (SCIM). Understanding these methods is essential for effective administration.

### Team Sync in GHES

Team synchronization allows you to link GitHub teams with groups in your Identity Provider (IdP). This integration ensures that any changes in the IdP group—such as adding or removing members—are automatically reflected in the corresponding GitHub team. This approach streamlines team management by centralizing user access control within the IdP.

However, it's important to note that team synchronization isn't a user provisioning service and doesn't invite non-members to join organizations in most cases. Therefore, a user will only be successfully added to a team if they're already an organization member.

Consider the following scenario to understand how team synchronization works in practice:

- When Azure AD group "DevOps Engineers" maps to GitHub team "DevOps"
- When Alice is added to the IdP group → automatically added to the GitHub team
- When she leaves the group → automatically removed from the team

> [!NOTE]
> Team Sync in GHES doesn’t provision accounts. Users must already be GitHub organization members.

### Team Sync Configuration

1. Enable Security Assertion Markup Language(SAML) Single Sign-On(SSO) and SCIM in your IdP.
2. Map GitHub teams to IdP groups via GitHub UI or API.
3. Changes in group membership sync automatically to GitHub.

Supported IdPs:
- **Microsoft Entra ID**: Requires permissions for profile reading and directory access.
- **Okta**: Requires SAML SSO, SCIM, tenant URL, and Single Sign-on for Web Systems(SSWS) token with read-only admin access.

### Disable Team Sync

To disable:

1. Navigate to **Settings** > **Organization security**
2. Click **Disable team synchronization**

:::image type="content" source="../media/disable-team-synchronization.png" alt-text="Screenshot of the organization setting to disable team synchronization." :::

> [!NOTE]
> Disabling sync removes users from teams if they were added via IdP mapping.

### SCIM in GHES
SCIM is an open standard protocol designed to automate the exchange of user identity information between identity domains and IT systems. In the context of GHES, SCIM enables administrators to provision, update, and deprovision user accounts directly through the GitHub API. This means you can create, update, and delete user accounts, and sync group information to map GitHub team memberships.

SCIM is useful for managing user lifecycles at scale, ensuring that user data remains consistent across systems.

Consider the following scenario to understand how SCIM works in practice:
- Okta SCIM integration provisions GitHub users automatically
- Bob is added to Okta → GitHub account is provisioned
- Bob changes roles → access and teams update
- Bob leaves → account is deprovisioned

**Key Benefit:** Full automation for account lifecycle management.

## Team Sync vs. Group SCIM

GitHub supports two primary identity integration approaches:

- **Team Sync**: Focused on syncing group membership to GitHub teams
- **Group SCIM**: Focused on full lifecycle management of users and groups

### Differences Between Team Sync and Group SCIM

| Feature                  | Team Sync                                     | Group SCIM                                   |
|--------------------------|-----------------------------------------------|----------------------------------------------|
| Focus                    | Team-level mapping                            | User and group provisioning                  |
| Setup                    | Manual group-to-team mapping                  | Automated via IdP SCIM config                |
| Automation Level         | Syncs group membership only                   | Full lifecycle automation                    |
| Ideal Use Case           | GitHub Teams management                       | Large orgs with high user turnover           |
| Deprovisioning           | Manual or IdP-group dependent                 | Fully automated                              |
| Identity Model           | Classic                                       | Managed Users                                |


## Choosing the Right Approach
The choice between Team Sync and Group SCIM depends on your organization’s needs, size, and existing identity management infrastructure:

| Use Case                          | Recommended Solution |
|----------------------------------|----------------------|
| Manage repository access by teams| Team Sync            |
| Automate user lifecycle          | Group SCIM           |
| Need full IdP-based governance   | Group SCIM           |
| GitHub Teams is core to workflow| Team Sync            |


## Usage Limits

When using team synchronization, observe these limits:

- Max members per team: **5,000**
- Max members per organization: **10,000**
- Max teams per organization: **1,500**

Exceeding these may result in performance issues or sync failures.

If your company is using Microsoft Entra ID or Okta as your IdP for your enterprise in GitHub's cloud, you can use team synchronization to manage team membership within each organization through IdP groups. With team synchronization enabled, changes made in an IdP group are automatically reflected on GitHub. This feature reduces the need for manual updates and custom scripts. You can centrally manage users' identities, allowing authorization, review, and revocation of permissions. 

When you synchronize a GitHub team with an IdP group, changes to the IdP group are reflected on GitHub automatically, reducing the need for manual updates and custom scripts. You can use an IdP with team synchronization to manage administrative tasks such as onboarding new members, granting new permissions for movements within an organization, and removing member access to the organization.

Managing a team via your service provider allows you to save time and resources that you'd otherwise spend duplicating in GitHub the information about your team that's already captured in your IdP. The Administrator of your IdP will need to enable SAML SSO and SCIM to implement team synchronization.

| Features               | Description                                                  |
| ---------------------- | ------------------------------------------------------------ |
| Sync Users             | Add or remove users from `Teams` in GitHub to keep in sync with Active Directory groups |
| Sync on new team       | Synchronize users when a new team is created                 |
| Custom team/group maps | The team `slug` and group name will be matched automatically, unless you define a custom mapping with `syncmap.yml` |
| Dynamic Config         | Utilize a `settings` file to derive Active Directory and GitHub settings |

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

For more details, see [Getting started with GitHub Enterprise Cloud](https://docs.github.com/get-started/onboarding/getting-started-with-github-enterprise-cloud) and [About GitHub Enterprise Server](https://docs.github.com/en/enterprise-server@latest/get-started/learning-about-github/about-github-enterprise-server).


Randy

## Usage limits

When using the team synchronization feature, there are specific usage limits you need to know about. Exceeding these limits can lead to unexpected performance, and might cause synchronization failures.

- Maximum number of members in a GitHub team: 5,000
- Maximum number of members in a GitHub organization: 10,000
- Maximum number of teams in a GitHub organization: 1,500

## Enable team synchronization

With team synchronization, you can use your IdP to manage administrative tasks like onboarding new members, granting new permissions in your organization, and removing member access. When you synchronize a GitHub team with an IdP group, changes made to the IdP group are reflected on GitHub automatically, reducing the need for manual updates and custom scripts. The steps to enable team synchronization depend on the IdP you use.

You can enable and use team synchronization, but only with the following supported IdPs:

- Microsoft Entra ID
- Okta

The steps to enable team synchronization depend on the IdP you want to use. There are prerequisites to enable team synchronization that apply to each IdP. To enable team synchronization with your IdP, you must obtain administrative access or work with your IdP administrator to configure the IdP integration and groups. After you enable team synchronization, team maintainers and organization owners can connect a team to an IdP group on GitHub or through the API.

**Microsoft Entra ID**: The GitHub System Admin for the GitHub organization needs to identify and work with the Microsoft Entra Administrator to configure Team Synchronization. On the Microsoft Entra ID side, the service is called *automatic user account provisioning*. To enable team synchronization for Microsoft Entra ID, the installation needs the following permissions:

- Read all users’ full profiles
- Sign in and read user profiles
- Read directory data

**Okta**: To enable team synchronization for Okta, you or your IdP administrator must:

- Enable SAML SSO and SCIM for your organization using Okta.
- Provide the tenant URL for your Okta instance.
- Generate a valid SSWS token with read-only admin permissions for your Okta installation as a service user.

## Disable team synchronization

When you disable team synchronization, any team members who were assigned to a GitHub team through the IdP group are removed from the team and may lose access to your organization's repositories. You can disable this feature through the organization settings by selecting **Your organization** and selecting **Settings**. Next, select **Authentication security** and choose **Disable team synchronization**.

:::image type="content" source="../media/disable-team-synchronization.png" alt-text="Screenshot of the organization setting to disable team synchronization." :::

If your company is using Azure AD or Okta as your IdP for your enterprise in GitHub's cloud, you can use team synchronization to manage team membership within each organization through IdP groups. With team synchronization enabled, changes made in an IdP group are automatically reflected on GitHub. This feature reduces the need for manual updates and custom scripts. You can centrally manage users' identities, allowing authorization, review, and revocation of permissions. 

When you synchronize a GitHub team with an IdP group, changes to the IdP group are reflected on GitHub automatically, reducing the need for manual updates and custom scripts. You can use an IdP with team synchronization to manage administrative tasks such as onboarding new members, granting new permissions for movements within an organization, and removing member access to the organization.

Managing a team via your service provider allows you to save time and resources that you'd otherwise spend duplicating in GitHub the information about your team that's already captured in your IdP. The Administrator of your IdP will need to enable SAML SSO and SCIM to implement team synchronization.

| Features               | Description                                                  |
| ---------------------- | ------------------------------------------------------------ |
| Sync Users             | Add or remove users from `Teams` in GitHub to keep in sync with Active Directory groups |
| Sync on new team       | Synchronize users when a new team is created                 |
| Custom team/group maps | The team `slug` and group name will be matched automatically, unless you define a custom mapping with `syncmap.yml` |
| Dynamic Config         | Utilize a `settings` file to derive Active Directory and GitHub settings |

> [!NOTE]
> Team synchronization is available for organizations and enterprise accounts using GitHub Enterprise Cloud.

## Usage limits

When using the team synchronization feature, there are specific usage limits you need to know about. Exceeding these limits can lead to unexpected performance, and may cause synchronization failures.

- Maximum number of members in a GitHub team: 5,000
- Maximum number of members in a GitHub organization: 10,000
- Maximum number of teams in a GitHub organization: 1,500

## Enable team synchronization

With team synchronization, you can use your IdP to manage administrative tasks like onboarding new members, granting new permissions in your organization, and removing member access. When you synchronize a GitHub team with an IdP group, changes made to the IdP group are reflected on GitHub automatically, reducing the need for manual updates and custom scripts. The steps to enable team synchronization depend on the IdP you use.

You can enable and use team synchronization, but only with the following supported IdPs:

- Azure AD
- Okta

The steps to enable team synchronization depend on the IdP you want to use. There are prerequisites to enable team synchronization that apply to each IdP. To enable team synchronization with your IdP, you must obtain administrative access or work with your IdP administrator to configure the IdP integration and groups. After you enable team synchronization, team maintainers and organization owners can connect a team to an IdP group on GitHub or through the API.

**Azure AD**: The GitHub System Admin for the GitHub organization will need to identify and work with the Azure AD Administrator to configure Team Synchronization. On the Azure AD side, the service is called “automatic user account provisioning.” To enable team synchronization for Azure AD, the installation needs the following permissions:

- Read all users’ full profiles
- Sign in and read user profiles
- Read directory data

**Okta**: To enable team synchronization for Okta, you or your IdP administrator must:

- Enable SAML SSO and SCIM for your organization using Okta.
- Provide the tenant URL for your Okta instance.
- Generate a valid SSWS token with read-only admin permissions for your Okta installation as a service user.

## Disable team synchronization

When you disable team synchronization, any team members who were assigned to a GitHub team through the IdP group are removed from the team and may lose access to your organization's repositories. You can disable this feature through the organization settings by selecting **Your organization** and selecting **Settings**. Next, select **Organization security** and choose **Disable team synchronization**.

:::image type="content" source="../media/disable-team-synchronization.png" alt-text="Screenshot of the organization setting to disable team synchronization." :::

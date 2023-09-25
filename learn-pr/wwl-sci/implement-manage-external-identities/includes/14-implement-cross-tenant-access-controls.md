Azure AD organizations can use external identities cross-tenant access settings to manage how they collaborate with other Azure AD organizations or Microsoft clouds. Cross-tenant access settings give you granular control over how external Azure AD organizations collaborate with you, **inbound access**. You can also control how your users collaborate with external Azure AD organizations, **outbound access**.<br>

:::image type="content" source="../media/cross-tenant-access-ac5d5d43.png" alt-text="Screenshot of the Azure AD external identities cross-tenant access controls dialog. Configure inbound and outbound access.":::


### Manage inbound and outbound settings

By default, B2B collaboration with other Azure AD organizations is enabled, and B2B direct connect is blocked. But the following comprehensive admin settings let you manage both of these features.

| **Cross-tenant access setting name** | **Operations managed**                                                                                                                                                                                                                                                                                                          |
| ------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Outbound access settings             | Control whether users can access resources in an external organization. You can apply settings to everyone, or specify individual users, groups, and applications.                                                                                                                                                              |
| Inbound access settings              | Control whether users from external Azure AD organizations can access resources in your organization. You can apply these settings to everyone, or specify individual users, groups, and applications.                                                                                                                          |
| Trust settings (inbound)             | Determine whether your Conditional Access policies will trust the multifactor authentication (MFA). You can also require compliant device, and hybrid Azure AD joined device. And finally, allow or restrict user from an external organization if their users have already satisfied these requirements in their home tenants. |
| B2b direct connect                   | Set up a mutual trust relationship with another Azure AD organization for seamless collaboration. This feature currently works with Microsoft Teams shared channels.                                                                                                                                                            |

### Organizational specific configuration

Above you explored the default settings. These settings are applied to all external connections. However, you can configure specific collaboration settings on a per organization basis as well. In the **cross-tenant access control** screen choose **Organizational settings** then add the tenant. Once added you can configure the inbound and outbound settings.

### Microsoft cloud specific configuration

What if your company has government contracts that need to connect to Microsoft Azure Government or Microsoft Azure China. Use the **Microsoft cloud settings** to connect to and configure the collaboration settings.

### B2B Direct Connect

B2B direct connect requires a mutual trust relationship between two Azure AD organizations to allow access to each other's resources. Both the resource organization and the external organization need to mutually enable B2B direct connect in their cross-tenant access settings. When the trust is established, the B2B direct connect user has single sign-on access to resources outside their organization using credentials from their home Azure AD organization.

Currently, B2B direct connect capabilities work with Teams shared channels. When B2B direct connect is established between two organizations, users in one organization can create a shared channel in Teams and invite an external B2B direct connect user to it. Then from within Teams, the B2B direct connect user can seamlessly access the shared channel in their home tenant Teams instance, without having to manually sign in to the organization hosting the shared channel.

Cross-tenant access control is a preview feature and is not currently on the SC-300 exam.

Azure AD organizations can use external identities cross-tenant access settings to manage how they collaborate with other Azure AD organizations or Microsoft clouds. Cross-tenant access settings give you granular control over how external Azure AD organizations collaborate with you, **inbound access**. You can also control how your users collaborate with external Azure AD organizations, **outbound access**.

:::image type="content" source="../media/cross-tenant-access-ac5d5d43.png" alt-text="Screenshot of the Azure AD external identities cross-tenant access controls dialog. Configure inbound and outbound access.":::


### Manage inbound and outbound settings

By default, B2B collaboration with other Azure AD organizations is enabled, and B2B direct connect is blocked. But the following comprehensive admin settings let you manage both of these features.

| **Cross-tenant access setting name** | **Operations managed**                                                                                                                                                                                                                                                                                                          |
| ------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Outbound access settings             | Control whether users can access resources in an external organization. You can apply settings to everyone, or specify individual users, groups, and applications.                                                                                                                                                              |
| Inbound access settings              | Control whether users from external Azure AD organizations can access resources in your organization. You can apply these settings to everyone, or specify individual users, groups, and applications.                                                                                                                          |
| Trust settings (inbound)             | Determine whether your Conditional Access policies will trust the multifactor authentication (MFA). You can also require compliant device, and hybrid Azure AD joined device. And finally, allow or restrict user from an external organization if their users have already satisfied these requirements in their home tenants. |

### Organizational specific configuration

Above you explored the default settings. These settings are applied to all external connections. However, you can configure specific collaboration settings on a per organization basis as well. In the **cross-tenant access control** screen choose **Organizational settings** then add the tenant. Once added you can configure the inbound and outbound settings.

### Microsoft cloud specific configuration

What if your company has government contracts that need to connect to Microsoft Azure Government or Microsoft Azure China. Use the **Microsoft cloud settings** to connect to and configure the collaboration settings.

## Evaluate solutions that use Microsoft Entra Internet Access as a secure web gateway

Microsoft Entra Internet Access provides an identity-centric Secure Web Gateway (SWG) solution for Software as a Service (SaaS) applications and other Internet traffic. It protects users, devices, and data from the Internet's wide threat landscape with best-in-class security controls and visibility through Traffic Logs.

### Web content filtering

The key introductory feature for Microsoft Entra Internet Access for all apps is **Web content filtering**. This feature provides granular access control for web categories and Fully Qualified Domain Names (FQDNs). By explicitly blocking known inappropriate, malicious, or unsafe sites, you protect your users and their devices from any Internet connection whether they're remote or within the corporate network.

Web content filtering is implemented using filtering policies, which are grouped into security profiles, which can be linked to Conditional Access policies. To learn more about Conditional Access, see [Microsoft Entra Conditional Access](/azure/active-directory/conditional-access/).


### Security profiles

Security profiles are objects you use to group filtering policies and deliver them through user aware Conditional Access policies. For instance, to block all **News** websites except for `msn.com` for user `angie@contoso.com` you create two web filtering policies and add them to a security profile. You then take the security profile and link it to a Conditional Access policy assigned to `angie@contoso.com`.

```
"Security Profile for Angie"       <---- the security profile
    Allow msn.com at priority 100  <---- higher priority filtering policies
    Block News at priority 200     <---- lower priority filtering policy
```

### Policy processing logic
Within a security profile, policies are enforced according to priority ordering with 100 being the highest priority and 65,000 being the lowest priority (similar to traditional firewall logic). As a best practice, add spacing of about 100 between priorities to allow for policy flexibility in the future.

Once you link a security profile to a Conditional Access (CA) policy, if multiple CA policies match, both security profiles are processed in priority ordering of the matching security profiles.


## Evaluate solutions that use Microsoft Entra Internet Access to access Microsoft 365, including cross-tenant configurations

Solutions in this area rely on Microsoft Entra Internet Access for Microsoft Traffic. This is essentially a traffic forwarding profile that enables Microsoft Entra Internet Access to acquire traffic going to Microsoft services, including Microsoft 365.

The Microsoft profile manages the following policy groups:

- Exchange Online
- SharePoint Online and OneDrive
- Microsoft 365 Common and Office Online (only Microsoft Entra ID and Microsoft Graph)

For more information, see the following resources:

- [Microsoft Entra Internet Access for Microsoft Traffic](/entra/global-secure-access/how-to-manage-microsoft-profile).
- [Configure cross-tenant access settings for B2B collaboration](/entra/external-id/cross-tenant-access-settings-b2b-collaboration).
- [Microsoft's Security Service Edge solution deployment guide for Microsoft Entra Internet Access for Microsoft Traffic proof of concept](/entra/architecture/sse-deployment-guide-microsoft-traffic).
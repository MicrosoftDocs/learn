In this module you've learned how to use PowerShell to manage users, groups, and licenses in Microsoft Entra ID. You've also learned how to manage some of the cloud services included in Microsoft 365. The following are the key takeaways:

- For configuring Microsoft 365 services, the service-specific, web-based consoles are intuitive and easy to use, but they don't provide access to all possible configuration options. There are many useful configuration options that you can review and configure only by using PowerShell cmdlets.
- You can manage Microsoft 365 identity features by using Microsoft Entra PowerShell (`Microsoft.Entra`) or the Microsoft Graph PowerShell SDK (`Microsoft.Graph`). Microsoft Entra PowerShell is recommended for most identity management tasks. Both modules use the Microsoft Graph API.
- You can manage users in Microsoft 365 by using Microsoft Entra PowerShell cmdlets such as `New-EntraUser`, `Get-EntraUser`, `Set-EntraUser`, and `Remove-EntraUser`. You need to connect to Microsoft 365 with `Connect-Entra` before you can create and manage user accounts.
- Microsoft 365 has multiple types of groups that you can use to provide access to resources or send email. Microsoft 365 groups are managed by cmdlets that are a part of Exchange Online, because these groups include a mailbox. Microsoft Entra PowerShell cmdlets such as `New-EntraGroup` and `Add-EntraGroupMember` manage distribution groups, security groups, and mail-enabled security groups.
- Microsoft Entra PowerShell requires you to identify whether a role is already in use before you can assign it to a user. If no users have been assigned to a role, it exists only as a template that you need to enable with `Enable-EntraDirectoryRole` before adding users to it.
- You can use `Get-EntraSubscribedSku` to review available licenses and `Set-EntraUserLicense` to assign or remove licenses in your Microsoft 365 tenant.

## Additional reading

To learn more, go through the following documents:

- [Microsoft Entra PowerShell overview](/powershell/entra-powershell/overview)
- [Get started with the Microsoft Graph PowerShell SDK​](/powershell/microsoftgraph/get-started)
- [Overview of Azure Cloud Shell​](/azure/cloud-shell/overview)
- [Compare groups​](/microsoft-365/admin/create-groups/compare-groups)

​



​

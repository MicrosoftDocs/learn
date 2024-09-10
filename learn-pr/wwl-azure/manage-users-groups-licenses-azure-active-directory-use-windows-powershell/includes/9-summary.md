In this module you've learned how to use PowerShell to manage users, groups, and licenses in Microsoft Entra ID. You've also learned how to manage some of the cloud services included in Microsoft 365. The following are the key takeaways:

- For configuring Microsoft 365 services, the service-specific, web-based consoles are intuitive and easy to use, but they don't provide access to all possible configuration options. There are many useful configuration options that you can review and configure only by using PowerShell cmdlets. 
- You can manage Microsoft 365 by using the Azure AD PowerShell for Graph (AzureAD) module or the Microsoft Azure Active Directory module for Windows PowerShell (MSOnline) module.
- You can manage users in Microsoft 365 by using both Msol and AzureAD cmdlets. In both cases, you need to connect to Microsoft 365 before you can create and manage user accounts.
- Microsoft 365 has multiple types of groups that you can use to provide access to resources or send email. Microsoft 365 groups are managed by cmdlets that are a part of Exchange Online, because these groups include a mailbox. There are AzureAD cmdlets to manage distribution groups, security groups, and mail-enabled security groups. There are no Msol cmdlets to manage distribution groups or mail-enabled security groups. 
- AzureAD cmdlets require you to identify whether a role is already in use before you can assign it to a user. If no users have been assigned to a role, then it exists only as a template, and you need to enable the role before you can add users to it. The Msol cmdlets don't differentiate between roles that are activated and those that aren't. 
- You can use both AzureAD and Msol cmdlets to manage and review the licenses available in your Microsoft 365 tenant. 

## Additional reading

To learn more, go through the following documents:

- [Get started with the Microsoft Graph PowerShell SDK​](https://aka.ms/get-started-with-the-Microsoft-Graph-PowerShell-SDK)
- [Overview of Azure Cloud Shell​](https://aka.ms/overview-of-azure-cloud-shell-2)
- [Compare groups​](https://aka.ms/compare-groups)

​



​

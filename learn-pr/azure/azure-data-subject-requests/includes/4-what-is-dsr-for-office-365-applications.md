Like the Azure DSR response, the Office 365 DSR response has a scope to it. Office 365 services are availabe in different envionments that can impact the scope. For example, a DSR received by an Office 365 customer in Germany would be executed in a national cloud called Office 365 Germany. Another similatrity between Azure and Office 365 DSR response is that the process of responing is broken into parts for ease of exection. 

## Scope of DSR for Office 365 applications
In general, the actions perfomed when executing a DSR for Office 365 applications will be the same regardless of the envionement. However, there are some exceptions based on isolated clouds and cross-premises scenarios. 

**Office 365 National Clouds**

National clouds are isolated from the Office 365 cloud and may have notible diferences in the DSR exectuion processes. The following are national clouds:
- Office 365 Germany
- Office 365 operated by 21Vianet (China)
- Office 365 US Government



**Hybrid deployments**

Many oganizaitons choose to manage their user identities in on-premises deployments of Active Directory. Hybrid deployments combine cloud-based servcies and on-premiess server products. In a hybrid deployments an organzation can share accounts and resources. For example, a user can sign in with their on-premises user account and access their mailbox in the cloud. Some of the most common hybrid deployments include:

- Exchange hybrid deployments, where some users have an on-premises mailbox and other users have Exchange Online mailboxes.
- SharePoint hybrid deployments, where site and file servers are on-premises and OneDrive for Business accounts are in Office 365
- The on-premises identity management system (Active Directory) that is synchronized with Azure Activity Directory, which is the underlying directory service in Office 365.

In a hybrid deployment the scope will vary based on the data that is responsive to a specific data subjet's DSR. It will be up to the controller to determin if the response must come from the cloud or from on-premises. While this module focuses on the cloud-based data responses, there is additional guidance available for responsding to DSRs on-premises. See "GDPR for Office on-premises Servers" https://docs.microsoft.com/en-us/compliance/regulatory/gdpr-for-office-servers 

## DSR response processes for Office 365 applications



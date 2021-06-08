Similar to the Azure DSR response, the Office 365 DSR response has a scope boundary. Office 365 services are available in different environments, which can impact scope. For example, what if an Office 365 customer receives a DSR in Germany? It would be fulfilled in the national cloud, Office 365 Germany. Another similarity between DSR responses for Azure and Office 365 is that the process of responding to DSRs consists of different parts. These differing parts enable easier fulfillment.

## DSR response scope for Office 365 applications

When responding to a DSR for Office 365 applications, the steps are virtually the same regardless of the environment. The only exceptions are that the steps might differ for isolated national clouds and hybrid deployments.

### Office 365 national clouds

National clouds are isolated from the Office 365 cloud. There might be notable differences in the DSR response processes. The Microsoft national clouds are:

- Microsoft Office 365 Germany
- Office 365 operated by 21Vianet (China)
- Office 365 US Government

### Hybrid deployments

Many organizations manage their user identities in on-premises Active Directory deployments, while retaining resources in the cloud. Hybrid deployments combine cloud-based services and on-premises server products. This enables an organization to share accounts and resources. For example, a user can sign in with their on-premises user account and access their cloud-based mailbox. Some common hybrid deployments include:

- **Microsoft Exchange.** In these hybrid deployments, mailboxes exist both on premises and in the cloud. 
- **Microsoft SharePoint.** Organizations with this hybrid deployment method use on-premises SharePoint servers, on-premises files servers, Skype for Business Online, and Microsoft OneDrive for Business accounts.
- **Hybrid identity management.** For this deployment, identities are managed on premises with Active Directory. Accounts are synchronized with Azure AD by using Azure AD Connect. This deployment type also makes single sign-on (SSO) scenarios possible for hybrid deployments.

In a hybrid deployment, the scope of a DSR will vary based on the data that's related to a specific DSR. The controller must determine whether the response must come from the cloud or from on premises. This unit focuses on cloud-based data responses. However, guidance is available for responding to DSRs on premises. Refer to the summary unit for more information.


## DSR response overview for Office 365 applications

There are four parts to the guidance for responding to a DSR in Office 365. The first three parts summarize the technical capabilities available to an organization that’s responding to a DSR. The fourth part provides resources for responding to DSRs in other Microsoft services and situations. The high-level response tasks differ based on the data type, application, and request type. For people using certain Office 365 products and services in limited scenarios, Microsoft is the data controller. 

### Part 1: Responding to DSRs for customer data

Guidance on responding to a DSR for customer data includes:

**Using the Content Search eDiscovery tool to respond to DSRs.** The applications in Microsoft 365 and Office 365 that support this tool are:

The applications that support content search in Microsoft 365 and Office 365 are:

- Calendar
- Excel
- Office Lens
- OneDrive for Business
- OneNote
- Outlook and Exchange
- People
- PowerPoint
- SharePoint Server and SharePoint Online
- Skype for Business
- Tasks
- Teams
- To Do
- Video
- Visio
- Word

> [!NOTES]
> 
> **Discovery of personal data** Microsoft estimates that more than 90 percent of an organization's data stored in Office 365 is authored in Word, Excel, PowerPoint, OneNote, and Outlook.

> Users authoring documents in these services usually store them on a SharePoint Online site, in their OneDrive for Business account, or in their Exchange Online mailbox. You can use the Content Search eDiscovery tool to find documents and mailbox items that might be relevant to the DSR you're investigating. The searches will also include the sites and mailboxes associated with Microsoft 365 Groups, Teams, and Education assignments. Limit the search. You can use compliance boundaries together with eDiscovery cases to limit the searchable content locations in an investigation. 

**Using in-app functionality to respond to DSRs.** You can use in-app functionality in these applications to find customer data:

- 365 Apps for Business
- Access
- Education
- Forms
- Kaizala
- Planner
- Power Apps
- Power Automate
- Power BI
- Project
- Publisher
- Stream
- Yammer

Responding to DSR rectification requests
Responding to DSR restriction requests 

The applications that support content search in Microsoft 365 and Office 365 are:

- Calendar
- Excel
- Office Lens
- OneDrive for Business
- OneNote
- Outlook
- Exchange Server and Microsoft Exchange Online
- People
- PowerPoint
- SharePoint Server and SharePoint Online
- Skype for Business
- Tasks
- Teams
- To Do
- Visio
- Word

### Part 2: DSR responses based on Office 365-generated insights

Office 365 offers analytics tools for both users and organizations. Delve and MyAnalytics provide insights for users including how they spend their time. The Workplace Analytics service provides insights to businesses about how people spend their time. These contain personal information, so they can be the source of a DSR.  
Responding to a DSR for MyAnalytics or Workplace Analytics can include the following steps:

1.	Access and export.
2.	Rectify.
3.	Restrict.
4.	Delete.


### Part three: Responding to DSRs for system-generated logs

The GDPR might require an organization to provide system-generated logs if they contain a data-subject's personal information. Examples include:

- Product and service usage data (user logs).
- User search requests and query data.
- Data that a product or service generates from system functionality and interaction by users or other systems.


> [!NOTE]
> You  can’t restrict or rectify data in system-generated logs. Doing so could expose Microsoft online services to fraud and increased security risks. The exposure can stem from system-generated logs that contain a historical record of the actions within these services. Any changes to these logs would break their integrity.

Responding to a DSR for system-generated logs can include the following:

1.	Access and export.
2.	Notify about DSR response issues.
3.	Delete.

#### National clouds

National clouds are isolated from other clouds by design. Administrators must follow guidance from the cloud that contains the data for any DSRs they receive. For a system-generated logs request, use the following steps:

- Office 365 Germany: Complete the same steps as you would for Microsoft 365 and Office 365:
  1. Access and export.
  2. Notify about DSR response issues.
  3. Delete.

- Office 365 US Government: Open the Microsoft 365 admin center and submit a request to Microsoft Support.
- Office 365 operated by 21Vianet (China):
    1. Open the Microsoft 365 admin center operated by the 21Vianet admin portal.
    1. Select **Commerce**, select **Subscription**, and then select **Privacy**.
    1. Select **GDPR**, and then enter the required information.

### Part four: Responding to DSRs for other Microsoft services

Microsoft provides specific guidance locating and action on personal data for DSR responses. This guidance is for scenarios in which a data subject uses one or more specific products, services, or administrative tools. The Summary unit for this module provides links to specific guidance for these products and services: 

- Microsoft Support
- Where Microsoft is the data controller
- Use of personal (Microsoft) accounts to acquire Microsoft products and services for personal use
- Third-party products
- Azure DevOps
- Dynamics 365
- Intune
- Visual Studio

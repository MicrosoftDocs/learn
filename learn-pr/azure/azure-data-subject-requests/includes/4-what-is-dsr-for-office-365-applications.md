Like the Azure DSR response, the Office 365 DSR response has a scope to it. Office 365 services are available in different environments that can impact the scope. For example, a DSR that an Office 365 customer receives in Germany would be fulfilled in a national cloud called Office 365 Germany. Another similarity between the DSR responses for Azure and Office 365 is that the process of responding consists of different parts, for ease of fulfillment. 

## Scope of DSR for Office 365 applications

In general, the actions performed when fulfilling a DSR for Office 365 applications will be the same, regardless of the environment. However, there are some exceptions based on isolated clouds and cross-premises scenarios. 

### Office 365 national clouds

National clouds are isolated from the Office 365 cloud and might have notable differences in the DSR fulfillment processes. The national clouds are:

- Office 365 Germany
- Office 365 operated by 21Vianet (China)
- Office 365 US Government

### Hybrid deployments

Many organizations choose to manage their user identities in on-premises deployments of Active Directory. Hybrid deployments combine cloud-based services and on-premises server products. In a hybrid deployment, an organization can share accounts and resources. For example, a user can sign in with their on-premises user account and access their mailbox in the cloud. Some of the most common hybrid deployments include<!--Richard, please review edits below. Also, the third bullet, identity management doesn’t match the list type - could you reword to match the “hybrid deployment type” list?-->:

- Microsoft Exchange hybrid deployments. Mailboxes exist both on-premises and in the cloud for an organization.
- Microsoft SharePoint hybrid deployments. An organization uses on-premises SharePoint servers, on-premises files servers, Skype for Business Online, and  Microsoft OneDrive for Business accounts.
- Hybrid Identity management. Identities are manged on-premises with Active Directory and the accounts are synchronized with Azure AD by using Azure AD Connect. This also facilitates single sign on scenarios for hybrid deployments.

In a hybrid deployment, the scope will vary based on the data that is responsive to a specific data subject's DSR. It’ll be up to the controller to determine if the response must come from the cloud or from on-premises. While this unit focuses on the cloud-based data responses, there is additional guidance available for responding to DSRs on-premises. Refer to the summary unit for more information. 

## DSR response processes for Office 365 applications

The guidance for fulfilling a DSR in Office 365 consists of four parts. The high-level fulfillment tasks differ based on the data type, application, and the request type. The first three parts detail the technical capabilities available to an organization to respond to a DSR. In some limited scenarios, however, Microsoft will be the data controller when people use certain Office 365 products and services. The fourth part provides guidance on how data subjects can submit DSRs to Microsoft.


### Part One: Responding to DSRs for customer data

Guidance on the fulfillment of a DSR for customer data consists of the following four sections:

- Using the Content Search eDiscovery tool to respond to DSRs
- Using in-app functionality to respond to DSRs
- Responding to DSR rectification requests
- Responding to DSR restriction requests

> [!NOTE]
> Microsoft estimates that more than 90 percent of an organization's data that is stored in Office 365 is authored in Microsoft Word, Microsoft Excel, Microsoft PowerPoint, Microsoft OneNote, and Microsoft Outlook.

The applications that support content search in Microsoft 365 and Office 365 are:

- Calendar
- Excel
- Office Lens
- OneDrive for Business
- OneNote
- Outlook
- Exchange Server and Exchange Online
- People
- PowerPoint
- SharePoint Server and SharePoint Online
- Skype for Business
- Tasks
- Microsoft Teams
- To Do
- Video
- Visio
- Word

When users author documents in Word, Excel, PowerPoint, OneNote, and Outlook, they most likely store them on a SharePoint Online site, in their OneDrive for Business account, or their Exchange Online mailbox. This means that you can use the Content Search eDiscovery tool to search and perform other DSR-related actions across SharePoint Online sites, OneDrive for Business accounts, and Exchange Online mailboxes. The searches will also include the sites and mailboxes associated with Microsoft 365 Groups, Teams, and EDU assignments. You can find documents and mailbox items that might be relevant to the DSR you're investigating.

> [!NOTE]
> You can use compliance boundaries together with eDiscovery cases to limit the content locations that can be searched in an investigation.

The applications where in-app functionality is used in Office 365 are:

- Microsoft Access
- Education
- Microsoft Power Automate
- Business App for Office 365
- Microsoft Forms
- Kaizala
- Microsoft Planner
- Microsoft Power Apps
- Microsoft Power BI
- Microsoft Project
- Microsoft Publisher
- Microsoft Stream
- Yammer

### Part two: Responding to DSRs with respect to insights generated by Office 365

The following table lists the Microsoft cloud services that include analytics that both users and organizations can utilize.

|Analytics service|Description|
|------|------|
|Delve|Insights for users|
|MyAnalytics|Insights for users|
|Workplace Analytics|Insights for organizations|

The fulfillment of a DSR for MyAnalytics or Workplace Analytics includes the following steps:

1. Access and export
2. Rectify
3. Restrict
4. Delete

### Part three: Responding to DSRs for system-generated logs
GDPR might require an organization to provide system-generated logs when they contain a data-subject's personal information.  Some examples include:

- Product and service usage data (user logs)
- User search requests and query data
- Data that a product or service generates as a result of system functionality and interaction by users or other systems

> [!NOTE]
> You cannot restrict or rectify data in system-generated logs. Doing so could expose the Microsoft cloud to fraud and increased security risks. This is because system-generated logs contain a historical record of the actions within the Microsoft cloud. Any changes to these logs would break their integrity. 

The fulfillment of a DSR for system-generated logs can include the following steps:

1. Accessing and exporting
2. Notifying about DSR execution issues
3. Deleting

#### National clouds

National clouds are isolated from other clouds by design. Administrators need to follow the guidance from the cloud that contains the responsive data for the DSR they receive. In the case of the request for system-generated logs the following will need to be performed:

- Office 365 Germany: Perform the same steps as Microsoft 365/Office 365:
	1. Accessing and exporting
	2. Notifying about DSR execution issues
	3. Deleting 
- Office 365 US Government: Go to the Microsoft 365 admin center and submit a request to Microsoft Support.
- Office 365 operated by 21Vianet (China): Go to the Microsoft 365 admin center operated by the 21Vianet admin portal. Select **Commerce**, select **Subscription**, select **Privacy**, select **GDPR**, and then enter the required information.

### Part four: Additional resources for DSRs

The following table lists some additional resources that are available for other DSR scenarios that might occur in the Microsoft cloud.<!--Richard, this table is a bit unclear. Are the “Resources” a mix of URLs and generic information? Could we make this less specific and provide a generic paragraph instead? -->
<!--Lakshmy, I had URLs here but removed them based on TR comments. I included these URLs in the summary unit. I have revised for clarity.-->

The follwoing scenarios require specific technical steps to fulfull a DSR. 
- Microsoft Support
- Microsoft is the data controller
- Personal accounts
- Third-party products
- Azure DevOps
- Dynamics 365 
- Intune
- Visual Studio

Microsoft has povides additional guidance on how to fulfull DSR when one or more of these products or services were used by a data subject. Links to the specific guidance for each of these procducts and servcies can be found in the Summary unit for this module.

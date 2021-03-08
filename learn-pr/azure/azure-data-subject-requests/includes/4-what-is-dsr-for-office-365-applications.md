Just as with the Azure DSR response, the Office 365 DSR response has a scope to it<!-- ID/SME. Can we reword the phrase "has a scope to it?" This is vague and won't translate well. -->. Office 365 services are available in different environments that can impact the scope. For example, if an Office 365 customer receives a DSR in Germany, it would be fulfilled in a national cloud called *Office 365 Germany*. Another similarity between the DSR responses for Azure and Office 365 is that the process of responding to DSRs consists of different parts, for ease of fulfillment.

## Scope of DSR for Office 365 applications

When responding to a DSR for Office 365 applications, the steps should be virtually the same regardless of the environment. However, there are some exceptions based on isolated clouds and cross-premises scenarios.

### Office 365 national clouds

National clouds are isolated from the Office 365 cloud and might have notable differences in the DSR fulfillment processes. The national clouds are:

- Microsoft Office 365 Germany
- Office 365 operated by 21Vianet (China)
- Office 365 US Government

### Hybrid deployments

Many organizations choose to manage their user identities in on-premises Active Directory deployments. Hybrid deployments combine cloud-based services and on-premises server products. This enables an organization to share accounts and resources. For example, a user can sign in with their on-premises user account and still access their mailbox in the cloud. Some of the most common hybrid deployments include:

- Microsoft Exchange hybrid deployments. In these deployments, mailboxes exist both on-premises and in the cloud for an organization.
- Microsoft SharePoint hybrid deployments. Organizations with this deployment method use on-premises SharePoint servers, on-premises files servers, Skype for Business Online, and  Microsoft OneDrive for Business accounts.
- Hybrid identity management. For this deployment, identities are managed on-premises with Active Directory and the accounts are synchronized with Azure AD by using Azure AD Connect. This deployment type also makes single sign-on (SSO) scenarios possible for hybrid deployments.

In a hybrid deployment, the scope will vary based on the data that's responsive<!-- Can we pick a word other than "responsive?" Responsive indicates movement, which data doesn't do. Also, the scope of what? Of the DSR?--> to a specific data subject's DSR. The controller will need to determine whether the response must come from the cloud or from on-premises. While this unit focuses on the cloud-based data responses, other guidance is available for responding to DSRs on-premises. Refer to the summary unit for more information.

## DSR response processes for Office 365 applications

The guidance for fulfilling a DSR in Office 365 consists of four parts. The first three parts detail the technical capabilities available to an organization responding to a DSR. The fourth part provides guidance on how data subjects can submit DSRs to Microsoft. The high-level fulfillment tasks differ based on the data type, application, and request type. For people using certain Office 365 products and services, in some limited scenarios, Microsoft will be the data controller. 

### Part one: Responding to DSRs for customer data

Guidance on DSR fulfillment for customer data consists of the following four sections:

- Using the Content Search eDiscovery tool to respond to DSRs
- Using in-app functionality to respond to DSRs
- Responding to DSR rectification requests
- Responding to DSR restriction requests

The applications that support content search in Microsoft 365 and Office 365 are:

- Calendar
- Microsoft Excel
- Office Lens
- Microsoft OneDrive for Business
- Microsoft OneNote
- Microsoft Outlook
- Microsoft Exchange Server and Microsoft Exchange Online
- Microsoft People
- Microsoft PowerPoint
- SharePoint Server and SharePoint Online
- Skype for Business
- Tasks
- Microsoft Teams
- Microsoft To Do
- Visio
- Microsoft Word

 [!NOTE]
> Microsoft estimates that more than 90 percent of an organization's data stored in Office 365 is authored in Word, Excel, PowerPoint, OneNote, and Outlook.

Users authoring documents in Word, Excel, PowerPoint, OneNote, and Outlook usually store them on a SharePoint Online site, in their OneDrive for Business account, or in their Exchange Online mailbox. This means you can use the Content Search eDiscovery tool to search and perform other DSR-related actions across these locations. The searches will also include the sites and mailboxes associated with Microsoft 365 Groups, Teams, and EDU<!-- ID/SME: We need to define this acronym. --> assignments. By using the Content Search eDiscovery tool, you can find documents and mailbox items that might be relevant to the DSR you're investigating.

> [!NOTE]
> You can use compliance boundaries together with eDiscovery cases to limit the content locations that can be searched in an investigation.

The applications where in-app functionality is used in Office 365 are:

- Microsoft Access
- Education
- Power Automate
- Business App for Office 365<!-- ID/SME: Please review this product name. I can't find it. There was an "Office 365 Apps for Business," but as of Feb 2020, per Term Studio, this been replaced with "Microsoft 365 Apps for Business." -->
- Microsoft Forms
- Microsoft Kaizala
- Microsoft Planner
- Microsoft Power Apps
- Microsoft Power BI
- Microsoft Project
- Microsoft Publisher
- Microsoft Stream
- Yammer

### Part two: Responding to DSRs with respect to insights generated by Office 365

The following table lists the Microsoft cloud services that include analytics that both users and organizations can use.

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

GDPR might require an organization to provide system-generated logs if they contain a data-subject's personal information. Some examples include:

- Product and service usage data (user logs)
- User search requests and query data
- Data that a product or service generates from system functionality and interaction by users or other systems

> [!NOTE]
> You can't restrict or rectify data in system-generated logs. Doing so could expose the Microsoft cloud to fraud and increased security risks. This is because system-generated logs contain a historical record of the actions within the Microsoft cloud. Any changes to these logs would break their integrity.

The fulfillment of a DSR for system-generated logs can include the following steps:

1. Accessing and exporting
2. Notifying about DSR fulfillment issues
3. Deleting

#### National clouds

National clouds are isolated from other clouds by design. Administrators need to follow the guidance from the cloud that contains the responsive data for the DSR they receive. For a system-generated logs request, you could use the following steps:

- Office 365 Germany: Complete the same steps as Microsoft 365/Office 365:
  1. Access and export
  2. Notify <!-- ID/SME: Notify whom? -->about DSR fulfillment issues
  3. Delete

- Office 365 US Government: Open the Microsoft 365 admin center and submit a request to Microsoft Support.
- Office 365 operated by 21Vianet (China):
    1. Open the Microsoft 365 admin center operated by the 21Vianet admin portal.
    1. Select **Commerce**, select **Subscription**, and then select **Privacy**.
    1. Select **GDPR**, and then enter the required information.

### Part four: Additional resources for DSRs

The following scenarios require specific technical steps to fulfill a DSR:

- Microsoft Support
- Microsoft is the data controller
- Personal accounts
- Third-party products
- Azure DevOps
- Dynamics 365
- Intune
- Visual Studio

> [!NOTE]
> Microsoft provides additional guidance on how to fulfill DSRs when a data subject uses one or more of these products or services. You can find links to the specific guidance for each of these products and services in the Summary unit for this module.
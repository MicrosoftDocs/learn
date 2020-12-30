Like the Azure DSR response, the Office 365 DSR response has a scope to it. Office 365 services are available in different environments that can impact the scope. For example, a DSR received by an Office 365 customer in Germany would be executed in a national cloud called Office 365 Germany. Another similarity between Azure and Office 365 DSR response is that the process of responding is broken into parts for ease of execution. 

## Scope of DSR for Office 365 applications
In general, the actions performed when executing a DSR for Office 365 applications will be the same regardless of the environment. However, there are some exceptions based on isolated clouds and cross-premises scenarios. 

**Office 365 National Clouds**

National clouds are isolated from the Office 365 cloud and may have notable differences in the DSR execution processes. The following are national clouds:
- Office 365 Germany
- Office 365 operated by 21Vianet (China)
- Office 365 US Government

**Hybrid deployments**

Many organizations choose to manage their user identities in on-premises deployments of Active Directory. Hybrid deployments combine cloud-based services and on-premises server products. In a hybrid deployments an organization can share accounts and resources. For example, a user can sign in with their on-premises user account and access their mailbox in the cloud. Some of the most common hybrid deployments include:

- Exchange hybrid deployments, where some users have an on-premises mailbox and other users have Exchange Online mailboxes.
- SharePoint hybrid deployments, where site and file servers are on-premises and OneDrive for Business accounts are in Office 365
- The on-premises identity management system (Active Directory) that is synchronized with Azure Activity Directory, which is the underlying directory service in Office 365.

In a hybrid deployment the scope will vary based on the data that is responsive to a specific data subject's DSR. It will be up to the controller to determine if the response must come from the cloud or from on-premises. While this module focuses on the cloud-based data responses, there is additional guidance available for responding to DSRs on-premises. See "GDPR for Office on-premises Servers" https://docs.microsoft.com/en-us/compliance/regulatory/gdpr-for-office-servers 

**In-scope Applications**

Office 365 encompass many applications that have the potential to store user data. Knowing which applications that the data subject uses will help narrow down what is in-scope for the DSR response. Depending on the application, you may be able to use the Content Search tool to respond. In some cases however, you'll have to use the in-app functionality to get to the data.


One of the fastest ways to determine the in-scope applications is to review the Microsoft 365 for business subscription. The Office 365 admin portal can be used to locate the user's account. In the properties for the user account you can view their product licensing. 

**Compliance Boundaries**

Compliance Boundaries can be created using the Security & Compliance Center. They are logical search boundaries that control locations that the people involved in the DSR execution can access. Some common use cases for compliance boundaries include:
- geographical boundaries
- governmental organizations agencies
- Organizational units or department

## DSR response processes for Office 365 applications

The guidance for executing a DSR in Office 365 ("Office 365 Data Subject Requests for the GDPR and CCPA" https://docs.microsoft.com/en-us/compliance/regulatory/gdpr-dsr-office365 ) is broken into four parts. The high-level execution tasks differ based on the data type,  application, and the request type. Parts 1-3 detail the technical capabilities available to an organization to respond to a DSR request. In some limited scenarios, however, Microsoft will be the data controller when people use certain Office 365 products and services. Part 4 provides guidance on how data subjects can submit DSR requests to Microsoft.


**Part 1: Responding to DSRs for Customer Data**

Guidance on the execution of a DSR for customer data is organized into four sections:

- Using the Content Search eDiscovery tool to respond to DSRs
- Using In-App functionality to respond to DSRs
- Responding to DSR rectification requests
- Responding to DSR restriction requests

> Microsoft estimates that over 90% of an organization's data that is stored in Office 365 is authored in Word, Excel, PowerPoint, OneNote, and Outlook.

The following table shows the applications that support Content Search in Office 365.

|||||
|---|---|---|---|
|Calendar|Excel|Office Lens|OneDrive for Business|
|OneNote|Outlook/Exchange|People|PowerPoint|
|SharePoint|Skype for Business|Tasks|Teams|
|To Do|Video|Visio|Word|

Documents authored in Word, Excel, PowerPoint, OneNote, and Outlook are most likely stored on a SharePoint Online site, in a user's OneDrive for Business account, or in a user's Exchange Online mailbox. That means you can use the Content Search eDiscovery tool to search (and perform other DSR-related actions) across SharePoint Online sites, OneDrive for Business accounts, and Exchange Online mailboxes (including the sites and mailboxes associated with Microsoft 365 Groups, Microsoft Teams, EDU Assignments) to find documents and mailbox items that may be relevant to the DSR you're investigating.

You can use Compliance Boundaries together with eDiscovery cases to limit the content locations that can be searched in an investigation.

The following table shows the applications where in-app functionality is used in Office 365.

|||||
|---|---|---|---|
|Access|Education|Flow|Business App for Office 365|
|Forms|Kaizala|Planner|Power Apps|
|Power BI|Project|Publisher|Stream|
|Yammer||||

**Part 2: Responding to DSRs with Respect to Insights Generated by Office 365**

The Microsoft suite of Office 365 services includes online services that provide insights to users and organizations that have opted to use them.

- Delve and MyAnalytics provide insights to individual users.
- Workplace Analytics provides insights to organizations.

The execution of a DSR for MyAnalytics or Workplace Analytics include the following steps:
1. Access and export
2. Rectify
3. Restrict
4. Delete

**Part 3: Responding to DSRs for system-generated Logs**

Examples of system-generated logs that may be deemed personal under GDPR include:
- Product and service usage data such as user activity logs
- User search requests and query data
- Data generated by product and services as a product of system functionality and interaction by users or other systems

> The ability to restrict or rectify data in system-generated logs is not supported. Data in system-generated logs constitutes factual actions conducted within the Microsoft cloud and diagnostic data, and modifications to such data would compromise the historical record of actions and increase fraud and security risks. 

The execution of a DSR for system-generated logs can include:
1. Accessing and exporting system-generated logs
2. Notify about exporting or deleting issues
3. Deleting system-generated logs

**National Clouds**

A global IT admin needs to do the following to export system-generated log data in the following national clouds:
- Office 365 Germany: Same steps as Office 365.
- Office 365 US Government: Go to the Office 365 admin portal and submit a request to Microsoft Support.
- Office 365 operated by 21Vianet (China): Go to the Office 365 operated by 21Vianet admin portal and then go to **Commerce > Subscription > Privacy > GDPR** and enter the required information.

**Part 4: Additional resources to assist you with DSRs**

There are various circumstances where your organization's users may use their work or school account (also referred to as "Azure Active Directory ID" or "AAD") to sign in to Microsoft products and services for which Microsoft is a data controller. For all such products and services, your users need to initiate their own data subject requests directly to Microsoft and Microsoft will fulfill the requests directly to the user. By design, products and services involving storage of user-authored content enable users to access, export, rectify, and delete their user-authored content as part of the inherent functionality of the products. Scenarios where this may apply include the following:
- Optional connected online services
- User feedback
- Windows authenticated via work or school account
- User-acquired products or services

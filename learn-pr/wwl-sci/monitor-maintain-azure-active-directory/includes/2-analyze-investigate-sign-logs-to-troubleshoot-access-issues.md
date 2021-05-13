The reporting architecture in Azure AD consists of the following components:

- **Activity**

  - **Sign-ins** - Information about the usage of managed applications and user sign-in activities.

  - **Audit logs** - Audit logs provide system activity information about users and group management, managed applications, and directory activities.

  - **Provisioning logs** - Provisioning logs enable customers to monitor activity by the provisioning service, such as creating a group in ServiceNow or a user imported from Workday.

- **Security**

  - **Risky sign-ins** - A risky sign-in is an indicator for a sign-in attempt by someone who isn't the legitimate owner of a user account.

  - **Users flagged for risk** - A risky user is an indicator for a user account that might have been compromised.

### Who can access the data?

- Users in the Security Administrator, Security Reader, Global Reader, and Report Reader roles

- Global Administrators

- Any user (non-admins) can access their own sign-ins

### What Azure AD license do you need to access sign-in activity?

The sign-in activity report is available in all editions of Azure AD and can also be accessed through the Microsoft Graph API.

## Sign-ins report

The user sign-ins report provides answers to the following questions:

- What is the sign-in pattern of a user?

- How many users have signed in over a week?

- What’s the status of these sign-ins?

On the Azure portal menu, select **Azure Active Directory**, or search for and select **Azure Active Directory** from any page.

> [!div class="mx-imgBorder"]
> ![Select Azure Active Directory](../media/select-azure-active-directory.png)

Under **Monitoring**, select **Sign-ins** to open the Sign-ins report.

> [!div class="mx-imgBorder"]
> ![Screenshot shows Sign-ins selected from the Monitoring menu.](../media/sign-ins-azure-active-directory.png)

It may take up to two hours for some sign-in records to show up in the portal.

> [!IMPORTANT]
> The sign-ins report only displays the interactive sign-ins—those in which a user manually signs in using their username and password. Non-interactive sign-ins, such as service-to-service authentication, are not displayed in the sign-ins report.

A sign-ins log has a default list view that shows the:

- Sign-in date

- Related user

- Application the user has signed in to

- Sign-in status

- Status of the risk detection

- Status of the multifactor authentication (MFA) requirement

> [!div class="mx-imgBorder"]
> ![Screenshot shows the Office 365 SharePoint Online Sign-ins.](../media/sign-activity.png)

You can customize the list view by clicking Columns in the toolbar.

> [!div class="mx-imgBorder"]
> ![Screenshot shows the Columns option in the Sign-ins page.](../media/columns-option.png)

The Columns dialog gives you access to the selectable attributes. In a sign-in report, you can't have fields that have more than one value for a given sign-in request as column. For example, this is true for authentication details, conditional access data, and network location.

> [!div class="mx-imgBorder"]
> ![Screenshot shows the Columns dialog box where you can select attributes.](../media/columns-2.png)

Select an item in the list view to get more detailed information.

> [!div class="mx-imgBorder"]
> ![Screenshot shows a detailed information view.](../media/basic-sign.png)

Customers can now troubleshoot Conditional Access policies through all sign-in reports. By clicking on the Conditional Access tab for a sign-in record, customers can review the Conditional Access status and dive into the details of the policies that applied to the sign-in and the result for each policy. For more information, see the [FAQ about CA information in all sign-ins](https://docs.microsoft.com/azure/active-directory/reports-monitoring/reports-faq).

## Filter sign-in activities

First, narrow down the reported data to a level that works for you. Second, filter sign-in data using date field as default filter. Azure AD provides you with a broad range of additional filters you can set:

> [!div class="mx-imgBorder"]
> ![Screenshot shows the Add filters option.](../media/add-filters-option.png)

**Request ID** - The ID of the request you care about.

**User** - The name or the user principal name (UPN) of the user you care about.

**Application** - The name of the target application.

**Status** - The sign-in status you care about:

- Success

- Failure

- Interrupted

**IP address** - The IP address of the device used to connect to your tenant.

**Location** - The location the connection was initiated from:

- City

- State/Province

- Country/Region

**Resource** - The name of the service used for the sign-in.

**Resource ID** - The ID of the service used for the sign-in.

**Client app** - The type of the client app used to connect to your tenant:

> [!div class="mx-imgBorder"]
> ![Client app filter](../media/client-app-filter.png)

| Name                             | Modern authentication | Description                                                                                                                                                                                    |
| -------------------------------- | --------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Authenticated SMTP               |                       | Used by POP and IMAP clients to send email messages.                                                                                                                                           |
| Autodiscover                     |                       | Used by Outlook and EAS clients to find and connect to mailboxes in Exchange Online.                                                                                                           |
| Exchange ActiveSync              |                       | Shows all sign-in attempts where the EAS protocol has been attempted.                                                                                                                          |
| Browser                          | yes                   | Shows all sign-in attempts from users using web browsers.                                                                                                                                      |
| Exchange ActiveSync              |                       | Shows all sign-in attempts from users with client apps using Exchange ActiveSync to connect to Exchange Online.                                                                                |
| Exchange Online PowerShell       |                       | Used to connect to Exchange Online with remote PowerShell. If you block basic authentication for Exchange Online PowerShell, you need to use the Exchange Online PowerShell module to connect. |
| Exchange Web Services            |                       | A programming interface that's used by Outlook, Outlook for Mac, and third-party apps.                                                                                                         |
| IMAP4                            |                       | A legacy mail client using IMAP to retrieve email.                                                                                                                                             |
| MAPI over HTTP                   |                       | Used by Outlook 2010 and later.                                                                                                                                                                |
| Mobile apps and desktop clients  | yes                   | Shows all sign-in attempts from users using mobile apps and desktop clients.                                                                                                                   |
| Offline Address Book             |                       | A copy of address list collections that are downloaded and used by Outlook.                                                                                                                    |
| Outlook Anywhere (RPC over HTTP) |                       | Used by Outlook 2016 and earlier.                                                                                                                                                              |
| Outlook Service                  |                       | Used by the Mail and Calendar app for Windows 10.                                                                                                                                              |
| POP3                             |                       | A legacy mail client using POP3 to retrieve email.                                                                                                                                             |
| Reporting Web Services           |                       | Used to retrieve report data in Exchange Online.                                                                                                                                               |
| Other clients                    |                       | Shows all sign-in attempts from users where the client app is not included or unknown.                                                                                                         |

**Operating system** - The operating system running on the device used to sign on to your tenant.

**Device browser** - If the connection was initiated from a browser, this field enables you to filter by browser name.

**Correlation ID** - The correlation ID of the activity.

**Conditional access** - The status of the applied conditional access rules.

- **Not applied**: No policy applied to the user and application during sign-in.

- **Success**: One or more conditional access policies applied to the user and application (but not necessarily the other conditions) during sign-in.

- **Failure**: The sign-in satisfied the user and application condition of at least one Conditional Access policy, and grant controls are either not satisfied or set to block access.

## Download sign-in activities

Click the **Download** option to create a CSV or JSON file of the most recent 250,000 records. Start with **Download Sign-ins** if you want to work with the data outside the Azure portal.

> [!div class="mx-imgBorder"]
> ![Download](../media/download-2.png)

> [!IMPORTANT]
> The number of records you can download is constrained by the [Azure AD report retention policies](https://docs.microsoft.com/azure/active-directory/reports-monitoring/reference-reports-data-retention).

## Sign-ins data shortcuts

Azure AD and the Azure portal both provide you with additional entry points to sign-in data:

- The Identity security protection overview

- Users

- Groups

- Enterprise applications

### Users sign-in data in Identity security protection

The user sign-in graph in the **Identity security protection** overview page shows weekly aggregations of sign-ins. The default for the period is 30 days.

> [!div class="mx-imgBorder"]
> ![Screenshot shows a graph of Sign-ins over a month.](../media/sign-ins-over-month.png)

Click on a day in the sign-in graph, you get an overview of the sign-in activities for this day.

Each row in the sign-in activities list shows:

- Who has signed in?

- What application was the target of the sign-in?

- What is the status of the sign-in?

- What is the MFA status of the sign-in?

By clicking an item, you get more details about the sign-in operation:

- User ID

- User

- Username

- Application ID

- Application

- Client

- Location

- IP address

- Date

- MFA Required

- Sign-in status

> [!NOTE]
> IP addresses are issued in such a way that there is no definitive connection between an IP address and where the computer with that address is physically located. Mapping IP addresses is complicated by the fact that mobile providers and VPNs issue IP addresses from central pools that are often very far from where the client device is actually used. Currently in Azure AD reports, converting an IP address to a physical location is a best effort based on traces, registry data, reverse look-ups, and other information.

On the **Users** page, you get a complete overview of all user sign-ins by clicking **Sign-ins** in the **Activity** section.

> [!div class="mx-imgBorder"]
> ![Screenshot shows the Activity section where you can select Sign-ins.](../media/activity-section.png)

## Usage of managed applications

With an application-centric view of your sign-in data, you can answer questions such as:

- Who is using my applications?

- What are the top three applications in my organization?

- How is my newest application doing?

The entry point to this data is the top three applications in your organization. The data is contained within the last 30 days report in the **Overview** section under **Enterprise applications**.

> [!div class="mx-imgBorder"]
> ![Screenshot shows where you can select Overview.](../media/select-overview.png)

The app-usage graphs weekly aggregations of sign-ins for your top three applications in a given time period. The default time period is 30 days.

> [!div class="mx-imgBorder"]
> ![Screenshot shows the App usage for a one month period.](../media/graph-chart.png)

If you want to, you can set the focus on a specific application.

> [!div class="mx-imgBorder"]
> ![Reporting](../media/single-app-usage-graph.png)

When you click on a day in the app usage graph, you get a detailed list of the sign-in activities.

The **Sign-ins** option gives you a complete overview of all sign-in events to your applications.

## Microsoft 365 activity logs

You can view Microsoft 365 activity logs from the Microsoft 365 admin center. Microsoft 365 activity and Azure AD activity logs share a significant number of the directory resources. Only the Microsoft 365 admin center provides a full view of the Microsoft 365 activity logs.

You can also access the Microsoft 365 activity logs programmatically by using the Office 365 Management APIs.


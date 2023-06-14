Microsoft Graph provides a unified programmability model that you can use to access the data in Microsoft 365, Windows, and Enterprise Mobility + Security. You can use the  data in Microsoft Graph to build customized apps for your organization.

The Microsoft Graph API offers a single endpoint, https://graph.microsoft.com (either v1.0 or beta versions). You can use REST APIs or SDKs to access the endpoint and build apps that support Microsoft 365 scenarios. Microsoft Graph also includes a powerful set of services that manage user and device identity, access, compliance, and security and help protect organizations from data leakage or loss.

### What's in Microsoft Graph?

Microsoft Graph exposes REST APIs and client libraries to access data on the following Microsoft cloud services:

 - Microsoft 365 core services: Bookings, Calendar, Delve, Excel, Microsoft Purview eDiscovery, Microsoft Search, OneDrive, OneNote, Outlook/Exchange, People (Outlook contacts), Planner, SharePoint, Teams, To Do, Viva Insights
 - Enterprise Mobility + Security services: *Advanced Threat Analytics*, *Advanced Threat Protection*, Azure Active Directory, Identity Manager, and Intune
 - Windows services: activities, devices, notifications, Universal Print
 - Dynamics 365 Business Central services

### Microsoft Graph Security API

The Microsoft Graph security API is an intermediary service (or broker) that provides a single programmatic interface to connect multiple Microsoft Graph security providers (also called security providers or providers). Requests to the Microsoft Graph security API are federated to all applicable security providers. The results are aggregated and returned to the requesting application in a common schema, as shown in the following diagram.

:::image type="content" source="../media/graph-security-overview-diagram.png" alt-text="Diagram showing the Microsoft Security Graph architecture.":::

 Developers can use the Security Graph to build intelligent security services that:

 -  Integrate and correlate security alerts from multiple sources.
 -  Stream alerts to security information and event management (SIEM) solutions.
 -  Automatically send threat indicators to Microsoft security solutions to enable alert, block, or allow actions.
 -  Unlock contextual data to inform investigations.
 -  Discover opportunities to learn from the data and train your security solutions.
 -  Automate SecOps for greater efficiency.

### Use the Microsoft Graph Security API

There are two versions of the Microsoft Graph Security API.

 - Microsoft Graph REST API v1.0
 - Microsoft Graph REST API Beta

The beta version provides new or enhanced APIs that are still in preview status. APIs in preview status are subject to change, and may break existing scenarios without notice.

For Security Operations Analysts, both Microsoft Graph API versions support advanced hunting using the **runHuntingQuery** method. This method includes a query in Kusto Query Language (KQL).

 - Advanced hunting example in Microsoft 365 Defender: 

    ```html    
    POST https://graph.microsoft.com/v1.0/security/runHuntingQuery

    {
        "Query": "DeviceProcessEvents | where InitiatingProcessFileName =~ \"powershell.exe\" | project Timestamp, FileName, InitiatingProcessFileName | order by Timestamp desc | limit 2"
    }
    ```
You can use [Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) to run the hunting query:

:::image type="content" source="../media/graph-explorer-hunting-kql-query-2023-06-08.png" alt-text="Screenshot of the Microsoft Graph Explorer running the KQL hunting query.":::

**Additional reading** - For more information, see [The Microsoft Graph Security API](/graph/security-concept-overview).

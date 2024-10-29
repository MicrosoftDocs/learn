Data security and compliance are critical in today's digital environment. Microsoft Purview Audit offers tools to log user and administrator activities, helping organizations protect their data and meet compliance requirements.

The IT compliance team at our network of healthcare facilities is now assessing these tools to enhance the security of patient data across multiple locations, driven by recent concerns over access patterns that could indicate potential breaches.

## Microsoft Purview auditing solutions

Microsoft Purview auditing solutions enable organizations to handle security events, forensic investigations, internal investigations, and compliance obligations efficiently. They integrate many Microsoft 365 services and solutions and record thousands of user and admin activities in your organization's unified audit log. Security ops, IT admins, insider risk teams, and compliance and legal investigators in your organization can search these audit records to find out what took happened across your Microsoft 365 organization.

Here you learn how to:

- Identify the differences between Audit (Standard) and Audit (Premium).
- Describe how auditing tools enhance your organizational security and compliance.
- Examine audit log retention policies and their role in meeting compliance and regulatory requirements.

## Comparison of key capabilities

Use the to table compare the key capabilities available in Audit (Standard) and Audit (Premium). All Audit (Standard) functionality is included in Audit (Premium).

|Capability|Audit (Standard)|Audit (Premium)|
|:------|:-------------|:-------------|
|Enabled by default|✔|✔|
|Thousands of searchable audit events|✔|✔|
|Audit search tool in the Microsoft Purview compliance portal and compliance portal|✔|✔|
|Search-UnifiedAuditLog cmdlet|✔|✔|
|Export audit records to CSV file|✔|✔|
|Access to audit logs via Office 365 Management Activity API|✔|✔|
|180-day audit log retention|✔|✔|
|1-year audit log retention||✔|
|10-year audit log retention||✔|
|Audit log retention policies||✔|
|Intelligent insights||✔|

## Audit (Standard) in Microsoft Purview

Audit (Standard) is a feature in Microsoft Purview that helps you log and search various activities performed by users and administrators across Microsoft 365 services. This functionality helps organizations to carry out forensic, IT, compliance, and legal investigations more efficiently.

- **Enabled by default**: Audit (Standard) is enabled by default for organizations with eligible subscriptions, ensuring no manual setup is needed for activity logging. The only setup requirement is assigning the necessary permissions for users to access the audit search tool.
- **Thousands of searchable audit events**: You can search for a wide range of user and admin activities, providing information about how Microsoft 365 services are used.
- **Searchability**: Audit logs are accessible and searchable in the Microsoft Purview compliance portal, supporting searches by activity, user, or timeframe. The `Search-UnifiedAuditLog` cmdlet in Exchange Online PowerShell allows for advanced searches and scripting opportunities.
- **Export audit records to a CSV file**: Search results can be exported to CSV format for analysis in Microsoft Excel. This functionality enables the examination, sorting, and comparison of audit data, making large amounts of audit data easier to manage.
- **API access**: The Office 365 Management Activity API provides another way to access audit logs, supporting longer retention or importing audit data to a SIEM solution for deeper security analysis.
- **180-day audit log retention**: Audit logs are retained for 180 days by default, offering a six-month review window for more thorough  investigations.

## Audit (Premium) in Microsoft Purview

Audit (Premium) enhances the functionality of Audit (Standard) by offering enhanced audit log management and analytical insights.

- **Audit log retention policies**: Audit (Premium) enables customized audit log retention policies to retain audit records up to one year, or 10 years for users with a required add-on license.
- **Longer retention of audit records**: Microsoft Entra ID, Exchange, OneDrive, and SharePoint audit records are retained for one year by default. Audit records for all other activities are retained for 180 days by default, or you can use audit log retention policies to configure longer retention periods.
- **Audit (Premium) intelligent insights**: Audit records for intelligent insights provide detailed visibility into specific events. For example, these events include actions like mail item access and user search behavior in Exchange Online and SharePoint Online. This capability enables more effective forensic and compliance investigations.
- **Higher bandwidth to the Office 365 Management Activity API**: Audit (Premium) provides organizations with about twice the API bandwidth allocation compared to Audit (Standard). This increased bandwidth enhances access to audit logs through the Office 365 Management Activity API.

### Long-term retention of audit logs

- **One year default retention**: Audit (Premium) retains the audit records of Exchange, SharePoint, and Microsoft Entra ID for one year by default. This default policy helps forensic and compliance investigations by making sure audit records are retained for a sufficient period.
- **Extended 10 year retention option**: For organizations that need to keep their audit logs for longer periods of time, Audit (Premium) provides the option to increase retention up to 10 years. This extended retention is suitable for in-depth, long-term investigations and complying with strict regulatory, legal, and internal requirements. This extended retention requires a per-user add-on license. It applies from the point of policy implementation forward and doesn't apply retroactively to previously generated logs.

### Audit log retention policies

With Audit (Premium), you can tailor audit log retention policies beyond the standard and default settings. These policies can be customized based on:

- The specific Microsoft 365 service involved.
- The nature of the audited activities.
- The users performing these activities.

Logs not covered by the default one year policy are kept for 180 days, but with customized policies, you can specify retention for up to 1 year (or 10 years with the add-on license) based on your organization's needs.

In Audit (Premium), you can assign priorities to your custom retention policies, ensuring that the most important ones are applied first. Additionally, if you make any changes to these policies or your licensing terms, these changes only affect audit data moving forward. Data that was already logged before the changes keep its original expiration settings, providing consistency for your historical records.

### Audit (Premium) activities

Audit (Premium) provides advanced tools for in-depth investigations in Microsoft 365 environments. It records key activities such as mail item access and user actions in Exchange Online and Microsoft Teams. This activity logging is essential for analyzing possible security breaches and ensuring compliance.

In Exchange Online, the system logs when mail items already marked with a sensitivity label are accessed.

In Microsoft Teams, the system logs various aspects of communication, such as:

- **Chat interactions**: Creation, retrieval, and updates of chat messages, along with their contextual properties.
- **Meeting details**: Details of meeting participants, including whether they joined from the lobby and what artifacts were shared during the session.
- **Message dynamics**: Creation, deletion, and modifications of messages, providing a trail of how information is handled within the organization.

## Knowledge check

Choose the best response for the question below, then select **Check your answers**.

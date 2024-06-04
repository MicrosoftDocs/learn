
Microsoft Purview auditing solutions provide an integrated solution to help organizations effectively respond to:

 -  Security events
 -  Forensic investigations
 -  Internal investigations
 -  Compliance obligations

### Two Microsoft Purview auditing solutions

Microsoft Purview provides two auditing solutions: Audit (Standard) and Audit (Premium).

Thousands of user and admin operations performed in dozens of Microsoft 365 services and solutions are captured, recorded, and retained in your organization's unified audit log. Audit records for these events are searchable by security ops, IT admins, insider risk teams, and compliance and legal investigators in your organization. This capability provides visibility into the activities performed across your Microsoft 365 organization.

### Audit (Standard)

Microsoft Purview Audit (Standard) provides organizations with the ability to log and search for audited activities. It also enables an organization to power its forensic, IT, compliance, and legal investigations.

 -  **Enabled by default**. Audit (Standard) is turned on by default for all organizations with the appropriate subscription. As a result, records for audited activities will be captured and searchable. The only setup that's required is to assign the necessary permissions to access the audit log search tool (and the corresponding cmdlet) and to ensure that users are assigned the right license for Microsoft Purview Audit (Premium) features.
 -  **Thousands of searchable audit events**. Organizations can search for a wide-range of audited activities that occur in most of the Microsoft 365 services in an organization. For a partial list of the activities that can be searched for, see [Audited activities](/microsoft-365/compliance/search-the-audit-log-in-security-and-compliance?azure-portal=true). For a list of the services and features that support audited activities, see [Audit log record type](/office/office-365-management-api/office-365-management-activity-api-schema#auditlogrecordtype?azure-portal=true).
 -  **Audit search tool in the Microsoft Purview compliance portal**. Organizations can use the Audit log search tool in the Microsoft Purview compliance portal to search for audit records. You can search for:
     -  Specific activities
     -  Activities performed by specific users
     -  Activities that occurred within a date range
    
    :::image type="content" source="../media/audit-log-search-tool-6cf1e38b.png" alt-text="Screenshot of the audit log search tool in the Microsoft Purview compliance portal." lightbox="../media/audit-log-search-tool-6cf1e38b.png":::
    
 -  **Search-UnifiedAuditLog cmdlet**. Organizations can also use the **Search-UnifiedAuditLog** cmdlet in Exchange Online PowerShell (the underlying cmdlet for the search tool) to search for audit events or to use in a script. For more information, see:
     -  [Search-UnifiedAuditLog cmdlet reference](/powershell/module/exchange/search-unifiedauditlog?azure-portal=true)
     -  [Use a PowerShell script to search the audit log](/microsoft-365/compliance/audit-log-search-script?azure-portal=true)
 -  **Export audit records to a CSV file**. After an organization runs the Audit log search tool in the Microsoft Purview compliance portal, it can export the audit records returned by the search to a CSV file. By doing so, Microsoft Excel can sort and filter on different audit record properties. Excel Power Query can also be used to transform functionality to split each property in the AuditData JSON object into its own column. This process enables you to effectively view and compare similar data for different events.
 -  **Access to audit logs via Office 365 Management Activity API**. A third method for accessing and retrieving audit records is to use the Office 365 Management Activity API. This API lets organizations retain auditing data for longer periods than the default 180 days. It also lets them import their auditing data into a SIEM solution. For more information, see [Office 365 Management Activity API reference](/office/office-365-management-api/office-365-management-activity-api-reference?azure-portal=true).
 -  **180-day audit log retention**. When an audited activity is performed by a user or admin, an audit record is generated and stored in the audit log for the organization. In Microsoft Purview Audit (Standard), records are retained for 180 days. As such, organizations can search for activities that occurred within the past three months.

### Audit (Premium)

Audit (Premium) builds on the capabilities of Audit (Standard) by providing audit log retention policies, longer retention of audit records, high-value crucial events, and higher bandwidth access to the Office 365 Management Activity API.

 -  **Audit log retention policies**. Audit (Premium) enables organizations to create customized audit log retention policies to retain audit records for up to one year (and up to 10 years for users with required add-on license). Organizations can create log retention policies to retain audit records based on:
     -  the service where the audited activities occurred.
     -  specific audited activities.
     -  the user who performed an audited activity.
 -  **Longer retention of audit records**. Exchange, SharePoint, and Microsoft Entra audit records are retained for one year by default. Audit records for all other activities are retained for 180 days by default. With Audit (Premium), organizations can use audit log retention policies to configure longer retention periods.
 -  **High-value, crucial Audit (Premium) events**. Audit records for crucial events can help an organization conduct forensic and compliance investigations. It does so by providing visibility to events such as:
     -  When mail items were accessed.
     -  When mail items were replied to and forwarded.
     -  When and what a user searched for in Exchange Online and SharePoint Online.

    These crucial events can help organizations investigate possible breaches and determine the scope of compromise.

 -  **Higher bandwidth to the Office 365 Management Activity API**. Audit (Premium) provides organizations with more bandwidth to access auditing logs through the Office 365 Management Activity API. All organizations that have Audit (Standard) or Audit (Premium) are initially allocated a baseline of 2,000 requests per minute. However, this limit dynamically increases depending on an organization's seat count and its licensing subscription. As such, organizations with Audit (Premium) get about twice the bandwidth as organizations with Audit (Standard).

Microsoft Purview Audit (Premium) is examined in greater detail in a later module.

### Comparison of key capabilities

The following table compares the key capabilities available in Audit (Standard) and Audit (Premium). All Audit (Standard) functionality is included in Audit (Premium).

| **Capability**                                                  | **Audit (Standard)** | **Audit (Premium)** |
|:--------------------------------------------------------------- |:--------------------:|:-------------------:|
| Enabled by default                                              |          X           |          X          |
| Thousands of searchable audit events                            |          X           |          X          |
| Audit search tool in the Microsoft Purview compliance portal    |          X           |          X          |
| Search-UnifiedAuditLog cmdlet                                   |          X           |          X          |
| Export audit records to CSV file                                |          X           |          X          |
| Access to audit logs via Office 365 Management Activity API (1) |          X           |          X          |
| 180-day audit log retention                                      |          X           |          X          |
| One-year audit log retention                                    |                      |          X          |
| 10-year audit log retention (2)                                 |                      |          X          |
| Audit log retention policies                                    |                      |          X          |
| High-value, crucial events                                      |                      |          X          |

**Footnotes**:

(1) Audit (Premium) includes higher bandwidth access to the Office 365 Management Activity API, which provides faster access to audit data.

(2) Besides the required licensing for Audit (Premium), a user must be assigned a 10-Year Audit Log Retention add-on license to retain their audit records for 10 years.

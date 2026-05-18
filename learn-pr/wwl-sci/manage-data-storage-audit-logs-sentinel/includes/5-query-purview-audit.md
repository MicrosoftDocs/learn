With the Purview Audit connector running and data flowing into the `OfficeActivity` table, Contoso's analysts now have two distinct tools for interrogating that data. The Purview Audit search interface in the Defender portal offers a guided, filter-driven experience—ideal for compliance investigations where a nontechnical reviewer might examine the results. Advanced Hunting KQL gives analysts the ability to write precise queries, join across tables, and correlate audit records with active Microsoft Sentinel incidents. Knowing when to use each tool, and how to move between them, is what separates a complete investigation from an incomplete one.

## Search audit records using the Purview Audit search tool

The Purview Audit search interface is available in the Microsoft Defender portal. Navigate to the **Microsoft Purview** section and select **Audit**, or search for "Audit" using the portal search bar. If you don't see the navigation option, your account can need the **View-Only Audit Logs** role assigned in the Microsoft Purview portal.

The Audit search page presents a structured filter form:

- **Start date / End date**: Set to the investigation window. For the Contoso SharePoint scenario, set the start date to 90 days ago and today as the end date.
- **Users**: Enter the account or accounts under investigation. Leave blank to search all users.
- **Activities**: Select specific operation types. For the SharePoint download scenario, search for "FileDownloaded" under SharePoint file and folder activities. Selecting specific activities narrows the result set significantly and reduces export size.
- **File, folder, or site** / **Workload**: Enter the SharePoint site URL or document name, and filter by service area (SharePoint, Exchange, Teams) if known.

Select **Search** to run the query. Results appear in a paginated list. Select any record to view the full detail panel, which includes the operation, user principal name, client IP address, site URL, target object, and result. For the Contoso investigation, the detail panel shows exactly which document was downloaded, from which site, and from which client IP—the information the compliance team needs.

To export results for compliance reporting, select **Export** in the toolbar. The export produces a CSV file with all record fields included, which you can share with the compliance team or retain as audit evidence.

## Query audit data with Advanced Hunting KQL

For more precise analysis—especially when you want to filter on multiple conditions, compute aggregations, or correlate audit data with other Microsoft Sentinel tables—use Advanced Hunting. The `OfficeActivity` table is available directly in Advanced Hunting queries.

For Contoso's SharePoint investigation, the following KQL query returns all SharePoint file download operations by the account under investigation within the 90-day window:

```kql
OfficeActivity
| where TimeGenerated > ago(90d)
| where RecordType == "SharePointFileOperation"
| where Operation == "FileDownloaded"
| where UserId == "analyst@contoso.com"
| project TimeGenerated, UserId, ClientIP, Site_Url, SourceFileName, Operation
| order by TimeGenerated desc
```

Adjust the `UserId` value to the account under investigation. The `project` clause surfaces the fields most relevant to the compliance question: when the download occurred, who performed it, from where, and which file.

For `CopilotActivity` queries—for example, to identify Microsoft 365 Copilot interactions with SharePoint content—modify the table name and filter on relevant fields:

```kql
CopilotActivity
| where TimeGenerated > ago(30d)
| where AppContext contains "SharePoint"
| project TimeGenerated, UserId, AppContext, PromptType, ResponseSummary
| order by TimeGenerated desc
```

This type of query is valuable for SOX compliance reviews where you need to demonstrate that AI-assisted access to financial data is auditable and reviewable.

## Correlate audit records with Microsoft Sentinel incidents

When an active Microsoft Sentinel incident involves a user account, you can pivot from the incident's entity into the `OfficeActivity` table to surface related audit events from the same time window.

For example, suppose a Microsoft Sentinel incident flagged impossible travel for the account `jsmith@contoso.com` - sign-ins from two geographically distant locations within 30 minutes. The account is already in your Microsoft Sentinel workspace as a user entity. To correlate that incident with SharePoint activity during the same window:

```kql
let incidentTime = datetime(2026-03-15T14:00:00Z);
let investigatedUser = "jsmith@contoso.com";
OfficeActivity
| where TimeGenerated between ((incidentTime - 2h) .. (incidentTime + 2h))
| where UserId =~ investigatedUser
| project TimeGenerated, RecordType, Operation, ClientIP, Site_Url, SourceFileName
| order by TimeGenerated asc
```

If the results show SharePoint document access from a different IP than the Microsoft Sentinel incident's flagged location, you have corroborating evidence for the compromise scenario. Select the query results and use **Add to incident** (if available in your portal version) to attach the findings directly to the Microsoft Sentinel incident record.

As with the Audit search tool, use **Export** in the Advanced Hunting toolbar to save results to CSV for documentary evidence linking the Microsoft Sentinel investigation to the Microsoft 365 audit trail.

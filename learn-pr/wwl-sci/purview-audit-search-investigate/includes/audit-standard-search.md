Microsoft Purview Audit (Standard) provides tools for logging activities across Microsoft 365 services. It helps you use audit log searches to respond to security incidents and manage compliance, ensuring thorough oversight and quick analysis within your organization.

## Prepare to search the audit log

Before you run a search, it's important to confirm that auditing is enabled and that you have the correct permissions.

- **Verify audit logging is enabled**: Run the following in Exchange Online PowerShell:

  ```powershell
  Get-AdminAuditLogConfig | Format-List UnifiedAuditLogIngestionEnabled
  ```

  If `UnifiedAuditLogIngestionEnabled` returns `True`, audit log search is enabled.

- **Confirm permissions**: You need either the **Audit Logs** or **View-Only Audit Logs** role. These are included by default in the **Audit Manager** and **Audit Reader** role groups on the **Permissions** page in the Microsoft Purview portal.

- **Understand retention**:

  - Users with a Microsoft 365 E5 or equivalent license have one-year retention for Microsoft Entra ID, Exchange, SharePoint, OneDrive activity. You can configure retention policies for other services up to one year.
  - Other users have a default 180-day retention period.

- **Use PowerShell if needed**: The `Search-UnifiedAuditLog` cmdlet in Exchange Online PowerShell supports advanced and automated searches.

- **For programmatic integration**: The Office 365 Management Activity API can be used to integrate with security and compliance tools.

## Conduct an audit search

Once your environment is ready, you can search the audit log in the Microsoft Purview portal.

1. Sign in to the [Microsoft Purview](https://purview.microsoft.com/?azure-portal=true) portal.

1. Select **Solutions** > **Audit**.

1. Configure your search parameters:

   - **Date range**: Defaults to the last seven days; adjust up to the retention limit for your license.
   - **Keyword Search**: Enter keywords or phrases to find specific events. Use an asterisk (*) for wildcard matches.
   - **Admin Units**: Select specific admin units or leave blank for all.
   - **Activity types**: Choose from friendly names or operation names.
   - **Record types**: Filter by service-specific record types.
   - **Search name**: Name the search for future reference.
   - **Users**: Specify individual accounts or leave blank for all.
   - **File, folder, or site**: Enter names or URLs to filter by location. Wildcards (*) are supported.
   - **Workloads**: Narrow to specific Microsoft services.

1. Select **Search** to run the query. You can run up to 10 concurrent search jobs per user. If the limit is reached, wait for a job to finish or delete one.

## Manage audit search jobs

Effective management of search jobs ensures you can review results promptly and keep your searches organized.

The search job dashboard displays:

- **Search name**
- **Job status**: _Queued_, _In Progress_, or _Completed_
- **Progress (%)**
- **Search time**: Time taken to complete
- **Total results**
- **Creation time** (UTC)
- **Search performed by**: Account that initiated the search

:::image type="content" source="../media/audit-new-search-columns.png" alt-text="Screenshot showing the results of an Audit search overview in Microsoft Purview." lightbox="../media/audit-new-search-columns.png":::

You can delete a search job to remove its definition and results without affecting the underlying audit data. Use **Copy this search** to duplicate a job with the same parameters.

> [!NOTE]
> Completed audit search jobs are stored in the portal for **30 days**. You can reopen results or re‑export without rerunning the search.

### View detailed search results

Select a specific search job to see item-level details:

- **Date (UTC)**
- **IP Address**
- **User**
- **Record type**
- **Activity**
- **Item**
- **Admin Units**
- **Details**

You can sort, filter, or export this information. Audit allows a maximum of 50,000 entries to a CSV file from a single audit log search.

:::image type="content" source="../media/audit-new-search-result-details.png" alt-text="Screenshot showing the search job item detail dashboard." lightbox="../media/audit-new-search-result-details.png":::

## Scenario: Investigating unauthorized access to patient records

The IT compliance team is using Microsoft Purview Audit (Standard) to investigate whether users deleted email messages related to patient data. The goal is to confirm whether deletions were authorized and in compliance with policy.

Steps in the investigation:

1. **Define search criteria**:

   - Activities: Under **Exchange mailbox activities**, select **Deleted messages from Deleted Items folder** and **Purged messages from mailbox**.
   - Date range: Match the suspected activity period.
   - Users: Focus on accounts with unusual access patterns.

1. **Run the search**:

   - In the Microsoft Purview portal, run a new search with the defined criteria.
   - Review for suspicious patterns such as bulk deletions or activity outside normal duties.

1. **Analyze results**:

   - Check the time of deletion, IP address, and user details.
   - For soft- or hard-deleted items, open the record's **Details** and view **More information** for context like the subject line and original location.

     **Example of a soft-deleted item**:
     :::image type="content" source="../media/soft-deleted-item.png" alt-text="Screenshot showing the audit record for a soft-deleted item.":::

     **Example of a hard-deleted item**:
     :::image type="content" source="../media/hard-deleted-item.png" alt-text="Screenshot showing the audit record for a hard-deleted item.":::

1. **Take corrective action**:

   - If unauthorized deletions are confirmed, follow incident response procedures.
   - If deletions were valid but flagged due to unusual volume or timing, adjust monitoring thresholds to reduce false positives.

### Recovery options

- SoftDeleted items can usually be restored within the retention window (14–30 days).
- HardDeleted items might be recoverable if the mailbox is on hold.
- Use Microsoft Purview portal search tools to locate and recover items where possible.

## Knowledge check

Choose the best response for this question.

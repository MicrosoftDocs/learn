An audit search starts with confirming that auditing is on. Once it is, scope the search with the right filters, manage the jobs that run in the background, and read the results the portal returns.

## Prepare to search the audit log

Confirm three things before you run a search:

1. **Auditing is enabled**. Run the following in Exchange Online PowerShell. If `UnifiedAuditLogIngestionEnabled` returns `True`, you're set.

   ```powershell
   Get-AdminAuditLogConfig | Format-List UnifiedAuditLogIngestionEnabled
   ```

1. **You have the right role**. You need **Audit Logs** or **View-Only Audit Logs**, included in the **Audit Manager** and **Audit Reader** role groups on the **Permissions** page in the Microsoft Purview portal.
1. **The retention window covers your date range**. Users with a Microsoft 365 E5 or equivalent license get one-year retention for Microsoft Entra ID, Exchange, SharePoint, and OneDrive activity. Other users get the default 180 days.

> [!NOTE]
> A few things surprise investigators on their first real search:
>
> - **Latency**: Records from core services like Exchange, SharePoint, OneDrive, and Teams are typically available 60 to 90 minutes after the activity. Other services can take longer.
> - **Time zones**: Portal search results and `Search-UnifiedAuditLog` timestamps use UTC. Convert your incident window to UTC before you set a date range, or you'll miss activity that fell outside your intended hours.
> - **One-year cap on non-user activity**: Records for service principals, application permissions, and system events age out after one year regardless of tier or retention policy. No policy raises that cap, so investigations that reach further back into those categories won't return records.

## Conduct an audit search

Once your environment is ready, you can search the audit log in the Microsoft Purview portal.

1. Sign in to the [Microsoft Purview](https://purview.microsoft.com/?azure-portal=true) portal.

1. Select **Solutions** > **Audit**.

1. Configure your search parameters:

   | Parameter | What it does |
   | --- | --- |
   | **Date range** | Defaults to the last seven days. Adjust up to the retention limit for your license. |
   | **Keyword Search** | Enter keywords or phrases. Use `*` for wildcard matches. |
   | **Admin Units** | Select specific admin units, or leave blank for all. |
   | **Activity types** | Choose from friendly names or operation names. |
   | **Record types** | Filter by service-specific record types. |
   | **Search name** | Name the search for future reference. |
   | **Users** | Specify individual accounts, or leave blank for all. |
   | **File, folder, or site** | Enter names or URLs to filter by location. Use `*` for wildcards. |
   | **Workloads** | Narrow to specific Microsoft services. |

1. Select **Search** to run the query. You can run up to 10 concurrent search jobs per user, with a limit of one unfiltered search job. If the limit is reached, wait for a job to finish or delete one.

## Manage audit search jobs

Search jobs run in the background, so you can close the browser and return later. In large tenants, a broadly scoped search with wide date ranges, many users, or high activity volumes can take up to 48 hours to complete. If a search stays at 0% progress for more than an hour, or doesn't advance in a full day, treat it as stuck. Delete it and rerun with a narrower scope.

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

You can sort, filter, or export this information. A single export supports up to 50,000 rows for Audit (Standard) and up to 1,000,000 rows for Audit (Premium).

:::image type="content" source="../media/audit-new-search-result-details.png" alt-text="Screenshot showing the search job item detail dashboard." lightbox="../media/audit-new-search-result-details.png":::

## When a search returns nothing

Empty results are usually a setup issue, not a search issue. Walk down this list before you rerun:

1. **Auditing is enabled tenant-wide**. Confirm with `Get-AdminAuditLogConfig | Format-List UnifiedAuditLogIngestionEnabled`. If it returns `False`, no records exist for the search window.
1. **Your date range falls inside the retention window**. Users with a Microsoft 365 E5 or equivalent license get one-year retention for Microsoft Entra ID, Exchange, SharePoint, and OneDrive. Other users get 180 days.
1. **The activity is recent enough to be indexed**. Core-service records take 60 to 90 minutes to appear. If the activity happened moments ago, wait and rerun.
1. **Advanced Auditing is enabled on the user**, and was enabled during the window you're searching. Required for `MailItemsAccessed`, `Send`, `SearchQueryInitiatedExchange`, and `SearchQueryInitiatedSharePoint`. Records only exist from the per-user enablement date forward.
1. **Your role covers what you're searching for**. You need **Audit Logs** or **View-Only Audit Logs**. If your account is scoped to an administrative unit, it only sees logs for users in that unit.
1. **Your date range is in UTC**. Portal results and `Search-UnifiedAuditLog` interpret dates as UTC, not your local time zone.

## Scenario: Investigating unauthorized access to patient records

The healthcare compliance team begins its investigation with Audit (Standard). Their first question: did anyone delete email messages related to the flagged patient records, and if so, were those deletions authorized?

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

- SoftDeleted items can be restored from the Recoverable Items folder until they reach the mailbox's deleted-item retention limit.
- HardDeleted items might be recoverable if the mailbox is on hold or covered by a retention policy.
- Use Microsoft Purview portal search tools to locate and recover items where possible.

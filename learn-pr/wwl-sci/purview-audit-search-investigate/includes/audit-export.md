An investigation ends with someone acting on findings, not with a search result on screen. That last step means getting the records out of the portal into a format you can sort, correlate with other logs, and hand to whoever asked the question. Both Standard and Premium export search results to CSV. What matters here is how you turn that CSV into report-ready data.

For the healthcare compliance team, this is where the mailbox deletions from Standard-tier searches, the Copilot patient-file access, and the physician's `MailItemsAccessed` records converge. Scattered searches become a single sortable table the compliance officer and clinical leadership can act on.

## Get records out of the portal

After running an audit log search in the Microsoft Purview portal, you can export the results for offline analysis.

1. Run your audit search with the desired filters.
1. On the search results page, select **Export** to download the audit records to a CSV file.

   :::image type="content" source="../media/audit-export-audit-search-results.png" alt-text="Screenshot showing where to select Export to export data.":::

1. Once the export finishes, save the file locally.

   - A single export supports up to 50,000 rows for Audit (Standard) and up to 1,000,000 rows for Audit (Premium). If your results exceed the limit, narrow the date range or apply more filters.

## Parse the export into a report-ready table

The exported CSV puts most of the useful detail inside a single `AuditData` column formatted as JSON, which is hard to read as-is. In Excel's Power Query Editor, you can parse that column into structured fields such as `SiteUrl`, `AccessedResources`, and `SensitivityLabelId`, then load the expanded table back into Excel for sorting and filtering.

The short version:

1. Open the exported CSV in Excel and select **Transform Data** to open Power Query.
1. Right-click the **AuditData** column, choose **Transform** > **JSON**, then use the expand icon to promote the JSON properties into columns.
1. Deselect properties you don't need, then **Close & Load** to return the flattened data to Excel.

For the full walkthrough with screenshots, see [Export, configure, and view audit log records](/purview/audit-log-export-records?azure-portal=true).

## Turn the parsed table into a finding

Parsing gets the data into a shape you can analyze. The analysis is what turns records into a finding.

The healthcare investigation's last question was whether Copilot referenced the same patient records the physician had opened directly. With both exports parsed in Excel, the team answers it by joining across the two tables:

1. Filter the Copilot export to rows where `AccessedResources` includes a patient record identifier or a `SensitivityLabelId` that matches the labeled patient data set.
1. Filter the `MailItemsAccessed` export to rows for the same users and time window, expanding `Folders[].FolderItems[]` down to individual messages.
1. Join the two filtered tables on user, resource identifier, and a time window loose enough to catch records that landed within a few minutes of each other.

Rows where both tables match mean the same patient record was reached through mail _and_ through Copilot by an account already flagged for review. That's the finding the compliance officer hands to clinical leadership, and it's a much shorter list than either export on its own.

The same pattern applies beyond healthcare. Once the CSV is parsed, any investigation that spans record types follows the same two steps. Filter each table on the property that identifies the resource, then join on user, resource, and time window.

## Search and export at scale with PowerShell

For more control over your audit searches and exports, use the `Search-UnifiedAuditLog` cmdlet in Exchange Online PowerShell.

### Example: Export SharePoint sharing operations

```powershell
$auditlog = Search-UnifiedAuditLog -StartDate 06/01/2025 -EndDate 06/30/2025 -RecordType SharePointSharingOperation
$auditlog | Select-Object CreationDate, UserIds, RecordType, AuditData | Export-Csv -Path C:\AuditLogs\SharePointAudit.csv -NoTypeInformation -Encoding UTF8
```

To append more data:

```powershell
$auditlog = Search-UnifiedAuditLog -StartDate 06/01/2025 -EndDate 06/30/2025 -RecordType SharePointFileOperation
$auditlog | Select-Object CreationDate, UserIds, RecordType, AuditData | Export-Csv -Append -Path C:\AuditLogs\SharePointAudit.csv -NoTypeInformation -Encoding UTF8
```

> [!TIP]
> `-Encoding UTF8` keeps non-ASCII characters in user names, folder paths, and Copilot content readable. Without it, Windows PowerShell defaults to ASCII and those characters can display as garbage in Excel. Use `UTF8BOM` if Excel still has trouble detecting the encoding.

> [!NOTE]
> `Search-UnifiedAuditLog` returns a maximum of 5,000 rows per call and 100 by default. The one-shot examples above silently truncate at 5,000 rows on larger date ranges. For larger exports, page through results with the `-SessionId` and `-SessionCommand ReturnLargeSet` parameters. See the [`Search-UnifiedAuditLog` reference](/powershell/module/exchange/search-unifiedauditlog?azure-portal=true) for the pagination pattern.

## Tips for exporting and reviewing audit data

- **Filter by RecordType** to focus on specific workloads.
- **Filter by Operations** to narrow results to key actions, such as file sharing or deletion.
- Use Power Query transformations to make JSON data in the **AuditData** column easier to read.

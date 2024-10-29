Microsoft Purview Audit (Standard) provides tools for logging activities across Microsoft 365 services. It helps you efficiently use audit log searches to respond to security incidents and manage compliance, ensuring thorough oversight and quick analysis within your organization.

The IT compliance team at a network of healthcare facilities uses Microsoft Purview Audit (Standard) to effectively manage and review access to electronic health records (EHR). This setup ensures that all access is properly logged and adheres to health data protection laws. With this system in place, the team is ready to address security concerns and enhance their auditing processes.

Here you learn to:

- Prepare and configure the audit log search environment in Microsoft Purview Audit (Standard).
- Conduct and manage audit search jobs effectively.
- Analyze search results to investigate and respond to security incidents.

## Prepare to search the audit log

Before you search the audit log, make sure your system is properly configured:

- Confirm audit log search is enabled in your Microsoft 365 or Office 365 enterprise environment with this command in **Exchange Online PowerShell**:

  ``` powershell
  Get-AdminAuditLogConfig | Format-List UnifiedAuditLogIngestionEnabled
  ```

  If _UnifiedAuditLogIngestionEnabled_ returns `True`, audit log search is enabled.

- Ensure you have one of the necessary roles to view the audit log, either _Audit Logs_ or _View-Only Audit Logs_. These roles are included by default in the _Audit Manager_ and _Audit Reader_ role groups on the **Permissions** page in the compliance portal.
- Understand that the retention of audit records depends on the user's license type:
  - **E5 license holders**: Records for Microsoft Entra ID, Exchange, and SharePoint activity are retained for one year by default. You can set up audit log retention policies for other services to retain records up to one year.
  - **Non-E5 license holders**: Records are retained for 180 days.
- Use the `Search-UnifiedAuditLog` cmdlet in **Exchange Online PowerShell** to perform searches outside the compliance portal. This method supports integration with automated scripts or complex queries.
- For programmatic data downloads, use the Office 365 Management Activity API to develop customized operations, security, and compliance solutions.

## Conduct an audit search

To perform an audit log search within the Microsoft Purview compliance portal:

1. Sign into the Microsoft Purview compliance portal.
1. Navigate to the **Audit** tab on the left panel, then select **New Search** tab at the top of the page.
1. On the **New Search** tab, configure your search parameters as applicable:

   - **Date range**: By default, searches cover the last seven days. You can adjust the **Start date** and **End date** up to a maximum of 180 days.
   - **Keyword Search:** Type in keywords or phrases to look for specific events or details. Use an asterisk (*) to replace any special characters.
   - **Admin Units**: Choose specific admin units or leave this field blank to include all units.
   - **Activity types**: Select from friendly names or specify operation names for targeted searches.
   - **Record types**: Select from a list to focus on activities related to specific Microsoft services.
   - **Search name**: Name your search for easier identification. Unnamed searches are automatically titled based on search parameters.
   - **Users**:  Specify individual users or leave this field blank to include all users and service accounts.
   - **File, folder, or site**: Enter full or partial names of files and folders, or the full URL of a file or folder, to search for related activities. Wildcards (*) can be used for partial names. Leave blank to include all files and folders in your organization in the search.
   - **Workloads**: Search for activities related to specific Microsoft services by entering their names.
1. After setting all your criteria, select **Search**. You can run up to 10 search jobs at the same time per user account. If you need more than 10 search jobs, you must wait for an _In progress_ job to finish or delete a search job.

## Manage audit search jobs

Managing audit search jobs effectively is essential for maintaining organizational compliance and security insights.

### Search job overview

The search job dashboard provides an overview of both ongoing and completed searches, detailing:

- **Search name**: Displays the name of the search job. The full name is displayed by hovering over the search job name.
- **Job status**: Indicates if the job is _Queued_, _In Progress_, or _Completed_.
- **Progress (%)**: Shows how much of the job is complete.
- **Search time**: The total time taken to complete the job.
- **Total results**: Number of results the search yielded.
- **Creation time**: The UTC timestamp when the job was created.
- **Search performed by**: The user account who initiated the search job.

:::image type="content" source="../media/audit-new-search-columns.png" alt-text="Screenshot showing the results of an Audit search overview in Microsoft Purview." lightbox="../media/audit-new-search-columns.png":::

You can delete a search job by selecting the job then selecting **Delete**. This action removes the search job definition and the associated results but doesn't affect the underlying data. Use **Copy this search** to duplicate and modify search criteria for new queries.

### Search job details dashboard

For detailed insights from a specific search job, select it to view:

- **Date (UTC)**: When the activity happened.
- **IP Address**: The device IP that performed the activity.
- **User**: The user who performed the activity.
- **Record type**: The type of record logged.
- **Activity**: The specific action taken.
- **Item**: The target of the activity (file, folder, or site).
- **Admin Units**: The administrative unit of the user.
- **Details**: Extended information about the activity.

You can sort and filter this information, or export it up to 50 KB for Audit (Standard) and 500 KB for Audit (Premium) to a CSV file.

:::image type="content" source="../media/audit-new-search-result-details.png" alt-text="Screenshot showing the search job item detail dashboard." lightbox="../media/audit-new-search-result-details.png":::

## Scenario: Investigate unauthorized access to patient records

The IT compliance team at the healthcare facilities network is using Microsoft Purview Audit (Standard) to address a common issue: determining if users deleted email items related to patient data. The goal of this investigation is to identify any unauthorized deletions that could compromise patient privacy and violate health data protection regulations.

The IT compliance team followed these steps using Microsoft Purview Audit to investigate the incident:

1. **Define the search criteria**:
   - **Activities**: Under **Exchange mailbox activities**, choose **Deleted messages from Deleted Items folder** and **Purged messages from mailbox** to specifically focus on actions where emails might have been intentionally removed from patient records.
   - **Date range**: Set the time frame during for when the suspicious deletions were noticed.
   - **Users**: Concentrate on user accounts that accessed the emails of high-profile patients or showed unusual activity during the flagged period.
1. **Conduct the search**:
   - Access **Audit** in the Microsoft Purview compliance portal and start a new search using the established criteria.
   - Examine the results for any deletions that were unauthorized or don't align with normal job duties. Look for actions like deleting significant amounts of emails suddenly or clearing out records without proper authorization.
1. **Review and analyze results**:
   - Analyze each relevant entry to understand the context of the deletion. This analysis includes examining the time of deletion, IP address, user details, and exact nature of the deleted emails.
   - After you run the search, filter the search results to display the audit records for soft-deleted or hard-deleted items. Select the audit record to open the **Details** flyout page and then select on **More information**. Here, you find more information about the deleted item, such as the subject line and the location of the item when it was deleted.

      **Example of audit record for a soft-deleted item**:

      :::image type="content" source="../media/soft-deleted-item.png" alt-text="Screenshot showing the audit record for a soft-deleted item.":::

      **Example of audit record for a hard-deleted item**:

      :::image type="content" source="../media/hard-deleted-item.png" alt-text="Screenshot showing the audit record for a hard-deleted item.":::
1. **Corrective actions**:
   - If unauthorized deletions are confirmed, initiate the incident response protocol. This protocol might include informing affected parties, securing the compromised accounts, and revising data access policies.
   - If the deletions were part of regular duties but flagged due to unusual volume or timing, update the monitoring thresholds. This change helps minimize false positives while maintaining robust security protocols.

### Options for recovering deleted emails

- Consider recovery options for both SoftDeleted and HardDeleted items. Users might restore SoftDeleted items if the action falls within the retention period, typically 14 to 30 days. HardDeleted items might also be recoverable if the mailbox is on hold.
- Use search tools available in the Microsoft Purview compliance portal to attempt the recovery of deleted emails, which is critical when patient care or privacy might be affected.

This approach helps the healthcare facility's compliance team address and manage any inappropriate email deletions, supporting their commitment to maintaining strict patient confidentiality and adherence to healthcare regulations.

## Knowledge check

Choose the best response for the question below, then select **Check your answers**.

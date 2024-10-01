Both the Standard and Premium versions of Microsoft Purview Audit have the capability to export audit logs to CSV. This functionality is essential for performing detailed data analysis and meeting compliance reporting requirements. CSV exports enable extensive data manipulation and deeper insights of audit activities, which are important for maintaining high data security standards in sensitive environments.

After securing electronic health records (EHR) using Microsoft Purview Audit, the IT compliance team at our healthcare network is now focusing on the export functionality. By exporting audit logs, they aim to deepen their analysis, supporting ongoing security evaluations and compliance with health data protection standards.

Here you learn to:

- Export audit logs to CSV.
- Use Excel's Power Query Editor to manage and analyze audit data.
- Customize audit log exports with PowerShell to meet specific investigation needs.

## Export and transform audit log data

Understanding how to effectively export and transform audit log data is crucial for comprehensive data analysis and compliance monitoring. Here's how you can handle the export and transformation process using Microsoft Purview Audit tools and Excel's Power Query Editor.

### Export audit log search results

1. Begin by searching the audit log. Adjust your search criteria as needed to ensure you capture the necessary data.
1. On the search results page, select **Export** to download all the audit records from your search into a CSV file. Preparing the download can take time, especially for large searches.
 
   :::image type="content" source="../media/audit-export-audit-search-results.png" alt-text="Screenshot showing where to select Export to export data.":::

1. Once the export process is complete, a prompt appears, guiding you to open the CSV file and save it to your local computer. You can also access the CSV file in the Downloads folder.
   - You can download a maximum of 50,000 entries to a CSV file from a single audit log search. If your search results exceed this limit, consider using a narrower date range to manage the volume of data.

### Transform audit log data using Power Query editor

After you export the audit data, the next step involves using Excel's Power Query Editor to enhance the data's readability and usability.

1. Open a blank workbook in Excel and navigate to the **Data** tab. Select **From Text/CSV** to open your exported CSV file.

   :::image type="content" source="../media/json-transform-open-csv-file.png" alt-text="Screenshot showing the From Text/CSV button in Excel.":::

1. Once the CSV file opens, select **Transform Data** to begin editing in the Power Query Editor.

   :::image type="content" source="../media/json-open-power-query.png" alt-text="Screenshot showing the Transform Data button in Excel.":::

1. Right-click **AuditData**, select **Transform**, then choose **JSON** in the **Query Editor**. This step transforms the data into a readable format, creating separate columns for each property within the JSON object.

   :::image type="content" source="../media/json-transform.png" alt-text="Screenshot showing where to select Transform then JSON to parse data.":::

1. Select the expand icon in the upper-right corner of the **AuditData** column to see a list of properties in the JSON objects.

   :::image type="content" source="../media/json-transform-expand-icon.png" alt-text="Screenshot showing the expand icon.":::

1. If only some properties are visible initially, select **Load more** to display the full list of properties in the JSON objects.

   :::image type="content" source="../media/json-transform-load-json-properties.png" alt-text="Screenshot showing where to select Load more to display the full list of properties.":::

1. Deselect any properties you don't need to simplify your data view. This helps in focusing only on relevant data for your analysis.
   - Keep in mind that the properties shown after clicking **Load more** are based on the first 1,000 rows in your CSV file. If different properties exist beyond these rows, they don't appear when the **AuditData** column is expanded. To ensure you capture all necessary properties, you might need to refine your audit log search to return fewer records or filter out less relevant data in the **Operations** column before expanding **AuditData**.
1. Decide if you want to include the original column name as a prefix in the new column titles, which can help maintain clarity about the data source.
1. After setting up your columns, select **OK** to apply the transformations. Each property from the JSON object now appears in its own column, which facilitates easier data analysis.
1. To finish, select **Close & Load** on the **Home** tab to exit the Power Query Editor and open the transformed CSV file in an Excel workbook.

### Use PowerShell to search and export audit log records

For more customizable audit log searches, consider using the `Search-UnifiedAuditLog` cmdlet in Exchange Online PowerShell. This approach allows for precise querying, particularly when filtering by _RecordType_. After exporting, the CSV file can be formatted using the same methods as outlined with the Power Query editor in Excel.

#### Example: Export SharePoint audit records

Imagine the IT compliance team at your healthcare network needs to review SharePoint sharing operations as part of an audit on how health records are accessed and shared. Here's how they could use PowerShell to capture and analyze these activities:

1. **Search for SharePoint sharing operations** within a specific period by running:

   ```powershell
   $auditlog = Search-UnifiedAuditLog -StartDate 06/01/2019 -EndDate 06/30/2019 -RecordType SharePointSharingOperation
   ```

   - Export the results to a CSV file:

   ```powershell
   $auditlog | Select-Object -Property CreationDate, UserIds, RecordType, AuditData | Export-Csv -Path c:\AuditLogs\PowerShellAuditlog.csv -NoTypeInformation
   ```

   The resulting file, _PowerShellAuditlog.csv_, includes four columns: CreationDate, UserIds, RecordType, AuditData.

1. **Append additional data** to the existing csv file by running:

   ```powershell
   $auditlog = Search-UnifiedAuditLog -StartDate 06/01/2019 -EndDate 06/30/2019 -RecordType SharePointFileOperation
   ```

   ```powershell
   $auditlog | Select-Object -Property CreationDate, UserIds, RecordType, AuditData | Export-Csv -Append -Path c:\AuditLogs\PowerShellAuditlog.csv -NoTypeInformation
   ```

### Tips for exporting and viewing the audit log

After you export the data, use the Power Query Editor in Excel to transform the JSON object in the AuditData column into a structured format. This process enhances data visibility and aids in pinpoint analyses:

- **Filter by RecordType**: Focus on specific events, such as SharePoint sharing operations, to streamline reviews and ensure compliance with healthcare data regulations.
- **Filter by Operations**: Narrow down to precise activities to monitor how sensitive information is being accessed or modified.

## Knowledge check

Choose the best response for the question below, then select **Check your answers**.

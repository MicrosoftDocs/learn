Understanding where sensitive data is stored and how it's accessed is essential for data security and compliance. **Data explorer** and **content explorer (classic)** in Microsoft Purview provide visibility into classified data across your organization.

- **Data explorer** provides a consolidated view of classified data, making it easier to analyze multiple classification types at once.
- **Content explorer** offers similar insights but requires more navigation to see classification details.

These tools help security and compliance teams:

- **Identify sensitive data** across Microsoft 365 and connected environments.
- **Analyze data classification trends** based on sensitivity labels, retention labels, and sensitive information types (SITs).
- **Review access patterns** to detect potential security risks.
- **Validate compliance policies** by verifying encryption, classification, and retention settings.

## Access data explorer and content explorer

To use data explorer or content explorer, you need the correct permissions in Microsoft Purview.

### Permissions

Access to these tools is highly restricted because they allow visibility into sensitive data. Permissions override local file access settings.

| Role | Access level |
|-----|-----|
| Data Explorer List Viewer | View file metadata and classification labels but not content. |
| Data Explorer Content Viewer | View file contents in addition to metadata. |
| Content Explorer List Viewer | View a list of items with classification details. |
| Content Explorer Content Viewer | View file contents in addition to metadata. |

> [!NOTE]
> Users with a **List Viewer** role can see classification details but can't open or preview file contents. The **Content Viewer** role is required to access file contents.

### Navigate to data explorer and content explorer

You can access data explorer and content explorer from multiple Microsoft Purview solutions, based on the area you're working in:

1. Navigate to the [Microsoft Purview portal](https://purview.microsoft.com/).

1. Select **Solutions**.

1. **Data explorer** and **Content explorer (classic) can be found in these solutions:

   - Communication compliance

   - Data lifecycle management

   - Data loss prevention (DLP)

   - Information protection

   - Records management

1. Select the drop-down for **Explorers**, then select **Data explorer** or **Content explorer (classic)**.

   :::image type="content" source="../media/data-explorer-content-explorer.png" alt-text="Screenshot showing the top level filter for the Reports page within Information Protection." lightbox="../media/data-explorer-content-explorer.png":::

## Analyze sensitive data with data explorer

### Data types displayed in data explorer

Data explorer provides a snapshot of classified items based on:

- **Sensitive information types (SITs)**: Identifies data like credit card numbers, Social Security numbers, and medical data.
- **Sensitivity labels**: Shows how items are labeled based on organizational policies.
- **Retention labels**: Displays how long labeled data is retained.
- **Trainable classifiers**: Uses AI to identify sensitive content based on examples.

### Use the data explorer

1. Search or filter data by label, classifier, or SIT.

1. Drill down into specific data sources like Exchange, OneDrive, or SharePoint.

1. Export results to a CSV file for further analysis.

   :::image type="content" source="../media/data-explorer.png" alt-text="Screenshot showing the Data explorer." lightbox="../media/data-explorer.png":::

## Analyze classified data with content explorer (classic)

### How content explorer differs from data explorer

| Feature | Data explorer | Content explorer |
|-----|-----|-----|
| Data organization and visibility | Shows sensitive information types, sensitivity labels, trainable classifiers, and retention labels in a single table for quick analysis. | Requires navigating into each location to view classification details, rather than displaying them in a consolidated table. |
| Integration with Information Protection Reports | Links directly from information protection reports, allowing users to drill into classification details. | Not linked from reports, so users must navigate to content explorer manually. |
| Copilot data visibility | Includes Copilot as a data source when applicable. | Doesn't list Copilot as a distinct source. |

### Use content explorer

1. Filter data by classification labels, retention labels, or SITs.

1. Browse by location to find labeled content.

   :::image type="content" source="../media/content-explorer.png" alt-text="Screenshot showing the Content explorer." lightbox="../media/content-explorer.png":::

## Export and refine data insights

Both data explorer and content explorer allow users to:

- **Export** data insights as a CSV file.

- **Use filters** to refine searches by location, sensitivity label, or SIT.

- **Analyze trends** to improve data classification policies.

### Example search filters

| Filter type | Example |
|-----|-----|
| Site URL | `https://contoso.onmicrosoft.com/sites/finance` |
| File name | `HR_policy_2024.docx` |
| File extension | `.pdf`, `.csv`, `.txt`  |
| Sensitive data | Credit card numbers, PII  |

**Data explorer** and **content explorer** provide visibility into classified and sensitive data across an organization. Security teams use these tools to track classified data, enforce compliance, and mitigate risks. Data explorer is the new experience that offers deeper insights, while content explorer remains available for organizations using the classic view.

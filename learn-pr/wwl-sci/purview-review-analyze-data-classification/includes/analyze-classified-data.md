Knowing where sensitive data is stored and how it's accessed helps organizations maintain strong data security and compliance. In Microsoft Purview, **Data explorer** provides a centralized view of classified and labeled data across your organization. **Content explorer (classic)** is available for continuity but uses an older interface and requires more steps to display classification information.

**Data explorer** helps security and compliance teams:

- Identify sensitive data across Microsoft 365 and connected environments
- Analyze classification trends based on sensitivity labels, retention labels, and sensitive information types (SITs)
- Review access patterns to detect potential security risks
- Validate compliance policies by confirming that encryption, classification, and retention settings are applied correctly

## Access Data explorer

To use data explorer, you need the correct permissions in Microsoft Purview.

### Permissions

Access to data explorer is restricted because it exposes sensitive information. This table lists the viewer roles and access levels available in both data explorer and content explorer (classic).

| Role | Access level  |
|-----|-----|
| Data Explorer List Viewer | View file metadata and classification labels but not file contents. |
| Data Explorer Content Viewer | View file contents in addition to metadata. |
| Content Explorer (classic) List Viewer | View a list of items with classification details. |
| Content Explorer (classic) Content Viewer | View file contents in addition to metadata. |

> [!NOTE]
> Users with a **List Viewer** role can see classification details but can't open or preview file contents. The **Content Viewer** role is required to view file contents.

### Navigate to data explorer

You can access data explorer from several Microsoft Purview solutions, depending on the area you're working in.

1. Navigate to the [Microsoft Purview portal](https://purview.microsoft.com/).
1. Select **Solutions**.
1. Under **Information Protection**, expand **Explorers**, then select **Data explorer**.
1. Optionally, select **Content explorer (classic)** if you need to view items through the older interface.

   :::image type="content" source="../media/data-explorer-content-explorer.png" alt-text="Screenshot showing the Information Protection menu in Microsoft Purview with options for Data explorer, Content explorer, and Activity explorer." lightbox="../media/data-explorer-content-explorer.png":::

## Analyze sensitive data with data explorer

Data explorer shows how different classification signals come together to describe your organization's sensitive data landscape.

### What Data explorer displays

Data explorer provides a unified snapshot of classified items, including:

- **Sensitive information types (SITs)**: Identifies data such as credit card numbers, Social Security numbers, or medical information.
- **Sensitivity labels**: Shows how content is labeled based on organizational policy.
- **Retention labels**: Displays retention rules that apply to labeled data.
- **Trainable classifiers**: Uses machine learning to detect sensitive content based on examples.

### Explore data in data explorer

1. Filter by label, classifier, or SIT to narrow results.
1. Drill into data sources such as Exchange, OneDrive, SharePoint, Teams, or Copilot.
1. Export results to a CSV file for analysis or reporting.

   Exports reflect your current filters. Data explorer keeps activity data for up to 30 days to support most audit scenarios.

:::image type="content" source="../media/data-explorer.png" alt-text="Screenshot showing Data explorer in Microsoft Purview with data sources including Copilot, Exchange, OneDrive, SharePoint, and Teams, and columns for sensitivity labels and classifiers." lightbox="../media/data-explorer.png":::

## Compare data explorer and content explorer (classic)

Content explorer (classic) remains available for organizations that still rely on the older interface. It allows browsing by location to find labeled and classified content but doesn't provide the consolidated or interactive experience available in data explorer.

This table compares data explorer and content explorer (classic) to show how the experiences differ.

| Feature | Data explorer | Content explorer (classic) |
|-----|-----|-----|
| Data organization and visibility | Displays sensitivity labels, retention labels, trainable classifiers, and SITs together in one view. | Requires navigating into each location to see details. |
| Integration with Information Protection Reports | Linked directly from reports for deeper investigation. | Not linked from reports; must be opened manually. |
| Copilot data visibility | Lists Copilot as a data source when enabled. | Doesn't include Copilot as a data source. |

> [!NOTE]
> Use **Data explorer** for most analysis tasks. Choose **Content explorer (classic)** only when legacy visibility is required.

## Export and refine data insights

Data explorer allows you to export filtered data for reporting or deeper investigation. Exports are based on your current filters and reflect data retained within the 30-day activity window.

### Filter data for specific results

Filters in data explorer help you focus on the information that matters most. You can combine filters to narrow results by location, label, or data type, which makes it easier to investigate specific areas or trends.

These examples show common filters you can apply in data explorer searches.

| Filter type | Example |
|-----|-----|
| Site URL | `https://contoso.onmicrosoft.com/sites/finance` |
| File name | `HR_policy_2024.docx` |
| File extension | `.pdf`, `.csv`, `.txt` |
| Sensitive data | Credit card numbers, PII |

Using these filters together helps narrow results to the data that matters most before exporting or reporting.

**Data explorer** gives security teams a clear view of where sensitive information lives and how it's classified. This visibility helps you build a clear picture of data protection across Microsoft 365. Next, you'll use **Activity explorer** to track how users handle labeled data and evaluate how well protection policies work in practice.

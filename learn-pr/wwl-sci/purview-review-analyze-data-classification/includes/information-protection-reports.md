The **Information Protection Reports** in Microsoft Purview provide a centralized view of data classification, protection policies, encryption, and security activities across Microsoft 365, Azure, AWS, on-premises storage, and Microsoft Fabric.

Security and compliance teams use these reports to:

- **Monitor sensitivity label adoption**: Identify how labels are applied across cloud and on-premises data.
- **Assess protection coverage**: Detect unprotected data across multicloud environments.
- **Analyze user interactions with labeled content**: Track data access, movement, and policy violations.
- **Review encryption trends**: Verify email and file encryption across multiple platforms.
- **Gain insights into Microsoft Purview Data Governance sources**: Track sensitive data within governed data estates.
- **Monitor findings from the Microsoft Purview Information Protection (MIP) scanner**: Identify sensitive data in on-premises file shares and SharePoint.

## Access the Reports page

To access Information Protection Reports in Microsoft Purview:

1. Navigate to the [Microsoft Purview portal](https://purview.microsoft.com/).

1. Select **Solutions** > **Information Protection** from the left navigation pane.

1. On the **Information Protection** page, select **Reports**.

On the **Reports** page, use the filter at the top to view classification and protection insights by data source:

:::image type="content" source="../media/information-protection-reports-top-filter.png" alt-text="Screenshot showing the top level filter for the Reports page within Information Protection." lightbox="../media/information-protection-reports-top-filter.png":::

This allows you to view specific classification and protection insights based on where data is stored.

## Explore deeper insights

Reports provide an overview of classification, labeling, and protection. Many reports include links to explore specific data in depth. The reports also allow you to hover over data points to reveal additional details, such as exact label counts, encryption metrics, or detected sensitive information types. This provides quick insights without needing to open a separate report.

For deeper analysis, these reports link to:

- **Data explorer**: Provides detailed visibility into labeled and sensitive content.
- **Activity explorer**: Shows how users interact with labeled data.
- **Protection policies (preview)**: Helps assess and adjust protection settings.
- **Scan reports**: Displays details of scanned content across cloud and on-premises storage.
- **Encryption reports**: Tracks email encryption and protection trends.

:::image type="content" source="../media/report-link-to-data-explorer.png" alt-text="Screenshot showing the Explore applied labels button linking to Data explorer in Information Protection reports." lightbox="../media/report-link-to-data-explorer.png":::

These linked insights allow administrators to investigate specific areas of risk, ensuring data security policies are properly implemented.

### Information Protection Reports

Each report provides insights into classification, protection, and security activities. Administrators can drill into specific data sources to investigate trends and risks more effectively.

| Report | Details | Purpose | Links to |
|-----|-----|-----|-----|
| **Protection coverage** | Percentage of encrypted and access-controlled data across cloud and on-premises sources. | Identifies gaps in encryption and access control policies. | Protection policies (preview) |
| **Sensitivity label coverage** | Percentage of labeled vs. unlabeled items across Microsoft 365, Azure, AWS, and on-premises. | Ensures sensitive data is labeled for proper protection and governance. | Data Explorer |
| **Data scanning summary** | Percentage of scanned data sources across cloud and on-premises. | Detects unscanned areas that might pose compliance risks. | Scan reports |
| **Sensitivity label usage** | Top sensitivity labels applied to files across all connected environments. | Helps track label adoption trends and identify policy gaps. | Data Explorer |
| **Email encryption summary** | Number of emails encrypted manually or by policy. | Ensures confidential emails are properly protected. | Encryption reports |
| **Top activities detected** | Logs of file access, labeling changes, DLP matches, and encryption actions. | Detects unauthorized modifications or suspicious access patterns. | Activity Explorer |
| **Sensitive information types (SITs)** | Most commonly detected sensitive data types (for example, credit card numbers, SSNs, medical data). | Helps identify high-risk data needing protection. | Data Explorer |
| **Data sources with sensitive info** | Top locations where labeled or sensitive data is stored (for example, SharePoint, OneDrive, Exchange, Azure). | Identifies data concentration areas to enhance security controls. | Data Explorer |
| **Trainable classifiers** | Most-used AI classifiers for autolabeling (for example, threat intelligence, HR records). | Supports automated classification for large-scale data protection. | Data Explorer |

The **Information Protection Reports** in Microsoft Purview offer a centralized way to track data classification and protection across Microsoft 365, Azure, AWS, on-premises, and Microsoft Fabric. By filtering reports and using linked insights, security and compliance teams can monitor how data is labeled, protected, and accessed to enforce security policies effectively.

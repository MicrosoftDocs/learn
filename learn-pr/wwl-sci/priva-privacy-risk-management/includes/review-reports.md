Microsoft Priva Privacy Risk Management provides insights into personal data across your environment through comprehensive reports and visualizations. The Overview page and Reports section in the [Priva portal (preview)](https://purview.microsoft.com/priva) enable admins to monitor sensitive information, track trends, and evaluate risks to improve data privacy practices.

## Overview page

The **Overview** page offers a summary of key activities and insights related to Privacy Risk Management. It includes the following report cards:

- **Instances of sensitive info types**: Displays a breakdown of unique sensitive information types (SITs) detected across your organization. A circle chart and bar graph highlight the aggregate count of unique SITs, such as Social Security or credit card numbers. For example, a document with three credit card numbers and one Social Security number is counted as two unique SITs and four total instances. Select **Explore Reports** for a detailed view.

   :::image type="content" source="../media/privacy-risk-management-overview-reports.png" alt-text="Screenshot showing the instances of sensitive info types card on the overview page of the Privacy Risk Management page." lightbox="../media/privacy-risk-management-overview-reports.png":::

- **Top locations with sensitivity labels**: Highlights data locations containing the most sensitivity-labeled items. Hovering over a location reveals the number of labeled items. Select **Explore more sensitivity labels** to access Content Explorer for further analysis.

## Reports page

The **Reports** page provides a detailed overview of personal data insights across Microsoft 365, Microsoft Azure (preview), and Amazon Web Services S3 (preview). It's organized into three sections:

### Key insights

- **Content items with the most personal data**: Identifies content containing significant amounts of personal data, helping you focus on high-risk items. View the number of unique personal data types, content owners, and data subjects. Select **Explore** to review specific content items.

   :::image type="content" source="../media/privacy-risk-management-reports-key-insights.png" alt-text="Screenshot showing the content items with the most personal data card on the reports page of the Privacy Risk Management page." lightbox="../media/privacy-risk-management-reports-key-insights.png":::

- **Active alerts over time**: Tracks trends in policy-triggered alerts, enabling admins to spot spikes or patterns in alert volume. Use this information to investigate and remediate issues.

- **Privacy regulations**: Integrates insights from Microsoft Purview Compliance Manager to help improve your privacy score by completing privacy-related actions. Links provide detailed guidance for compliance improvements.

   :::image type="content" source="../media/privacy-risk-management-reports-privacy-regulations.png" alt-text="Screenshot showing the privacy regulations card on the reports page of the Privacy Risk Management page." lightbox="../media/privacy-risk-management-reports-privacy-regulations.png":::

- **Personal data type instances by region**: Displays a map for multi-geo environments, aggregating personal data type instances by region. Hover over regions to view data counts.

   :::image type="content" source="../media/privacy-risk-management-reports-regional-data.png" alt-text="Screenshot showing the personal data type instances by region card on the reports page of the Privacy Risk Management page." lightbox="../media/privacy-risk-management-reports-regional-data.png":::

### Policy trends

- **Personal data found in the organization**: Tracks trends in the detection of personal data, allowing filtering by location, data type, and timeframe.

- **Overexposed personal data**: Monitors trends in data sharing behaviors that could result in overexposure. This includes potential risks in Microsoft 365 and multicloud environments.

- **Data transfers detected in the organization**: Highlights trends in data movement between departments or regions, with filters for location, data type, and timeframe.

- **Unused personal data**: Identifies trends in the retention of inactive personal data within Microsoft 365, offering insights to refine policy settings and reduce retention risks.

### Classification

- **Top 5 sensitivity labels**: Lists the five most frequently applied sensitivity labels across your organization, categorized by data location. Select **Explore more sensitivity labels** to view detailed data in Content Explorer.

- **Top 5 sensitive information types**: Highlights the most common SITs detected in your organization, categorized by data location. Select **Explore more sensitive info types** for additional insights in Content Explorer.

- **Top locations with sensitivity labels**: Shows the locations containing the most sensitivity-labeled content, helping you identify areas with concentrated privacy risks.

## Next steps

Regularly reviewing Privacy Risk Management reports allows your organization to:

- Identify high-risk content and take corrective actions.
- Monitor trends in personal data usage and overexposure.
- Optimize policies for better compliance and data protection.

**Activity explorer** in Microsoft Purview allows security and compliance teams to track how labeled content is accessed, modified, and shared. By analyzing activity trends, organizations can assess policy effectiveness, detect potential security risks, and refine data protection measures.

## Why use Activity explorer?

- **Monitor classified data usage**: Track how labeled content is accessed, modified, or shared.
- **Audit policy effectiveness**: Identify compliance gaps by analyzing data loss prevention (DLP) matches, labeling changes, and file actions.
- **Refine analysis with filters**: Apply filters for date, user, activity type, sensitivity label, location, and more.
- **Use predefined filter sets**: Quickly view activities such as labeling changes, DLP detections, and endpoint data movement.
- **Use Security Copilot (preview)**: AI-driven insights detect anomalies, analyze patterns, and suggest policy refinements.

## Access Activity explorer

### Permissions

Users must be assigned one of the following roles or role groups in Microsoft Purview or Microsoft 365.

| Category | Roles | Role groups |
|-----|-----|-----|
| Microsoft Purview | - Information Protection Admin <br> - Information Protection Analyst <br> - Information Protection Investigator <br> - Information Protection Reader | - Information Protection <br> - Information Protection Admins <br> - Information Protection Investigators <br> - Information Protection Analysts <br> - Information Protection Readers |
| Microsoft 365 | - Compliance Admin <br> - Security Admin <br> - Compliance Data Admin | - Compliance Administrator <br> - Security Administrator <br> - Security Reader |

### Navigate to Activity explorer

You can access Activity explorer from multiple Microsoft Purview solutions, based on the area you're working in:

1. Navigate to the [Microsoft Purview portal](https://purview.microsoft.com/).

1. Select **Solutions**.

1. **Activity explorer** can be found in these solutions:

   - Communication compliance

   - Data lifecycle management

   - Data loss prevention (DLP)

   - Information protection

   - Records management

1. Select the drop-down for **Explorers**, then select **Activity explorer**.

   :::image type="content" source="../media/navigate-to-activity-explorer.png" alt-text="Screenshot showing navigation to Activity explorer from Information Protection in Microsoft Purview." lightbox="../media/navigate-to-activity-explorer.png":::

## Filters in Activity explorer

Filters allow you to refine data based on specific criteria. Activity explorer provides around **50 different filters**, including:

| Filter Type | Example |
|-----|-----|
| Date range | View activities from the last 30 days. |
| Activity type | Label applied, removed, or changed. |
| Location | Exchange, SharePoint, OneDrive, Teams. |
| Sensitivity label | Highly Confidential, Internal, General. |
| User | Track actions by specific users. |
| Client IP | Identify access patterns based on IP. |
| Device name | Detect file actions on specific devices. |
| Protected status | Filter activities based on encrypted content. |

> [!NOTE]
> Filter dropdowns display results from the first 500 records for performance optimization.

## Predefined filter sets

Filter sets help quickly identify specific activities. Activity explorer includes built-in filter sets such as:

- **Endpoint DLP activities**: Actions on files from managed devices.
- **Sensitivity label changes**: Applied, changed, or removed labels.
- **Egress activities**: Data movement outside the organization. Use this to detect potential data exfiltration.
- **DLP detections**: Activities triggering DLP policies.
- **Network DLP activities**: Data movement across monitored networks.
- **Protected Browser**: Track actions within secure browsers. Useful for monitoring activity in Microsoft Edge with security policies enabled.

Admins can also create and save custom filter sets by combining multiple filters.

## Security Copilot in Activity explorer (preview)

Microsoft **Security Copilot** enhances Activity explorer with AI-driven insights, helping identify security risks, policy violations, and suspicious activity.

AI-driven capabilities include:

- **Data hunting**: Use machine learning to surface critical data activity.
- **Prompt-based filtering**: Enter natural language queries to generate filter sets.
- **Investigative assistance**: Drill down into suspicious activities.

Example prompts:

- "Show me the top 5 activities from the past week."
- "Filter and investigate files copied to the cloud with sensitive data."

   :::image type="content" source="../media/security-copilot-activity-explorer.png" alt-text="Screenshot showing Activity explorer, highlighting Security Copilot features." lightbox="../media/security-copilot-activity-explorer.png":::

> [!IMPORTANT]
> Security Copilot results should be verified for accuracy before taking action.

## Activity types in Activity explorer

Activity explorer collects data from Microsoft 365 audit logs to track label-related actions.

| Activity type | Example |
|-----|-----|
| Labeling activities | Label applied, changed, removed. |
| Auto-labeling simulation | Track how autolabeling policies apply labels. |
| File actions | Read, modify, copy, print, delete. |
| DLP rule matches | Track policy violations across Exchange, SharePoint, OneDrive, Teams. |
| Endpoint DLP actions | Clipboard copies, file movements, unallowed app access. |

> [!NOTE]
> Exchange retention activities aren't currently included in Activity Explorer.

## Alerts and policy effectiveness tracking

Activity explorer provides insight into policy enforcement and alerting behavior.

| Policy Configuration | Action Logged? | Policy Match Detected? | Alert Triggered? |
|-----|-----|-----|-----|
| Policy allows activity (no auditing) | Yes | No | No |
| Policy audits some activities | Yes | Yes (only for specific rules) | Yes (if rule is set to trigger alerts) |
| Policy allows activity with no audits | Yes | No | No |

Admins can use these insights to fine-tune compliance policies and mitigate risks.

## Export and analyze activity data

Users can export Activity explorer data to a CSV file for further analysis.

- **Use case**: Investigate large-scale labeling changes.
- **Export scope**: Includes all visible filtered data.
- **Retention**: Data is stored for 30 days in Activity Explorer.

Activity explorer in Microsoft Purview helps security teams track how classified data is accessed and modified. It integrates with Microsoft 365 audit logs, supports filter-based investigation, and now includes Security Copilot AI insights. By using filters, predefined sets, and AI-driven queries, admins can enhance data protection policies and detect compliance risks more effectively.

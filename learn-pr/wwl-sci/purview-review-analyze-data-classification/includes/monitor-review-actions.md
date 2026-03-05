**Activity Explorer** in Microsoft Purview helps security and compliance teams see how labeled content is accessed, modified, and shared. By reviewing these activity trends, organizations can evaluate policy effectiveness, spot potential risks, and strengthen data protection measures.

## Use Activity Explorer to track data activity

You can use Activity Explorer in several ways to better understand how labeled data is used and protected across your organization.

- **Monitor classified data usage**: Track how labeled content is accessed, modified, or shared.
- **Audit policy effectiveness**: Identify compliance gaps by analyzing data loss prevention (DLP) matches, labeling changes, and file actions.
- **Refine analysis with filters**: Apply filters for date, user, activity type, sensitivity label, location, and more.
- **Use predefined filter sets**: Quickly view activities such as labeling changes, DLP detections, and endpoint data movement.
- **Use Security Copilot**: AI-driven insights detect anomalies, analyze patterns, and suggest policy refinements.

## Access Activity Explorer

Access to Activity Explorer requires specific permissions and an understanding of where it appears in the Microsoft Purview portal. These sections explain the roles and steps involved.

### Permissions

The table lists the Microsoft Purview and Microsoft 365 roles that grant access to Activity Explorer.

| Category | Roles | Role groups |
|-----|-----|-----|
| Microsoft Purview | - Information Protection Admin <br> - Information Protection Analyst <br> - Information Protection Investigator <br> - Information Protection Reader | - Information Protection <br> - Information Protection Admins <br> - Information Protection Investigators <br> - Information Protection Analysts <br> - Information Protection Readers |
| Microsoft 365 | - Compliance Admin <br> - Security Admin <br> - Compliance Data Admin | - Compliance Administrator <br> - Security Administrator <br> - Security Reader |

### Navigate to Activity Explorer

You can access Activity Explorer from multiple Microsoft Purview solutions, based on the area you're working in:

1. Navigate to the [Microsoft Purview portal](https://purview.microsoft.com/).

1. Select **Solutions**.

1. **Activity Explorer** can be found in these solutions:

   - Communication compliance

   - Data lifecycle management

   - Data loss prevention (DLP)

   - Information protection

   - Records management

1. Select the drop-down for **Explorers**, then select **Activity Explorer**.

   :::image type="content" source="../media/navigate-to-activity-explorer.png" alt-text="Screenshot showing navigation to Activity Explorer from Information Protection in Microsoft Purview." lightbox="../media/navigate-to-activity-explorer.png":::

## Use filters to focus your analysis

Filters help you focus on the data that matters most. You can combine multiple filters to narrow results by activity type, user, or location. The table shows some of the most common options.

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

## Apply predefined filter sets for quick insights

Filter sets make it easier to find specific types of activity quickly. Activity Explorer includes built-in filter sets such as:

- **Endpoint DLP activities**: Actions on files from managed devices.
- **Sensitivity label changes**: Applied, changed, or removed labels.
- **Egress activities**: Data movement outside the organization. Use this to detect potential data exfiltration.
- **DLP detections**: Activities triggering DLP policies.
- **Network DLP activities**: Data movement across monitored networks.
- **Protected Browser**: Track actions within secure browsers. Useful for monitoring activity in Microsoft Edge with security policies enabled.

Admins can also create and save custom filter sets by combining multiple filters.

## Use Microsoft Security Copilot for AI-driven investigation

**Microsoft Security Copilot** adds AI-driven insights to Activity Explorer. It helps identify risks, highlight potential policy violations, and surface unusual activity for investigation.

AI-driven capabilities include:

- **Data hunting**: Uses machine learning to surface significant data activity and anomalies.
- **Prompt-based filtering**: Enter natural-language questions to create or refine filter sets.
- **Investigative assistance**: Guides deeper review of suspicious or high-risk actions.

**Example prompts**:

- "Show me the top 5 activities from the past week."
- "Find files with sensitive data copied to the cloud."

   :::image type="content" source="../media/security-copilot-activity-explorer.png" alt-text="Screenshot showing Activity Explorer, highlighting Security Copilot features." lightbox="../media/security-copilot-activity-explorer.png":::

> [!IMPORTANT]
> Always verify Security Copilot results before taking action to confirm that AI-generated insights align with your organization’s context.

## Review activity types tracked in Activity Explorer

Activity Explorer collects data from Microsoft 365 audit logs to track labeling and protection-related actions. The table outlines common activity types that Activity Explorer tracks from Microsoft 365 audit logs.

| Activity type | Example |
|-----|-----|
| Labeling activities | Label applied, changed, removed. |
| Auto-labeling simulation | Track how autolabeling policies apply labels. |
| File actions | Read, modify, copy, print, delete. |
| DLP rule matches | Track policy violations across Exchange, SharePoint, OneDrive, Teams. |
| Endpoint DLP actions | Clipboard copies, file movements, unallowed app access. |

> [!NOTE]
> Exchange retention activities aren't currently included in Activity Explorer.

## Analyze policy alerts and enforcement

Activity Explorer also provides insight into how policies enforce protection and trigger alerts. The table summarizes how different policy configurations affect logging, matches, and alerts.

| Policy configuration | Action logged? | Policy match detected? | Alert triggered? |
|-----|-----|-----|-----|
| Policy allows activity (no auditing) | Yes | No | No |
| Policy audits some activities | Yes | Yes (only for specific rules) | Yes (if rule is set to trigger alerts) |
| Policy allows activity with no audits | Yes | No | No |

Admins can use these insights to fine-tune compliance policies and mitigate risks.

## Export and analyze activity data

Users can export Activity Explorer data to a CSV file for further analysis.

- **Use case**: Investigate large-scale labeling changes.
- **Export scope**: Includes all visible filtered data.
- **Retention**: Data is stored for 30 days in Activity Explorer.

Activity Explorer gives security teams a real-time view of how classified data is used across Microsoft 365. It draws from Microsoft 365 audit logs, supports filter-based investigation, and integrates with Microsoft Security Copilot for AI-assisted insights. By combining filters, predefined sets, and natural-language queries, admins can fine-tune data-protection policies and quickly detect potential compliance risks.

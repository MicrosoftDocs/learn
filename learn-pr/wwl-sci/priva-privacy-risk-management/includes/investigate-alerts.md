Microsoft Priva Privacy Risk Management helps organizations gain visibility into data exposure, minimization, and transfer policies through actionable alerts. By investigating these alerts, admins can identify cases that require further attention and create issues to facilitate structured follow-up, prioritize risks, and collaborate on resolutions.

## Manage alerts and issues in Privacy Risk Management

The **Alerts** page in the [Microsoft Priva portal (preview)](https://purview.microsoft.com/priva?azure-portal=true) serves as the central hub for monitoring active risks and taking corrective actions. This page provides an overview of active alerts and their associated risks, serving as the starting point for managing privacy concerns.

### Manage alerts

The **Alerts** page provides a filterable list of active alerts generated by your policies. Each alert includes details such as the triggering conditions, matching items, and severity. To manage alerts:

1. Select an alert name from the list to open its details page.
1. Review the associated content under the **Content** tab to understand what triggered the alert, including data types, file locations, and user actions.
1. Based on your assessment, you can:
   - **Create an issue**: Prompt further investigation and structured resolution by naming the issue and adding relevant comments, by selecting **Create issue**.
   - **Dismiss the alert**: Remove it from the active alerts list if no action is required.

### Manage issues

Admins can create issues from alerts to ensure thorough investigation and resolution of privacy risks. Issues are accessible on the **Issues** page, where they're categorized by severity (high, medium, low, or unassigned) to aid prioritization. To manage issues:

1. Select an issue from the list to open its details page.
1. Use the tabs on the issue details page to:
   - **Overview**: View the issue's status, recommended actions, associated policy, and content timeline.
   - **Alerts**: Access a detailed list of alerts related to the issue.
   - **Content**: Review and filter associated files, view details, and take new remediation actions if necessary.
   - **Notes**: Add or view team notes for collaborative context.
   - **Collaborators**: Manage team members involved in resolving the issue.

## Review content and take actions

To address the files associated with an issue, open the **Content** tab and select items for review. Available remediation actions include:

- **Notify owner**: Send a notification to the content owner about the detected issue.
- **[Apply retention label](/purview/retention?azure-portal=true)**: Add a label to retain or delete the content based on a specified timeframe.
- **[Apply sensitivity label](/purview/sensitivity-labels?azure-portal=true)**: Mark the content's sensitivity and apply protection such as encryption or visual markings.
- **Mark as not a match**: Identify false positives to exclude them from further consideration.
- **Delete**: For data minimization policies, move items to a deleted state where recovery options apply.
- **Make private**: Restrict access to overexposed content.

Once all necessary actions are completed, close the issue by selecting **Resolve** and providing final comments for documentation.

Thoroughly investigating and resolving alerts is a critical step in maintaining data privacy and compliance. By using Privacy Risk Management, organizations can proactively mitigate risks, protect sensitive information, and enhance their reputation for privacy stewardship.

## Legal disclaimer

[Microsoft Priva legal disclaimer](/privacy/priva/priva-disclaimer?azure-portal=true)

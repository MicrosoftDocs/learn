Insider Risk Management helps organizations detect, investigate, and respond to internal risks. Before using these tools, ensure your organization meets all prerequisites and licensing requirements.

## Subscriptions and licensing

To use Microsoft Purview Insider Risk Management, your organization must meet the following licensing and geographical requirements:

- **Required license**: A subscription to **Microsoft 365 E5**, **Microsoft 365 E5 Compliance**, or an equivalent plan that includes Insider Risk Management capabilities. Equivalent plans may include add-ons like Microsoft 365 E5 Insider Risk Management if paired with another base plan.
- **Trial options**: Organizations without an existing E5 plan can explore trial options in the Microsoft 365 admin center.
- **Geographical availability**: Insider Risk Management is supported in Azure-supported regions. Verify eligibility through Azure dependency availability by region.

If your organization uses premium indicators, such as advanced analytics or custom connectors, pay-as-you-go billing might be required to access these features.

## Recommended actions

The **Overview** page provides recommended actions to guide your initial setup of Insider Risk Management. These steps ensure prerequisites are met and help you effectively create and manage policies:

   :::image type="content" source="../media/insider-risk-management-recommendations.png" alt-text="Screenshot showing the top recommendations for insider risk management.":::

- **Turn on auditing**: Enable audit logging to track user and admin activities. This is a critical prerequisite for detecting insider risks.
- **Turn on analytics to scan for potential risks**: Use analytics to identify trends and refine policies. (Optional)
- **Get to know insider risk management**: Learn key concepts, best practices, and use cases for insider risk management. (Optional)
- **Configure insider risk settings**: Adjust global settings for privacy, exclusions, and risk indicators to align with organizational needs.
- **Create your first policy**: Use predefined templates to detect risky activities, such as data exfiltration or unauthorized access.
- **Make sure your team can get their jobs done**: Assign roles and permissions to ensure administrators and analysts have access to manage policies and investigations.

The **Recommendations** tab provides more actions for ongoing optimization, such as reviewing alerts, fine-tuning detection, and integrating tools like Microsoft Defender XDR.

## Prerequisites for Insider Risk Management

Follow these steps to ensure all prerequisites are met before creating policies.

### Step 1: Enable permissions for Insider Risk Management

Assign the following roles to configure and manage Insider Risk Management:

- **Global Administrator or Compliance Administrator**: Assign and oversee roles and access.
- **Insider Risk Management Admin**: Configure global settings and manage policies.
- **Insider Risk Management Analyst**: Review and investigate alerts.
- **Insider Risk Management Investigator**: Investigate user activity and cases.

Always ensure at least one user has admin access to avoid a "zero administrator" scenario.

#### Add users to role groups

To assign users to role groups:

1. Sign in to the [Microsoft Purview portal](https://purview.microsoft.com?azure-portal=true).
1. Navigate to **Settings** on the left sidebar, then select **Roles and scopes** > **Roles groups**.
1. Select the appropriate role group, for example _Insider Risk Management Admin_, then select **Edit**.
1. Select **Choose users**, then select the checkboxes for the users you want to add to the role group.
1. Select **Next**, then select **Save** to save your settings.

### Step 2: Enable Microsoft 365 Audit logs

Audit logs capture essential activity data for analytics and alerts. Verify auditing is active by running this command in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell?azure-portal=true):

```powershell
Get-AdminAuditLogConfig | Format-List UnifiedAuditLogIngestionEnabled
```

If the _UnifiedAuditLogIngestionEnabled_ property returns `True`, auditing is enabled.

Be sure to use Exchange Online PowerShell for accurate results. Running it in Security & Compliance PowerShell always shows `False`, even if auditing is enabled.

For step-by-step instructions on enabling audit logging in Microsoft 365, see [Turn auditing on or off](/purview/audit-log-enable-disable?azure-portal=true#turn-on-auditing)

### Step 3: Enable insider risk analytics (Optional)

Analytics provide insights into user activities, helping you identify trends and potential risks before deploying policies. Analytics also recommend threshold settings to refine detection.

To enable insider risk analytics:

1. Sign in to the [Microsoft Purview portal](https://purview.microsoft.com?azure-portal=true).
1. Navigate to the **Insider Risk Management** solution.
1. On the **Overview** tab, on the **Scan for insider risks in your organization** card, select **Run scan**. This action turns on analytics scanning for your organization.

   You can also turn on scanning by going to **Insider risk settings** > **Analytics** and enabling **Scan your tenant's user activity to identify potential insider risks**.

1. On the **Analytics details** pane, select **Run scan to start the scan for your organization**. Analytics scan results might take up to 48 hours before insights are available as reports for review.

### Step 4: Configure prerequisites for policy indicators

To ensure effective detection, set up data sources and configure policies:

- **HR connector**: Integrates data such as resignation dates and terminations, supporting templates like _Data theft by departing users_.
- **Cloud indicators**: Review activities in platforms like Google Drive, Dropbox, and Azure for risks like data exfiltration or privilege escalation.
- **Healthcare data**: Import logs from systems like Epic to track improper access or editing of patient records, supporting policies like _Patient data misuse_.
- **Third-party systems**: Use tools like Microsoft Sentinel or Splunk to bring in aggregated detections from external systems, enriching your organization's risk coverage.

To learn more about third-party data connectors, see [Learn about connectors for third-party data](/purview/archive-third-party-data?azure-portal=true)

Certain policy templates also require specific configurations:

- **Data loss prevention (DLP) policies**: Identify sensitive data exposure for templates like _Data leaks_, using high-severity DLP alerts.
- **Microsoft Defender for Endpoint**: Provides endpoint activity signals for templates like _Security policy violations_.
- **Priority user groups**: Boost risk scoring for users in critical roles or with elevated access, enabling templates like _Data leaks by priority users_.

### Step 5: Configure insider risk settings

Settings shape how risks are detected and managed across all policies. Key settings include:

- **Privacy**: Ensure compliance with data handling rules.
- **Indicators**: Define signals to detect risky activities.
- **Exclusions**: Reduce noise by excluding specific users or activities.
- **Detection groups**: Monitor targeted groups for focused insights.
- **Intelligent detections**: Use analytics to identify risks more accurately.

To access insider risk settings, navigate to the Microsoft Purview portal and select  **Settings** > **Insider Risk Management**.

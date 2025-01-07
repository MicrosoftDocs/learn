Insider Risk Management policies help organizations detect and respond to potential risks posed by insider activities. These policies are tailored to specific risk scenarios, such as data theft, data leaks, or security violations. Creating and managing custom policies effectively ensures your organization can proactively address insider risks while respecting privacy.

## Overview of Insider Risk Management policies

Insider Risk Management policies define the scope of users and the types of activities that generate alerts. Policies include conditions, thresholds, and risk indicators that identify potentially risky behavior.

Key features of these policies:

- **Policy templates**: Predefined configurations tailored to specific risk scenarios.
- **Customizable indicators**: Detect various activities, such as data exfiltration or policy violations.
- **Risk scoring**: Assign risk scores based on activity and priority content.
- **Privacy by design**: Includes pseudonymization and role-based access controls.

Policies can be applied to the entire organization or scoped to specific users, groups, or content types.

## Steps to create a custom Insider Risk Management policy

Follow these steps to create a new Insider Risk Management policy:

### 1. Select a policy template

Policy templates provide a starting point for configuring custom policies tailored to specific risk scenarios, such as data theft by departing users or security policy violations. Choose the template that aligns with your organization's needs.

1. Sign in to the [Microsoft Purview portal](https://purview.microsoft.com/?azure-portal=true) using credentials with [appropriate permissions for Insider Risk Management](/purview/insider-risk-management-configure?azure-portal=true#step-1-required-enable-permissions-for-insider-risk-management).
1. Navigate to **Solutions** > **Insider Risk Management** > **Policies**
1. Select **Create policy** > **Custom policy**.
1. Review available templates and choose one. Confirm that you meet any prerequisites listed, such as configuring the HR Connector or integrating Microsoft Defender for Endpoint.

   :::image type="content" source="../media/insider-risk-policy-template.png" alt-text="Screenshot showing the available policy templates in Insider Risk Management." lightbox="../media/insider-risk-policy-template.png":::

1. Select **Next** to continue.

### 2. Define policy details

On the **Name your policy** page, provide a name and description for the policy:

- **Name**: Use a descriptive name, for example, "Prevent Data Loss for Departing Users."
- **Description**: Optionally, describe the purpose of the policy and the risks it addresses.

:::image type="content" source="../media/insider-risk-name-your-policy.png" alt-text="Screenshot showing the Name your policy screen when creating an insider risk policy." lightbox="../media/insider-risk-name-your-policy.png":::

Select **Next** to continue.

### 3. Scope users and groups

On the **Choose users, groups, & adaptive scopes** page, define which users or groups the policy covers:

- **All users, groups, and adaptive scopes**: Broad coverage for your entire organization.
- **Specific users, groups, and adaptive scopes**: Narrow the scope to individuals or teams.
- **Exclude users or groups** (optional) (preview): Specify exclusions, such as executives or specific departments.

> [!NOTE]
> If you selected All users, groups, and adaptive scopes, the **Exclude users and groups (optional) (preview)** page appears. Use this page to exclude specific users or groups from the policy scope. For example, you might exclude executive-level roles or certain departments.

If your organization uses **adaptive scopes** or **priority user groups**, you can include those in the policy.

### 4. Prioritize content (optional)

1. On the **Decide whether to prioritize content** page, choose one of the following options:

   - **I want to prioritize content**: Enable prioritization to assign higher risk scores to activities involving specific types of content.
   - **I don't want to prioritize content right now**: Skip prioritization for this policy. No changes are applied to risk scores based on content.

1. If you select **I want to prioritize content**, you can configure the policy to prioritize specific types of content:

   - **SharePoint sites**: Specify critical sites to detect potential risks related to activity.
   - **Sensitivity labels**: Choose labels, such as "Confidential" or "Highly Confidential."
   - **Sensitive info types**: Select predefined or custom sensitive information types (for example, Social Security Numbers or Credit Card Numbers).
   - **File extensions**: Define up to 50 extensions to prioritize (for example, .docx, .pdf).
   - **Trainable classifiers**: Select up to five classifiers to prioritize activities associated with specific patterns, such as source code or financial data.

1. Complete the configuration by selecting the specific SharePoint sites, labels, sensitive info types, file extensions, or trainable classifiers you want to prioritize. These settings ensure that activities involving this content are assigned higher risk scores, increasing the likelihood of generating high-severity alerts.

    :::image type="content" source="../media/insider-risk-prioritize-content.png" alt-text="Screenshot showing what content to prioritize when creating an Insider Risk Management policy." lightbox="../media/insider-risk-prioritize-content.png":::

### 5. Define policy triggers

On the **Choose triggering event for this policy** page, define the conditions that bring users into the policy scope. The available triggers depend on the selected template:

- **Data leaks** or **Data leaks by priority users**: Use the **User matches a data loss prevention (DLP) policy** trigger to base the policy on a DLP match.
- **Data theft** or **Data leaks by risky users**: Use the **User performs an exfiltration activity** trigger to specify activities such as downloading or sharing files externally.
- **Security policy violations by risky users**: Select **Risk triggers from communication compliance (preview)** to include flagged users.
- **Data theft by departing users**: Enable the **HR data connector events** trigger to assign users based on HR-reported events, such as resignation or termination dates.

> [!NOTE]
> The triggers available depend on the selected template. If a desired trigger isn't available, ensure it's enabled in your organization's settings using the **Turn on indicators** prompt.

:::image type="content" source="../media/insider-risk-triggering-event.png" alt-text="Screenshot showing where to define policy triggers in Insider Risk Management." lightbox="../media/insider-risk-triggering-event.png":::

### 6. Configure policy indicators

1. On the **Indicators** page, define the activities that the policy will detect for assigned users. Select from available categories such as:

   - **Office indicators**: File downloads, sharing, and edits.
   - **Device indicators**: USB usage, file transfers, or printing.
   - **Browsing indicators**: Visiting restricted or malicious sites.

1. On the **Detection options** page, enable advanced detection features if applicable:

   - **Sequence detection**: Identify patterns of related risky activities (for example, file downloads followed by external sharing).
   - **Cumulative exfiltration detection**: Detect unusually high levels of activity over time.
   - **Risk score boosters**: Amplify risk scores for specific indicators.

1. On the **Choose threshold type for indicators** page, define the sensitivity of alerts generated by the policy:

   - **Apply thresholds provided by Microsoft**: Automatically apply preconfigured thresholds for the selected indicators.
   - **Choose your own thresholds**: Adjust thresholds to align with your organization’s risk tolerance or priorities.
   - For certain indicators, you can choose thresholds based on anomalous activities compared to a user's typical behavior.

> [!IMPORTANT]
> If some indicators aren't selectable, ensure they're enabled in the Insider Risk Management Settings.

### 7. Review and submit

Review the policy details to ensure all settings are correct:

- Verify the template and scope.
- Confirm prioritized content and indicators.
- Address any warnings or recommendations.

After you've completed these steps to create your first insider risk management policy, you'll start to receive alerts from activity indicators after about 24 hours.

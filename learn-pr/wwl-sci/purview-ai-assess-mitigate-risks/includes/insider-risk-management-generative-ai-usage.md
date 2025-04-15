Microsoft Purview Insider Risk Management is a compliance solution designed to help organizations detect, investigate, and mitigate internal risks, whether caused by accidental actions or intentional misuse. It supports the creation of policies that evaluate user behavior, assign risk scores, and trigger appropriate remediation actions, while maintaining user privacy.

As AI tools become more common in the workplace, new types of risk have emerged. To help manage these risks, Insider Risk Management includes policy templates that focus on detecting and responding to activity involving AI applications.

## Use policy templates to detect risky AI activity

Insider Risk Management includes two preview policy templates that help detect and respond to risky behavior related to AI usage:

- **Risky browser usage (preview)**: Detects when users access known generative AI websites from supported browsers.
- **Risky AI usage (preview)**: Detects sensitive prompts or AI-generated responses in tools like Microsoft 365 Copilot. Detection contributes to user risk scoring and supports adaptive protection.

These templates help you:

- Identify behavior that might put sensitive data at risk
- Analyze how AI tools are used across supported applications and websites
- Respond to early signs of policy violations or risky behavior

### Risky browser usage (preview) policy template

The Risky browser usage (preview) policy template in Microsoft Purview Insider Risk Management is designed to detect web browsing activity that might go against organizational policies. This includes visits to inappropriate, non-compliant, or potentially risky websites such as generative AI platforms. This template helps organizations:

- Detect and review risky web activity
- Identify visits to websites that might violate internal policies
- Promote responsible use of devices and networks
- Support compliance with acceptable use policies

### Risky AI usage (preview) policy template

This policy detects risky interactions with AI tools, such as:

- User prompts that contain sensitive information
- AI responses that might inappropriately reveal internal data

Detection applies to tools like Microsoft 365 Copilot and Copilot in Microsoft Edge. These activities contribute to user risk scores and support Adaptive Protection. You can create this policy directly in the Insider Risk Management experience or through Data Security Posture Management (DSPM) for AI in Microsoft Purview.

This policy also supports wider risk detection when paired with:

- The Microsoft Insider Risk Extension for Microsoft Edge or the Purview Extension for Chrome
- A communication compliance policy to review messages for inappropriate content
- An optional HR connector to identify departing users

## Prerequisites for using insider risk policies with AI indicators

These requirements help ensure policies can detect activity related to AI usage, including browsing behavior and interactions in AI tools.

### General requirements for Insider Risk Management

| **Step** | **Description** | **Learn more** |
|----------|-----------------|----------------|
| Check licensing requirements | Verify that you have the correct Microsoft 365 E3 or E5 licenses for Insider Risk Management. | [Microsoft Purview Insider Risk Management service guide](/office365/servicedescriptions/microsoft-365-service-descriptions/microsoft-365-tenantlevel-services-licensing-guidance/microsoft-365-security-compliance-licensing-guidance?azure-portal=true#microsoft-purview-insider-risk-management) |
| Enable auditing | Turn on auditing in Microsoft 365 to capture user and admin activity. | [Turn auditing on or off in Microsoft 365](/purview/audit-log-enable-disable?azure-portal=true) |
| Assign permissions | Add users to the Insider Risk Management or Insider Risk Management Admins role groups. | [Enable permissions for insider risk management](/purview/insider-risk-management-configure?azure-portal=true#step-1-required-enable-permissions-for-insider-risk-management) |
| Configure indicators | Turn on the indicators you want to use in your policy. | [Configure policy indicators](/purview/insider-risk-management-settings-policy-indicators?azure-portal=true) |

### Requirements for Risky browser usage (preview)

| **Requirement** | **Description** |
|-----------------|-----------------|
| Onboard devices | Devices must be onboarded to Microsoft Purview to detect browser activity. |
| Microsoft Edge | Use Microsoft Edge x64 version 91.0.864.41 or later with Microsoft Compliance Extension (1.0.0.44+). Edge.exe must be allowed. |
| Configure Microsoft Edge | Use basic, Intune, or Group Policy setup to configure browser support. |
| Google Chrome | Use Chrome x64 with Microsoft Compliance Extension (2.0.0.183+). Chrome.exe must be configured. |
| Configure Chrome | Use basic, Intune, or Group Policy setup for deployment. |
| Test signals | Create a policy and verify that indicators are triggered as expected. |

### Additional recommendations for Risky AI usage (preview)

| **Requirement** | **Description** |
|-----------------|-----------------|
| Communication Compliance policy | (Recommended) Helps detect inappropriate messages that can serve as policy triggers. |
| [HR connector](/purview/hr-data-connector-overview?azure-portal=true) | (Recommended) Tracks termination or resignation dates for additional risk context. |

## Create an insider risk policy for AI usage

Use these steps to create a policy using either template.

### Create a policy using the Risky browser usage (preview) template

:::image type="content" source="../media/risky-browser-usage-template.png" alt-text="Screenshot showing the Risky browser usage template in Insider Risk Management." lightbox=" ../media/risky-browser-usage-template.png":::

1. Go to [Microsoft Purview](https://purview.microsoft.com/).
1. Select **Solutions** > **Insider risk management** > **Policies**.
1. Select **Create policy**.
1. Choose the **Risky browser usage (preview)** template.
1. Name your policy and provide an optional description.
1. Choose whether to apply the policy to all users or specific groups.
   - Applying to all users enables real-time analytics.
1. Skip content prioritization unless required for other indicators.
1. On the **Triggering events** page, select the indicators that apply to your policy. To focus on AI-related activity, select **Browsed to generative AI websites**.
1. Choose built-in or custom thresholds for triggering events.
1. On the **Indicators** page, select the indicators you want this policy to use. You can also turn on any additional indicators that aren't currently enabled.
1. Choose default or custom thresholds.
1. Review your settings and select **Submit** to activate the policy.

### Create a policy using the Risky AI usage (preview) template

You can create this policy in three ways: as a quick policy, a custom policy, or from a recommendation in DSPM for AI.

**From a recommendation in DSPM for AI**:

Creating the policy through DSPM for AI helps organizations prioritize AI-specific risk signals and integrate with other data security recommendations.

- Go to **Solutions** > **DSPM for AI** > **Recommendations**, select **Detect risky interactions in AI apps (preview)**, and choose **Create policies**.

**As a quick policy**:

1. In Microsoft Purview, go to **Solutions** > **Insider Risk Management** > **Policies**.
1. Select **Create policy** > **Quick policy** > **Risky AI usage (preview)** and follow the prompts.

**As a custom policy**:

Use these steps to configure the policy manually:

:::image type="content" source="../media/risky-ai-usage-template.png" alt-text="Screenshot showing the Risky AI usage template in Insider Risk Management." lightbox=" ../media/risky-ai-usage-template.png":::

1. Go to [Microsoft Purview](https://purview.microsoft.com/).
1. Select **Solutions** > **Insider risk management** > **Policies**.
1. Select **Create policy** > **Custom policy**.
1. Choose the **Risky AI usage (preview)** template.
1. Name your policy and provide an optional description.
1. Choose whether to apply the policy to all users or specific groups.
   - Applying to all users enables real-time analytics.
1. Skip content prioritization unless required for other indicators.
1. On the **Triggering events** page, select the events that will start assigning risk scores. For AI-related policies, consider options like browsing to generative AI sites or messages flagged by Communication Compliance.
1. Choose built-in or custom thresholds for triggering events.
1. On the **Indicators** page, select the indicators you want this policy to use. You can also turn on any additional indicators that aren't currently enabled.
1. Choose default or custom thresholds.
1. Review your settings and select **Submit** to activate the policy.

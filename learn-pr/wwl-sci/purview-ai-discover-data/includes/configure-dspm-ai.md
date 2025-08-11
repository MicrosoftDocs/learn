Microsoft Purview Data Security Posture Management (DSPM) for AI helps organizations understand how AI tools interact with data, identify potential risks, and connect insights to security and compliance tools that help enforce policy. To use DSPM for AI effectively, organizations need to configure key settings, enable monitoring, and apply security controls.

## Prerequisites

Before configuring DSPM for AI, check that your environment meets these requirements:

- **[Check permissions](/purview/ai-microsoft-purview-permissions?azure-portal=true)**: Your account needs appropriate permissions in Microsoft Entra or Microsoft Purview, such as Compliance Administrator or a related role with compliance management permissions.
- **[Verify Microsoft Purview Audit is enabled](/purview/audit-log-enable-disable?azure-portal=true#verify-the-auditing-status-for-your-organization)**: Auditing is on by default for new tenants, but it's a good idea to verify.
- **[Assign Copilot Licenses](/copilot/microsoft-365/microsoft-365-copilot-enable-users?azure-portal=true#assign-licenses)**: Users should be assigned Microsoft 365 Copilot licenses for activity tracking.
- **[Onboard Devices to Microsoft Purview](/purview/device-onboarding-overview?azure-portal=true)**: Devices need to be onboarded to Microsoft Purview to track AI interactions.
- **[Install the Microsoft Purview Browser Extension](/purview/insider-risk-management-browser-support#configure-browser-signal-detection-for-microsoft-edge?azure-portal=true)**: The Microsoft Purview browser extension is required to monitor non-Microsoft AI site visits.

## Steps to configure DSPM for AI

After completing the prerequisites, configure DSPM for AI in Microsoft Purview. This process includes enabling built-in policies, running data assessments, and verifying that AI-related security controls are in place.

### Step 1: Set up DSPM for AI

1. Sign in to the [Microsoft Purview portal](https://purview.microsoft.com/?azure-portal=true).
1. Navigate to **Solutions** > **DSPM for AI**.
1. From the **Overview** page, go to **Get started** to complete the required setup tasks.
1. Verify that **Microsoft Purview Audit** is enabled to track AI interactions.
1. Install the **Microsoft Purview browser extension** to detect AI-related activity.
1. **Onboard devices to Microsoft Purview** to monitor AI interactions.
1. Enable **Extend your insights for data discovery** to create policies that detect risky AI usage, track AI site visits, and identify when users paste sensitive data into AI apps.

    :::image type="content" source="../media/dspm-ai-get-started.png" alt-text="Screenshot of the DSPM for AI interface in Microsoft Purview, showing the Get started checklist with required setup steps." lightbox="../media/dspm-ai-get-started.png":::

### Step 2: Review and configure recommendations and policies

Microsoft Purview provides AI security recommendations that help organizations protect sensitive data and monitor AI interactions. These recommendations include preconfigured policy templates (one-click policies) that work with Microsoft Purview features like data loss prevention (DLP), Insider Risk Management, or Communication Compliance, as well as guidance for manual policy implementation.

#### How to use recommendations

1. Go to **Recommendations** in the Microsoft Purview portal.
1. Review the available AI security recommendations and their status.
1. Select a recommendation to:

   - **Create a policy**: Instantly apply a one-click policy with built-in security settings.
   - **View the recommendation**: Assess and manually take action based on guidance.

   :::image type="content" source="../media/dspm-ai-recommendations.png" alt-text="Screenshot of the Recommendations page in Microsoft Purview, showing a list of AI security recommendations categorized as Not Started, Dismissed, or Completed." lightbox="../media/dspm-ai-recommendations.png":::

   > [!NOTE]
   > Recommendations that provide one-click policies include a **Create policy** button, while manual recommendations require reviewing and taking action based on the provided guidance.

#### Types of AI security recommendations

Recommendations are grouped into categories such as **Data Security**, **Data Discovery**, or **AI Regulations**. When selecting a recommendation, DSPM for AI provides either:

- A preconfigured policy that can be activated immediately (one-click policy)
- Guidance on security measures that require manual implementation

**Recommendations in DSPM for AI**:

DSPM for AI offers a range of AI security recommendations, each designed to detect specific risks or enforce specific protections. Some apply a one-click policy. Others offer guidance for manual configuration.

Use this table to get a quick understanding of what each recommendation does so you can decide which to apply in your environment.

| Recommendation | Type | Description |
|-----|-----|-----|
| Fortify your data security | Data security | Uses Adaptive Protection to apply a block-with-override rule for high-risk users interacting with AI sites. |
| Control unethical behavior in AI | Insight into communications | Creates a policy to detect unethical behavior in Microsoft 365 Copilot. Alerts are generated in Communication Compliance. |
| Guided assistance to AI regulations | AI regulations | Provides guidance on regulatory compliance for AI interactions. |
| Protect sensitive data referenced in Copilot responses | Data security | Runs a data assessment to identify oversharing risks in Copilot interactions. |
| Discover and govern interactions with ChatGPT Enterprise AI (Preview) | Data discovery |Requires setting up a connector in Purview to track ChatGPT Enterprise interactions. |
| Protect sensitive data referenced in Microsoft 365 Copilot (Preview) | Data security | Creates a data loss prevention policy to prevent Copilot from processing labeled content. |
| Protect your data from potential oversharing risks | Data security | Provides insights into oversharing risks based on a weekly scan. |
| Use Copilot to improve your data security posture (Preview) | Data security | Uses Security Copilot to investigate alerts and analyze security risks. |
| Information Protection Policy for Sensitivity Labels | Data security | Sets up default sensitivity labels to preserve document access rights and protect Copilot output. |

#### Understand recommendation status

Each recommendation falls into one of three categories:

- **Not Started**: Recommendations that haven't been acted on.
- **Dismissed**: Recommendations that were reviewed but not applied.
- **Completed**: Recommendations that have been fully implemented.

#### Policy activation timeline

Policies take up to 24 hours to take effect. Once activated in the appropriate Microsoft Purview solution, policies begin tracking or enforcing rules based on AI activity and risk signals, with results appearing in DSPM reports and Activity Explorer after data processing. Deleted policies remain visible with a **PendingDeletion** status until fully removed.

After configuring DSPM for AI, use Microsoft Purview reports and data assessments to evaluate AI interactions and identify potential risks. Reports provide insights into policy enforcement, AI data exposure, and compliance status, while data assessments help detect oversharing risks before they affect security.

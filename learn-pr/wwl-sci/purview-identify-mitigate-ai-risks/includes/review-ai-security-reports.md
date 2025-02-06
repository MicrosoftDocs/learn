After configuring Data Security Posture Management (DSPM) for AI, the next step is to monitor AI activity, assess security risks, and review reports to ensure that AI interactions comply with organizational policies. Microsoft Purview provides insights into how AI is used, identifies potential data security issues, and enables organizations to take action when necessary.

## Reports in DSPM for AI

The **Reports** section in DSPM for AI provides insights into AI interactions, sensitive data exposure, and security risks. These reports help organizations assess AI activity, identify potential compliance issues, and take proactive steps to protect sensitive information.

To view AI activity insights:

1. Sign in to the [Microsoft Purview portal](https://purview.microsoft.com/).
1. Navigate to **Solutions** > **DSPM for AI**.
1. Go to **Reports** to review AI-related activity, trends, and risk assessments.

## Understand report categories and their insights

Each report helps organizations understand AI usage and risks in different ways. The reports are grouped into three sections: **Activity**, **Data**, and **User Risk**.

### Activity reports

**Activity** reports provide an overview of AI usage patterns across the organization. These reports help security teams track adoption trends, detect unusual activity, and determine whether AI interactions align with company policies. Understanding AI usage is crucial for assessing risks and identifying whether extra safeguards are needed.

The reports available here include:

- **Total interactions over time (Microsoft Copilot & enterprise AI apps)**: Tracks the number of AI interactions within Microsoft 365 Copilot and non-Microsoft AI tools. This report helps organizations monitor AI adoption and identify patterns that might require further investigation.
- **Total visits (other AI apps)**:  Displays user visits to AI applications such as ChatGPT, Gemini, and Copilot for Bing. This report helps organizations determine whether employees are engaging with unauthorized AI tools and take action if needed.

### Data insights

**Data** reports highlight risks related to AI interactions involving sensitive data. These reports help organizations identify where sensitive information is being processed and whether AI tools are being used responsibly.

The reports available here include:

- **Sensitive interactions per AI app**: Identifies AI applications that process sensitive data. This report helps security teams assess which AI tools pose the highest data exposure risks.
- **Top unethical AI interactions**: Surfaces instances where Microsoft 365 Copilot has generated or responded to unethical, inappropriate, or noncompliant content. This information is useful for organizations using Communication Compliance policies to monitor AI-generated messages.
- **Top sensitivity labels referenced in Copilot for Microsoft 365**: Displays which sensitivity-labeled content is being referenced by AI tools. This insight helps organizations assess whether AI interactions involve confidential or highly classified data.

### User risk reports

**User** risk reports help organizations identify potential insider threats based on how employees interact with AI tools. These reports assess user behavior, AI usage trends, and the severity of security risks.

The reports available here include:

- **Insider risk severity**: Shows user AI interactions grouped by risk levels, helping security teams identify patterns that might indicate excessive or inappropriate AI usage.
- **Insider risk severity per AI app**: Breaks down user risk levels by specific AI applications, showing where risky behavior is occurring. This report helps organizations determine whether Copilot or non-Microsoft AI tools require stricter monitoring.

### Taking action on reports

After reviewing AI security reports, organizations can take specific actions to enhance monitoring, reduce risks, and enforce security policies. Some reports might initially appear blank if data tracking hasn't been enabled. In these cases, adjustments might be needed to begin collecting insights.

To act on report findings, consider:

- **Extend insights**: If reports show "Data discovery is yet to be defined," AI interactions aren't currently being tracked. Select Extend insights to enable monitoring for Microsoft 365 Copilot and non-Microsoft AI tools.
- **Enable policies**: Certain reports require data loss prevention (DLP) policies, sensitivity labels, or communication compliance rules to be activated before tracking begins. If a report remains empty despite AI activity in your environment, check policy configurations.
- **Review flagged activity**: Reports can highlight sensitive data usage, risky AI interactions, or insider threats. If an anomaly is detected, security teams should investigate further using Activity Explorer. They can then apply necessary controls, such as blocking AI interactions with classified data or restricting access to high-risk AI tools.

By continuously monitoring AI reports and acting on insights, organizations can ensure AI technologies are used securely, responsibly, and in compliance with data protection policies.

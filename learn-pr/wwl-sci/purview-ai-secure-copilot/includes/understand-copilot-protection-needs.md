Microsoft 365 Copilot introduces new ways for users to access and work with organizational data. By generating summaries, drafting content, and answering questions across Microsoft 365 apps, Copilot interacts with data stored in Outlook, Word, Excel, SharePoint, and Teams. This cross-app access creates new challenges for protecting sensitive information.

Unlike traditional tools that operate within a single workload, Copilot can surface data from multiple sources based on what the user is allowed to access. This requires a broader approach to information protection that includes sensitivity labels, data loss prevention (DLP), retention settings, auditing, and communication policies.

## Identify risks introduced by Copilot

When organizations enable Microsoft 365 Copilot, they should consider these risk areas:

- **Visibility gaps**: It can be difficult to determine what content Copilot is accessing and how it's being used.
- **Access amplification**: Users might prompt Copilot in ways that reveal sensitive information that would otherwise stay buried in older documents or conversations.
- **Audit and compliance blind spots**: Prompt and response data, or content referenced during AI interactions, might not be captured without specific audit or retention settings.

Being aware of these risks helps guide the selection and configuration of appropriate controls.

## Use Data Security Posture Management for AI to discover risks and recommend protections

Microsoft Purview Data Security Posture Management (DSPM) for AI helps administrators identify where sensitive data might be used during Microsoft 365 Copilot interactions. It analyzes content usage patterns and provides recommendations for applying appropriate protections.

DSPM for AI organizes its recommendations into three categories that reflect common risk scenarios when Copilot is used across an organization:

- **Data security**: Gaps in labeling, DLP, or access control configurations that could let Copilot process sensitive files
- **Communication insights**: Prompts or responses that include inappropriate language or expose sensitive data
- **AI regulations**: Audit, retention, or policy settings that must align with regulatory expectations

DSPM for AI is designed to help you get started quickly. You can act on recommendations directly or use them to guide configuration in the relevant Microsoft Purview tools.

## Choose where to manage policies

Although DSPM for AI can initiate policies, it doesn't manage them directly. Each policy is created and stored in its corresponding solution area within Microsoft Purview:

- DLP policies appear under **Data Loss Prevention** and can be adjusted there as needed.
- Sensitivity labels and label policies are managed in **Information Protection**.
- Communication Compliance and retention policies are configured in their respective areas.

You can choose to start from DSPM when you're looking for guidance or recommendations. If you're already familiar with the tools, you can go directly to the appropriate section to create or update policies.

This flexibility lets you decide how to incorporate DSPM into your workflow. DSPM for AI is useful for identifying risks in Microsoft 365 Copilot activity, but enforcement and customization happen in the solution areas that manage each policy.

Managing AI security risks requires tools that provide visibility, enforce policies, and prevent data exposure. **Microsoft Purview Data Security Posture Management (DSPM) for AI** helps organizations secure AI interactions, monitor AI-generated content, and ensure compliance with regulatory requirements.

It provides visibility into AI activity, security policies for AI interactions, and compliance controls to manage AI-related risks.

## Capabilities of Data Security Posture Management (DSPM) for AI

### AI insights and analytics

DSPM for AI provides visibility into how AI tools interact with organizational data. It provides:

- Identify which AI tools are in use, including Microsoft 365 Copilot and non-Microsoft AI services
- Insights into data exposure risks in AI-generated content
- Reports to help assess compliance and security posture

### Security policies for AI usage

DSPM for AI includes security policies that help prevent unauthorized data exposure in AI interactions. Policies can:

- Detect when users share sensitive data with AI tools
- Block or warn users before sharing regulated or confidential data
- Apply sensitivity labels and data loss prevention policies to AI-generated content

### Data assessments

DSPM for AI runs **weekly data assessments** for the top 100 SharePoint sites used by Copilot. These assessments help identify:

- Data that is frequently accessed or overshared
- Files containing sensitive information that might be exposed through AI
- Content missing appropriate labeling or governance controls

Organizations can also create custom assessments to scan specific users or sites for potential data exposure risks.

### Compliance controls

To support regulatory and security requirements, DSPM for AI integrates with other Microsoft Purview solutions, including:

- **[Sensitivity labels](/purview/sensitivity-labels?azure-portal=true)** to classify and protect AI-referenced data
- **[Data classification](/purview/data-classification-overview?azure-portal=true)** to apply security controls based on content type
- **[Customer Key](/purview/customer-key-overview?azure-portal=true)** for encryption with customer-managed keys
- **[Communication compliance](/purview/communication-compliance-solution-overview?azure-portal=true)** to detect risky AI interactions
- **[Auditing](/purview/audit-solutions-overview?azure-portal=true)** and **[eDiscovery](/purview/ediscovery?azure-portal=true)** for tracking AI activity and managing investigations

## Get started with DSPM for AI

To start using DSPM for AI:

- **Access the Microsoft Purview Portal**: Navigate to DSPM for AI from the Microsoft Purview portal or Microsoft Purview compliance portal.
- **Review AI activity insights**: Identify AI usage patterns and potential data security risks.
- **Activate preconfigured security policies**: Enable built-in policies to monitor and control AI interactions.
- **Run data assessments**: Evaluate AI-related data exposure risks and implement remediation actions.
- **Monitor compliance reports**: Use AI activity logs, security alerts, and policy reports to track AI risks over time.

DSPM for AI helps organizations manage AI-related security and compliance risks by applying the same security principles to AI-generated content as other enterprise data.

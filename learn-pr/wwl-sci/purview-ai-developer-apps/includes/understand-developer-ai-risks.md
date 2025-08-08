Developers are increasingly using tools like Copilot Studio, Azure AI services, Copilot in Fabric, and Microsoft Entra-registered apps. These environments offer powerful capabilities but also introduce new data security and compliance risks. From unsecured data access to ungoverned AI responses, a single misconfigured agent or prompt can result in sensitive data exposure or regulatory violations.

AI agents and apps created in development environments can ingest, generate, and share sensitive information based on user inputs and backend data sources. Several factors make these environments uniquely risky:

- Prompt injection attacks can exploit unfiltered input to manipulate an agent's behavior.
- AI agents might access and return data they shouldn't, especially if their permissions are too broad.
- Files used in development might lack sensitivity labels or encryption, leaving them unprotected.
- Custom apps registered through Microsoft Entra ID or deployed using Azure AI services might fall outside the visibility of traditional security tools if not onboarded to Microsoft Purview.

These environments include any tools or platforms where developers or makers build, configure, or extend AI-powered apps, whether through low-code, custom code, or Microsoft Entra-registered interfaces.

## Understand the challenge

The pace and flexibility of AI development environments can create gaps in visibility and control. Unlike traditional IT-managed systems, these tools often operate in decentralized or low-code platforms where safeguards aren't consistently applied. This creates risk not only during deployment but also during early development and testing phases.

## Establish safeguards across development environments

To reduce these risks, organizations need clear safeguards across the environments where AI is built and deployed. These safeguards include:

- Discovering which apps, agents, and services are in use and what data they interact with
- Applying sensitivity labels, encryption, and data loss prevention policies to consistently protect content
- Detecting prompt misuse or unauthorized access using analytics and risk signals
- Retaining, auditing, and classifying AI interactions to meet compliance obligations

## Use Microsoft Purview to apply protections

Microsoft Purview provides tools that support data security and compliance across AI development environments, as long as those environments are correctly configured and supported:

- **Data Security Posture Management (DSPM) for AI** is the central entry point. It helps identify which AI apps and agents are active across your organization. This includes agents built with Copilot Studio, apps registered through Microsoft Entra ID, and solutions deployed using Azure AI services. It can also surface activity from agents that interact with non-Microsoft AI websites in supported browsers.

- **Sensitivity labels** can protect content used during development when agents interact with labeled files in supported services such as SharePoint or OneDrive. In some environments, like Copilot Studio agents that access SharePoint, labels can determine whether the agent is allowed to summarize or return content.

- **Data Loss Prevention (DLP) policies** help prevent unsafe agent behavior involving sensitive data. For example, policies can restrict agents from summarizing labeled files or block users from pasting sensitive content into prompts when using browser-based AI tools.

- **Auditing and risk detection** features help capture agent interactions and identify possible misuse. These signals become available when agent activity is logged through supported Microsoft 365 services or DSPM collection policies.

- **Retention and eDiscovery** features help meet compliance requirements by preserving prompts and responses for later search and investigation. These capabilities apply when interactions are stored in Exchange Online or other supported data sources.

## Support secure development without slowing innovation

These tools allow organizations to apply consistent safeguards across AI development environments. When agents and apps are registered, integrated, and onboarded to Microsoft Purview, these protections help ensure AI usage aligns with security and compliance standards.

By focusing on visibility, protection, detection, and compliance, organizations can support responsible AI usage from development through deployment.

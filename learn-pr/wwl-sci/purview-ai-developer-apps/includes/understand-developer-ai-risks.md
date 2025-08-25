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

To reduce these risks, organizations should take these actions across AI development environments:

- **Discover apps and agents** in use and identify the data they access
- **Apply sensitivity labels and DLP policies** to protect sensitive files and restrict unsafe AI interactions
- **Detect risky behavior** such as prompt misuse or unauthorized access using analytics and risk signals
- **Preserve and investigate interactions** with retention, audit, and eDiscovery to meet compliance requirements

### Use Microsoft Purview to apply protections

Microsoft Purview provides the tools to put these safeguards into practice. **DSPM for AI** gives visibility into which apps and agents are active, while **auditing and risk detection** capture interactions and surface potential misuse. To protect sensitive content, admins can apply **sensitivity labels** and **DLP policies**. **Retention policies** preserve prompt and response data for compliance, while **eDiscovery** supports search and investigation of that data when required.

## Support secure development without slowing innovation

These tools allow organizations to apply consistent safeguards across AI development environments. When agents and apps are registered, integrated, and onboarded to Microsoft Purview, these protections help ensure AI usage aligns with security and compliance standards.

By focusing on visibility, protection, detection, and compliance, organizations can support responsible AI usage from development through deployment.

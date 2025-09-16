Developers are increasingly using tools like Copilot Studio, Azure AI services, Copilot in Fabric, and Microsoft Entra-registered apps. These environments unlock new capabilities but also create security and compliance risks if safeguards aren't applied. From unsecured data access to ungoverned AI responses, a single misconfigured agent or prompt can result in sensitive data exposure or regulatory violations.

AI agents and apps created in development environments can ingest, generate, and share sensitive information based on user inputs and backend data sources. Several factors make these environments uniquely risky:

- Prompt injection attacks can exploit unfiltered input to manipulate an agent's behavior.
- AI agents might access and return data they shouldn't, especially if their permissions are too broad.
- Files used in development might lack sensitivity labels or encryption, leaving them unprotected.
- Custom apps registered through Microsoft Entra ID or deployed using Azure AI services might fall outside the visibility of traditional security tools if not onboarded to Microsoft Purview.

These environments include any tools or platforms where developers or makers build, configure, or extend AI-powered apps, whether through low-code, custom code, or Microsoft Entra-registered interfaces.

## Understand the challenge

The pace and flexibility of AI development often create gaps in visibility and control. Unlike traditional IT-managed systems, these tools run in decentralized or low-code platforms where safeguards aren't consistently applied. That introduces risk not only during deployment but also in early development and testing.

## Establish safeguards across development environments

To reduce these risks, organizations should take these actions across AI development environments:

- **Discover apps and agents** to identify the data they access
- **Apply sensitivity labels and DLP policies** so sensitive files and unsafe interactions are protected
- **Detect risky behavior** such as prompt misuse or unauthorized access using Purview analytics
- **Preserve and investigate interactions** with retention, audit, and eDiscovery to meet compliance needs

### Use Microsoft Purview to apply protections

Once risks are identified, Microsoft Purview provides the tools to apply consistent safeguards across development environments. **DSPM for AI** gives visibility into which apps and agents are active, while **auditing and risk detection** capture interactions and surface potential misuse. To protect sensitive content, admins can apply **sensitivity labels** and **DLP policies**. **Retention policies** preserve prompt and response data for compliance, while **eDiscovery** supports search and investigation of that data when required.

## Support secure development without slowing innovation

These tools let organizations apply consistent safeguards across AI development environments. By focusing on visibility, protection, detection, and compliance, organizations can support secure development without slowing innovation.

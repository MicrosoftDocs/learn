Microsoft Security Copilot provides both an immersive standalone experience and intuitive embedded experiences within other Microsoft security products, enhancing your security operations. In addition, Security Copilot offers developer scenarios that enable you to build, test, publish, and integrate agents and plugins to meet unique security needs.

### Standalone experience
Access Security Copilot directly at [securitycopilot.microsoft.com](https://securitycopilot.microsoft.com) for a comprehensive, independent experience. This platform allows security professionals to apply the full capabilities of Security Copilot in one place.

### Embedded experience
Utilize Security Copilot within other Microsoft security products to gain context-specific functionalities seamlessly integrated into your existing workflows. For example, within Microsoft Defender XDR, you can access features like incident summarization or script analysis directly.

A feature common to all embedded experiences is the ability to hide or show the Copilot sidecar panel. The panel behavior persists per embedded experience, remembering the user's option. The embedded copilot functionality remains the same whether it's hidden or not, so closing the panel doesn't affect SCU consumption.

> [!NOTE]
> For detailed guidance on specific embedded experiences, refer to the documentation library of the corresponding service. For instance, if using Security Copilot within Microsoft Defender XDR, the relevant guidance can be found in the Microsoft Defender XDR documentation.

### Available Embedded Experiences

The following table lists the available embedded experiences.

| Product | Embedded experience |
|---------|-------------------|
| **Azure Firewall** | Enrich threat profiles of IDPS signatures, generate recommendations to secure your environment, look for IDPS signatures across your tenant, and retrieve top IDPS signature hits |
| **Microsoft Defender for Cloud** | Analyze recommendations, delegate recommendations, remediate code, remediate recommendations, and summarize recommendations |
| **Microsoft Defender Threat Intelligence** | Use Copilot for advanced threat intelligence capabilities for proactive security measures |
| **Microsoft Defender XDR** | Summarize incidents, analyze scripts and codes, generate KQL queries for hunting, use guided response, create incident reports, summarize device information, summarize identities, and analyze files |
| **Microsoft Entra** | Investigate risky users, investigate app risk, investigate incidents, and manage lifecycle workflows |
| **Microsoft Intune** | Device query, policy and setting management, and troubleshoot devices |
| **Microsoft Purview** | Investigate Data Loss Prevention alerts, summarize Communication Compliance messages, investigate insider risk management activities, and summarize eDiscovery messages |
| **Microsoft Sentinel** | Summarize Microsoft Sentinel incidents |

### Agents

Security Copilot supports autonomous AI agents that handle high-volume security tasks across Microsoft security products. Agents are available in both the standalone and embedded experiences, helping teams address common security and IT challenges faster. You can discover agents from the agent library in the standalone experience or within the embedded portals. Visit the [Microsoft Security Store](https://securitystore.microsoft.com/) to browse Microsoft and partner-built agents.

### Plugins and Integrations

Security Copilot extends its capabilities through plugins from Microsoft and third-party security products. These plugins bring extra context from event logs, alerts, incidents, and policies. Integrations with services like ServiceNow enhance the functionality and contextual awareness of Security Copilot, making it a versatile tool in your security arsenal.

### Developer Scenarios

Security Copilot supports developer scenarios for organizations seeking to extend, automate, or integrate security workflows. Developer scenarios empower you to build custom agents and plugins to automate security tasks, integrate Security Copilot with other Microsoft security products, and build, publish, test, and manage agents tailored to your organization's needs.

### Operational Workflow

1. **User Prompts:** Security products send user prompts to Security Copilot.
2. **Preprocessing:** Security Copilot refines these prompts using plugins before forwarding them to the language model.
3. **Response Generation:** The language model generates responses, which are then enhanced with contextual information through plugins.
4. **Response Delivery:** Users receive and review the refined responses.
5. **Iterative Processing:** Security Copilot continuously processes and orchestrates these services to deliver relevant, actionable insights based on your organizational data.

By using these capabilities, Microsoft Security Copilot significantly enhances the efficiency and effectiveness of security professionals, ensuring robust protection against evolving threats.

For more detailed guidance, visit the [Microsoft Security Copilot documentation](/copilot/security/experiences-security-copilot).

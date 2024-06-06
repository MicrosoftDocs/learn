Microsoft Copilot for Security provides both an immersive standalone experience and intuitive embedded experiences within other Microsoft security products, enhancing your security operations.

**Standalone Experience**  
Access Copilot for Security directly at [securitycopilot.microsoft.com](https://securitycopilot.microsoft.com) for a comprehensive, independent experience. This platform allows security professionals to apply the full capabilities of Copilot for Security in one place.

**Embedded Experience**  
Utilize Copilot for Security within other Microsoft security products to gain context-specific functionalities seamlessly integrated into your existing workflows. For example, within Microsoft Defender XDR, you can access features like incident summarization or script analysis directly.

> [!NOTE]
> For detailed guidance on specific embedded experiences, refer to the documentation library of the corresponding service. For instance, if using Copilot for Security within Microsoft Defender XDR, the relevant guidance can be found in the Microsoft Defender XDR documentation.

### Available Embedded Experiences

#### Microsoft Defender XDR
- **Summarize Incidents:** Quickly generate summaries of security incidents.
- **Analyze Scripts and Codes:** Automatically interpret and analyze scripts and code snippets.
- **Generate KQL Queries for Hunting:** Create KQL queries to help threat hunting.
- **Use Guided Response:** Receive step-by-step instructions for incident response.
- **Create Incident Reports:** Compile comprehensive reports on security incidents.
- **Summarize Device Information:** Get detailed summaries of device status and activity.
- **Analyze Files:** Perform in-depth file analysis to identify potential threats.

#### Microsoft Entra
- **Investigate Risky Users:** Identify and analyze users with suspicious activity.

#### Microsoft Intune
- **Policy and Setting Management:** Manage and enforce security policies across devices.
- **Troubleshoot Devices:** Use Microsoft Copilot to diagnose and resolve device issues.

#### Microsoft Purview
- **Investigate Data Loss Prevention Alerts:** Examine alerts to prevent data breaches.
- **Summarize Communication Compliance Messages:** Generate summaries of compliance-related messages.
- **Investigate Insider Risk Management Activities:** Analyze activities related to insider threats.
- **Summarize eDiscovery Messages:** Create summaries of messages within eDiscovery cases.

#### Microsoft Defender Threat Intelligence
- **Use Copilot for Threat Intelligence:** Use advanced threat intelligence capabilities for proactive security measures.

### Plugins and Integrations

Copilot for Security extends its capabilities through plugins from Microsoft and third-party security products. These plugins bring extra context from event logs, alerts, incidents, and policies. Integrations with services like ServiceNow enhance the functionality and contextual awareness of Copilot for Security, making it a versatile tool in your security arsenal.

### Operational Workflow

1. **User Prompts:** Security products send user prompts to Copilot for Security.
2. **Preprocessing:** Copilot for Security refines these prompts using plugins before forwarding them to the language model.
3. **Response Generation:** The language model generates responses, which are then enhanced with contextual information through plugins.
4. **Response Delivery:** Users receive and review the refined responses.
5. **Iterative Processing:** Copilot for Security continuously processes and orchestrates these services to deliver relevant, actionable insights based on your organizational data.

By using these capabilities, Microsoft Copilot for Security significantly enhances the efficiency and effectiveness of security professionals, ensuring robust protection against evolving threats.

For more detailed guidance, visit the [Microsoft Copilot for Security documentation](/copilot/security/experiences-security-copilot).

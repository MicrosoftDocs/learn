Microsoft Defender agents are AI-powered tools designed to enhance the efficiency of security operations. These agents integrate seamlessly with Microsoft Security Copilot to help security engineers address challenges like phishing, threat intelligence, and incident response.

## Understand the role of Microsoft Defender agents
Microsoft Defender agents serve as virtual assistants that automate and streamline various security tasks. By leveraging AI capabilities, these agents reduce manual effort and improve decision-making in security operations. They work in conjunction with Microsoft Security Copilot to provide:

- Automated analysis and classification of security incidents.
- Transparent reasoning for decisions made by the agents.
- Continuous learning and improvement based on user feedback.

> [!NOTE]
> Microsoft Defender agents are embedded within the Microsoft Defender portal, ensuring seamless integration with other Microsoft security products.

## Identify key Microsoft Defender agents and their use cases
Microsoft Defender includes specialized agents tailored for specific security tasks. Two notable examples are:

- **Phishing Triage Agent**: This agent helps security teams classify and triage user-reported phishing incidents. It autonomously determines whether an email is a phishing attempt or a false alarm using advanced AI models. By reducing false positives, it allows teams to focus on high-priority threats.
- **Threat Intelligence Briefing Agent**: While not explicitly detailed in the provided documents, this type of agent typically assists in gathering and analyzing threat intelligence to inform proactive security measures.

The Phishing Triage Agent, for instance, operates autonomously and provides natural language explanations for its decisions. It continuously learns from analyst feedback, improving its accuracy over time.

## Set up and configure Microsoft Defender agents
To set up Microsoft Defender agents, follow these steps:

1. **Provision capacity**: Ensure your organization has an active subscription to Security Copilot and sufficient Security Compute Units (SCU) to power the workload.
2. **Enable required plugins**: Activate plugins such as Microsoft Defender XDR, Microsoft Threat Intelligence, and the specific agent (e.g., Phishing Triage Agent).
3. **Configure permissions**: Enable Unified Role-Based Access Control (URBAC) and set up necessary alert policies, such as "Email reported by user as malware or phish."

For more details, refer to the [Get started with Security Copilot](https://learn.microsoft.com/copilot/security/get-started-security-copilot) guide.

## Analyze outputs from Microsoft Defender agents
Microsoft Defender agents generate actionable insights and reports to aid security decision-making. For example, the Phishing Triage Agent provides:

- Classification verdicts with transparent reasoning.
- Visual representations of its decision-making process.
- Continuous updates based on feedback to align with organizational needs.

These outputs help security engineers prioritize and respond to incidents effectively.

## Integrate Microsoft Defender agents with other security tools
Microsoft Defender agents can be integrated with other security tools to create a unified security approach. Key integrations include:

- **Microsoft Entra**: Enhance identity and access management by linking Defender agents with Entra’s capabilities.
- **Microsoft Defender XDR**: Use extended detection and response features to correlate data across endpoints, emails, and other sources.

By connecting these tools, organizations can achieve a comprehensive security posture, streamlining workflows and improving threat detection.

> [!TIP]
> Ensure all required plugins and configurations are enabled to maximize the effectiveness of these integrations.

Phishing remains one of the most common ways attackers gain initial access. It also represents one of the highest-volume challenges security operations center (SOC) teams face, due to the large number of user-reported suspicious emails that must be investigated daily.

The Phishing Triage Agent addresses this challenge by automating the triage and classification of phishing incidents, enabling security teams to focus on higher-priority tasks.

The Phishing Triage Agent is an AI-powered assistant integrated into Microsoft Defender. When a user submits a suspicious email, the agent evaluates the content and determines whether it is a phishing attempt or a false alarm. This process helps streamline incident management, reduces manual effort, and enhances decision making. Some of the agent’s highlights are as follows:

- Operates autonomously. The Phishing Triage Agent leverages advanced AI tools to perform sophisticated assessments and determine whether a phishing submission is a real threat or a false alarm, without requiring step-by-step human input or code.
- Provides a transparent rationale for its classification verdicts in natural language, including the reasoning behind its decisions and the evidence it used to arrive at those conclusions. It also shows a visual representation of its reasoning process for every decision.
- Continuously learns and improves its accuracy based on feedback provided by analysts. Over time, this feedback loop fine-tunes the agent’s behavior, aligning it more closely with organizational nuances and reducing the need for manual verification.

The Phishing Triage Agent uses advanced large language model (LLM)-based analysis to understand the content of reported emails and autonomously determine whether a submission is a genuine phishing attempt or a false alarm. Unlike rule-based systems, it doesn't rely on predefined input or code to operate. Instead, it applies dynamic reasoning to analyze and act on incoming reports at scale.

### Information about the agent and prerequisites

The Phishing Triage Agent, which is available in Microsoft Defender XDR as part of the Copilot embedded experience, is characterized as follows:

- **Trigger**: The agent is triggered when a user in your organization submits a phishing incident. The agent autonomously analyzes the submitted email to classify them as either phishing or not phishing based on its training and the context of the organization.
- **Permissions**: This agent can read data from Defender XDR adn Microsoft Threat Intelligence.
- **Identity**: Connection to an existing user account.
- **Products**: Microsoft Defender for Office 365 Plan 2 and Microsoft Security Copilot with provisioned capacity is necessary to run the agent.  The following Microsoft Defender capabilities are required:
  - Unified role-based access control (URBAC) must be enabled for managing permissions.
  - The *Monitor reported messages in Outlook* must be enabled in the User reported settings page.
  - Enable the "Email reported by user as malware or phish" alert policy.
- **Plugins**: The following plugins must be enabled in Security Copilot:
  - Microsoft Defender XDR
  - Microsoft Threat Intelligence
  - Phishing Triage Agent
- **Role-based access**: Owners and contributors can view generated reports within the agent library page.

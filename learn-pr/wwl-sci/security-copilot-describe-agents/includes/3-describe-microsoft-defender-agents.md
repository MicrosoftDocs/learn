
Phishing remains one of the most common ways attackers gain initial access. It also represents one of the highest-volume challenges security operations center (SOC) teams face, due to the large number of user-reported suspicious emails that must be investigated daily.

The Phishing Triage Agent is an AI-powered assistant integrated into Microsoft Defender. When a user submits a suspicious email, the agent evaluates the content and determines whether it is a phishing attempt or a false alarm. This process helps streamline incident management and reduces manual effort. Some of the agent’s highlights include:

- It operates autonomously. The Phishing Triage Agent leverages advanced AI tools to perform sophisticated assessments and determine whether a phishing submission is a real threat or a false alarm, without requiring step-by-step human input or code.
- It provides a transparent rationale for its classification verdicts in natural language, including the reasoning behind its decisions and the evidence it used to arrive at those conclusions. It also shows a visual representation of its reasoning process for every decision.
- It continuously learns and improves its accuracy based on feedback provided by analysts. Over time, this feedback loop fine-tunes the agent’s behavior, aligning it more closely with organizational nuances and reducing the need for manual verification.

The Phishing Triage Agent uses advanced large language model (LLM)-based analysis to understand the content of reported emails and autonomously determine whether a submission is a genuine phishing attempt or a false alarm. Unlike rule-based systems, it doesn't rely on predefined input or code to operate. Instead, it applies dynamic reasoning to analyze and act on incoming reports at scale.

### Prerequisites

To deploy and use the Phishing Triage Agent effectively, your organization must meet the following requirements:

- Products:
  - An active subscription to Security Copilot and provisioned capacity in Security Compute Units (SCU) to power workloads.
  - Microsoft Defender for Office 365 Plan 2 must be deployed in your environment.

- Microsoft Defender features:
  - Unified role-based access control (URBAC) must be enabled for managing permissions. See [Unified role-based access control (URBAC)](/defender-xdr/manage-rbac) for more information.
  - The *Monitor reported messages in Outlook* must be enabled in the User reported settings page. See [User reported settings](/defender-office-365/submissions-user-reported-messages-custom-mailbox) for more information.
- Alert policy: Enable the "Email reported by user as malware or phish" alert policy. See [Alert policies in the Microsoft Defender portal](/defender-xdr/alert-policies) for more information.

#### Required plugins

The following plugins must be enabled in Security Copilot:

- Microsoft Defender XDR
- Microsoft Threat Intelligence
- Phishing Triage Agent

### Explain how the phishing triage agent improves SOC efficiency
Phishing remains one of the most common attack vectors, creating a significant workload for SOC teams. The Phishing Triage Agent addresses this challenge by automating the triage and classification of phishing incidents, enabling security teams to focus on higher-priority tasks.

- **Reduces manual workload**: By autonomously analyzing and classifying phishing submissions, the agent removes false alarms from the queue.
- **Accelerates response times**: Automation allows SOC teams to process hundreds or thousands of submissions quickly, ensuring critical incidents are addressed promptly.
- **Enhances decision-making**: Transparent reasoning and visual representations of the agent's decisions provide analysts with actionable insights.

By leveraging the Phishing Triage Agent, organizations can scale their phishing response capabilities, improve efficiency, and reduce the time spent on repetitive tasks.
Microsoft Security Copilot is a generative AI-powered security solution that brings together the power of AI and human expertise to help administrators and security teams respond to attacks faster and more effectively. Microsoft Entra is one of the Microsoft plugins that enable the Security Copilot platform to generate accurate and relevant information. Through the Microsoft Entra plugin, Security Copilot can help you investigate and resolve identity risks, assess identities and access with AI-driven intelligence, and complete complex tasks quickly.

Security Copilot gets insights from your Microsoft Entra users, groups, sign-in logs, audit logs, and more, while also providing contextualized insights and recommendations on security best practices. You can explore sign-ins and risky users, get contextualized insights on how to resolve incidents, and learn how to protect accounts using natural language. Built on top of real-time machine learning, Security Copilot can help you find gaps in access policies, generate identity workflows, and troubleshoot faster.

### Standalone and embedded experiences

Security Copilot in Microsoft Entra includes both a standalone experience and embedded experiences available in the Microsoft Entra admin center.

- **Standalone experience**: In the Security Copilot portal (securitycopilot.microsoft.com), you can use natural language prompts to investigate identity-related incidents. The Microsoft Entra plugin provides built-in capabilities (skills) that you can use, or you can enter your own prompts based on the capabilities supported. Example prompts include:
  - *Give me all user details for karita@woodgrovebank.com and extract the user Object ID.*
  - *List the recent risky sign-ins for karita@woodgrovebank.com.*
  - *Can you give me sign-in logs for karita@woodgrovebank.com for the past 48 hours? Put this information in a table format.*
  - *Get Microsoft Entra audit logs for karita@woodgrovebank.com for the past 72 hours.*

- **Embedded experience**: Within the Microsoft Entra admin center, Security Copilot capabilities are built directly into workflows. For example, the risky users' report in Identity Protection embeds Security Copilot capabilities to summarize a user's risk level, provide insights relevant to the incident at hand, and provide recommendations for rapid mitigation.

:::image type="content" source="../media/entra-risky-users-summarize-v2.png" lightbox="../media/entra-risky-users-summarize-v2.png" alt-text="Screen capture showing the Copilot generated summary of a risky user in Microsoft Entra.":::

### Microsoft Entra scenarios supported by Security Copilot

Security Copilot supports a wide range of identity and access management scenarios across multiple Microsoft Entra products. The following describes the product areas and the types of tasks you can accomplish using Security Copilot in Microsoft Entra.

- **Microsoft Entra ID**—Quickly retrieve and manage user, group, domain, and license information. Investigate sign-in logs and audit logs to identify suspicious activity. Explore Conditional Access policies, authentication methods, device details, and role assignments. Security Copilot can also surface Microsoft Entra recommendations and health monitoring alerts.

- **Microsoft Entra ID Protection**—Summarize a user's risk level, investigate risk detections, and get remediation recommendations. You can also assess application risk by analyzing workload identities and permissions.

- **Microsoft Entra ID Governance**—Analyze access review data and decision patterns, manage access packages in entitlement management, monitor privileged access through Privileged Identity Management (PIM), and configure or troubleshoot lifecycle workflows.

### Microsoft Entra agents

Security Copilot supports specialized agents that automate repetitive identity and access management tasks and reduce manual workloads for administrators. These agents analyze your identity environment, apply best practices, and take automated actions to improve your identity security posture and operational efficiency. Each agent is grounded in a specific product area and can run on a schedule, be triggered manually, or both.

Currently, the following Microsoft Entra agents are available:

- **Access Review Agent**—Empowers reviewers to make fast and accurate access decisions. Working with Microsoft Entra ID Governance, this agent delivers insights and recommendations so reviewers can complete their work through a simple conversation directly inside Microsoft Teams. The agent scans the tenant for active access reviews, gathers additional context, and saves recommendations and justifications for the reviewer. Final decisions, submitted through the Teams conversation, use the reviewer's identity.

- **Conditional Access Optimization Agent**—Ensures comprehensive user protection by analyzing Conditional Access policies and recommending improvements. The agent evaluates the current policy configuration against Microsoft best practices and Zero Trust principles, identifying gaps, overlap, and misconfigurations.

- **Identity Risk Management Agent (Preview)**—Helps administrators investigate potential risks in Microsoft Entra ID Protection, learn about potential effects, and take decisive action to protect the organization's critical assets.

Each agent uses a unique agent identity created when the agent is turned on. The agent identity is granted specific read and write permissions needed to perform its tasks. Administrators configure and manage agents through the Microsoft Entra admin center under the **Agents** section. Discovery of Microsoft and partner-built agents is also available through the Security Store, which is embedded directly in the Microsoft Entra admin center.

### Providing feedback

Copilot in Microsoft Entra uses AI and machine learning to process data and generate responses. AI-generated content might be incorrect. All Security Copilot features include an option for submitting feedback through thumbs up and thumbs down icons. Your feedback on the generated responses helps improve the accuracy of Copilot and Microsoft Entra over time.

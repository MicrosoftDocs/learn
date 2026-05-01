Microsoft Entra is one of the Microsoft plugins that enable the Security Copilot platform to generate accurate and relevant information. Through this plugin, Security Copilot can help you investigate and resolve identity risks, assess identities and access with AI-driven intelligence, and complete complex tasks quickly. Security Copilot gets insights from your Microsoft Entra users, groups, sign-in logs, audit logs, and more, while also providing contextualized insights and recommendations in security best practices.

> [!NOTE]
> The list of Copilot capabilities embedded in Microsoft Entra is continually growing. This unit provides just a sampling of those capabilities. For more information, see the documentation on Security Copilot in Microsoft Entra.

### Getting started

Before you use Copilot in Microsoft Entra, your organization must be onboarded to Security Copilot, the Microsoft Entra plugin must be enabled, and users must have the appropriate role permissions. Copilot assumes the permissions of the current user when it tries to access data, so you need the required roles to access the relevant Microsoft Entra data.

Security Copilot is accessible in the Microsoft Entra admin center through a globally available button in the menu bar. You can choose from a set of starter prompts that appear at the top of the Security Copilot window or enter your own natural language queries in the prompt bar. Suggested prompts, which can appear after a response, are predefined prompts that Security Copilot selects based on the prior response.

Security Copilot scenarios in Microsoft Entra span multiple product areas, each covering specific use cases for identity security and administration:

- **Microsoft Entra ID** – Enterprise user management, sign-in and audit log analysis, Conditional Access evaluation, and more.
- **Microsoft Entra ID Protection** – Risky user investigation and application risk assessment.
- **Microsoft Entra ID Governance** – Access reviews, entitlement management, Privileged Identity Management (PIM), and lifecycle workflows.
- **Microsoft Entra Internet Access and Private Access** – Global Secure Access network traffic analysis.

### Microsoft Entra ID scenarios

Microsoft Entra ID is the foundational product of Microsoft Entra, and provides the essential identity, authentication, policy, and protection to secure users, devices, apps, and resources. Security Copilot enhances these capabilities across multiple areas:

- **Enterprise user management**: Quickly retrieve and investigate user, group, domain, and license information using natural language. For example, you can ask Copilot to list all users in a specific department, identify ownerless groups, or check the licenses assigned to your tenant.
- **Sign-in and audit log analysis**: Investigate sign-in failures and suspicious activity by querying sign-in logs, audit logs, and provisioning logs. For example, you can ask Copilot for sign-in logs for a specific user over the past 48 hours or audit logs in table format.
- **Conditional Access**: Understand and evaluate Conditional Access policies using natural language prompts. Copilot helps you find gaps in access policies and troubleshoot policy configurations faster.
- **Authentication**: Discover enabled authentication methods, registration status, and overall authentication strategy for your tenant or specific users.
- **Roles and administrators**: Investigate role assignments within your directory to ensure proper role-based access control.
- **Recommendations and health monitoring**: Get insights from Microsoft Entra recommendations and health monitoring alerts to proactively improve your security posture.
- **Devices**: Explore device details and compliance status registered in Microsoft Entra.

### Microsoft Entra ID Protection scenarios

Microsoft Entra ID Protection focuses on identity risk detection and remediation. Security Copilot provides AI-powered insights for:

- **Risky user investigation**: Security Copilot summarizes a user's risk level, provides insights relevant to the incident at hand, and provides recommendations for rapid mitigation. This helps reduce the time to resolution by giving IT admins and SOC analysts the right context to investigate and remediate identity risk incidents.

    :::image type="content" source="../media/entra-risky-users-summarize-v2.png" lightbox="../media/entra-risky-users-summarize-v2.png" alt-text="Screen capture showing the Copilot generated summary of a risky user.":::

    You can use natural language prompts to list or identify users based on risk, get user-specific risk information, and review user risk history.

- **Application risk assessment**: Identity admins and security analysts can assess risk from workload identities by using natural language prompts. By using prompts like "List risky app details for my tenant," you can discover permissions granted (especially high privileged permissions), unused apps, apps from outside your tenant, and the risk level of applications. App risk starter prompts appear in application-related admin center blades such as **Enterprise apps**, **App Registrations**, and **Identity Protection Risky workload identities**.

### Microsoft Entra ID Governance scenarios

Microsoft Entra ID Governance helps you manage identity lifecycle and access governance at scale. Security Copilot enhances these capabilities in the following areas:

- **Access reviews**: Extract and analyze access review data using natural language. You can understand who approved access, identify reviewers who took no decisions, and investigate overrides of AI recommendations.
- **Entitlement management**: Interact with entitlement management data to query access packages, policies, connected organizations, and catalog resources without custom scripting.
- **Privileged Identity Management (PIM)**: Monitor and manage privileged access using natural language queries. You can get insights into just-in-time role assignments, track changes, and rapidly respond to potential risks. PIM write actions also allow you to activate the least-privileged role needed for a task directly within a Copilot conversation, without manually navigating away.
- **Lifecycle workflows**: Configure custom workflows to manage the lifecycle of users across joiner, mover, and leaver (JML) scenarios. Copilot helps you create step-by-step guidance for new workflows, explore available configurations, analyze the active workflow list, troubleshoot workflow runs, and compare workflow versions.

### Microsoft Entra Internet Access and Private Access scenarios

Security Copilot integrates with Global Secure Access to enable network traffic analysis using natural language queries. Network administrators and security teams can analyze user, device, and branch network usage, identify network issues, and detect threats or policy violations in real time. Use cases include monitoring data consumption and bandwidth usage, investigating blocked traffic and security threats, analyzing user application access patterns, and monitoring cross-tenant access and external connections.

### Data exploration

Security Copilot supports a data exploration feature for Microsoft Entra scenarios. When prompts return datasets with more than 10 items, you can select **Open list** from the Copilot chat response to access a comprehensive data grid. This allows you to explore large datasets with complete and accurate results for more efficient decision-making. Each data grid displays the underlying Microsoft Graph URL, helping you verify query accuracy.

### Feedback

Copilot in Microsoft Entra uses AI and machine learning to process data and generate responses. However, AI-generated content might be incorrect. Your feedback on generated responses helps improve the accuracy of Copilot over time. All key features include an option for providing feedback through thumbs up and thumbs down icons.

:::image type="content" source="../media/entra-feedback.png" lightbox="../media/entra-feedback.png" alt-text="Screen capture showing the feedback menu.":::

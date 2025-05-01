Microsoft Entra agents play a crucial role in identity and access management by automating repetitive tasks, enhancing security operations, and integrating seamlessly with Microsoft Security Copilot. This learning unit introduces the purpose, features, and setup of Microsoft Entra agents, tailored for beginner-level security engineers.

## Define Microsoft Entra agents and their purpose
Microsoft Entra agents are designed to automate high-volume, time-consuming tasks in identity and access management. They integrate with [Microsoft Security Copilot](https://learn.microsoft.com/copilot/security/microsoft-security-copilot) to enhance operational efficiency and reduce manual workloads. These agents:

- Automate repetitive tasks like policy evaluation and threat intelligence briefings.
- Provide actionable recommendations based on best practices, such as Zero Trust principles.
- Help security teams focus on strategic initiatives by handling routine operations.

By leveraging AI-driven insights, Microsoft Entra agents enable organizations to scale their security processes and respond swiftly to emerging threats.

## Describe key features of Microsoft Entra agents
Microsoft Entra agents offer several capabilities that improve identity and access management. Key features include:

- **Identity risk investigation**: Analyze potential risks associated with user identities.
- **Sign-in troubleshooting**: Identify and resolve issues related to user sign-ins.
- **Audit log analysis**: Review and interpret audit logs for better compliance and security.
- **Policy recommendations**: Suggest Conditional Access policies aligned with Zero Trust principles.

The Conditional Access optimization agent, for example, evaluates policies requiring multifactor authentication (MFA), enforces device-based controls, and blocks legacy authentication methods.

:::image type="content" source="../media/conditional-access-optimization-agent-overview.png" alt-text="Screenshot showing the Conditional Access Optimization Agent enabled in an organization.":::

> [!NOTE]
> Newly created policies by the agent are initially set to report-only mode, allowing administrators to review their impact before full implementation.

## Explain how to use Microsoft Entra agents for identity threat response
To address identity threats effectively, Microsoft Entra agents leverage AI-driven insights to:

- Detect unprotected users or risky configurations.
- Recommend new Conditional Access policies or updates to existing ones.
- Enable administrators to review and approve suggested changes before implementation.

For example, the Conditional Access optimization agent runs every 24 hours and provides detailed suggestions for improving policy coverage. Administrators can evaluate these suggestions and implement them to mitigate identity risks.

## Summarize the integration of Security Copilot with Microsoft Entra
Security Copilot enhances Microsoft Entra agents by providing contextualized insights and actionable recommendations. This integration allows:

- Seamless automation of security tasks, such as policy optimization and threat detection.
- Improved scalability and resilience in security operations.
- Enhanced collaboration between security tools and IT workflows.

By combining data and AI language models, Security Copilot ensures that Microsoft Entra agents operate efficiently and adapt to organizational needs.

## Identify prerequisites and setup steps for Microsoft Entra agents
To get started with Microsoft Entra agents, ensure the following prerequisites are met:

- Assign the [Security Administrator](https://learn.microsoft.com/entra/identity/role-based-access-control/permissions-reference#security-administrator) or [Global Administrator](https://learn.microsoft.com/entra/identity/role-based-access-control/permissions-reference#global-administrator) role.
- Have at least a Microsoft Entra ID P1 license.
- Ensure availability of [security compute units (SCU)](https://learn.microsoft.com/copilot/security/manage-usage).
- For device-based controls, obtain [Microsoft Intune licenses](https://learn.microsoft.com/intune/intune-service/fundamentals/licenses).

### Setup steps
1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) with the required administrator role.
2. Navigate to the **Agents** section from the home page.
3. Select the Conditional Access optimization agent and click **Start agent**.
4. Review the agent's suggestions and configure policies as needed.

> [!TIP]
> Use the **Custom Instructions** field to tailor the agent's behavior, such as excluding specific accounts from policy recommendations.
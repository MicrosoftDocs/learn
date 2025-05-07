Microsoft Entra agents are designed to automate repetitive tasks, enhance security operations, and integrate seamlessly into existing workflows. For Security Operations Analysts, these agents can significantly reduce manual workloads, allowing teams to focus on strategic initiatives and complex problem-solving.

The Conditional Access optimization agent, a Security Copilot Agent embedded in Microsoft Entra, ensures all users are protected by policy. It recommends policies and changes based on best practices aligned with Zero Trust and Microsoft's learnings. The agent provides the following functionality:

- Evaluates policies requiring multifactor authentication (MFA),
- Enforces device based controls (device compliance, app protection policies, and Domain Joined Devices), 
- Blocks legacy authentication and device code flow.

The agent runs every 24 hours or can be triggered manually. It operates under the permissions of the administrator who configures it and only acts upon approved suggestions.

:::image type="content" source="../media/conditional-access-optimization-agent-overview.png" alt-text="Screenshot showing the Conditional Access Optimization Agent enabled in an organization.":::

### Describe the prerequisites for using the Microsoft Entra Conditional Access optimization agent

To use the Conditional Access optimization agent, ensure the following prerequisites are met:

- **Roles**: You must have the Security Administrator or Global Administrator role.
- **Licenses**: At least a Microsoft Entra ID P1 license is required.
- **Resources**: Available Security Compute Units (SCUs) are necessary, with each agent run consuming less than one SCU.
- **Device-based controls**: Require Microsoft Intune licenses.

### Prerequisites

- You must be assigned the Security Administrator or Global Administrator role during the preview. These roles also have access to Security Copilot by default.
- You must have at least Microsoft Entra ID P1.
- You must have available security compute units (SCU). On average, each agent run consumes less than one SCU.
- Device-based controls require Microsoft Intune licenses.

### Getting started

Follow these steps to configure and run the Conditional Access optimization agent:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) with at least a Security Administrator role.
2. From the home page, select **Go to agents** from the agent notification card.
3. Under the Conditional Access Optimization Agent, select **View details** and then **Start agent**.
4. Review the agent overview page to see runtime schedules, performance highlights, and recent suggestions.
5. Evaluate suggestions, make edits, and review potential policy impacts before applying changes.
6. Newly created policies are set to report-only mode by default. Move the **Enable policy** toggle to **On** after evaluation.

:::image type="content" source="../media/conditional-access-optimization-start-agent.png" alt-text="Screenshot showing the Conditional Access Optimization Agent configuration page.":::


### Limitations

While the Conditional Access optimization agent offers significant benefits, it has some limitations:

- Agents cannot be stopped or paused once started.
- Each run evaluates only four similar policy pairs for consolidation.
- The agent runs under the identity of the user who enables it.
- During the preview, it should only be run from the Microsoft Entra admin center.

> [!NOTE]
> Use the **Remove agent** button in the agent window if you no longer wish to use the Conditional Access optimization agent.
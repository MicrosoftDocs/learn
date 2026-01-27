Some AI-assisted tasks can be completed quickly, while others require extended processing time. These longer tasks may involve gathering information from multiple sources, reasoning across data, or producing structured outputs over several steps.

To support this type of work, Windows 11 Pro uses AI agents that run using cloud execution. These agents allow tasks to continue independently in the background, while Windows maintains visibility and control through the taskbar.

By treating long-running cloud work as a first-class system activity, Windows enables users to stay productive without waiting for tasks to finish or managing separate application windows.

:::image type="content" border="true" source="../media/agents-on-taskbar.png" alt-text="A screenshot showing an agent working on the Windows taskbar.":::

## What are AI agents in Windows 11?

In Windows 11 Pro, an AI agent is a cloud-connected capability that can perform multi-step tasks on a user's behalf. These tasks may involve:

- Planning and reasoning over time
- Accessing approved data sources
- Producing outputs that require synthesis or analysis

Agents operate using cloud execution, allowing them to handle work that would be impractical to complete instantly or locally on a device.

Agents can include first-party agents, such as Microsoft 365 Copilot agents, and third-party agents, made available by an organization

>[!NOTE]
> A Microsoft 365 Copilot license is required to use built‑in agents like Researcher and Analyst.

## How agents appear and operate on the taskbar

When a user initiates an agent-based task—such as launching an agent from the Ask Copilot experience—the task transitions out of the interaction interface and continues running in the cloud.

Windows surfaces the agent on the taskbar as a dedicated icon, allowing users to:

- See that cloud-based work is in progress
- Continue working in other applications
- Return to the agent when needed

:::image type="content" border="true" source="../media/agents-on-the-taskbar-stages.svg" alt-text="A simple chart showing how users can continue working as their agents work on the taskbar.":::

## Monitoring long-running cloud tasks

Windows provides clear visibility into agent activity through the taskbar. From this familiar system interface, users can monitor cloud-based work without constant interaction.

Windows displays the status through:

- Visual indicators that show an agent is active
- Hover summaries that describe what the agent is working on
- Notifications when the agent needs attention or has completed its task

These signals allow users to stay informed while avoiding unnecessary interruptions.

By managing agent activity at the operating system level, Windows makes cloud execution transparent and predictable—helping users trust and rely on background AI work.

## Why agents rely on cloud execution

Agent-based tasks often require capabilities that benefit from cloud execution, including:

- **Extended processing time**, beyond what fits within a single interaction
- **Multi-step reasoning**, where outputs depend on intermediate results
- **Access to broader data sources**, such as organizational or web information
- **Scalable compute**, independent of device hardware

By running these tasks in the cloud, Windows 11 Pro can support complex workflows while keeping the local system responsive and focused on the user's active work.

## Security and control considerations

Agents in Windows 11 are designed to operate within defined boundaries. Agent experiences are built with:

- clear user visibility
- controlled permissions
- and safe execution models

This approach helps organizations balance productivity gains with security, compliance, and manageability requirements.

| **Security Area** | **How Windows implements it** | **Why it matters** |
| :---: | :---: | :---: |
| **User visibility** | Taskbar indicators, hover summaries, in workspace transparency | Users can see what agents are doing at all times, preventing hidden actions. |
| **Permission control** | Separate agent accounts, least privilege folder access, secure MCP connectors via Windows On Device Registry | Limits agent access to only what is necessary and ensures controlled integration with apps/tools. |
| **Safe execution models** | Agent Workspace (isolated environment), policy-controlled runtimes | Protects user workflows and system stability by containing agent actions. |
| **AI specific threat protection** | Hardened MCP communication, guardrails against prompt injection, continuous auditing | Reduces risks unique to agentic AI, such as cross prompt injection or unintended automation. |
| **Enterprise governance** | Integration with Purview, sensitivity labels, DLP, audit trails | Ensures agent activity aligns with organizational compliance and data protection policies |

Azure SRE Agent combines its knowledge of Azure with the context that you make available through resources, connectors, instructions, and prior operational findings. It uses tools to gather evidence and perform permitted operations.

## Follow the operational lifecycle

A typical agent-assisted response follows this lifecycle:

1. **Receive a request or trigger.** A person asks a question, an incident platform sends an alert, or a scheduled task begins.
1. **Investigate.** The agent queries relevant Azure resources and connected systems for metrics, logs, changes, deployments, incidents, and other evidence.
1. **Reason over evidence.** The agent correlates findings, considers available operational knowledge, and develops a hypothesis or recommendation.
1. **Choose a response.** Depending on the scenario, the agent can propose a direct mitigation, create a work item, send a notification, or trigger another workflow.
1. **Apply controls.** The agent checks its permissions, run mode, policy gates, and resource locks before an action can proceed.
1. **Execute and verify.** When an action is permitted and approved as required, the agent performs it, checks the outcome, and reports the result.

This lifecycle distinguishes an agent-assisted workflow from a fixed script. A script generally follows predetermined steps. Azure SRE Agent uses current evidence and operational context to decide which permitted response fits the situation.

## Set up a new SRE Agent

SRE Agent can be accessed by its own portal at https://sreagent.azure.com or through the Azure portal. The service is available in supported regions, and you can create multiple agents for different workloads or teams. When you create a new agent, you define its basic configuration:

:::image type="content" source="../media/create-agent.jpg" alt-text="Screenshot of Basics at Create Agent Wizard.":::

Post creation, you can configure additional settings such as managed identity and network configuration. You can also configure the agent's run mode, permissions, and connected systems.

## Add resources and connectors

With the SRE Agent created, you can add Azure resources and connectors to other systems. The agent can access many Azure services, subject to its permissions. Connectors can add context from observability tools, incident platforms, source control, and communication systems.

:::image type="content" source="../media/sreagent-connectors.jpg" alt-text="Screenshot of Agent landing page, highlighting connectors to Code, Logs, Incidents, and Azure resources.":::

When creating a new SRE agent, the agent creation wizard guides you through adding resources and connectors. To ensure the agent has the ability to investigate, you can provide the following resources and connectors:

- **Knowledge files**: Upload operational knowledge files to provide the agent with domain-specific guidance and context.
- **Code**: Connect to GitHub or Azure DevOps to access source code, deployment history, and pull requests.
- **Logs**: Connect to Application Insights or Log Analytics to access metrics, logs, and traces.
- **Incidents**: Connect to Azure Monitor, PagerDuty, or ServiceNow to access incident records and update their status.
- **Azure resources**: Add Azure resources to the agent's scope so it can query their state and perform permitted operations.

## Extend the agent

You can adapt the agent to your environment with several extension types:

- **Skills** add discrete operational capabilities.
- **Subagents** provide specialized behavior for an operational domain or multistep workflow.
- **Python tools** add custom logic, transformations, or API interactions.
- **Model Context Protocol (MCP) servers** connect external tools and data sources.
- **Hooks** run event-triggered automation at defined lifecycle points.

Choose the smallest extension that meets the need. A focused, repeatable operation might fit a skill, while a specialized workflow that requires several tools and decisions might fit a subagent.

## Build operational knowledge

The agent can retain synthesized findings such as symptoms, root causes, resolution steps, and team preferences. This knowledge can improve continuity across conversations and on-call shifts. Teams should treat retained knowledge as governed operational data and review the service's data-handling behavior before adoption.

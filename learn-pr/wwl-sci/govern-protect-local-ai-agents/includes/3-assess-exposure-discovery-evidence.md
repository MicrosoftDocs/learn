In the previous unit, you separated possible reach from observed action. In this unit, you apply that distinction to discovery evidence, so you can interpret agent inventory and relationships without confusing visibility with usage or protection.

## Read an inventory entry for what it proves

Suppose you open the Microsoft Defender portal at Contoso and find an entry for a command-line agent on a developer's laptop. What does that entry tell you?

Microsoft Defender discovers supported local agents and their configured MCP servers on onboarded Windows and macOS devices, and it shows them in the Defender portal. Defender defines an agent as a combination of a user, a device, and an agent type. If a developer runs the same agent type in many project folders on one device, the portal shows one **inventory entry**. The same agent type on a second device, or under a second account, appears as another entry.

Discovery depends on the agent type. For process-based discovery, observing the agent process running can be enough for an entry. The user doesn't need to submit a prompt. On Windows and macOS, the onboarded Defender client also periodically collects installed code editor extension data, so an extension can appear in the inventory even when it isn't running.

An entry shows that an agent of a given type was observed on a device and is associated with an account. It doesn't prove active use, and it doesn't prove that the agent successfully reached an AI service. It also isn't a complete inventory of installed software. Installing an agent doesn't by itself guarantee an entry, so a missing entry doesn't prove an agent is absent.

Coverage depends on the agent type and the operating system, so check the [support matrix](/defender-endpoint/ai-agent-support-matrix) before you draw conclusions. Discovery is generally available on supported Windows and macOS devices, but per the support matrix, certain scenarios are in preview at time of authoring, such as some macOS extension entries and agents that run in Windows Subsystem for Linux. Licensing also differs between baseline discovery and posture details such as risk level, risk indicators, and recommendations, so confirm the current requirements for your organization. Learn more about [local agent discovery in Microsoft Defender](/defender-endpoint/local-agent-discovery-overview).

## Interpret relationships as potential reach

An entry is only the starting point. Defender also reports the device and the account the agent runs under, the local and remote MCP servers configured for the agent, whether its host process is trusted, and whether the agent approves its own actions. The **exposure map** adds relationships among agents, devices, identities, and the resources those identities can access, to help you assess potential impact.

Each of these details describes possible reach. Recall from the previous unit that a local agent inherits the access of the user who runs it, so the account association tells you whose access is in play. Nothing in this evidence shows what the agent did with that access. The following table pairs each type of evidence with what it can and can't support.

| Evidence | What the evidence can tell you | What it doesn't prove |
| --- | --- | --- |
| Inventory entry | An agent type was observed on a device and is associated with an account. | Active use or successful access to an AI service. |
| Configured MCP server | The agent has a configured local or remote connection to tools or data. | That the agent called the server or reached the service. |
| Device and account association | Which device the agent runs on and whose access it inherits. | What the agent did with that access. |
| Exposure map relationship | Which identities, devices, and resources are connected to the agent. | That the agent accessed those resources. |
| Auto-approve setting | Whether the agent can act without asking the user to approve each action. | That the agent took any action without approval. |

When you need to go beyond the portal views, **advanced hunting** is an investigation surface that lets you query discovery data by using Kusto Query Language (KQL). It examines the same evidence, so it doesn't add proof of use.

## Compare what each discovery surface can see

Defender isn't the only place where local agents appear. Other Microsoft services look at agents from different positions, and each position has its own dependencies. The following table compares three surfaces.

| Surface | What it shows | Status at time of authoring | Key dependency |
| --- | --- | --- | --- |
| Defender endpoint discovery | Agents and their configured MCP servers on onboarded devices | Generally available, with preview exceptions listed in the support matrix | Device onboarding and the required Defender components |
| Microsoft Entra Global Secure Access AI agent discovery | A network-level view of AI agents that reach the internet, attributed to a user, device, and process, and classified as managed or shadow by registration with Microsoft Entra Agent ID | In preview at time of authoring | The Global Secure Access client on the endpoint, with internet access forwarding and Transport Layer Security (TLS) inspection enabled |
| Microsoft 365 admin center Local agents page | A place for IT administrators to discover, monitor, and govern unmanaged local agents | In preview at time of authoring, as part of the Frontier preview program | Detection and blocking apply to managed Windows devices enrolled in Microsoft Intune, and some usage details appear only when Global Secure Access is enabled |

These surfaces are separate. Defender looks from the device and reports what it observes there. Global Secure Access looks from the network path and reports agent traffic it inspects. The Microsoft 365 admin center page gives administrators a governance view of unmanaged local agents. Because the vantage points, dependencies, and coverage differ, don't assume that they list identical agents.

The managed or shadow label reflects whether an agent is registered with Microsoft Entra Agent ID, so it describes registration, not behavior. Governance for cloud-hosted agents differs from governance for local agents, so this module focuses on the local-agent view of each surface. Learn more about [AI agent discovery in Global Secure Access](/entra/global-secure-access/concept-ai-agent-discovery) and [Local agents in the Microsoft 365 admin center](/microsoft-agent-365/admin/agent-local).

## Decide which evidence supports a claim

Seeing an agent in any of these surfaces is visibility. It doesn't by itself constrain what the agent does, so visibility is also different from protection. Discovery evidence establishes presence and potential reach. A claim about what happened requires evidence of observed activity.

> **Reflect:** A manager at Contoso asks whether a developer's agent accessed sensitive data. Which evidence from this unit would you trust to make that claim, and what additional evidence would you need before you answer?

> **Try it yourself:** Practice weighing evidence in the optional <a href="https://microsoftskilling.github.io/platform-simulations/Security/security-shadow-AI/" target="_blank">Review AI agents simulation</a>, which takes about 10 minutes. As a security analyst, you review access, connections, and activity for four discovered agents, and you decide which one needs attention first. The scenario covers cloud-hosted agents and one local agent, so it reinforces how to judge risk from evidence, not the local-agent specifics in this module. The simulation doesn't affect your module progress. When you finish, it links to a <a href="https://demos.microsoft.com/Microsoft/play/7533/investigate-and-respond-to-shadow-it-ai-agents-in-microsoft-defender" target="_blank">Microsoft Defender demo on investigating and responding to shadow IT AI agents</a> that continues the scenario.
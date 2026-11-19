In the introduction, you saw that local agents put useful capability close to the work, and that this closeness makes them hard to govern. In this unit, you learn to distinguish three sources of exposure: local execution, inherited access, and untrusted input.

## Recognize a local agent by where it acts and what it can reach

A **local agent** is an AI agent that runs on a user's device and acts with that user's local access. Two things define it: where the agent executes and what it can reach. Where its AI model runs doesn't define it. The model can be a remote service, but the agent software on the device is what reads files, runs commands, and calls other services.

Local agents take many forms: command-line agents, desktop applications, agentic development environments, code editor extensions, and local agent frameworks. At Contoso, your developers might use any of these. What they share is proximity to the work. An agent that can read a source code repository, run commands, and call internal services is far more useful than one confined to a web app, and it adds a far larger risk surface for you to account for.

Compare this with a cloud agent. A cloud agent is created, authenticated, and monitored in systems your enterprise already controls. A local agent can be installed in minutes, acts with the user's own local access, and can begin reaching files, credentials, source code, and internal systems before a security team knows it exists. This gap in visibility is the first source of exposure: local execution.

## Trace inherited access to a blast radius

Local agents run with the privileges of the user who starts them. Whatever the user can open, run, or sign in to, the agent can potentially reach too. This inherited access is the second source of exposure, and it explains why the same agent can be harmless on one device and risky on another.

To reason about that risk, think in terms of **blast radius**: the potential impact if an agent or its device is misused or compromised. Several factors widen or narrow it:

- **Device posture.** The same agent carries different risk on a compliant, managed device than on a compromised one. Because local coding agents often hold keys and passwords for code and cloud systems, a single compromised device can expose far more than one machine.
- **Approval behavior.** Some agents can act without asking the user to approve each action. This setting is often called auto-approve. Microsoft Defender reports whether a discovered agent approves its own actions and whether its host process is trusted, so you can see where an agent acts with the least human oversight.

The following table organizes the exposure into four risk areas. Use it as a lens when you assess any local agent in your environment.

| Risk area | What the agent can reach | Example concern |
| --- | --- | --- |
| Devices | The device where the agent runs, including its security posture | The agent runs on a device that isn't compliant or is already compromised. |
| Data | Files, credentials, source code, and other local data the user can open | A credentials file or source code repository is read and sent outside the device. |
| Tools | Commands the agent can run and tools it can call | The agent runs commands without asking the user to approve each one. |
| Connected applications | Internal and cloud services the agent can reach through the user's access and configured connections | Keys and passwords on one device give access to code and cloud systems. |

For example, suppose a Contoso developer runs a command-line agent in a project folder. The agent can read everything the developer can read in that folder, run commands the developer can run, and use any keys or sign-ins already present on the laptop. The agent doesn't need its own permissions to reach them.

> **Guiding question:** Think about the devices in your own environment. Which teams are most likely to run local agents, and what could a user's access let those agents reach on their devices?

## Separate configured connections from observed actions

Agents extend their reach by connecting to tools and data. One common way is the **Model Context Protocol (MCP)**, an open standard that defines how applications provide tools and contextual data to large language models. An MCP server is the component that exposes those tools and data to an agent.

MCP servers come in two forms. A *local MCP server* runs as a process on the device. A *remote MCP server* is reached over the network. Both extend what an agent can do, and each adds a connection to a tool, a data source, or a service that you need to account for.

Pay attention to what the evidence actually tells you. A configured MCP server shows a possible connection. It doesn't prove that the agent used the tool or reached the service. Discovery works the same way: finding an agent shows that it is present, but it isn't proof of active use. Carry this caution through the rest of the module. Possible reach tells you how large the exposure could be, while observed actions tell you what actually happened. You need both to judge risk accurately, and you shouldn't treat one as the other.

## Recognize how untrusted input steers an agent

The third source of exposure is untrusted input. Local agents act on text from prompts, files, web content, and tool output. They can't reliably separate trusted content from hidden instructions. **Prompt injection** is the technique that exploits this weakness: an attacker places instructions in content the agent reads, and the agent treats them as part of its task. A single injected instruction can misuse the agent's access to exfiltrate data, modify code, or run harmful commands.

Consider a short example. A coding agent fetches a project's documentation to answer a developer's question. The page contains hidden text that instructs the agent to read a local secrets file and post its contents to an external address. The developer never sees the hidden text, but the agent reads it along with everything else. Because the agent runs with the developer's access, it can read the file and reach the network.

This content doesn't need to come from an obviously suspicious place. Files in a repository, web pages, project documentation, and tool responses can all carry instructions. Untrusted input becomes more dangerous when it combines with the other two sources: an agent that runs locally, inherits broad access, and acts without approval gives hidden instructions the most room to cause harm.

> **Reflect:** Pick one local agent and one connection it might use in your environment. Which of the three sources of exposure (local execution, inherited access, or untrusted input) would worry you most, and why?

With these three sources of exposure and four risk areas, you can describe what a local agent might reach and why that matters before you choose any control. Learn more about [why local agents need their own governance](/microsoft-agent-365/guidance/govern-local-agents).

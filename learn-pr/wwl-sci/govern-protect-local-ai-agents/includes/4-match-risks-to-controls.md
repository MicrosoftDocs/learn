In the previous unit, you saw that discovery shows presence and potential reach, but it doesn't protect anything. In this unit, you match each local-agent risk to the control layer that addresses it, and you identify what that layer still misses.

## Choose a control layer by the risk it addresses

Suppose you're an administrator at Contoso, and you want to reduce local-agent risk without unnecessarily interrupting your developers' legitimate work. No single control covers devices, data, tools, and connected applications, so you start with the risk and then check each layer's coverage limits.

| Control layer | Risk it addresses | What it can't cover |
| --- | --- | --- |
| Discovery and inventory | Agents that exist without your knowledge, and what they can reach | It doesn't restrict or inspect anything an agent does. |
| Identity and permissions (Microsoft Entra) | Excess access to resources that Microsoft Entra protects | Local file and command access, and resources that don't use Entra-issued tokens. |
| Network controls (Global Secure Access) | Risky destinations on covered internet-bound traffic, such as web categorization of destinations (including MCP servers and application programming interfaces), file-type policies, and blocking of malicious destinations | Traffic that doesn't pass through the service. |
| Runtime inspection (Microsoft Defender) | Prompt injection and harmful agent actions, as content enters or leaves the agent loop | Agents and inspection methods that the support matrix doesn't list. |
| Data protection | Sensitive information that agents read, send, or receive | Coverage varies by product, so confirm what a given control inspects. |
| Containment | An agent's reach into the machine, its files, and the network | It limits access but doesn't inspect what an agent reads, and it applies only to agents and tools that run inside the container. |

These layers complement one another. Discovery tells you where to look, identity limits what an agent can request from protected resources, network controls shape where its traffic can go, runtime inspection examines content and actions, and containment limits what a compromised agent can touch. AI agent discovery in Global Secure Access is in preview at time of authoring.

## Separate local permissions from Entra-protected access

A local agent uses two different kinds of access, and different controls govern each. **Local operating system permissions** determine which files and commands the agent can use on the device, because the agent runs with the user's local access. **Microsoft Entra Conditional Access** applies only when a user or agent requests an access token for a resource that Microsoft Entra protects.

Consider two requests from a Contoso developer's agent. Reading a secrets file on the laptop involves no token request, so Conditional Access doesn't see it. Reading a document in a Microsoft Entra-protected service involves a token request, so Conditional Access can evaluate it.

What the policy evaluates depends on the token's subject:

- **Signed-in user's identity (on-behalf-of, also called delegated access).** The user is the token subject, so policies that target that user apply. A policy that targets agent identities doesn't cover these requests.
- **The agent's own agent identity.** The agent identity is the subject, so policies target the agent identity or its blueprint.
- **The agent's user account.** The account is the subject, so a policy targets that account. This pattern is separate from the other two.

An agent can use more than one pattern, so a policy for one subject doesn't cover the others. A resource that an agent reaches with an API key bypasses Microsoft Entra token issuance, so Conditional Access doesn't apply. Also, don't assume that every local process you discover has a Microsoft Entra Agent ID or that agent-targeted policies cover it. Conditional Access for agents has its own licensing requirements, so check them before you rely on it. Learn more about [Conditional Access for agents](/entra/identity/conditional-access/agent-id).

## Understand what runtime protection inspects and where its coverage ends

Identity controls don't inspect what an agent reads. Runtime inspection does. Microsoft Defender AI agent runtime protection, which is in preview at time of authoring, inspects critical points in the agent loop where content enters or leaves the agent's reasoning.

Defender uses two inspection approaches:

- **Agent-native event inspection** works with agents that expose vendor-supported event interfaces.
- **Network inspection** examines agent-to-large-language-model network flows that the support matrix covers, to detect prompt injection in transit. It doesn't cover agents that use certificate pinning or HTTP/3.

In audit mode, Defender records detections and lets the action continue. In block mode, it blocks supported actions before they run. The next unit covers how to choose between them.

Coverage has limits. The support matrix lists discovery support and runtime protection support separately, so an agent in your inventory isn't necessarily one that runtime protection supports. The matrix lists runtime protection support for Windows, and support doesn't mean protection is enabled on a device. Microsoft Intune configures and distributes the setting to devices, but it's a deployment surface, not another inspection engine. Learn more about [AI agent runtime protection](/defender-endpoint/ai-agent-runtime-protection-overview) and the [support matrix](/defender-endpoint/ai-agent-support-matrix).

## Apply least privilege and containment to limit reach

The remaining controls limit how far a mistake or an attack can spread. They rest on two governance principles. Least privilege means giving an agent and its user only the access needed for the task. Containment means limiting the reach of what runs on the device. In practice, you keep inventory and ownership current, review permissions regularly, and remove access that no one needs.

Running an agent inside an isolated container is one way to apply containment. The container limits the agent's reach into the rest of the machine, its files, and the network, so a single compromised agent or device does less damage. The goal isn't to remove local agents but to keep their productivity.

**Microsoft Execution Containers (MXC)** are one existing option. MXC is a policy-driven way to run an agent, or the tools it launches, inside a container on the device. A policy defines the maximum access the container allows, such as which files it can read or change, whether it can use the network, and whether it can interact with the desktop. The policy sits outside the agent's control, so the agent can't grant itself more access. If the agent requests access beyond the policy, the container is designed to prevent the operation. An agent or tool has to run inside the container for the policy to apply. MXC is generally available at time of authoring. This module doesn't cover how to deploy or manage MXC across an organization. Learn more about [Microsoft Execution Containers](https://blogs.windows.com/windowsdeveloper/2026/10/07/microsoft-execution-containers-policy-driven-containment-for-ai-agents/).

Data protection controls work at the information level. Conceptually, they classify sensitive information and limit what agents can read, send, or receive, including content in prompts and tool responses. Governance for cloud-hosted agents also differs from governance for local agents, so don't assume controls transfer unchanged. Confirm in current documentation what each control covers.

> **Reflect:** At Contoso, an agent reads a project's documentation that contains hidden instructions. The agent then reads a local secrets file and tries to send it to an external address. Which control layers would reduce the risk in this scenario, and what would each one still miss?

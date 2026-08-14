An operational agent might access sensitive telemetry and propose changes to production resources. Before adoption, evaluate how identity, isolation, approval, and audit controls align with your organization's requirements.

## Scope access with managed identity and RBAC

Azure SRE Agent uses a managed identity to access Azure resources. Agents have Reader access by default and require explicit role assignments before they can take write actions.

Apply least privilege when you assign access:

- Start with a single resource when the workflow has a narrow target.
- Use resource-group scope when the agent must operate across a workload.
- Avoid subscription-wide write access unless the scenario and environment justify it.
- Use custom roles when built-in roles grant more actions than the workflow requires.

The agent can't override Azure RBAC or ReadOnly management locks. Product guardrails also block Azure CLI delete and remove operations and Azure Key Vault commands.

## Choose a run mode

Run modes determine how the agent can act within its assigned permissions:

| Run mode | Behavior | Suitable starting point |
| --- | --- | --- |
| **ReadOnly** | Investigates and reports without taking write actions. | Monitoring, assessment, and early evaluation. |
| **Review** | Proposes write actions and waits for human approval. | Production pilots and workflows that require human control. |
| **Autonomous** | Executes permitted actions without per-action approval. | Well-understood, tested workflows with an accepted risk level. |

Run mode doesn't grant access. The managed identity's RBAC assignments still define which resources and operations are available.

## Isolate execution and credentials

Agent reasoning and tool execution run in separate compute boundaries. Each agent has a dedicated sandbox, while an isolated identity service supplies short-lived credentials to individual tool processes. A network proxy validates and routes outbound requests.

This design keeps credentials out of the reasoning context and separates customer compute, data stores, network routing, and identities. Review the current security documentation for detailed data residency and private networking requirements.

## Observe and govern actions

The service sends operational telemetry to the Application Insights resource configured during setup. Telemetry can include conversation traces, tool-call dependencies, errors, hook activity, and mitigation records.

Governance still requires human decisions. Define approved workflows, review retained conversation and knowledge data, test agent conclusions, and monitor actions. As with any AI system, Azure SRE Agent can reach an incorrect conclusion or propose a mitigation that doesn't fit the environment.

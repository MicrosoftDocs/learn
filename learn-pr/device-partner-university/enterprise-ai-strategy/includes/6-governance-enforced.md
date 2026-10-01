Governance policies define what an agent should and shouldn't be allowed to do. To understand how those policies are applied, it helps to distinguish between the systems that define governance and the systems where agents actually operate:

- **Control plane**: Where administrators discover, govern, and audit agents and establish policy.
- **Execution layer**: Where agent actions occur and security policies are enforced.

Microsoft security, identity, and management services can provide control-plane capabilities for discovering agents, managing identities and policies, monitoring activity, and supporting audit requirements. Windows provides an execution environment in which supported agent workloads can operate within applicable identity, containment, and policy boundaries.

| Layer | Microsoft technologies | Purpose | Key capabilities |
| --------- | ------------------------ | --------- | ------------------ |
| **Control plane** | Microsoft Agent 365, Microsoft Intune, and Microsoft Entra ID | Provides centralized visibility, identity controls, governance, and policy management for AI agents. | Defines security policies and guardrails, manages identity and access, monitors agent activity, and maintains an audit trail. |
| **Execution layer** | Windows | Provides the operating environment where agent workloads run and governance policies are enforced. | Supports per-agent identity, OS-level containment through Microsoft Execution Containers (MXC), workload isolation, runtime signals, and policy enforcement. |

## Why the two layers matter together

Consider a policy that limits an agent's access to a business application.

The control plane provides the mechanisms to establish and manage that policy. The execution layer provides the environment where the agent operates within those controls.

This creates a continuous relationship:

Policies and controls are sent to the execution layer, while information about agent activity flows back to administrators for monitoring, governance, and auditing in the control plane.

This distinction is important because governing agents isn't only about creating policies or reviewing activity after the fact. Organizations also need controls that can shape agent behavior while the workload is operating.

With the governance model and enforcement layers in place, the final step is to turn these concepts into an agent-ready strategy.

The previous unit introduced agent identities as a distinct identity class with purpose-built constructs for lifecycle management, governance, and risk detection. Conditional Access for Agent ID builds on that foundation by extending Conditional Access evaluation and enforcement to AI agents—evaluating their access requests using agent-specific logic.

As a security architect, you need to understand when Conditional Access applies to agent flows and how to design policies that govern agent access without creating coverage gaps.

## Agent identity constructs relevant to Conditional Access

The previous unit introduced the agent identity hierarchy. The following table recaps each construct with its relevance to Conditional Access policy design:

| Term | Description |
|---|---|
| **Agent blueprint** | A logical definition of an agent type, represented by a service principal in the tenant. Blueprints can't independently access resources—they exist to create agent identities and agent users. Policies targeting a blueprint automatically cover all child agent identities. |
| **Agent identity** | An instantiated identity that performs token acquisitions and accesses resources. This is the identity evaluated by Conditional Access during resource access flows. |
| **Agent user** | A nonhuman user identity for scenarios requiring a user account—mailbox access, Teams membership, or collaborative workflows. Evaluated by Conditional Access separately from agent identities. |
| **Agent resource** | An agent blueprint or agent identity acting as the target of another agent's access request in agent-to-agent (A2A) flows. |

When an agent accesses another agent as a resource, both the actor and the target are evaluated by Conditional Access. Blueprint-level scoping is the recommended approach for managing related agent families, since policies cascade to all child agent identities.

## When Conditional Access applies to agents


Conditional Access evaluates agent identities and agent users whenever they request access to a resource (token acquisition flows). However, not all agent-related flows are governed by Conditional Access:

| Authentication flow | Conditional Access applies | Details |
|---|---|---|
| Agent identity → Resource | Yes | Governed by agent identity policies |
| Agent user → Resource | Yes | Governed by agent user policies |
| Agent blueprint → Microsoft Graph (create agent identity or agent user) | No | Blueprint operations only; no direct resource access |
| Agent blueprint or agent identity → Token Exchange | No | Intermediate token exchange at the Microsoft Entra token exchange endpoint; doesn't involve resource access |

Conditional Access also does **not** apply when:

- A policy is scoped to **users** or **workload identities** rather than **agents**. Agent-scoped policies require selecting "Agents (Preview)" in the assignment configuration.
- **Security defaults** are enabled. Security defaults and Conditional Access are mutually exclusive; organizations using Conditional Access for agents must disable security defaults.

This distinction is critical for security architects: existing Conditional Access policies scoped to "All users" or workload identities do **not** automatically cover agent identities. You must create agent-specific policies to close this coverage gap.

## Policy design for agents


Agent Conditional Access policies follow the same structure as human and workload identity policies—assignments, target resources, conditions, and access controls—but offer agent-specific scoping mechanisms that shape how you design your policy set.

**Assignments** can target all agent identities, individual agent identities, agent identities grouped by custom security attributes, or all agents parented by a specific blueprint. Agent users can also be targeted separately. Blueprint-level targeting is particularly useful because it automatically covers all child agent identities.

**Target resources** can scope to all resources, all agent resources (blueprints and agent identities acting as resources), specific resources by custom security attributes or appId, or specific agent blueprints.

**Conditions** currently support **agent risk** (high, medium, low) evaluated by Microsoft Entra ID Protection. This is the only condition available for agent policies at this time, which limits the granularity of conditional logic compared to human-identity policies.

**Access controls** support **block** access. Policies can be set to On, Off, or Report-only mode for simulation before enforcement.

## Common policy design scenarios




### Scenario 1: Allow only approved agents to access resources

Organizations need to ensure that only reviewed and approved agents can access specific resources. There are two approaches:

**Custom security attributes (recommended)**—Define attribute sets that categorize agents by approval status and resources by department, then create a block-all policy that excludes agents carrying the approved attribute value. This approach is self-maintaining: new agents are automatically blocked until they receive the approved attribute, and policy scope expands as new resources are tagged.

**Enhanced object picker**—Select individual agent blueprints or agent identities to exclude from a block-all policy. This approach works for smaller environments but requires manual updates as new agents are added and doesn't scale well.

### Scenario 2: Block high-risk agent identities


Design a policy that targets all agent identities, scopes to all resources, sets the agent risk condition to **High**, and blocks access. This ensures that compromised or anomalous agents are automatically blocked based on signals from Microsoft Entra ID Protection.

Deploy in report-only mode first to validate the risk signal accuracy and confirm expected behavior before switching to enforcement.

### Combining scenarios

For comprehensive agent governance, deploy both scenarios together: a baseline policy that blocks unapproved agents, and a risk-based policy that blocks approved agents if they exhibit high-risk behavior. This layered approach aligns with Zero Trust's assume breach principle.

## Observability for agent policy evaluation


Agent Conditional Access evaluations appear in existing Microsoft Entra sign-in logs, split across three locations based on the identity type involved:

- **Service principal sign-in logs**—agent identities accessing resources
- **Noninteractive user sign-in logs**—agent users accessing resources
- **User sign-in logs**—users accessing agents

Each log entry includes a Conditional Access tab showing which policies applied and the grant or block outcome. When designing your policy rollout, plan for the **What If tool** to simulate policy evaluation against specific agent identities before deployment, and **report-only mode** to observe real-world impact without enforcing decisions.

## Design considerations for security architects

When designing Conditional Access policies for agent identities:

- **Close the coverage gap.** Existing policies scoped to "All users" or workload identities don't cover agents. Audit your policy set to confirm that agent identities and agent users have dedicated coverage.
- **Use custom security attributes for scale.** Attribute-based policies automatically apply to new agents as they receive attributes, avoiding the operational burden of manually updating exclusion lists.
- **Scope policies by blueprint.** Although blueprints themselves aren't evaluated by Conditional Access, you can select a blueprint as an assignment scope so the policy automatically covers all agent identities parented by that blueprint—simplifying management for related agent families.
- **Start with report-only mode.** Deploy all agent policies in report-only mode first to understand impact. Review sign-in logs and policy impact reports before switching to enforcement.
- **Layer risk-based policies on top of approval policies.** An approved agent can still be compromised. Combine approval-based policies with agent risk policies for defense in depth.
- **Plan for agent-to-agent flows.** When agents access other agents as resources (A2A flows), both the actor agent identity and the target agent resource are evaluated. Ensure policies account for these flows.
- **Integrate with broader Zero Trust strategy.** Agent Conditional Access policies are one component of agent governance. Coordinate with workload identity policies, app consent policies, and secret management to build a comprehensive agent security posture.
- **Monitor and iterate.** Schedule regular reviews of agent sign-in logs and risk detections. As the agent landscape evolves, update attributes, blueprints, and policies to maintain alignment with organizational security requirements.

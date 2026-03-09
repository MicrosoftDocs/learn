As organizations adopt AI agents—software systems that perceive their environment, make decisions, and take actions—a new category of identity emerges that doesn't fit neatly into existing human or workload identity models. As a security architect, you need to design an identity strategy that accounts for this new identity type and the unique security, governance, and compliance challenges it introduces.

Microsoft Entra Agent ID extends the security capabilities of Microsoft Entra to AI agents, enabling organizations to discover, govern, and protect agent identities using the same Zero Trust framework applied to human users and workload identities.

## Why agent identities require dedicated design

Traditional identity models address human users (interactive authentication, predictable schedules) and workload identities (programmatic authentication, static behavior). AI agents don't fit either category. Like users, some agents need access to collaborative resources—documents, team channels, and mailboxes. Like workload identities, agents authenticate programmatically at machine speed. Unlike either, agents make autonomous decisions, adapt dynamically, interact with other agents, and face AI-specific attack vectors such as prompt injection.

Treating agents as workload identities leaves governance gaps (no sponsor accountability, no lifecycle management), while treating them as human users creates authentication friction and misaligned security signals. Microsoft Entra Agent ID addresses this gap by establishing agent identities as a distinct, first-class identity type.

## Types of AI agents

Your agent identity solution must account for three agent types, each with distinct security implications:

**Assistive agents** perform specific tasks when initiated by a user, operating within the requesting user's delegated permissions. Security risk centers on ensuring the agent doesn't exceed its delegated scope.

**Autonomous agents** operate independently with their own identities, making decisions without human intervention. These present the highest intrinsic risk—a compromised autonomous agent can operate at machine speed without oversight.

**Agent users** function with human user characteristics: persistent identities, mailbox access, team membership, and meeting participation. A compromised agent user could act as a trusted team member, accessing documents and sending communications under assumed legitimacy.

## Agent identity architecture

Microsoft Entra Agent ID introduces purpose-built identity constructs that form a hierarchy designed for management at scale.

| Object | Purpose |
|---|---|
| **Agent identity blueprint** | A logical definition of an agent type, represented as an application registration and service principal. Blueprints can't access resources directly—they serve as templates that define inheritable OAuth 2.0 delegated permissions for child agent identities. |
| **Agent identity blueprint principal** | The service principal representation of the blueprint in a tenant. For multitenant agents, a blueprint principal can be provisioned in a resource tenant, enabling agent identity creation across tenant boundaries. |
| **Agent identity** | An instantiated identity that performs token acquisitions and accesses resources. Parented by a blueprint and inherits permissions from it. |
| **Agent user** | A nonhuman user identity for scenarios requiring a user account—mailbox access, Teams membership, or collaborative workflows. |
| **Agent resource** | An agent blueprint or agent identity acting as the target of another agent's access request in agent-to-agent (A2A) flows. The agent resource validates the incoming token and controls access to its capabilities. |

This hierarchy is architecturally significant: policies applied to a blueprint automatically cascade to all child agent identities, enabling management of related agent families through a single policy assignment. The platform uses OAuth 2.0 and OpenID Connect (OIDC) standards, so existing token validation, consent, and authorization infrastructure applies.

## Agent security challenges that drive design decisions

When designing an agent identity solution, your architecture must mitigate several categories of risk that differentiate agents from other identity types.

### Increased attack surface

AI agents expand the organizational attack surface in ways that require specific design responses:

- **External accessibility**—Agents interacting with external systems or the public internet create pathways for adversaries to compromise agents and pivot into organizational resources.
- **Permission escalation risk**—Agents are frequently provisioned with permissions broader than necessary, violating least privilege.
- **Autonomous decision-making**—Compromised agents with purchasing authority or administrative privileges can take harmful actions at machine speed.
- **Prompt injection**—Malicious instructions inserted into data processed by the agent can manipulate agent behavior—an attack vector unique to AI.
- **Agent-to-agent propagation**—A compromised orchestration agent can target other agents through A2A flows, propagating compromise across agent ecosystems.

### Agent sprawl

Agent proliferation creates a governance challenge termed "agent sprawl"—the uncontrolled expansion of agents across an organization without adequate visibility, management, or lifecycle controls. Agent sprawl emerges when business units create agents independently (shadow AI), agents created for temporary purposes remain in production indefinitely, permissions accumulate without review, and ownership accountability is lost. The consequences include degraded security posture, compliance risk, operational inefficiency, data exposure, and impaired incident response.

Your agent identity design must address sprawl proactively by requiring every agent to have a registered identity, an assigned sponsor, and a governed lifecycle.

## Design an agent identity governance strategy

Microsoft Entra ID Governance extends to agent identities, enabling you to apply the same lifecycle and access management controls used for human identities. Your governance design should address three areas: lifecycle management, access assignment, and sponsor accountability.

### Lifecycle management

Agent identities start with limited permissions—only OAuth 2.0 delegated scopes inherited from their parent blueprint. Additional access must be explicitly requested, approved, and assigned through governed processes.

### Access assignment through entitlement management

Entitlement management access packages assign agent identities access to security group memberships, application OAuth API permissions (including Microsoft Graph application permissions), and Microsoft Entra roles. Access can be requested by the agent identity itself (programmatically), the agent's sponsor, or an administrator.

Access packages support expiration policies, ensuring agent access is time-bound. As expiration approaches, sponsors receive notifications and must either request an extension (triggering a new approval cycle) or allow access to expire.

### Sponsor accountability

Every agent identity should have a designated human sponsor accountable for its lifecycle and access decisions. If a sponsor leaves the organization, sponsorship automatically transfers to their manager. Lifecycle Workflows notify cosponsors and managers about impending sponsorship changes, maintaining an unbroken chain of human oversight.

## Design for agent identity protection

Microsoft Entra ID Protection extends risk detection and response to agent identities. Because agents can operate autonomously and at scale, anomalous behavior requires automated detection and response rather than relying on manual review.

ID Protection for agents establishes a behavioral baseline for each agent and then monitors for deviations. Activities that contribute to an agent being flagged as risky include:

| Risk detection | Meaning |
|---|---|
| **Unfamiliar resource access** | Agent targeted resources outside its normal pattern—possible lateral movement. |
| **Sign-in spike** | Abnormally high sign-in frequency—possible automated tooling or attack activity. |
| **Failed access attempt** | Agent attempted unauthorized resource access—possible token replay. |
| **Sign-in by risky user** | Agent signed in on behalf of a risky user during delegated authentication—possible credential exploitation. |
| **Confirmed compromised** | Administrator confirmed compromise through manual investigation. |
| **Microsoft Entra threat intelligence** | Microsoft threat intelligence identified activity consistent with known attack patterns. |

These risk signals feed into Conditional Access for agents (covered in the next unit), enabling risk-based policies that automatically block high-risk agents from accessing resources. Your design should combine agent risk detection with Conditional Access enforcement as a layered defense.

## Design network-level controls for agents

Microsoft Entra Global Secure Access extends network security controls to agent traffic. For agents built on platforms such as Microsoft Copilot Studio, you can forward agent traffic to Global Secure Access's proxy service, applying the same network policies used for users. Capabilities include logging agent network activity, applying web categorization to control API and MCP server access, restricting file transfers by type, blocking malicious destinations via threat intelligence, and detecting prompt injection attacks.

Network controls complement identity-layer protections: Conditional Access governs token acquisition, while network controls govern traffic paths and content once authorized—providing defense in depth.

## Agent registry and discovery

The agent registry in the Microsoft Entra admin center provides centralized visibility into all agent identities, their metadata (purpose, capabilities, protocols), owners, and sponsors. It supports agent-to-agent discovery and authorization based on standard protocols including MCP (Model Context Protocol) and A2A (Agent-to-Agent). The registry is your primary mechanism for addressing agent sprawl—requiring registration establishes organizational visibility and ensures every agent can be inventoried, audited, and governed.

## Integration across Microsoft platforms

Microsoft Entra Agent ID integrates with multiple platforms that create and manage agents, providing consistent identity management regardless of where agents originate:

- **Microsoft Foundry** automatically provisions blueprints and agent identities throughout the agent lifecycle.
- **Microsoft Copilot Studio** agents can automatically receive agent identities when enabled in a Power Platform environment.
- **Azure App Service and Azure Functions** can use the agent identity platform to connect to resources as agents.
- **Microsoft Teams** agent identity blueprints can be managed in the Developer Portal for Teams.

This cross-platform integration means Microsoft Entra Agent ID provides the unified identity layer regardless of where agents originate.

## Design considerations for security architects

When designing an agent identity solution:

- **Establish agent identities as a distinct identity class.** Don't repurpose human user accounts or standard service principals for agents. Use the purpose-built agent identity constructs to ensure proper governance, risk detection, and policy coverage.
- **Require blueprint-level organization.** Group related agents under shared blueprints to simplify policy assignment and permission inheritance. This reduces operational overhead as agent populations grow.
- **Mandate sponsor assignment for every agent.** Unsponsored agents are ungoverned agents. Design your processes to prevent agent identity creation without a designated human sponsor.
- **Apply least-privilege access by default.** Agent identities inherit only delegated permissions from their blueprint at creation. Design access assignment workflows through entitlement management access packages with approval, expiration, and review controls.
- **Layer identity and network controls.** Combine Conditional Access for agent risk with Global Secure Access network policies for defense in depth. Identity controls govern token acquisition; network controls govern traffic and content.
- **Plan for multitenant agents.** If your organization uses or builds agents that operate across tenants, design for blueprint principals in resource tenants, similar to multitenant application service principals.
- **Address agent sprawl from the start.** Require agent registration in the centralized registry, enforce lifecycle management through ID Governance, and schedule regular access reviews for agent identities—just as you would for human users.
- **Integrate agent identity monitoring into security operations.** Agent risk detections, sign-in logs, and network activity logs should flow into your SIEM (such as Microsoft Sentinel) for correlation with broader threat detection workflows.

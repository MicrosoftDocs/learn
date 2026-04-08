## Unit overview

This unit guides solution architects through defining **solution rules and architectural constraints** when designing AI components using **Copilot Studio**, **Microsoft Foundry**, and **Foundry Tools**. Establishing clear rules and constraints ensures AI solutions are **reliable, secure, compliant, scalable, and predictable** across enterprise environments.

## Learning objectives

By the end of this unit, learners will be able to:

- Identify how platform differences influence architectural constraints
- Define required guardrails for data, actions, and tool access
- Decide how to establish solution-level rules for responsible behavior
- Decide how to define environment, networking, and operational constraints
- Decide how to create a unified rule framework across Copilot Studio and Foundry

## Architectural foundations and platform roles

### Copilot Studio

Copilot Studio provides a **low-code environment** for building task and retrieval agents, enabling rapid design cycles and controlled extensibility. It imposes constraints through managed connectors, responsible AI boundaries, and simplified orchestration.

#### Key constraints

- Behavior shaped through structured instructions and tool permissions

- Limited execution complexity compared to Foundry

- Governed environment for business users

- Built-in safety filters restrict unsafe outputs

- AI agents executed within Microsoft's secure SaaS boundary

#### Solution rules

- Use Copilot Studio for **workflow-bounded**, **task-driven**, or **information retrieval** scenarios

- Apply strict **connector scoping** to control data exposure

- Define **task boundaries** that prevent the agent from making high-impact decisions

- Ensure prompt instructions reflect organizational policies

### Microsoft Foundry

Foundry supports **pro-code, high-complexity AI applications** and multi-agent systems. It enables custom orchestration, multi-step reasoning, advanced tooling, and deeper integration with enterprise systems.

#### Key constraints

- Requires explicit governance for tools, models, and memory

- Supports hosted agents, declarative agents, and tooldriven architectures

- Increased responsibility for model selection, risk mitigation, and evaluation

- Greater operational overhead (monitoring, failover, scaling)

#### Solution rules

- Use Foundry for **complex reasoning**, **multi-agent orchestration**, or **custom tool integration**

- Define strict **action boundaries** for tools that modify systems or trigger workflows

- Apply **evaluation pipelines** to audit safety, correctness, and drift

- Use **role separation** so each agent has scoped permissions

### Foundry tools

Foundry Tools include model catalogs, tool APIs, agent orchestration frameworks, evaluation utilities, and developer SDKs. They provide a versatile foundation but require carefully defined rules.

#### Key constraints

- Developers must manage memory lifetime, context, and data sensitivity

- Agents can call external tools, making permissioning critical

- Orchestration complexity increases with multi-agent designs

#### Solution rules

- Implement **least-privilege** permissions for each tool

- Use evaluation tools to test **failure cases** and **undesirable behavior**

- Define **clear escalation rules** for when an agent must defer to humans

- Document all tool integrations with security and auditing considerations

## Data constraints and governance boundaries

### Data access rules

Solution architects must define explicit guardrails around data to avoid overexposure or unintended model hallucination.

#### Rules

- Provide agents **only the data they require**

- Mask sensitive fields where retrieval is needed but full data is unnecessary

- Limit grounding sources to curated, authoritative datasets

- For generative tasks, enforce constraints on what content agents can produce

#### Data movement and storage constraints

- Prevent persistent storage of messages unless compliance requires it

- Define memory policy (ephemeral vs. persistent)

- Restrict crossdomain data access (HR, Finance, Legal)

#### Compliance and regulatory constraints

- Agents must conform to organizational regulatory obligations

- High-risk tasks (financial approvals, legal drafting, health decisions) require human review

- Enable mandatory auditing for tool invocation

## Behavioral rules and responsible AI constraints

### Behavior envelopes

Define what an agent is _allowed_ and _not allowed_ to do.

#### Required constraints

- Define explicit boundaries:
  
  - "Agent may summarize"
  - "Agent may not decide"
  - "Agent may not execute financial transactions"

- Include disallowed behaviors aligned to security, privacy, and safety policies

- Use structured instructions to prevent unsafe improvisation

#### Responsible AI (RAI) controls

- Mandate use of bias and safety evaluation pipelines

- Apply strict instructions for citing sources, representing facts, and avoiding hallucination

- Require human-in-the-loop checkpoints for high-impact actions

## Environment, deployment, and networking constraints

### Environment rules

- Copilot Studio: Operates inside Microsoft 365 tenant boundary; isolated per environment

- Foundry: Requires architected deployment environment (VNet, private endpoints, region constraints)

Microsoft 365 Copilot: Operates inside Microsoft 365 tenant boundary; operates within the company tenant.

- Ensure separation of development, testing, and production with dedicated configurations

### Networking constraints

- For Foundry: use private networking for confidential workloads

- Restrict external tool calls to allow domains

- Require API isolation for sensitive system integrations

### Operational constraints

- Establish SLOs for reliability, latency, and throughput

- Require agent health monitoring and incident response plans

- Mandate rollback and failsafe procedures

## Unified rule framework across platforms

Solution architects must define a **single set of rules**, then apply them differently across platforms.

| **Rule Category** | **Copilot Studio Application** | **Foundry Application** |
|---|---|---|
| **Data Access** | Strict connector scoping | Full control; must define explicit boundaries |
| **Actions** | Light task automation | Deep tool integration and orchestration |
| **Governance** | Platform-enforced | Architect-led, customizable |
| **Risk Level** | Low-medium | Medium-high |
| **Evaluation** | Built-in safety | Requires evaluation pipelines |

### Solution constraint pyramid

**Top:** Behavioral rules

**Middle:** Data and tool constraints

**Base:** Environment, governance, and operational guardrails

### Multi-platform governance flow

User Request → Copilot Studio Agent → Escalation Rules → Foundry Orchestrated Agents → Verification Pipeline → Output

## References

- Integrating Azure AI Foundry with Copilot Studio — a strategic and technical overview. [https://techcommunity.microsoft.com/blog/azure-ai-foundry-blog/integrating-azure-ai-foundry-with-copilot-studio-a-strategic-and-technical-overv/4457370](https://techcommunity.microsoft.com/blog/azure-ai-foundry-blog/integrating-azure-ai-foundry-with-copilot-studio-a-strategic-and-technical-overv/4457370)

- Microsoft Copilot Studio vs. Microsoft Foundry — building AI agents and apps. [https://techcommunity.microsoft.com/blog/microsoft-security-blog/microsoft-copilot-studio-vs-microsoft-foundry-building-ai-agents-and-apps/4483160](https://techcommunity.microsoft.com/blog/microsoft-security-blog/microsoft-copilot-studio-vs-microsoft-foundry-building-ai-agents-and-apps/4483160)

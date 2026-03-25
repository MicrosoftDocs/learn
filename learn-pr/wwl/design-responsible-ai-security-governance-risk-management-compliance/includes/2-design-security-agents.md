## Overview

Design a defense in depth approach for autonomous and semi-autonomous agents that operate across Microsoft clouds. You'll translate business and compliance requirements into identity, access, data protection, observability, and threat protection controls. You'll also define how agents authenticate, what they can do, what they can see, and how their behavior is monitored and governed at scale.

### By the end of this unit, solution architects will be able to

- Map agent personas to least-privilege roles and scopes using Azure role-based access control and managed identities.

- Select secure authentication and authorization patterns for agents, tools, and backend services.

- Apply data governance controls (DLP, sensitivity labels, and data residency) to constrain agent knowledge and outputs.

- Establish organization-wide observability for agent behavior, usage, and cost.

- Integrate AI-specific threat protection, red teaming, and incident response into the agent lifecycle.

- Standardize development and interoperability choices to reduce risk and improve maintainability.

## Key concepts and decisions

### Identity and access design

**Goal:** Every agent, tool, and pipeline has a first-class identity, clear ownership, and least-privilege access.

**Agent identity** 

- Assign a unique cloud identity per agent (prod, pre-prod, dev) and record ownership, version, and lifecycle metadata.

- Prefer **managed identities** for agent-to-Azure authentication to remove secrets and simplify rotation.

**Authorization patterns** 

- Enforce **least privilege** with narrowly scoped role assignments (subscription/resource group/resource).

- When an agent acts **on behalf of a user**, propagate the user's permissions; when it acts **as itself**, scope a service role with only the actions the agent needs.

**Separation of duties** 

- Distinct roles for Maker, Publisher, Environment Admin, and Security Admin.

- Require approvals for publishing to production and for changes to high-risk capabilities (for example, actions that modify data).

:::image type="content" source="../media/role-based-access-control.png" alt-text="RBAC design matrix.":::

## Data governance and protection

**Goal:** Agents use only the right data, in the right places, for the right duration.

**Data boundaries** 

- Separate internal vs. public workloads. Keep confidential sources out of public-facing agents.

- Honor **data residency** by selecting compliant regions for knowledge, logs, and memory.

**Data loss prevention and sensitivity** 

- Use **DLP policies** to restrict connectors, actions, and data movement.

- Apply **sensitivity labels** to knowledge sources; surface the highest label in responses where supported.

**Retention and minimization** 

- Define retention windows for logs, agent memories, and training data. Automate purge/anonymization.

**Transparency** 

- Disclose AI involvement and data usage to users and stakeholders. Provide data deletion mechanisms.

## Observability and cost governance

**Goal:** Make agent actions auditable and costs predictable.

**Unified logging** 

- Centralize telemetry for prompts, tool calls, errors, and safety events in a single workspace.

- Capture custom business metrics (successful task completion, escalation rates).

**Inventory and ownership** 

- Maintain an authoritative catalog of agents with owner, version, environment, and purpose.

**Cost controls** 

- Tag resources by agent and cost center. Track token and API consumption.

- Set alerts for spend thresholds and anomalous usage.

## Threat protection and assurance

**Goal:** Reduce the blast radius of adversarial input and model-specific risks.

**AI threat protection** 

- Enable protections that detect prompt manipulation, data leakage attempts, and risky outputs.

**Input/output filtering** 

- Sanitize tool inputs, enforce type/size limits, and apply safety moderation to free-text channels.

**Adversarial testing** 

- Run **red team** evaluations pre-production and after major changes; gate releases on findings closure.

**Incident response** 

- Define how to disable an agent quickly, preserve logs, notify stakeholders, and recover safely.

- Rehearse drills for critical agents.

## Development and interoperability standards

**Goal:** Standardize how agents connect to tools, data, and each other.

**Frameworks and SDKs** 

- Adopt a standard agent framework with built-in governance hooks and documentation.

**Protocols** 

- Use **Model Context Protocol (MCP)** for structured tool/data access.

- Use **Agent-to-Agent (A2A)** for controlled delegation and context sharing across agents.

**Environment strategy** 

- Provide safe maker spaces via environment routing. Separate dev/test from production.

**Change control** 

- Version artifacts, enforce approvals, and use automated checks for security posture before publish.

## Implementation guide

**Establish identities and access**

- Create managed identities per agent per environment.

- Assign least-privilege Azure roles to the identities at the narrowest scope.

- Define maker/publisher/admin role mappings and access review cadence.

**Harden data access**

- Inventory knowledge sources and classify sensitivity.

- Apply DLP and sensitivity labels; restrict risky connectors and HTTP calls.

- Configure data residency and retention for knowledge, logs, and memory.

**Stand up observability**

- Route logs to a central workspace; enable application telemetry for prompts, tool calls, and errors.

- Build dashboards for quality, safety, and cost; configure alerts for anomalies and budget thresholds.

**Enable threat protection and testing**

- Turn on AI-aware threat protections and content safety checks.

- Schedule red team assessments; track findings to closure before production release.

**Govern environments and releases**

- Use environment routing to separate dev/test/prod.

- Require peer review and approver signoff to publish; block publishing if mandatory checks fail.

**Prepare incident response**

- Document disable/rollback steps, comms templates, and evidence preservation.

- Run tabletop exercises for high-impact agents.

- Identify proactive alerting for emerging potential threats

## Design checklist

- Agent identities exist for each environment; owners recorded.

- Managed identities used; no embedded secrets.

- Role assignments scoped minimally; access reviews scheduled.

- DLP policies active; sensitivity labels applied to knowledge sources.

- Data residency and retention configured; purge jobs implemented.

- Centralized logging, dashboards, and spend alerts in place.

- AI-specific threat protection and output moderation enabled.

- Red team performed; open risks addressed.

- MCP/A2A usage documented; allowed external endpoints approved.

- Incident response runbook tested.

## Practice

**Scenario:** A customer wants a helpdesk triage agent that reads ticket data, summarizes trends, and updates knowledge articles.

**Tasks:**

1. Propose identities, roles, and scopes for the agent, tools, and pipelines.

2. Sketch the data boundary (what corp systems it can read/write, labels, DLP).

3. Define observability signals and cost thresholds.

4. List preprod red team tests and release gates.

5. Outline the incident response plan for a data leakage event.

**Deliverable:** A onepage architecture decision record (ADR) plus the RBAC matrix.

## References

- [Governance and security for AI agents across the organization](/azure/cloud-adoption-framework/ai-agents/governance-security-across-organization)

- [Examine agent approval governance](/training/modules/perform-admin-tasks-microsoft-365-copilot-agents/7-examine-agent-approval-governance)

- [Security and governance in Microsoft Copilot Studio](/microsoft-copilot-studio/security-and-governance)

- [Manage IAM for AI workloads on Azure](/training/paths/manage-iam-for-ai-workloads-on-azure/)
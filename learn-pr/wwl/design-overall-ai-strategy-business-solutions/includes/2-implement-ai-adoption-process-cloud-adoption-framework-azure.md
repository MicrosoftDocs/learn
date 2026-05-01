## Learning objectives

By the end of this unit, learners will be able to:

- **Map** CAF's AI adoption phases (Strategy, Plan, Ready, Govern, Secure, Manage) to the AI agent lifecycle (Plan agents, Govern & secure agents, Build agents, Operate agents)
- **Design** an enterprise-ready operating model that aligns landing zones, data, security, and agent governance
- **Select** appropriate Microsoft platforms (Foundry, Copilot Studio, Azure AI services, Microsoft 365 Copilot) and apply decision criteria for agents vs. applications
- **Apply** actionable checklists to progress from proofs of concept to production operations for both AI workloads and agents

## Unified model introduction

**Why unify?** CAF gives you the end-to-end adoption backbone for AI solutions on Azure; the Agent Adoption guidance layers in the **specific operating model** for planning, governing, building, and operating **AI agents** across the enterprise. Aligning these frameworks reduces risk, prevents "agent sprawl," and accelerates value realization. 

CAF AI adoption (left rail) defines [foundations and operational guardrails](/azure/architecture/ai-ml/architecture/baseline-microsoft-foundry-landing-zone).

Agent lifecycle (right rail) defines [how teams plan, govern, build, and operate agents](/azure/cloud-adoption-framework/scenarios/ai/).

### Phase-by-phase guidance and deliverables

#### A. AI strategy (CAF) ⇄ Plan agents (agent lifecycle)

##### Goals

- Document business outcomes, prioritize use cases, and select Microsoft AI technologies

- Decide **whether agents are appropriate**, and if so, **which platform** (SaaS vs. custom)

##### Key activities

- Identify high-impact AI use cases; define measurable success metrics and ROI hypotheses

- Create the **technology plan for agents** (SaaS agent vs. Foundry/Copilot Studio) and initial TCO/effort tradeoffs

- Draft data and Responsible AI strategies aligned with compliance

##### Outputs

- AI Strategy brief + **Agent Technology Plan** (decision tree, platform choice, guardrails)

##### Checklist (excerpt)

- Define AI tech strategy, data strategy, and Responsible AI strategy

- Build the **business plan for agents** and rank candidate agent use cases by impact/feasibility

#### B. AI plan (CAF) ⇄ Plan agents (continued)

##### Goals

- Convert strategy to an actionable adoption plan; select a starter project; address skills and resource gaps

##### Key activities

- Assess and acquire AI skills; access AI resources; prioritize use cases; run a **proof of concept (PoC)**

- Define **agent readiness criteria** (data availability, governance readiness, identity model, connectors)

##### Outputs

- AI adoption plan, PoC report, and **agent readiness assessment**

##### Checklist (excerpt)

- Assess skills; acquire skills; access AI resources; prioritize use cases; create PoCs; implement Responsible AI

#### C. AI ready (CAF) ⇄ Govern & secure agents (foundation)

##### Goals

- Establish landing zones, resource organization, connectivity, and **AI governance boundaries**

- Put **agent governance** in place: roles, standards, and development process

##### Key activities

- Build the AI environment and choose the right reference architectures and design areas; use **Azure landing zones** for scale

- Define **agent governance** (policies for capability access, data boundaries, approvals, monitoring)

- Prepare **data architecture for agents** to ensure agents operate on authoritative, governed sources

##### Outputs

- AI landing zone(s), policy assignments, network segmentation, **agent governance charter**, and **data access model**

##### Checklist (excerpt)

- Establish AI governance, networking, reliability, and foundation; choose architectures and design areas

#### D. Govern AI + secure AI (CAF) ⇄ Govern & secure agents (enforcement)

##### Goals

- Enforce AI governance policies, monitor organizational risk, and **secure AI platforms**

- Apply **agent-specific** governance and security controls across the estate

##### Key activities

- Apply policy-based governance for AI platforms (Azure Policy, platform baselines)

- Document and enforce AI policies; monitor organizational risks

- Implement controls for agent behavior, data access, and compliance (e.g., review prompts/tools, audit trails, escalation)

##### Outputs

- AI/agent policy set, risk register, and **security controls** for data, models, and endpoints

#### E. Build agents (agent lifecycle) ⇄ AI ready→adopt (execution on Azure)

##### Goals

- Standardize the **process to build agents** consistently across teams; prevent architecture drift and security gaps

##### Key activities

- Provide **development process** guidelines for Copilot Studio and Foundry (patterns: knowledge tools, action tools, triggers; evaluations)

- Select platform services for AI (PaaS) and follow reference architectures to align with landing zones

##### Outputs

- Standard agent templates, evaluation gates, environment strategy, and **CI/CD with policy guardrails**

#### F. Manage AI (CAF) ⇄ Operate agents (run, monitor, improve)

##### Goals

- Operationalize AI workloads and **agent fleets** with monitoring, cost controls, release practices, and business continuity

##### Key activities

- Define deployment authority within governance boundaries; implement comprehensive monitoring/telemetry and SLOs

- Establish **agent operations**: rollout patterns, behavior monitoring, performance tuning, and lifecycle management

##### Outputs

- AI operations baseline (observability, incident response, cost/usage reports) and **Agent Ops playbook** (SLOs, retraining rules, deprecation)

## RACI snapshot (example)

| **Activity** | **Solution Architect** | **Platform Team** | **Security & Compliance** | **Data/Knowledge Owner** |
|---|---|---|---|---|
| **Strategy & use case selection** | **A/R** | C | C | C |
| **Agent tech plan (SaaS vs. custom)** | **A/R** | C | C | C |
| **Landing zone & policies** | C | **A/R** | **C/R (controls)** | C |
| **Agent governance & SDLC** | **R** | A | **A/R (policy)** | C |
| **Build agents (Foundry/Studio)** | **A/R** | R (platform services) | C | **C/R (grounding data)** |
| **Operate agents & telemetry** | **A/R** | R | C | C |

_A = Accountable, R = Responsible, C = Consulted_

## Visual artifacts to include in the ILT deck/handbook

**Unified process map** - the Mermaid flow above (export as SVG).

**Architecture block diagram** - Landing zones (management groups, platform vs. app subscriptions), Foundry resources, Copilot Studio environments, and data estates with governance boundaries. 

**Agent governance swimlane** - Roles (Agent Owner, Platform, Security) with gates: design review → evaluation → approval → rollout → monitoring. 

**Data readiness funnel** - Authoritative sources → indexing/grounding → access controls → lineage/quality metrics for agents. 

## Actionable checklists

### Strategy & planning

- Use case inventory with quantified outcomes and success metrics

- Agent platform decision (SaaS vs. custom) with cost/effort fit

- Skills assessment and upskilling plan (architects, data, security)

### Ready & foundations

- Landing zone(s) with management groups for **external vs. internal** workloads; baseline policies applied

- Data foundation for agents (authoritative sources, access model, lineage)

### Govern & secure

- Document AI and agent policies; define approvals, change control, and evaluation criteria

- Implement platform security for models, data, keys, and endpoints; maintain a complete AI asset inventory

### Build & operate

- Standardized agent build process, templates, and CI/CD; adopt reference architectures for PaaS AI

- Operational telemetry and SLOs for workloads and agents; cost and incident runbooks

## References

- [AI adoption - Cloud Adoption Framework (overview and checklists)](/azure/cloud-adoption-framework/scenarios/ai/)

- [Create your AI strategy](/azure/cloud-adoption-framework/scenarios/ai/strategy)

- [Plan for AI adoption](/azure/cloud-adoption-framework/scenarios/ai/plan)

- [AI Ready (resource organization, connectivity, governance boundaries)](/azure/cloud-adoption-framework/scenarios/ai/ready)

- [Secure AI (security process, asset protection, threat detection)](/azure/cloud-adoption-framework/scenarios/ai/secure)

- [Manage AI (deployment authority, monitoring, cost, operations)](/azure/cloud-adoption-framework/scenarios/ai/manage)

- [Azure landing zone design areas (reference architecture for scale)](/azure/cloud-adoption-framework/ready/landing-zone/)

- [Get AI architecture guidance for PaaS (reference patterns)](/azure/cloud-adoption-framework/scenarios/ai/platform/architectures)

- [AI Agent Adoption Guidance for Organizations (plan, govern & secure, build, operate)](/azure/cloud-adoption-framework/ai-agents/)

- [Technology plan for AI agents (SaaS vs. custom)](/azure/cloud-adoption-framework/ai-agents/plan/technology-plan)

- [Data architecture for AI agents](/azure/cloud-adoption-framework/ai-agents/plan/data-architecture)

- [Governance & security for AI agents](/azure/cloud-adoption-framework/ai-agents/govern/governance-and-security)

- [Manage AI agents (operate)](/azure/cloud-adoption-framework/ai-agents/operate/manage) 

- [CAF AI adoption (GitHub source)](https://github.com/MicrosoftDocs/cloud-adoption-framework/blob/main/docs/scenarios/ai/index.md)
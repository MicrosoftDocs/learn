Azure SRE Agent is a cloud-native service built on **generative AI** (using large language models), combined with deep integration into the Azure platform. it'sn't a simple chatbot layer on top of monitoring. Instead, it's an orchestrated agentic system that combines reasoning capabilities with tool access, telemetry ingestion, and governed execution paths. Microsoft hosts the underlying models, without needing customer-managed model deployments. There is no requirement for fine-tuning or being an expert in prompt engineering. The agent's intelligence is delivered as a managed service, abstracting the AI infrastructure so that operations teams can focus on reliability outcomes rather than model management.

## Architecture layers

The architecture follows a four-layer reference model. Each layer has a distinct responsibility, and the separation between layers is what enables the governance controls that make agentic operations enterprise-viable.

```text
┌─────────────────────────────────────────────────────────────┐
│                  Signal & Context Layer                     │
│  Azure Monitor · Log Analytics · App Insights · Change data │
│  Resource topology · Deployment history · Incident history  │
├─────────────────────────────────────────────────────────────┤
│                 Reasoning & Planning Layer                  │
│  LLM-powered reasoning · Intent interpretation              │
│  Multi-step investigation · Tradeoff evaluation             │
│  Root cause correlation · Evidence generation               │
├─────────────────────────────────────────────────────────────┤
│              Control Plane (Governance Layer)               │
│  RBAC · Managed Identity · Approval gates · Policy          │
│  Audit logging · Tool mediation · Scope enforcement         │
├─────────────────────────────────────────────────────────────┤
│                    Execution Plane                          │
│  Azure CLI · REST APIs · Deployment slot operations         │
│  Scaling actions · Service restarts · Rollback operations   │
└─────────────────────────────────────────────────────────────┘
```

### Layer 1 – Signal & context layer

The agent consumes signals from Azure Monitor, Log Analytics, Application Insights, and supported external observability systems. These resources are used to build a live, continuously updated understanding of system health and dependencies. This layer provides the raw material that the reasoning layer operates on:

- **Real-time metrics and logs** – CPU, memory, request rates, error rates, and custom metrics streamed from Azure Monitor. Log entries from Log Analytics workspaces, including application logs, platform logs, and activity logs.
- **Distributed traces** – End-to-end request flows from Application Insights, enabling the agent to trace a user request from the frontend through backend services, databases, and external dependencies, identifying where latency or errors are introduced.
- **Resource configuration state and topology** – The current configuration and relationship across Azure resources allows the agent to reason about dependency chains during incident analysis.
- **Deployment and change history** – Records of recent deployments, configuration changes, slot swaps, scaling events, and RBAC modifications from Azure Activity Log. Change correlation is one of the agent's most powerful diagnostic capabilities.
- **Historical incident patterns and resolutions** – Previous incidents, their root causes, and the remediation actions that resolved them. This historical context enables the agent to recognize recurring patterns and suggest proven remediation strategies.

### Layer 2 – Reasoning & planning layer

The reasoning layer activates when an alert gets trigger, or when an engineers runs prompts. The reasoning layer forms the generative AI core of the system, and its capabilities go far beyond data retrieval or log summarization:

- **Multi-source correlation** – The agent correlates telemetry with recent deployments, configuration changes, and resource state changes simultaneously. It doesn't just search for anomalies, but rather constructs a causal narrative explaining how observed symptoms relate to underlying changes.
- **Dependency chain mapping** – The agent traces failure propagation across connected resources. If a SQL database connection fails, the agent performs a sequence of checks. Perhaps starting with examining the database's health and validating the network path. Next, the agent performs checks to validate the App Service's connection string configuration or looks into Azure Key Vault where credentials are stored.
- **Historical pattern matching** – The agent compares current symptoms against previous incident patterns. To then identify whether it involves a known failure mode with an established remediation path or a novel situation requiring human decision.
- **Multi-step investigation planning** – Rather than executing a single query, the agent forms investigation plans. Think of these as a series of diagnostic steps that adapt based on intermediate findings. If the first query reveals a deployment event, the next step examines what changed in that deployment.
- **Evidence-based explanation generation** – The agent produces human-readable summaries that include specific timestamps, metrics, log entries, and deployment events supporting its conclusions. Engineers can verify the agent's reasoning rather than trusting a black box.

### Layer 3 – Control plane (governance layer)

The control plane is the safety mechanism that makes agentic operations Enterprise-compliant. Without it, an AI agent with access to production infrastructure would represent an unacceptable risk:

- **Role-Based Access Control (RBAC)** – The agent operates under a managed identity with explicitly scoped permissions. Read permissions (for diagnosis) and write permissions (only when approved, only used for remediation) are separated and independently allocated.
- **Approval gates** – Write and remediation actions require human approval before execution. The agent presents its reasoning, the proposed action, and the expected outcome. The human cloud engineer reviews and authorizes.
- **Audit logging** – Every action, proposal, reasoning chain, and decision is logged with timestamps and identity attribution. These logs serve compliance, security, incident review, and continuous improvement purposes.
- **Policy enforcement** – Actions are bounded by organizational policies and scope restrictions. The agent can't exceed its granted permissions or operate outside its assigned resource groups.
- **Tool mediation** – The agent accesses Azure resources through controlled interfaces (Azure CLI, REST APIs). It never receives raw credentials or unbounded access. From the agent conversation, engineers have full insights on the proposed and executed commands.

### Layer 4 – Execution plane

The execution plane consists of the deterministic systems that apply changes when the reasoning layer proposes and the governance layer approves:

- Azure CLI commands and REST API calls for resource management
- Deployment slot swap operations for rollback scenarios
- Service scaling operations (horizontal and vertical)
- Service restart operations for state recovery
- Configuration updates for remediation

The execution plane is deliberately separated from reasoning. The intent is: **agents reason; orchestration executes**. This separation guarantees that the creative, probabilistic work of diagnosis is decoupled from the mechanical, deterministic work of applying changes.

## Single-agent vs. multi-agent patterns

Teams typically start with a **single "generalist" agent** that handles investigation and remediation across a Resource Group or application workload boundary. As operational maturity grows and more workloads are onboarded, **multi-agent patterns** can be created. Specialized agents may handle detection, triage, remediation, and verification. Reflecting the specialization we see in mature SRE team structures today. Because of the granularity within your Azure subscriptions and SRE Agent RBAC permissions, it's doable to creat small-scoped agents.

## Interaction model

Azure SRE Agent exposes a **chat-based interface** in the Azure portal. Engineers interact using natural language to investigate incidents, ask diagnostic questions, review historical patterns, and approve remediation actions. This conversational model lowers the barrier to complexity significantly. Engineers don't need to learn a new query language, master KQL syntax, or navigate unfamiliar diagnostic dashboards - both within Azure or in third-party solutions - to gain immediate value from the agent. The chat interface preserves conversation context across a session, enabling iterative investigation where each question builds on previous findings.

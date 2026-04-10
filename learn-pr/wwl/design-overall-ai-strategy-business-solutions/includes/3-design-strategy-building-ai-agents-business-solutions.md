## Unit overview

AI agents are becoming essential components in modern business solutions, enabling automated reasoning, decision-making, multi-step orchestration, and domain-specific assistance. Solution architects must be able to evaluate when to adopt **SaaS agents**, when to **extend existing copilots**, and when to **build custom AI agents** using platforms such as Microsoft Foundry or Copilot Studio.

This unit teaches architects how to define an end-to-end strategy for selecting, designing, and scaling AI agents aligned to organizational outcomes.

## Understanding the role of AI agents in business solutions

AI agents support business processes by automating tasks, synthesizing information, triggering workflows, or executing complex multi-step logic.

Microsoft's Cloud Adoption Framework describes a technology planning approach that helps solution architects decide whether to adopt a **ready-to-use SaaS agent**, or build custom agents using Foundry, Copilot Studio, or containerized models.

In Dynamics 365, copilots and domain-specific agents already deliver guided actions, summarization, automated updates, and customer service support. These built-in agents provide a benchmark for understanding functional requirements before building custom solutions.

For more information, see [AI agent adoption - Cloud Adoption Framework](/azure/cloud-adoption-framework/ai-agents/)

## Core principles for designing an AI agent strategy

### Align design with business outcomes

Always start with measurable business goals. Before selecting a platform or architecture, define:

- The operational problem being solved

- The measurable impact (efficiency, decision quality, reduced costs, improved response times)

- Stakeholder expectations and constraints

- This ensures technical decisions reinforce business value

### Choose the right agent type

Microsoft identifies three broad categories:

- **SaaS (prebuilt) agents** - immediate value, minimal customization

- **Low-code agents** - moderate customization, rapid deployment via Copilot Studio

- **Pro-code agents** - maximum flexibility for orchestrating complex business logic via Foundry or custom model hosting

- This tiered approach helps match functional requirements to appropriate technologies

### Prioritize responsible AI and governance

Agent reasoning must operate within defined boundaries.

Architects enforce and document design decisions such as:

- Data access controls

- Guardrails for actions and tool invocation

- Monitoring criteria

- Privacy boundaries

- Built-in responsible AI capabilities across Copilot Studio and Dynamics 365 copilots reduce the need for custom safeguards

## Technology decision framework for agent design

### The SaaS agent first principle

Begin with: **Does a SaaS agent meet the functional requirements?**

If yes, use it. If no, determine whether low-code or pro-code custom agents are needed.

- Microsoft's technology plan emphasizes this decision tree approach

### Custom agent platform choices

#### Copilot Studio (low-code / SaaS)

Best for:

- Fast deployment

- Direct integration with Dynamics 365 apps

- Business analyst-driven customization

- Retrieval and task agents

- Provides:

- Prebuilt connectors

- Azure AI Search integration

- Built-in responsible AI features

#### Microsoft Foundry (pro-code / PaaS)

Best for:

- Complex orchestrations and multi-agent workflows

- Custom logic, advanced generative behavior

- Integration with enterprise systems at scale

Foundry provides:

- Declarative or code-first agent models

- Hosted execution environment

- Model catalog with OpenAI, Anthropic, Meta, and Mistral options

- Support for Activity Protocol and agent-to-agent interactions

#### GPUs & containers (pro-code / IaaS)

Use when:

- You need full control of model execution

- Agents must run on private, isolated compute

- Strict compliance environments require BYO model hosting

## Architectural design considerations

### Plan for single-agent vs multi-agent systems

Start with a single agent unless the use case:

- crosses security or compliance boundaries

- requires orchestration across multiple teams

- demands modular specialization

- Only scale to multi-agent systems after validating complexity drivers

### Integrate agents with enterprise data

Data quality, relevance, and accessibility determines agent reliability. Architects must define:

- Grounding data sources

- Data quality and freshness expectations

- Indices and schemas for retrieval

- Least-privilege access models

- Dynamics 365 copilots illustrate how deep domain data integration improves task success rates

### Align deployment with operational realities

Choosing the right hosting and security model depends on:

- Required network isolation

- Expected latency and availability

- Integration with Azure management and monitoring

- Operational continuity and change management processes

- Foundry's standard setup supports private networking for sensitive workloads

## Professional visuals and recommended charts

For the detailed AI Agent decision tree, see the following for more information [technology solutions plan strategy - Cloud Adoption Framework](/azure/cloud-adoption-framework/ai-agents/technology-solutions-plan-strategy)

### Agent architecture comparison chart

| **Solution** | **Approach** | **Agent types** | **Best for** |
|---|---|---|---|
| **SaaS agents** | Ready-to-use (SaaS) | Retrieval, Task | Personal productivity. Requires minimal customization to deliver immediate value. |
| **Microsoft Foundry** | Pro-code and low/no-code (PaaS) | Retrieval, Task, Autonomous | Strategic transformation. Supports deep integration and custom logic. |
| **Microsoft Copilot Studio** | Low/no-code (SaaS) | Retrieval, Task, Autonomous | Process transformation. Enables fast development with minimal coding and SaaS security. |
| **GPUs and containers** | Pro-code (PaaS or IaaS) | Retrieval, Task, Autonomous | Compliance-sensitive or highly customized (custom model configurations, private networking, strict isolation) workloads with full control of the entire technology stack. |

[Technology solutions plan strategy - Cloud Adoption Framework](/azure/cloud-adoption-framework/ai-agents/technology-solutions-plan-strategy)

## Summary

A strategic design approach ensures that AI agents enhance business operations while keeping governance, security, and operational readiness aligned with enterprise needs. Solution architects must balance speed, capability, and safety when determining how to design and adopt agents across their organizations. By applying the technology plan and understanding existing copilots in Dynamics 365, architects can create scalable, responsible AI solutions.

## References

- [Technology Plan for AI Agents across your organization - Cloud Adoption Framework](/azure/cloud-adoption-framework/ai-agents/technology-solutions-plan-strategy)

- [Copilot and generative AI in Dynamics 365](/dynamics365/copilot/)
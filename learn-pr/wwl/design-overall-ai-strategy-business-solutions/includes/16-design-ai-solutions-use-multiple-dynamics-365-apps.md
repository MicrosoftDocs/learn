## Unit overview

This unit equips solution architects with the skills to design AI solutions that operate across multiple Dynamics 365 applications. Modern AI-powered business processes often span Dynamics 365 Sales, Customer Service, Finance, Field Service, and custom line-of-business extensions. To design scalable solutions, architects must understand how AI components orchestrate data, context, and business events across different workloads while ensuring consistency, compliance, and performance.

This unit synthesizes best practices for multi-app architectures, intent-driven AI patterns, multi-session app concepts, and Dynamics 365 agent models.

## Dynamics 365 in multi-app AI architectures

AI solutions used across Dynamics 365 apps must consider:

### Shared business context

Cross-application scenarios require a unified view of customer, product, or operational state. AI components must interpret signals from multiple workloads and present a consistent, accurate representation back to users—no matter where interaction begins.

### Process continuity across apps

Sales → Customer Service → Finance → Field Service workflows may be sequential or parallel.

AI agents must maintain context so users can "continue where they left off," regardless of the application surface.

### Data interoperability

Multi-app AI relies on enterprise-grade data practices:

- Harmonized Dataverse tables

- Consistent entity schemas

- Clean integration boundaries

- Event-driven data flows

AI models must ground responses exclusively on authoritative, governed sources to prevent drift in multi-app scenarios.

## Using multi-session app patterns

Multi-session capabilities in Dynamics 365 allow complex tasks to unfold across extended time periods, supporting multi-step workflows often required in AI-driven processes.

### Why multi-session matters for AI

AI systems need time-persistent context for:

- Case classification and routing

- Opportunity progression

- Follow-up actions requiring user review

- Escalations that rely on history, notes, and interactions

Architects must design AI processes around long-lived business objects and incorporate session persistence into model inputs and AI-generated recommendations.

### Key considerations

- Use session metadata to maintain continuity

- Store AI insights in structured entities

- Avoid embedding volatile or short-lived content in prompts

- Keep user tasks modular for automation enhancements

## Single-agent vs. multi-agent architectures in Dynamics 365 AI solutions

AI solutions can use a **single agent** or **multiple agents** depending on complexity, autonomy, and data reach requirements.

### Single-agent approach

Best for:

- Simple, linear workflows

- Single business domain

- Tasks requiring minimal orchestration

Example: A single AI agent assisting with case triage.

### Multi-agent approach

Best for:

- Complex cross-domain processes

- Orchestration across multiple Dynamics apps

- Multi-step autonomous coordination

Multi-agent Dynamics 365 patterns align with:

- Planner agent → orchestrates business flow

- Worker agent(s) → retrieve domain-specific information

- Reviewer agent → validate recommendations against business rules

AI solutions spanning multiple Dynamics apps commonly benefit from this architecture.

## Intent-driven AI for multi-app Dynamics 365 scenarios

Intent-driven architectures allow AI to determine the user's goal and route the request appropriately across apps.

### Core principles

**Intent parsing**: Determine if the ask belongs to Sales, Service, or another workload

**Context routing**: Map the intent to the correct app and entity

**Adaptive actions**: Use business rules to adjust next steps dynamically

**Event-based triggers**: Use Dataverse events while minimizing point-to-point integrations

### Architectural benefits

- Reduces custom workflow logic scattered across apps

- Enables reusable, centralized AI patterns

- Scales easily to new business processes

## AI design considerations across multiple Dynamics apps

### Data readiness

- Unified data modeling

- High-quality entity relationships

- Attribute consistency across workloads

### Security & compliance

- Honor app-specific and row-level security policies

- Ensure prompts and model responses use only permitted data

- Maintain lineage for auditability

### Operationalization

- Monitoring across all apps

- Logging interactions for analysis

- Versioning AI models and agents

### User experience

- Consistent Copilot experiences

- AI recommendations that adapt to the active app

- Clear explanations so users trust workflows

## References

- Bridging AI and Dynamics — a scalable architecture for intent-driven applications. [https://dev.to/deep_sharma/bridging-ai-and-dynamics-a-scalable-architecture-for-intent-driven-applications-30jp](https://dev.to/deep_sharma/bridging-ai-and-dynamics-a-scalable-architecture-for-intent-driven-applications-30jp)

- Dynamics 365 Customer Service — enable customers to create multisession apps (2025 wave 1). [/dynamics365/release-plan/2025wave1/service/dynamics365-customer-service/enable-customers-create-multisession-apps](/dynamics365/release-plan/2025wave1/service/dynamics365-customer-service/enable-customers-create-multisession-apps)
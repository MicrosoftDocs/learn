## Unit overview

This unit provides solution architects with expert-level guidance on determining when organizations should build **custom AI agents** versus when they should **extend Microsoft 365 Copilot**. You'll learn evaluation criteria, architectural decision factors, capability boundaries, and strategic considerations that influence when each approach best supports business needs.

Copilot Studio, Microsoft 365 Copilot extensibility, and Azure OpenAI-based custom agents all offer different strengths. Choosing the right approach ensures scalability, maintainability, security alignment, and measurable business value.

## Understanding the decision space

AI solutions within the Microsoft ecosystem span two primary approaches:

### Extending Microsoft 365 Copilot

Extend Copilot when:

- Core Copilot capabilities already perform most of the required tasks

- The business scenario aligns with productivity workflows inside Microsoft 365 apps

- You primarily need Copilot to use organizational knowledge and automate small tasks

- The solution benefits from Microsoft's built-in Responsible AI guardrails

- Custom logic, actions, and data integrations remain simple

Extensions typically include:

- Creating connectors and plugins

- Adding organization-specific knowledge sources

- Automating repetitive document and communication tasks

- Enhancing Copilot behavior in existing applications

### Building custom agents

Build custom agents when:

- You need specialized workflows that Copilot can't handle

- Your scenario requires custom reasoning patterns, multi-step logic, or orchestration

- Integration requires direct system APIs, external applications, or operational autonomy

- You need multi-agent collaboration or complex, domain-specific behavior

- You require execution outside Microsoft 365 environments

Custom agents provide greater control over:

- Prompt engineering and orchestration

- Data routing and grounding

- Tooling integration and model selection

- Multi-agent collaboration

- Operational behavior and lifecycle management

## Key architectural evaluation criteria

Below are critical criteria solution architects should consider when selecting an approach.

### Scope and complexity

| **Scenario Type** | **Recommended Approach** |
|---|---|
| **Simple retrieval or summarization** | Extend Copilot |
| **Complex multi-step workflow** | Build custom agent |
| **High-volume automation** | Build custom agent |
| **Productivity-only context** | Extend Copilot |

### Data requirements

Choose custom agents when:

- Data must be processed across systems outside Microsoft 365
- You need strict grounding control and advanced vector search behavior.

Extend Copilot when:

- Data lives primarily in Microsoft 365

- You require secure use of existing document graphs, semantic index, or organizational knowledge.

### Action and tooling requirements

Select custom agents if:

- You need to call specialized internal systems

- Actions require advanced logic, branching, or multi-step processes

- The environment must run independently from user interactions.

Extend Copilot if:

- Actions relate to calendar, email, file management, or standard workflows.

### Governance and compliance

Custom agents require:

- Custom governance and operational policy definitions

- Monitoring, evaluation, and model behavior controls

Copilot provides:

- Enterprise-grade safety and Responsible AI guardrails

- Built-in compliance and security

### Skill and operational maturity

Choose custom agents when:

- Development teams have strong expertise in Azure AI, agent orchestration, and system architecture.

Extend Copilot when:

- The team needs a low-code approach

- Rapid enablement outweighs customization needs.

## Decision framework summary

### Platform capability comparison matrix

| **Attribute** | **Copilot Extension** | **Custom Agent** |
|---|---|---|
| **Autonomy** | Low | High |
| **Custom Logic** | Limited | Extensive |
| **Data Variety** | Microsoft 365 | Any enterprise data |
| **Actions** | Simple | Complex + multi-step |
| **Orchestration** | None / Implicit | Full agent orchestration |
| **Governance** | Built-in | Custom required |

## Practical guidance for solution architects

### Choose to extend Microsoft 365 Copilot when

- The primary user interaction occurs in Word, Excel, Teams, or Outlook

- You want seamless integration with existing Microsoft 365 activities

- Productivity acceleration is the main objective

- Minimal engineering investment is required

- The solution must inherit Microsoft's Responsible AI compliance.

### Choose to build custom agents when

- Business rules require modeling complex domain logic

- You need orchestration across tools, APIs, or other agents

- Autonomy, continuous workflows, or system-wide triggers are important

- Integration with external enterprise systems is mandatory

- You must design specialized behaviors or multi-agent collaboration.

Custom agents excel in scenarios involving:

- Case management and complex decision flows

- Field operations automation

- Industry vertical solutions

- Multi-agent ecosystems with coordination and role specialization

## References

- [Introduction to Copilot declarative agents — when to use declarative agents](/training/modules/copilot-declarative-agent-intro/4-when-to-use-declarative-agents)

- [Microsoft AI Decision Framework — evaluation criteria](https://microsoft.github.io/Microsoft-AI-Decision-Framework/docs/evaluation-criteria.html)
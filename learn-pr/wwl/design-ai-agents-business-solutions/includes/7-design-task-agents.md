## Learning objectives

By the end of this unit, learners will be able to:
- Describe the core components that make up a task-focused agent in Microsoft Copilot Studio
- Design task agents that automate processes, support business workflows, and interact with enterprise data securely
- Map agent behaviors to organization-specific rules using goals, skills, actions, and grounding data
- Apply best practices to ensure task agents are reliable, predictable, and aligned with enterprise needs

## Introduction

Task agents are specialized AI agents designed to complete specific actions or tasks on behalf of users. In Microsoft Copilot Studio, task agents enable organizations to extend Copilot's intelligence into structured workflows, integrating business logic, APIs, and enterprise data.

Task agents help teams improve efficiency by:

- Automating repetitive or multi-step workflows

- Executing actions (e.g., creating records, updating data, triggering automations)

- Using context to make decisions

- Accessing organizational data safely and securely

- Supporting consistent processes across teams

Designing effective task agents requires understanding the architecture that drives how agents reason, take action, and collaborate with users.

## Components of a task agent

Task agents in Microsoft Copilot Studio use a modular architecture. Each component contributes to the agent's ability to act, reason, and integrate into business processes.

### Chart: Agent architecture components and their purpose

| **Component** | **Purpose** |
|---|---|
| **Goals** | Define what the agent is expected to accomplish |
| **Skills** | Capabilities used to achieve goals (extraction, reasoning, planning) |
| **Actions** | Executable operations via connectors, APIs, or workflows |
| **Knowledge** | Structured/unstructured information the agent can reference |
| **Context** | Enterprise data and signals influencing decisions |
| **Safety & Rules** | Guardrails that determine what the agent can and cannot do |

## Designing task agents

### Define the agent's purpose

Start with a clear business objective.

Examples:

- Automate order entry

- Summarize customer inquiries

- Trigger onboarding workflows

- Retrieve inventory status

- Create and assign work items

- Use clear, outcome-based goal statements

### Define agent goals

A goal is the agent's core mission.

Example goals:

- "Create a new sales record based on customer data."

- "Submit a support ticket with priority levels."

- "Generate a summary of a customer conversation."

Goals should be:

- Actionable

- Observable

- Testable

- Relatable to business outcomes

### Assign skills

Skills are the agent's "capabilities."

Core skill types include:

- **Language Understanding** (extract intent, classify messages)

- **Data Interpretation** (read, summarize, transform)

- **Planning** (sequence steps needed to complete a task)

- **Execution** (invoke actions to complete tasks)

### Add actions

Actions are created through:

- **Power Platform connectors**

- **Custom connectors**

- **APIs**

- **Dataverse operations**

- **Cloud flows**

Examples:

- Create a case

- Update a lead

- Send an approval request

- Retrieve a customer account

- Create a follow-up task

Each action requires:

- Input parameters

- Output schema

- Authentication

- Error handling rules

### Knowledge sources

Knowledge sources determine what content the agent can reference.

Examples:

- SharePoint libraries

- Product manuals

- Standard operating procedures

- Dataverse data

- Knowledge articles

Knowledge must be:

- Accurate

- Recent

- Governed

- Indexed

### Define safety rules

Rules constrain or direct agent behavior.

Examples:

- "Never override a customer's credit limit."

- "Always ask before submitting an order."

- "Escalate if the issue contains complaint keywords."

Rules ensure predictable and trustworthy agent behavior.

## Best practices for task agent design

- Start with one high-value workflow

- Keep goals small and focused

- Provide agents with clean, structured data

- Limit action permissions to lowest necessary scope

- Implement monitoring and logging

- Test with real scenarios and edge cases
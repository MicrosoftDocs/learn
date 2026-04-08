## Learning objectives

By the end of this unit, learners will be able to:
- Explain the purpose and value of autonomous agents in modern business solutions
- Identify the core components that make up an autonomous agent in Copilot Studio
- Design agent goals, triggers, instructions, and actions aligned to business requirements
- Test, refine, and publish autonomous agents for use in Microsoft Teams or enterprise workflows

## Introduction: What are autonomous agents?

Autonomous agents are **AI-powered systems that perform tasks independently** using business goals, contextual knowledge, and integrated instructions. They transform manual or repetitive business processes into automated, intelligent workflows.

In Copilot Studio, autonomous agents:

- Understand intent using built-in reasoning

- Access organizational knowledge to make informed decisions

- Execute tasks using connectors, actions, and triggers

- Operate inside Microsoft Teams or integrated enterprise applications

## Core components of an autonomous agent

Copilot Studio provides a structured architecture for designing autonomous agents. 

Key components include:

### Goals

Define what the agent is expected to accomplish (ex: "Create an onboarding request," "Summarize weekly reports").

### Triggers

Events that cause the agent to start, such as user input, system changes, or scheduled prompts.

### Instructions

Detailed business rules that guide agent behavior ("If the customer is VIP, escalate the ticket immediately").

### Knowledge sources

Documents, SharePoint libraries, Dataverse tables, and enterprise content the agent uses to ground responses.

### Actions

Executable operations the agent performs, such as calling APIs, creating records, sending emails, or updating CRM fields.

## Designing autonomous agents in Copilot Studio

Building an autonomous agent follows a structured workflow:

### Step 1 - Identify use case & expected outcome

Examples include:

- Automating onboarding workflows

- Managing follow-up actions

- Creating customer service tickets

### Step 2 - Build your agent

Copilot Studio provides a step-by-step builder:

- Create a new autonomous agent

- Set the agent's goal and system instructions

- Add knowledge sources (files, URLs, SharePoint sites)

- Configure triggers and decision-making logic

- Connect actions via Power Automate, connectors, or Dataverse

### Step 3 - Test & refine

Testing includes:

- Validating output accuracy

- Verifying correct grounding

- Reviewing action execution

### Step 4 - Deploy

- Agents can be published directly into **Microsoft Teams** for users to interact with

## Chart: Components of an autonomous agent

| **Component** | **Description** |
|---|---|
| **Goals** | Business outcomes that define what the agent must achieve |
| **Triggers** | Events initiating agent behavior |
| **Instructions** | Rules and guidelines shaping decision-making |
| **Knowledge** | SharePoint, URLs, Dataverse tables for grounding |
| **Actions** | Operational steps performed by the agent |
| **Publishing** | Deploy the agent into Teams or workflows |

## Best practices for designing autonomous agents

- Start with a simple, high-value use case

- Provide the agent with clean, structured instructions

- Limit the number of knowledge sources to maintain accuracy

- Use grounding sources that are approved, reviewed, and updated regularly

- Test business logic repeatedly before publishing

- Monitor agent performance and refine based on user feedback

## References

- [Build an autonomous agent in Copilot Studio](/training/modules/autonomous-agent/)
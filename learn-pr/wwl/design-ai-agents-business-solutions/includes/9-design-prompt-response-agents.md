## Learning objectives

By the end of this unit, learners will be able to:
- Design prompt-driven conversational agents using Copilot Studio topics, NLU boosting, system topics, conditions, and triggers
- Apply generative answering, conditional branching, and event-driven logic to build adaptive, context-aware agent responses
- Select and configure the appropriate mechanism — NLU Boost node, system topic, condition logic, or trigger — to produce reliable, grounded interactions

## Overview of prompt and response agents

Prompt and response agents in **Microsoft Copilot Studio** combine **natural language understanding (NLU)**, **topic-based logic**, and **event-driven behavior** to generate accurate answers and perform actions.

Agents process:

- **User prompts** → Identify intent

- **Knowledge sources / topics** → Retrieve content

- **Conditions** → Shape the dialog flow

- **Triggers** → Start actions from events instead of user queries

This modular architecture ensures flexibility and predictable results.

## NLU Boost & generative answers

### NLU Boost: Expanding understanding with generative answers

The **Generative Answers (NLU Boost) node** allows agents to answer questions using content from internal or external knowledge sources.

Agents can retrieve from:

- Public websites

- Dataverse documents

- SharePoint

- Enterprise connectors

- Custom data flows

If an agent **cannot match a topic**, it uses **generative answers as fallback** to respond based on available content.

### Customizing the response

Agents can store generated responses in variables, surface them on Adaptive Cards, and apply custom formatting before sending output to the user.

## Using system topics for core responses

System topics are built-in capabilities that provide ready-made responses for common situations such as:

- Greeting

- Escalation

- Fallback

- End of conversation

- Multiple topics matched (disambiguation)

- Error handling

System topics provide core conversation scaffolding and trigger automatically based on user messages or events.

### Why system topics matter

They ensure:

- Consistency

- Predictable behavior

- Standardized user experiences

- This allows designers to focus on advanced topics while relying on tested defaults

## Designing conditional responses (condition nodes)

Use **conditions** to shape dialog flow based on variables, values, and logic.

Condition nodes allow branching using:

- Comparisons

- Variables

- Operators (equals, greater than, blank, etc.)

- AND / OR logic

- Multiple branches (if, elseif, else)

Conditions enable agents to adapt responses based on:

- Customer type (VIP vs standard)

- Form input

- Conversation context

- Previous user messages

- Conditions also support **Power Fx formulas** when advanced logic is needed

## Using event triggers for autonomous actions

Event triggers enable agents to act **without waiting for a user prompt**.

Examples include:

- A file uploaded

- A task completed

- A Dataverse row added

- A scheduled recurrence

Triggers send payloads to agents that include:

- Data

- Instructions

- Execution context

Triggers support fully autonomous agent workflows, such as:

- Sending a summary

- Starting a topic

- Calling an action via connectors

- Updating records

- Triggers must be explicitly authorized and may impact billing consumption

## Chart: When to use each mechanism

| **Mechanism** | **Use When** |
|---|---|
| Generative Answers (NLU Boost) | User question not covered by topics; answer from knowledge bases required |
| System Topics | Greeting, fallback, escalation, errors, disambiguation |
| Condition Nodes | Branching dialog based on values or variables |
| Event Triggers | Agent must react to events rather than user queries |

## References

Use these links to access all source content for this unit:

- [NLU boost node](/microsoft-copilot-studio/nlu-boost-node)

- [Authoring system topics](/microsoft-copilot-studio/authoring-system-topics)

- [Authoring using conditions](/microsoft-copilot-studio/authoring-using-conditions)

- [Authoring triggers about](/microsoft-copilot-studio/authoring-triggers-about)
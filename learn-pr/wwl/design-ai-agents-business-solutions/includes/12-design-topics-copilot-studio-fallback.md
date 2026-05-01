## Learning objectives

By the end of this unit, learners will be able to:

- Describe topics and their role in Copilot Studio conversational design
- Build effective topics using triggers, messages, questions, actions, and conditions
- Configure and manage system fallback behavior to handle unmatched intent
- Apply best practices for designing scalable topic architectures for enterprise copilots

## Introduction to topics in Copilot Studio

Topics are the building blocks of conversational logic in Microsoft Copilot Studio. Each topic defines a **specific user intent**, aligned response flow, and connected actions. When a user enters a message, Copilot Studio evaluates the message and selects the most appropriate topic based on:

- Trigger phrases

- Natural language matching

- Orchestration and generative understanding

- Topics allow copilots to handle structured scenarios while combining them with generative responses where appropriate

## Key components of topics

Topics use modular components that define how the copilot interacts with users. 

### Trigger phrases

A trigger phrase signals the start of a topic. Example:"Track my order," "Update my profile," "I need support."

### Message nodes

Messages deliver information back to the user in a concise, conversational tone.

### Question nodes

Used to gather structured responses (choice lists, text, dates, numbers).

### Conditions and branching

Used to route users through different dialog paths depending on:

- Their input

- Business rules

- Context and variables

### Actions

Actions connect the copilot to business applications, databases, and workflows. Examples:

- Update a Dataverse record

- Trigger a Power Automate flow

- Retrieve external data

## Designing strong topics

To create effective conversational experiences, consider:

### Start with user intents

- Identify what users want to accomplish and group similar tasks.

### Write clear trigger phrases

- Use language real users would say.

### Keep dialog flows short

- Provide guidance without overwhelming the user.

### Use variables and context

- Store user choices or retrieved values to maintain continuity.

### Reuse components

- Create shared topics for authentication, FAQs, and repeated logic.

## Designing and configuring the system fallback topic

When the copilot cannot match the user's message to a known topic, the **fallback topic** ensures a graceful experience.

### Purpose of fallback

Fallback protects against:

- Unrecognized intent

- Unexpected phrasing

- Missing topic coverage

### What fallback should do

A well-designed fallback topic should:

- **Acknowledge misunderstanding** - *"I'm not sure I understood that."*

- **Offer alternative choices** - Present suggested intents or help options

- **Redirect to a human agent** - (optional) Applicable in support or escalation scenarios

- **Capture user feedback** - Improve future topic coverage

### Avoid overuse

Fallback shouldn't replace strong intent recognition. Ensure topics cover the most common scenarios.

## Chart: Topic types in Copilot Studio

| **Topic Type** | **Purpose** | **Example** |
|---|---|---|
| Instructional Topic | Guides the user through a task | "Reset MFA method" |
| Action Topic | Runs an automated step | "Create support ticket" |
| Informational Topic | Provides structured information | "Business hours" |
| System Topic | Handles system-level events | Greeting, escalation, fallback |
| Reusable Topic | Shared logic across topics | Authentication |

## Best practices for topic and fallback design

- Prioritize clarity and brevity in message nodes
  
- Use structured questions to reduce ambiguity
  
- Leverage entity extraction for important data such as names, numbers, or dates

- Maintain consistent tone following Microsoft Writing Style Guide

- Ensure fallback pathways are supportive and not abrupt

- Test with real-world phrasing and / or recorded customer language

## References

- [Authoring system fallback topic](/microsoft-copilot-studio/authoring-system-fallback-topic)

- [Topics overview](/microsoft-copilot-studio/guidance/topics-overview)

- [Manage topics in Microsoft Copilot Studio](/training/modules/manage-power-virtual-agents-topics/)

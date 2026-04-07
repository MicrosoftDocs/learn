## Unit Overview

This unit introduces how to design intelligent agents and agent flows within **Microsoft Copilot Studio**, using natural language, visual design, and automation best practices. Agent flows extend an agent's capabilities by enabling it to **automate repetitive tasks**, **connect systems**, and **trigger business logic**.

Copilot Studio provides a unified environment where makers can build agents, add knowledge, create flows, integrate data, and orchestrate end-to-end business processes. Agent flows simplify automation while maintaining consistent execution and visibility across enterprise workloads.

## Learning objectives

By the end of this unit, learners will be able to:
- Design agents using Copilot Studio's authoring surfaces (Describe, Configure, Test, Publish).
- Create **Agent Flows** using natural language and the visual designer.
- Identify **triggers** and **actions**, the two primary building blocks of agent flows.
- Integrate agent flows with existing systems to create end-to-end automation.

## 1. Designing agents in Copilot Studio

Agents in Copilot Studio are configured through the **Describe** and **Configure** steps. Makers can define an agent's purpose, goals, instructions, and behavior using natural language and structured settings.

### 1.1 Define the agent

Agents are created by describing:

- Purpose.

- Behaviors.

- Tasks.

- Operational boundaries.

Copilot Studio generates an initial agent with instructions and a structure that can be refined through configuration.

### 1.2 Add knowledge sources

Agents require domain knowledge to respond effectively. Supported grounding sources include:

- SharePoint sites and folders.

- Microsoft 365 content.

- Public websites.

- Linked knowledge bases.

### 1.3 Enable capabilities

Agents can incorporate capabilities such as:

- Code Interpreter (Python).

- Image Generator.

- Rich adaptive card responses.

## 2. Designing agent flows in Copilot Studio

### 2.1 What are agent flows?

Agent flows automate tasks, integrate services, and extend agent behavior. They run natively inside Copilot Studio and are fully optimized for agent execution.

Agent flows offer:

- **Consistent execution**

- **End-to-end process visibility**

- **No Power Automate license requirement**

- **Support for natural language automation**.

### 2.2 Triggers and actions

Every agent flow includes:

| **Component** | **Description** |
|---|---|
| **Trigger** | How a flow starts - manual, scheduled, system event, or another agent. |
| **Action** | Operation performed by the flow (send email, update data, retrieve information). |

### 2.3 Creating an agent flow

Agent flows can be built in two ways:

**Method A: Natural Language Prompting**

- Makers describe what they want, e.g.,

- "When a customer submits a form, send a confirmation email and update the CRM record.".

- Copilot generates the workflow automatically.

**Method B: Visual Designer**

The flow can be refined using a node-based visual canvas for full control over logic and branching.

## 3. Integrating agent flows with enterprise systems

Agent flows connect Copilot Studio agents to systems such as:

- Microsoft Forms.

- Dynamics 365.

- Dataverse.

- Email services.

- APIs and custom connectors.

Agent flows enable:

- Multistep workflows.

- Automated responses.

- CRM updates.

- Notifications and escalations[[linkedin.com]](https://www.linkedin.com/pulse/mastering-agent-flows-copilot-studio-step-by-step-guide-dhruvin-shah-mtzxf/).

## 4. Chart: Agent vs cloud flows

| **Feature** | **Agent Flow** | **Power Automate Cloud Flow** |
|---|---|---|
| **Licensing** | Uses Copilot Studio message capacity | Requires Power Automate license |
| **Trigger types** | User messages, scheduled, events | Connectors, triggers, system events |
| **Best for** | AI-driven conversational automation | Enterprise integration automation |
| **Builder experience** | Natural language + visual canvas | Connector-driven workflow design |

 - Step by step guide [[linkedin.com]](https://www.linkedin.com/pulse/mastering-agent-flows-copilot-studio-step-by-step-guide-dhruvin-shah-mtzxf/).


## 5. Best practices

Start with a clear business scenario.

Keep agent instructions concise using Microsoft Writing Style Guide guidance.

Use natural language prompting for rapid prototyping; refine using visual designer.

Test agent + flow interactions together.

Monitor analytics for flow errors and user experience issues.

Keep flows modular - one flow per major task or automation.

## 6. References

[Use agent flows](/training/modules/use-agent-flows/).

[Copilot Studio](/copilot-studio).




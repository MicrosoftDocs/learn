## Overview

This unit teaches solution architects how to design, build, and operationalize agents in Microsoft 365 Copilot by leveraging Agent Builder and scenario-driven design approaches. You will learn the architectural considerations, governance needs, lifecycle stages, and best practices for scaling agent solutions across the Microsoft 365 ecosystem.

Agents in Microsoft 365 Copilot act as intelligent, task-oriented components that perform operations on behalf of users, automate workflows, retrieve and summarize information, and collaborate with other systems. To design effective agents, architects must consider user intent, data access boundaries, security, compliance, and extensibility across Microsoft 365 workloads.

In this learning module, students will learn the following:

- The foundations of Microsoft 365 Copilot agent.
- The agent design framework
- How design the **Designing Collaborative Agents**

## Foundations of Microsoft 365 Copilot agents

### What is a Copilot agent?

A Copilot agent is a modular, instruction-driven AI component designed to perform a specific business task or workflow. These agents follow structured instructions, leverage organizational data, and use tools and connectors to take action.

#### Agents typically support

**Task automation** (scheduling, research, workflow execution)

**Information retrieval** from Microsoft Graph and integrated systems

**Multi-step operations** such as classification, analysis, or routing

**Collaboration workflows** such as draft creation or summaries

#### Where agents operate

Copilot agents work directly inside:

Microsoft Teams

Microsoft Outlook

Microsoft Loop

SharePoint

Custom line-of-business applications via extensibility points

Architects align agent design with business processes already occurring in these applications.

## Agent design framework

Below are the foundations of an agent design framework that solution architects should follow when designing the use cases for agents in Microsoft 365 Copilot. 

### A. Understand the core problem

Begin by defining:

What task is the agent responsible for?

What business goal does it support?

What decisions does it need to make?

What systems must it interact with?

Agents should solve a single high-value need such as:

Lead and opportunity preparation

Case triage and response drafting

Policy or knowledge Q&A

Cross-app summarization for productivity

Workflow routing decisions

### B. Define agent behavior

Specify:

Role (e.g., "act as a customer service triage assistant")

Capabilities allowed / not allowed

Guardrails (tone, content boundaries, compliance limits)

Conditions that escalate to human review

### C. Connect data and tools

Agents rely on:

Microsoft Graph data

Organizational content (SharePoint, OneDrive, Teams messages, files)

**Built-in connectors and actions**

Custom APIs when required

Architects ensure the agent works within least-privilege and zero-trust boundaries.

### Designing collaborative agents

Collaborative agents support multi-step workflows across Microsoft 365 apps. They can pass context, reuse structured instructions, and build on each other's output.

#### Patterns for collaboration

**Sequential workflow**<br>Agent A → Agent B → User review

**Parallel evaluation**<br>Multiple agents score or analyze data, then combine results

**Feedback-loop iteration**<br>Agent refines content (drafts, insights, summaries) until quality is met

**Orchestrated interaction**<br>A primary agent delegates subtasks based on intent or conditions

Architects define clear handoff rules and responsibility boundaries to ensure predictable outcomes.

## Building agents with Agent Builder

### Leveraging Agent Builder in Microsoft 365 Copilot is the easiest way to build custom declarative agents.

### Agent Builder provides a guided environment to rapidly create agents with

Step-by-step configuration

**Built-in tool access**

Declarative instruction authoring

Testing and validation workspace

Publishing controls to Microsoft 365

### Agent Builder workflow

Define the agent's purpose

Add instructions, tasks, and guardrails

Connect data sources

Configure actions and permissions

Test with sample prompts

Publish to targeted users or groups

Agent Builder enforces clarity of intent and ensures enterprise-grade safety.

## Managing Copilot agent scenarios

Solution architects must facilitate and design operational readiness and lifecycle planning for agents deployed across the organization.

### Operational responsibilities

Monitor agent quality and user feedback

Update instructions for accuracy

Enforce access control and data protections

Review logs for compliance

Version agents using governance processes

Identify new scenarios based on user demand

### Scenario design considerations

Does the scenario require cross-app context?

Do users benefit from automated task execution?

Will the agent support frontline or knowledge workers?

What latency, safety, or reliability constraints apply?

## References

[https://learn.microsoft.com/en-us/copilot/microsoft-365/microsoft-365-copilot-page?view=o365-worldwide](/copilot/microsoft-365/microsoft-365-copilot-page)

[https://learn.microsoft.com/en-us/microsoft-365-copilot/extensibility/agent-builder-build-agents](/microsoft-365-copilot/extensibility/agent-builder-build-agents)

<https://blog.ciaops.com/2025/08/16/building-a-collaborative-microsoft-365-copilot-agent-a-step-by-step-guide/>

[https://learn.microsoft.com/en-us/microsoft-365-copilot/extensibility/agent-builder](/microsoft-365-copilot/extensibility/agent-builder) 
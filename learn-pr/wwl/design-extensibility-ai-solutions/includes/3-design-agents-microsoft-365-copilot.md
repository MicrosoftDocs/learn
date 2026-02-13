## Overview

This unit teaches solution architects how to design, build, and operationalize agents in Microsoft 365 Copilot by leveraging Agent Builder and scenariodriven design approaches. You will learn the architectural considerations, governance needs, lifecycle stages, and best practices for scaling agent solutions across the Microsoft 365 ecosystem.

Agents in Microsoft 365 Copilot act as intelligent, taskoriented components that perform operations on behalf of users, automate workflows, retrieve and summarize information, and collaborate with other systems. To design effective agents, architects must consider user intent, data access boundaries, security, compliance, and extensibility across Microsoft 365 workloads.

In this learning module, students will learn the following:

- The foundations of Microsoft 365 Copilot agent.
- The agent design framework
- How design the **Designing Collaborative Agents**

## 1. Foundations of Microsoft 365 Copilot Agents

### What Is a Copilot Agent?

A Copilot agent is a modular, instructiondriven AI component designed to perform a specific business task or workflow. These agents follow structured instructions, leverage organizational data, and use tools and connectors to take action.

#### Agents typically support:

**Task automation** (scheduling, research, workflow execution)

**Information retrieval** from Microsoft Graph and integrated systems

**Multistep operations** such as classification, analysis, or routing

**Collaboration workflows** such as draft creation or summaries

#### Where Agents Operate

Copilot agents work directly inside:

Microsoft Teams

Microsoft Outlook

Microsoft Loop

SharePoint

Custom lineofbusiness applications via extensibility points

Architects align agent design with business processes already occurring in these applications.

## 2. Agent Design Framework

Below are the foundations of an agent design framework that solution architects should follow when designing the use cases for agents in Microsoft 365 Copilot. 

### A. Understand the Core Problem

Begin by defining:

What task is the agent responsible for?

What business goal does it support?

What decisions does it need to make?

What systems must it interact with?

Agents should solve a single highvalue need such as:

Lead and opportunity preparation

Case triage and response drafting

Policy or knowledge Q&A

Crossapp summarization for productivity

Workflow routing decisions

### B. Define Agent Behavior

Specify:

Role (e.g., "act as a customer service triage assistant")

Capabilities allowed / not allowed

Guardrails (tone, content boundaries, compliance limits)

Conditions that escalate to human review

### C. Connect Data and Tools

Agents rely on:

Microsoft Graph data

Organizational content (SharePoint, OneDrive, Teams messages, files)

Builtin connectors and actions

Custom APIs when required

Architects ensure the agent works within leastprivilege and zerotrust boundaries.

### 3. Designing Collaborative Agents

Collaborative agents support multistep workflows across Microsoft 365 apps. They can pass context, reuse structured instructions, and build on each other's output.

#### Patterns for Collaboration

**Sequential workflow**<br>Agent A → Agent B → User review

**Parallel evaluation**<br>Multiple agents score or analyze data, then combine results

**Feedbackloop iteration**<br>Agent refines content (drafts, insights, summaries) until quality is met

**Orchestrated interaction**<br>A primary agent delegates subtasks based on intent or conditions

Architects define clear handoff rules and responsibility boundaries to ensure predictable outcomes.

## 4. Building Agents with Agent Builder

### Leveraging Agent Builder in Microsoft 365 Copilot is the easiest way to build custom declarative agents.

### Agent Builder provides a guided environment to rapidly create agents with

Stepbystep configuration

Builtin tool access

Declarative instruction authoring

Testing and validation workspace

Publishing controls to Microsoft 365

### Agent Builder Workflow

Define the agent's purpose

Add instructions, tasks, and guardrails

Connect data sources

Configure actions and permissions

Test with sample prompts

Publish to targeted users or groups

Agent Builder enforces clarity of intent and ensures enterprisegrade safety.

## 5. Managing Copilot Agent Scenarios

Solution architects must facilitate and design operational readiness and lifecycle planning for agents deployed across the organization.

### Operational Responsibilities

Monitor agent quality and user feedback

Update instructions for accuracy

Enforce access control and data protections

Review logs for compliance

Version agents using governance processes

Identify new scenarios based on user demand

### Scenario Design Considerations

Does the scenario require crossapp context?

Do users benefit from automated task execution?

Will the agent support frontline or knowledge workers?

What latency, safety, or reliability constraints apply?

## 6. Professional Visuals (TextBased for Word)

### Visual 1 - Agent Architecture Model

User Action 

    ↓

Microsoft 365 Application (Teams, Outlook, Loop)

    ↓

Copilot Agent Instructions & Policies

    ↓

Tools & Connectors (Graph, SharePoint, APIs)

    ↓

Business Logic Execution

    ↓

Response Back to User

### Visual 2 - Collaborative Agent Workflow

Primary Agent (Intent Detection)

      ↓ determines task

SubAgent A (Data Gathering)    SubAgent B (Draft Generation)

      ↓                                 ↓

     Combined Output → Human Review → Publish/Act

### Visual 3 - Agent Governance Lifecycle

Design → Build → Test → Deploy → Monitor → Improve

## References

[https://learn.microsoft.com/en-us/copilot/microsoft-365/microsoft-365-copilot-page?view=o365-worldwide](/copilot/microsoft-365/microsoft-365-copilot-page)

[https://learn.microsoft.com/en-us/microsoft-365-copilot/extensibility/agent-builder-build-agents](/microsoft-365-copilot/extensibility/agent-builder-build-agents)

<https://blog.ciaops.com/2025/08/16/building-a-collaborative-microsoft-365-copilot-agent-a-step-by-step-guide/>

[https://learn.microsoft.com/en-us/microsoft-365-copilot/extensibility/agent-builder](/microsoft-365-copilot/extensibility/agent-builder) 
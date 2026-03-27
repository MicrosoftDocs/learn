## Overview

This unit equips solution architects with expert guidance to design, orchestrate, and scale AIpowered experiences within Dynamics 365 Customer Service and Contact Center. You will learn how to integrate Copilot capabilities, automate service workflows, augment agent productivity, and ensure AI is aligned with customer experience (CX) objectives, governance requirements, and enterprise architecture.

### This unit focuses on:

* Designing serviceoriented AI patterns in Dynamics 365.

* Using conversational, embedded, and automated AI features to enhance case management, triage, and customer interaction quality.

* Structuring scalable AI solutions across omnichannel service operations.

* Applying extensibility options to tailor Copilot for complex business processes.

## 1. Understanding of the AI capabilities within Dynamics 365 Customer Service and Contact Center

AI within Dynamics 365 Customer Service enhances how agents resolve issues, locate knowledge, manage cases, and collaborate with customers. AI becomes a reliable service partner when using Dynamics 365 Customer Service and Contact Center by reducing manual effort, improving case accuracy, and enabling faster customer resolutions.

There are three types of AI capabilities:

1. Agent Hub
1. Autonomous service agents
1. Copilot in Contact Center

### Agent Hub

Agent hub in Dynamics 365 Contact Center and Customer Service is a one-stop hub that empowers admins and supervisors to safely adopt autonomous AI agents, monitor impact, and make informed, responsible decisions. For more information, see [Overview of agent hub | Microsoft Learn](/dynamics365/contact-center/administer/overview-agent-hub)

### Autonomous service agents

**Customer Intent Agent:** Autonomously discover intents by analyzing past and current cases and customer conversations

For more information, see [Overview of Customer Intent Agent | Microsoft Learn](/dynamics365/contact-center/administer/overview-customer-intent-agent)

**Case Management Agent: Automate the case life cycle for service representatives by automating the create, update, resolve, and close processes of cases.** 

For more information, see [https://learn.microsoft.com/en-us/dynamics365/customer-service/use/use-case-creation-agent](/dynamics365/customer-service/use/use-case-creation-agent) 

**Customer knowledge Management Agent:** 

* For more information, see [https://learn.microsoft.com/en-us/dynamics365/customer-service/use/admin-km-agent-insights](/dynamics365/customer-service/use/admin-km-agent-insights) 

**Quality Evaluation Agent:** 

* For more information, see [https://learn.microsoft.com/en-us/dynamics365/contact-center/administer/manage-quality-evaluation-agent#manage-quality-evaluation-agent](/dynamics365/contact-center/administer/manage-quality-evaluation-agent) 

### Copilot in Contact Center

Copilot provides real-time AI assistance that helps customer service representatives (service representatives or representatives) automate time-consuming tasks to handle cases efficiently and resolve issues faster so that they can deliver value to customers. Copilot features can include asking a question, composing an email, summarizing a case, and summarizing a conversation. The features may be embedded with the application or be run as a standalone. Not all capabilities are available in all capacities. For more information, see [Enable Copilot features | Microsoft Learn](/dynamics365/contact-center/administer/configure-copilot-features)

## 2. AI Experience Models in Customer Service

### 2.1 Conversational Copilot (Sidecar Model)

A chat based experience that:

* Understands agent questions about cases, customers, and policies.

* Generates summaries, troubleshooting steps, or drafted responses.

* Provides contextual insights from Dynamics 365 records.

### 2.2 Embedded Intelligent Features

These appear within workspaces such as:

* Case forms

* Customer timelines

* Knowledge articles

* Embedded AI analyzes the page context and proactively suggests actions or insights.

### 2.3 Automated AI Behaviors

Examples include:

* AIdriven case routing

* Automatic sentiment tagging

* Predictive escalation triggers

* These allow service managers to scale consistent customer experiences.

## 3. Designing AI Architecture Across CX Workloads

Solution architects ensure AI aligns with business goals, service capabilities, and enterprise governance.

Key design considerations:

* **Data quality:** CRM fields, history, interactions, SLAs, and knowledge must be accurate and complete.

* **Security & privacy:** Ensure AI respects data access levels, customer privacy, and compliant handling of sensitive data.

* **Service consistency:** AI recommendations must reflect policies, tone, and approved workflows.

* **Extensibility:** Integrate custom prompts, workflows, models, and automation patterns through Power Platform or Azure services.

## 4. Orchestration Models for Customer Service AI

### 4.1 Casecentric orchestration

AI anchors around the customer case:

Reads description, notes, conversations.

Suggests next actions.

Generates resolution summaries.

### 4.2 Interactioncentric automation

AI analyzes:

Customer messages (email, chat).

Knowledge article links.

Relevant troubleshooting procedures.

### 4.3 Multisystem orchestration

AI workflows may require:

Dynamics 365 Customer Service + Field Service

Customer Service + Finance (billing / refunds)

Customer Service + Power Automate for escalations

Architects align AI agents with crossdepartmental processes.

## 5. Designing Extensible AI Features

Copilot and Customer Service AI features are extensible through:

* **Custom prompts and behaviors**

* **Power Automate flows**

* **Plugins and custom actions**

* **Azure OpenAI integrations**

* **Knowledge retrieval extensions**

Best practice:<br>**Modularize AI behaviors** so that service teams can update logic without rewriting the entire solution.

## References

<https://www.microsoft.com/en-us/dynamics-365/resources/customer-service>

[https://www.microsoft.com/en-us/dynamics-365/products/customer-service#Agents](https://www.microsoft.com/en-us/dynamics-365/products/customer-service) 

[https://learn.microsoft.com/en-us/dynamics365/customer-service/copilot](/dynamics365/customer-service/copilot)

[https://learn.microsoft.com/en-us/dynamics365/customer-service/service-workspace](/dynamics365/customer-service/service-workspace)

[Manage Customer Knowledge Management Agent | Microsoft Learn](/dynamics365/customer-service/administer/admin-km-agent)
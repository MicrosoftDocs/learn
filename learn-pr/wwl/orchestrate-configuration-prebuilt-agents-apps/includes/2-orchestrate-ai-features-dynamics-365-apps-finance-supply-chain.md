## Overview

AI capabilities in Dynamics 365 Finance and Supply Chain apps help organizations automate decision-making, accelerate operational workflows, and improve user productivity. Copilot provides conversational assistance, AI-driven insights, and embedded intelligent actions that work across finance, procurement, warehousing, planning, and supply chain operations.

Solution architects must design AI orchestration patterns that ensure data governance, responsible AI usage, and workflow consistency across modules. This unit provides guidance on orchestrating Copilot-driven features—sidecar chat experiences, embedded insights, and external AI agents—to create cohesive, compliant, and scalable AI-enabled business processes.

## AI Experience Models in Dynamics 365 Finance and Supply Chain

### 1. Sidecar

Sidecar Copilot appears alongside the Finance and Supply Chain apps and supports natural language chat. Users can ask questions, request insights, or invoke actions.

#### Common sidecar capabilities include:

* **Generative help and guidance**: Explain features, processes, and actions in the app.

* **Workflow summaries**: Summarize journal history, approvals, or operational status.

* **Chat with finance and operations data**: Support natural language queries against business data models.

#### Architectural considerations

* Optimize prompts with businessdomain vocabulary.

* Apply rolebased access so users only retrieve data appropriate to their permissions.

* Orchestrate crossmodule queries using standardized entity metadata.

## 2. Embedded

Embedded AI brings Copilot capabilities directly inside workspace pages or operational views, enabling contextual, inapp intelligence.

### Examples include:

* **Purchase order change analysis**

* **Customer collections summaries**

* **Demand planning insights**

* **Supplier communication drafting**

### Benefits

* Enhances user efficiency where work is performed.

* Surfaces recommended actions inside operational workflows.

* Reduces navigation overhead and manual analysis.

### Architectural implications

* Ensure embedded AI uses authoritative data entities.

* Validate that embedded capabilities align with business rules.

* Update extensions to handle model changes introduced by AI workflows.

## 3. Outside (External Orchestration with Copilot)

External agents interact with Finance and Supply Chain data beyond the application UI and help orchestrate across different apps and tasks. 

### Examples:

* Crossapplication automations.

* Rolespecific AI copilots in Teams.

* Workflow routing and automated notifications.

### Design guidelines

* Use Dataverse or custom APIs for consistent and governed data access.

* Ensure all AI orchestration scenarios follow organizational data residency and privacy rules.

* Validate that actions triggered externally match security and approval constraints in Dynamics.

### Key AI Capabilities in Finance and Supply Chain

#### Finance-Specific AI Capabilities

* Collections coordinator summaries

* Customer page summaries

* Statement posting summaries

* Opportunity and risk analysis

#### Supply Chain Capabilities

* AI-augmented demand planning

* Warehouse workload insights

* Supplier communication agent

* Change review for confirmed purchase orders

#### CrossApp Capabilities

* Generative help

* Enhanced feedback loops

* Natural language data assistance

#### Extending Copilot for Finance and Supply Chain

Solution architects can extend Copilot experiences using:

* **Custom scripts and extensions** through the developer framework.

* **Prompt-defined behaviors** within sidecar experiences.

* **Custom data sources**, such as external knowledge or structured business content.

* **Business event triggers** connected to Power Automate or Azure Functions.

* **Custom actions** that Copilot can call as part of a guided workflow.

#### Best practices

* Keep extensions modular and compliant with solution boundaries.

* Apply Responsible AI guidelines to all prompts and custom instructions.

* Align Copilot extensions with existing workflows to avoid duplication and inconsistencies.

* Copilot sidecar experiences need to understand the context in which the user is working in. for that reason, application context with Copilot is available to embed in the flow of the business process. The integration will include three types of context: For more information, see the following: [Use application context with Copilot - Finance & Operations | Dynamics 365 | Microsoft Learn](/dynamics365/fin-ops-core/dev-itpro/copilot/copilot-application-context)

* The creation of client plugins, or client actions, are Microsoft Copilot plugins that invoke client code and are available for users in the context of client experiences for finance and operations apps. For more information see the following: [https://learn.microsoft.com/en-us/dynamics365/fin-ops-core/dev-itpro/copilot/tutorial-create-client-plugins](/dynamics365/fin-ops-core/dev-itpro/copilot/tutorial-create-client-plugins) 

* Plugins must be created using the Copilot in Finance and Operation chatbot with an X++ method created in the application. For more information, see the following: [https://learn.microsoft.com/en-us/dynamics365/fin-ops-core/dev-itpro/copilot/copilot-architecture](/dynamics365/fin-ops-core/dev-itpro/copilot/copilot-architecture) 


## References

[https://learn.microsoft.com/en-us/dynamics365/fin-ops-core/fin-ops/copilot/copilot-for-finance-operations](/dynamics365/fin-ops-core/fin-ops/copilot/copilot-for-finance-operations)

[https://learn.microsoft.com/en-us/dynamics365/fin-ops-core/dev-itpro/copilot/extend-copilot](/dynamics365/fin-ops-core/dev-itpro/copilot/extend-copilot)

[Create client plugins for Copilot in finance and operations apps - Finance & Operations | Dynamics 365 | Microsoft Learn](/dynamics365/fin-ops-core/dev-itpro/copilot/copilot-client-plugins)

[https://learn.microsoft.com/en-us/dynamics365/fin-ops-core/dev-itpro/copilot/copilot-architecture](/dynamics365/fin-ops-core/dev-itpro/copilot/copilot-architecture) 

[Use application context with Copilot - Finance & Operations | Dynamics 365 | Microsoft Learn](/dynamics365/fin-ops-core/dev-itpro/copilot/copilot-application-context)
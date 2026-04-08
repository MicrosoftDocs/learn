## Overview

Dynamics 365 Finance & Operations now supports **Copilot client plugins**, enabling solution architects to extend the built-in F&O agent with **additional knowledge sources**, **custom actions**, and **domain-specific logic**.

This unit equips learners to design interoperable agent experiences that combine:

* F&O system data

* External knowledge sources

* Custom business logic

* Plugin-based actions

* Secure, governed access patterns

The goal is to help organizations create richer, more accurate, and more context-aware AI experiences inside F&O agent chats.

By the end of this unit, learners will be able to:

* Explain how Copilot client plugins extend Finance & Operations agent chats

* Identify additional knowledge sources appropriate for F&O agents

* Design interoperability patterns between F&O data, plugins, and external content

* Configure agent behaviors that use multiple knowledge sources responsibly

* Apply governance, security, and lifecycle best practices

## Understanding F&O Agent Interoperability

### The F&O Copilot agent is designed to

* Answer questions using system data

* Execute actions through plugins

* Retrieve information from external knowledge sources

* Provide contextual, grounded responses

### How Interoperability Works

* User asks a question in F&O Copilot

* Agent determines intent

* Agent selects the appropriate knowledge source

* F&O data

* Plugin action

* External knowledge base

* Agent synthesizes a grounded response

* Agent optionally performs an action (e.g., create a record)

### Why Interoperability Matters

* Many business processes span multiple systems

* F&O data alone may not answer all questions

* Plugins allow the agent to "reach out" to other systems

* External knowledge sources enrich reasoning and context

## Additional Knowledge Sources for F&O Agents

Solution architects can extend the agent with:

### A. External Knowledge Bases

Examples

* SharePoint libraries

* Policy documents

* Vendor portals

* Product catalogs

* Standard operating procedures

### B. Line-of-Business Systems

Using plugins or APIs

* CRM

* HR systems

* Procurement portals

* Manufacturing execution systems

### C. Custom Datastores

* Azure SQL

* Dataverse tables

* Azure Cognitive Search indexes

### D. Domain-Specific Content

Compliance rules

Financial policies

Inventory classification rules

Pricing guidelines

These sources help the agent answer questions that F&O alone cannot.

## Designing Copilot Client Plugins for Interoperability

### Plugins allow the agent to

* Retrieve data

* Perform actions

* Trigger workflows

* Integrate with external systems

### Plugin Capabilities

* Define custom actions

* Provide structured responses

* Enforce business logic

* Support multi-step workflows

### Plugin Design Considerations

* What data or action is missing from F&O

* What external system must be accessed

* What business logic must be enforced

* What constraints or validations are required

## Designing Interoperable Agent Experiences

### A. Map Business Questions to Knowledge Sources

Example

"What is the current vendor credit limit?"<br>→ F&O data

"What is the vendor's latest compliance certificate?"<br>→ SharePoint

"Can you update the vendor's payment terms?"<br>→ Plugin action

### B. Use Plugins to Bridge System Gaps

Plugins can:

* Fetch external data

* Validate business rules

* Trigger workflows

* Write back to F&O

### C. Combine Knowledge Sources in a Single Response

Example

"Your vendor is approved in F&O, and their latest compliance certificate (SharePoint) expires in 30 days."

### D. Ensure Grounding and Accuracy

* Use authoritative sources

* Avoid inaccurate outputs

* Validate external data before use

## Governance, Security, and Lifecycle Considerations

### A. Permissions

* Plugins must respect F&O security roles

* External knowledge sources must enforce access control

* Agents must not expose sensitive data

### B. Responsible AI

* Provide transparent explanations

* Avoid unsupported assumptions

* Log plugin actions

### C. Monitoring & Maintenance

* Track plugin usage

* Update knowledge sources regularly

* Review agent responses for accuracy

## References

[https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/copilot/copilot-client-plugins](/dynamics365/fin-ops-core/dev-itpro/copilot/copilot-client-plugins)
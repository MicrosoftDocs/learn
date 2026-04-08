## Learning objectives

By the end of this unit, learners will be able to:
- Identify the categories of Azure AI Foundry tools available for agent development and orchestration
- Match business or technical requirements to the correct tool in the Foundry tool catalog
- Recommend appropriate Foundry tools for building, grounding, extending, or operationalizing AI agents
- Evaluate constraints such as data access, API type, compute needs, and integration patterns

## Introduction

Azure AI Foundry provides a **catalog of tools** that agents can use to perform tasks such as retrieving data, calling APIs, grounding responses, orchestrating workflows, and triggering actions across applications.

When designing an AI agent, selecting the correct tool is essential. The goal is to choose tools that:

- **Meet the requirement with minimal complexity**

- **Ensure security and compliance**

- **Leverage existing enterprise systems**

- **Reduce integration overhead**

- **Support accurate, grounded outputs**

## Categories of Foundry tools

_Based on Azure AI Foundry tool catalog organization_.

Azure AI Foundry tools fall into several functional categories commonly used when designing AI agents.

### Retrieval and grounding tools

Used when the agent must **access enterprise knowledge** or **retrieve relevant documents**. Typical capabilities include:

- Vector search

- Hybrid (keyword + semantic) search

- Indexing structured or unstructured sources

- Querying enterprise knowledge bases

### Data and application connectors

Used when the agent must interact with business applications or databases:

- CRM systems

- ERP or financial systems

- Line-of-business apps

- SQL databases or Cosmos DB

- REST or Graph API endpoints

### Workflow and action tools

Used to trigger **automated business actions**, such as:

- Creating records

- Updating cases

- Sending notifications

- Triggering Power Automate flows

- Calling custom API operations

### Reasoning, planning, and execution tools

Used when the agent must:

- Evaluate conditions

- Break tasks into steps

- Select the right action

- Handle branching logic

### Specialized tools

Used for purpose-specific capabilities:

- Document summarization

- Classification

- Custom ML model execution

- Safe completion and validation tools

## Proposing tools for requirements

Below are examples of how to map business requirements to the correct Foundry tools.

### Requirement type: Retrieve policies, guidelines, or knowledge

**Recommended Tools:**

- **Retrieval tools** (vector search)

- **Hybrid search connectors**

- **SharePoint / OneDrive document ingestion tools**

**Why:** These tools ground an agent in enterprise knowledge while respecting security controls.

### Requirement type: Integrate with business systems (CRM, ERP, HR)

**Recommended Tools:**

- **Native application connectors** (Dynamics, SAP, ServiceNow, custom APIs)

- **Custom REST/Graph API connectors**

**Why:** Allow agents to read/write data in enterprise-approved systems.

### Requirement type: Execute multistep workflows

**Recommended Tools:**

- **Power Automate flow connector**

- **Workflow orchestration tools**

- **Custom action tools**

**Why:** These tools let agents trigger actions reliably and repeatedly.

### Requirement type: Analyze or transform data

**Recommended Tools:**

- **Azure Functions** (lightweight compute tasks)

- **ML model tools** (classification, extraction, scoring)

- **Data transformation connectors**

**Why:** They enable structured, controlled processing before returning results.

### Requirement type: Build advanced reasoning or task decomposition

**Recommended Tools:**

- **Planner / Reasoning tools**

- **LLM-based decision tools**

- **Context evaluators**

**Why:** These tools help agents choose the right next step safely.

## Chart: Mapping requirements to Foundry tools

| **Requirement Type** | **Recommended Tool Category** | **Examples** |
|---|---|---|
| Document retrieval | Retrieval & Grounding | Vector search, semantic search |
| App integration | App & Data Connectors | REST APIs, Dynamics connector |
| Workflow automation | Workflow & Action | Power Automate, custom actions |
| Data processing | Compute Tools | Azure Functions, ML Tools |
| Decision and planning | Reasoning Tools | Planner, rule evaluators |

## References

(Use these for learner follow-up)

- [Azure AI Foundry tool catalog](/azure/ai-foundry/agents/concepts/tool-catalog)

- Azure AI Foundry Tools <https://azure.microsoft.com/products/ai-foundry/tools/>

## Overview

This unit provides solution architects with expert-level guidance on designing enterprise-grade AI solutions by using custom models in Microsoft Foundry. It explains when custom models are appropriate, how Foundry supports model development and lifecycle management, and how to architect scalable and secure AI solutions that integrate with Microsoft cloud services and line-of-business applications.

Microsoft Foundry enables organizations to build, fine-tune, evaluate, deploy, and operate custom AI models aligned with their business constraints, data governance requirements, and performance needs. Instead of relying only on pre-built models, custom models provide deeper control over reasoning, domain specificity, and compliance—making them essential for advanced AI workloads.

In this learning module, students will learn the following:

- When to use custom models
- Understand the architecture foundations in Microsoft Foundry
- How to design AI solutions with custom models
- How to operationalize custom models in Foundry

## When to use custom models

Solution architects determine when custom AI models are needed by evaluating business complexity, data requirements, regulatory needs, and performance targets.

### Appropriate scenarios

**Domain-specific language and reasoning**<br>Industries such as legal, healthcare, engineering, finance, and manufacturing require AI models that understand specialized terminology and follow domain-specific logic.

**High-impact decision processes**<br>Custom models are used when accuracy directly affects compliance, financial outcomes, or operational safety.

**Data sovereignty and governance mandates**<br>Custom models enable organizations to determine exactly how data is processed, stored, evaluated, and monitored.

**Unique workflows or personalization requirements**<br>Pre-built copilots may not support custom interaction patterns, long-running processes, or proprietary toolchains.

**Cost optimization for high-volume inference**<br>Small, specialized custom models can provide performance and cost advantages over large foundation models.

## Understanding architecture foundations in Microsoft Foundry

Microsoft Foundry provides an end-to-end platform for custom model development, including tools for data preparation, training, evaluation, deployment, observability, and governance.

### Key architectural elements

**Model Catalog**<br>Offers base models that can be fine-tuned or enhanced using enterprise data and specialized tasks.

**Training and Fine-tuning Pipelines**<br>Help orchestrate data ingestion, labeling, evaluation, and iterative improvements at scale.

**Agent and Tooling Integration**<br>Custom models can be embedded into Foundry agents and orchestrations to support multi-step reasoning and automated workflows.

**Responsible AI Controls**<br>Includes content filtering, safety evaluation, transparency artifacts, policy enforcement, and auditability.

**Deployment Topologies**

Hosted secure environments

Private networking deployments

Integration with Azure Kubernetes Service and Foundry runtime environments

## Designing AI solutions with custom models

Solution architects should follow a structured, repeatable design approach to ensure models align with business objectives.

### Step 1 — Define the business objectives

Identify measurable outcomes (accuracy goals, time-saved targets, cost-efficiency goals).

Map objectives to use cases where custom models outperform standard copilots.

### Step 2 — Assess data requirements

Evaluate available proprietary datasets.

Identify gaps in labeling, quality, diversity, or structure.

Ensure governance policies allow data to be used in model training.

### Step 3 — Select the custom model path

#### Typical options include

**Fine-tuning foundation models**<br>Adjust behavior using domain datasets without full retraining.

**Training domain-built small models**<br>Useful for lightweight tasks requiring speed and edge compatibility.

**Hybrid architectures**<br>Combining custom models with prebuilt copilots for augmented reasoning.

### Step 4 — Integration with enterprise systems

#### Custom models should integrate with

Dynamics 365 applications

Azure Functions and Logic Apps

Foundry agent workflows

Azure AI Search and data stores

Business process automation pipelines

### Step 5 — Validation and evaluation

#### Establish a rigorous testing plan

Scenario-based evaluations

Safety and bias analysis

Stress, latency, and scaling tests

ROI measurement and business validation

## Operationalizing custom models in Foundry

Modern AI systems require robust operational frameworks, especially with custom AI models. Foundry has tools to help support these custom AI models for long term feasibility. 

### Key operational components

**Model Monitoring and Observability**<br>Track drift, performance degradation, user friction areas, latency, and unexpected model outputs.

**Governance and Compliance Controls**<br>Ensure every deployment meets enterprise privacy, security, and regulatory requirements.

**Versioning and Lifecycle Management**<br>Maintain clear model version trails, update pipelines, and rollback strategies.

**Deployment Automation (MLOps/GenAIOps)**<br>Automate validations, approval workflows, and environment-specific deployments.

## Professional visuals (text-based)

These visuals can be directly converted into diagrams for Word or PowerPoint.

### Visual A — Custom model decision matrix

Decision Factor             | Standard Copilot | Custom Model (Foundry)

-----------------------------------------------------------------------

Domain specificity needed    | Low              | High

Compliance restrictions      | Moderate         | High

Performance requirements     | Medium           | High

Data confidentiality         | Medium           | Full control

Workflow complexity          | Low/Medium       | High

Inference cost optimization  | Moderate         | High (small language models)

### Visual B — Custom model development lifecycle

Business Goal → Data Collection → Data Preparation →

Model Selection → Training/Fine-Tuning → Evaluation →

Deployment → Monitoring & Optimization

### Visual C — AI solution architecture (Foundry)

User Request

    ↓

Foundry Agent Orchestration

    ↓

Custom Model Inference Engine

    ↓

Enterprise Data Connectors & Tools

    ↓

Business Outcome Returned to Application

## References

[https://learn.microsoft.com/en-us/training/modules/choose-ai-agent-development-path/](/training/modules/choose-ai-agent-development-path/)
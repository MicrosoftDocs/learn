## Overview

This unit provides solution architects with expertlevel guidance on designing enterprisegrade AI solutions by using custom models in Microsoft Foundry. It explains when custom models are appropriate, how Foundry supports model development and lifecycle management, and how to architect scalable and secure AI solutions that integrate with Microsoft cloud services and lineofbusiness applications.

Microsoft Foundry enables organizations to build, finetune, evaluate, deploy, and operate custom AI models aligned with their business constraints, data governance requirements, and performance needs. Instead of relying only on prebuilt models, custom models provide deeper control over reasoning, domain specificity, and compliance—making them essential for advanced AI workloads.

In this learning module, students will learn the following:

- When to use custom models
- Understand the architecture foundations in Microsoft Foundry
- How to design AI solutions with custom models
- How to operationalize custom models in Foundry

## 1. When to Use Custom Models

Solution architects determine when custom AI models are needed by evaluating business complexity, data requirements, regulatory needs, and performance targets.

### Appropriate Scenarios

**Domainspecific language and reasoning**<br>Industries such as legal, healthcare, engineering, finance, and manufacturing require AI models that understand specialized terminology and follow domainspecific logic.

**Highimpact decision processes**<br>Custom models are used when accuracy directly affects compliance, financial outcomes, or operational safety.

**Data sovereignty and governance mandates**<br>Custom models enable organizations to determine exactly how data is processed, stored, evaluated, and monitored.

**Unique workflows or personalization requirements**<br>Prebuilt copilots may not support custom interaction patterns, longrunning processes, or proprietary toolchains.

**Cost optimization for highvolume inference**<br>Small, specialized custom models can provide performance and cost advantages over large foundation models.

## 2. Understanding Architecture Foundations in Microsoft Foundry

Microsoft Foundry provides an endtoend platform for custom model development, including tools for data preparation, training, evaluation, deployment, observability, and governance.

### Key Architectural Elements

**Model Catalog**<br>Offers base models that can be finetuned or enhanced using enterprise data and specialized tasks.

**Training and FineTuning Pipelines**<br>Help orchestrate data ingestion, labeling, evaluation, and iterative improvements at scale.

**Agent and Tooling Integration**<br>Custom models can be embedded into Foundry agents and orchestrations to support multistep reasoning and automated workflows.

**Responsible AI Controls**<br>Includes content filtering, safety evaluation, transparency artifacts, policy enforcement, and auditability.

**Deployment Topologies**

Hosted secure environments

Private networking deployments

Integration with Azure Kubernetes Service and Foundry runtime environments

## 3. Designing AI Solutions with Custom Models

Solution architects should follow a structured, repeatable design approach to ensure models align with business objectives.

### Step 1 — Define the Business Objectives

Identify measurable outcomes (accuracy goals, timesaved targets, costefficiency goals).

Map objectives to use cases where custom models outperform standard copilots.

### Step 2 — Assess Data Requirements

Evaluate available proprietary datasets.

Identify gaps in labeling, quality, diversity, or structure.

Ensure governance policies allow data to be used in model training.

### Step 3 — Select the Custom Model Path

#### Typical options include:

**Finetuning foundation models**<br>Adjust behavior using domain datasets without full retraining.

**Training domainbuilt small models**<br>Useful for lightweight tasks requiring speed and edge compatibility.

**Hybrid architectures**<br>Combining custom models with prebuilt copilots for augmented reasoning.

### Step 4 — Integration with Enterprise Systems

#### Custom models should integrate with:

Dynamics 365 applications

Azure Functions and Logic Apps

Foundry agent workflows

Azure AI Search and data stores

Business process automation pipelines

### Step 5 — Validation and Evaluation

#### Establish a rigorous testing plan:

Scenariobased evaluations

Safety and bias analysis

Stress, latency, and scaling tests

ROI measurement and business validation

## 4. Operationalizing Custom Models in Foundry

Modern AI systems require robust operational frameworks, especially with custom AI models. Foundry has tools to help support these custom AI models for long term feasibility. 

### Key Operational Components

**Model Monitoring and Observability**<br>Track drift, performance degradation, user friction areas, latency, and unexpected model outputs.

**Governance and Compliance Controls**<br>Ensure every deployment meets enterprise privacy, security, and regulatory requirements.

**Versioning and Lifecycle Management**<br>Maintain clear model version trails, update pipelines, and rollback strategies.

**Deployment Automation (MLOps/GenAIOps)**<br>Automate validations, approval workflows, and environmentspecific deployments.

## 5. Professional Visuals (TextBased)

These visuals can be directly converted into diagrams for Word or PowerPoint.

### Visual A — Custom Model Decision Matrix

Decision Factor             | Standard Copilot | Custom Model (Foundry)

-----------------------------------------------------------------------

Domain specificity needed    | Low              | High

Compliance restrictions      | Moderate         | High

Performance requirements     | Medium           | High

Data confidentiality         | Medium           | Full control

Workflow complexity          | Low/Medium       | High

Inference cost optimization  | Moderate         | High (SLMs)

### Visual B — Custom Model Development Lifecycle

Business Goal → Data Collection → Data Preparation →

Model Selection → Training/Fine-Tuning → Evaluation →

Deployment → Monitoring & Optimization

### Visual C — AI Solution Architecture (Foundry)

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
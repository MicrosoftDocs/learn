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

#### Domain-specific language and reasoning

Industries such as legal, healthcare, engineering, finance, and manufacturing require AI models that understand specialized terminology and follow domain-specific logic.

#### High-impact decision processes

Custom models are used when accuracy directly affects compliance, financial outcomes, or operational safety.

#### Data sovereignty and governance mandates

Custom models enable organizations to determine exactly how data is processed, stored, evaluated, and monitored.

#### Unique workflows or personalization requirements

Pre-built copilots may not support custom interaction patterns, long-running processes, or proprietary toolchains.

#### Cost optimization for high-volume inference

Small, specialized custom models can provide performance and cost advantages over large foundation models.

## Understanding architecture foundations in Microsoft Foundry

Microsoft Foundry provides an end-to-end platform for custom model development, including tools for data preparation, training, evaluation, deployment, observability, and governance.

### Key architectural elements

#### Model catalog

Offers base models that can be fine-tuned or enhanced using enterprise data and specialized tasks.

#### Training and fine-tuning pipelines

Help orchestrate data ingestion, labeling, evaluation, and iterative improvements at scale.

#### Agent and tooling integration

Custom models can be embedded into Foundry agents and orchestrations to support multi-step reasoning and automated workflows.

#### Responsible AI controls

Includes content filtering, safety evaluation, transparency artifacts, policy enforcement, and auditability.

#### Deployment topologies

- Hosted secure environments.
- Private networking deployments.
- Integration with Azure Kubernetes Service and Foundry runtime environments.

## Designing AI solutions with custom models

Solution architects should follow a structured, repeatable design approach to ensure models align with business objectives.

### Step 1. Define the business objectives

- Identify measurable outcomes, such as accuracy goals, time-saved targets, and cost-efficiency goals.
- Map objectives to use cases where custom models outperform standard copilots.

### Step 2. Assess data requirements

- Evaluate available proprietary datasets.
- Identify gaps in labeling, quality, diversity, or structure.
- Ensure governance policies allow data to be used in model training.

### Step 3. Select the custom model path

Typical options include:

#### Fine-tuning foundation models

Adjust behavior using domain datasets without full retraining.

#### Training domain-built small models

Useful for lightweight tasks requiring speed and edge compatibility.

#### Hybrid architectures

Combine custom models with prebuilt copilots for augmented reasoning.

### Step 4. Integrate with enterprise systems

Custom models should integrate with:

- Dynamics 365 applications.
- Azure Functions and Logic Apps.
- Foundry agent workflows.
- Azure AI Search and data stores.
- Business process automation pipelines.

### Step 5. Validate and evaluate

Establish a rigorous testing plan that includes:

- Scenario-based evaluations.
- Safety and bias analysis.
- Stress, latency, and scaling tests.
- ROI measurement and business validation.

## Operationalizing custom models in Foundry

Modern AI systems require robust operational frameworks, especially for custom AI models. Foundry has tools to support these models for long-term feasibility.

### Key operational components

#### Model monitoring and observability

Track drift, performance degradation, user friction areas, latency, and unexpected model outputs.

#### Governance and compliance controls

Ensure every deployment meets enterprise privacy, security, and regulatory requirements.

#### Versioning and lifecycle management

Maintain clear model version trails, update pipelines, and rollback strategies.

#### Deployment automation (MLOps/GenAIOps)

Automate validations, approval workflows, and environment-specific deployments.

### Custom model decision matrix

| Decision factor | Standard Copilot | Custom model (Foundry) |
| --- | --- | --- |
| Domain specificity needed | Low | High |
| Compliance restrictions | Moderate | High |
| Performance requirements | Medium | High |
| Data confidentiality | Medium | Full control |
| Workflow complexity | Low/Medium | High |
| Inference cost optimization | Moderate | High (small language models) |

## References

[https://learn.microsoft.com/en-us/training/modules/choose-ai-agent-development-path/](/training/modules/choose-ai-agent-development-path/)

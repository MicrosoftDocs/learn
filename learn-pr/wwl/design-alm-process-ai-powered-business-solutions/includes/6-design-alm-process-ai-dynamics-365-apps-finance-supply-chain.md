## Overview

This unit teaches solution architects how to design a complete Application Lifecycle Management (ALM) process for AI components used in Microsoft Dynamics 365 Finance and Dynamics 365 Supply Chain Management.<br>AI capabilities in these applications—such as predictions, anomaly detection, document understanding, knowledge retrieval, and Copilot-driven assistance—require controlled ALM practices to ensure data quality, compliance, security, and operational reliability.

### A robust ALM process helps teams

* Maintain consistent and reliable AI behavior across environments.

* Protect financial and supply chain data according to organizational governance.

* Manage model versions, prompts, data dependencies, and automations predictably.

* Enable continuous improvement while minimizing operational risk.

## ALM Foundations for AI in Dynamics 365 Finance and Supply Chain

AI features in these workloads operate across ERP data, process automation, and model-driven decision logic. Designing ALM requires a layered approach combining:

### AI Assets to Govern

* **AI models** (prediction, scoring, classification, anomaly detection)

* **Prompts and instructions** for Copilot assistance

* **Feature engineering pipelines**

* **Knowledge sources** (documents, tasks guides, structured data entities)

* **Automations and orchestration flows**

* **Integration components** (Connectors, Dataverse virtual entities, APIs)

### Core ALM Principles

* Enforce **environment separation** (Dev → Test → Prod).

* Use **version control** for models, data schemas, and AI configuration.

* Assign **roles and responsibilities** for approvals and review cycles.

* Maintain **repeatable deployment patterns** through managed solutions or deployment pipelines.

* Support **end-to-end traceability** across model development, tuning, deployment, and retirement.

## Environment Strategy

### Environment Purposes

| **Environment** | **Purpose** |
|---|---|
| **DEV** | Build and iterate AI models, prompts, orchestration logic, and integrations. |
| **TEST** | Validate with safe, anonymized production-like data. Perform regression checks. |
| **PROD** | Execute approved AI capabilities in live financial and supply chain workloads. |

### Key Requirements

* No direct edits in production.

* Use environment variables for endpoints, model names, and connection strings.

* Maintain separate data sources, including synthetic datasets for safe Test operations.

## AI Development and Data Preparation

### Data Contract for Finance and Supply Chain AI

Define:

* Financial and operational entities required by the AI model.

* Valid ranges, constraints, and business rules.

* Sensitivity labels for financial and personally identifiable data.

* Schema version identifiers to align data pipelines with ALM promotion gates.

### Preparing Training and Evaluation Data

* Build **curated datasets** for training (DEV).

* Build **gold datasets** for evaluation (TEST).

* Keep datasets versioned and immutable once promoted.

* Document data sources, transformations, and assumptions.

## Model Development and Configuration

### AI Model Work Products

* Model architecture

* Hyperparameters

* _Hyperparameters are external configuration settings, such as learning rate, batch size, or network layers, that define a machine learning model's structure and behavior before training begin_

* Training configuration

* Performance metrics

* Business constraints and output expectations

### Prompts and Copilot Configuration

* Prompts must reflect ERP terminology, policies, roles, and business context.

* Align terminology with Finance and Supply Chain metadata (e.g., vendor, ledger, work order, production order).

* Validate prompt behavior through scenario-based testing.

## ALM Promotion Gates

A structured process ensures only validated models move forward.

### Gate 1 — DEV → TEST

Criteria:

* Data profiling complete and approved.

* Training and prompt logic documented.

* Initial quality and safety evaluations passed.

### Gate 2 — TEST → PROD

Criteria:

* Model evaluation thresholds met (accuracy, relevancy, stability).

* No bias or unsafe output in validation scenarios.

* Performance verified under ERP workload constraints.

* Security, compliance, and data residency reviews completed.

* Deployment package approved by architecture and governance teams.

## Deployment and Release Management

### Deployment Packaging

* Package AI models, prompts, knowledge assets, and automation flows into versioned releases.

* Use managed solutions or automated pipelines to ensure predictable deployments.

### Release Readiness Checklist

* Finalized model and prompt versions

* Configuration of environment variables

* Synthetic and real evaluation results documented

* Backout and rollback plans

* Monitoring dashboards activated

## Monitoring, Risk Controls, and Continuous Improvement

### Operational Monitoring

* Latency, success rates, and exception rates

* Prediction drift (accuracy changes over time)

* Data drift (input patterns deviate from training data)

* User feedback and Copilot satisfaction indicators

### Risk & Compliance Controls

* Data residency requirements for financial data

* Sensitivity labelling enforcement

* DLP rules for AI actions

* Guardrails for business-critical processes (e.g., posting journals, approving purchase orders)

### Continuous Improvement Loop

* Capture telemetry.

* Identify drift or inefficiencies.

* Retrain or refine prompts/models.

* Reevaluate using Test environment.* 

* Promote upgraded versions through ALM gates.

## References

[https://learn.microsoft.com/training/modules/describe-microsoft-power-platform-administration-governance/6-describe-application-lifecycle-management-power-platform](/training/modules/describe-microsoft-power-platform-administration-governance/6-describe-application-lifecycle-management-power-platform)

<br>[https://learn.microsoft.com/dynamics365/fin-ops-core/dev-itpro/dev-tools/version-control-metadata-navigation](/dynamics365/fin-ops-core/dev-itpro/dev-tools/version-control-metadata-navigation)
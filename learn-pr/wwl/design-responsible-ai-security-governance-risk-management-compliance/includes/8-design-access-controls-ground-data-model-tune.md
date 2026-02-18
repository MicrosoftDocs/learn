## Overview

Designing access controls for grounding data and modeltuning workflows is a critical responsibility for solution architects. AI systems depend on trustworthy, policyaligned grounding data and secure tuning processes to ensure predictable, compliant, and responsible outputs. Effective controls protect sensitive assets, enforce the principle of least privilege, and ensure AI behaviors remain aligned with organizational, legal, and ethical requirements.

This unit provides a structured approach for evaluating and designing access controls around data ingestion, grounding retrieval, model evaluations, and supervised finetuning workflows.

## 1. Foundation: Access Control Strategy for Grounding Data

Grounding data is the authoritative information used to produce reliable model responses. Access to these data sources must follow a structured authorization model that protects confidentiality and prevents ungoverned data use.

### Key Design Principles

- **Least privilege by default:** Allow the minimum necessary access for each role, agent, model, or service.

- **Rolealigned data partitions:** Separate grounding data by function (e.g., customer support, finance, engineering).

- **Clear ownership and stewardship:** Assign accountable stakeholders who govern quality and security of each data domain.

- **Auditability:** All access events and data retrieval operations must be logged and reviewable.

### Recommended Architecture

:::image type="content" source="../media/recommended-architecture.png" alt-text="Recommended Architecture Diagram.":::

## 2. Securing Grounding Data Retrieval Workflows

AI systems retrieve grounding data during search, retrievalaugmented generation (RAG), or context assembly. Each retrieval mechanism must enforce:

- **Connectorlevel authorization:** restricting which data types the model can query

- **Structured query filtering:** preventing models from accessing disallowed fields

- **DLP and sensitivity labeling:** applied across all data stores

- **Regionaligned access rules:** ensuring data residency adherence

- **Retrieval Access Flow:** Prompt → Policy Check → Search Index → Sanitization Layer → Model Context Injection

## 3. Access Controls for Model Tuning

Modeltuning operations—evaluation, supervised finetuning, or reinforcement learning—require elevated permissions. These processes must be insulated from production operations.

### Model Tuning Access Requirements

- Segregated environments for **development, evaluation, and production**

- Approval workflows for introducing new training datasets

- Verified data lineage and documentation of tuning datasets

- Security scanning of all tuning inputs

- Restricted ability to promote new tuned models into production

### Model Tuning Role Matrix

:::image type="content" source="../media/model-tuning-role-matrix.png" alt-text="Model Tuning Role Matrix.":::

## 4. Designing Guardrails for Grounding Data and Tuning Inputs

Guardrails protect both users and the system by preventing unsafe or noncompliant data from influencing model behavior.

### Examples of Guardrails

- Blocklists for prohibited document types

- Sanitization pipelines removing PII or contractual data

- Automated reviews validating safety and policy alignment

- Alerting and anomaly detection for unusual data access or tuning patterns

### Guardrail Enforcement Model

:::image type="content" source="../media/guardrail-enforcement-model.png" alt-text="Guardrail Enforcement Model.":::

## 5. Operational Monitoring and Compliance Enforcement

Continuous monitoring ensures access controls work as intended.

### Operational Controls

- Logging for prompt activity, tuning actions, and retrievalbased access

- Periodic reviews of RBAC assignments

- Automated anomaly alerts for abnormal retrieval patterns

- Governance dashboards tracking how grounding data is used

## References

- [https://learn.microsoft.com/en-us/training/modules/embrace-responsible-ai-principles-practices/7-put-responsible-ai-frameworks](/training/modules/embrace-responsible-ai-principles-practices/7-put-responsible-ai-frameworks)

- [https://learn.microsoft.com/en-us/training/modules/build-copilot-ai-studio/3-search-data](/training/modules/build-copilot-ai-studio/3-search-data)

- [https://learn.microsoft.com/en-us/azure/well-architected/ai/grounding-data-design](/azure/well-architected/ai/grounding-data-design)

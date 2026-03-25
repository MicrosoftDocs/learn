## Overview

Designing access controls for grounding data and model-tuning workflows is a critical responsibility for solution architects. AI systems depend on trustworthy, policy-aligned grounding data and secure tuning processes to ensure predictable, compliant, and responsible outputs. Effective controls protect sensitive assets, enforce the principle of least privilege, and ensure AI behaviors remain aligned with organizational, legal, and ethical requirements.

This unit provides a structured approach for evaluating and designing access controls around data ingestion, grounding retrieval, model evaluations, and supervised fine-tuning workflows.

## Access control strategy for grounding data

Grounding data is the authoritative information used to produce reliable model responses. Access to these data sources must follow a structured authorization model that protects confidentiality and prevents ungoverned data use.

### Key design principles

- **Least privilege by default:** Allow the minimum necessary access for each role, agent, model, or service.

- **Role-aligned data partitions:** Separate grounding data by function (e.g., customer support, finance, engineering).

- **Clear ownership and stewardship:** Assign accountable stakeholders who govern quality and security of each data domain.

- **Auditability:** All access events and data retrieval operations must be logged and reviewable.

## Securing grounding data retrieval workflows

AI systems retrieve grounding data during search, retrieval-augmented generation (RAG), or context assembly. Each retrieval mechanism must enforce:

- **Connector-level authorization:** restricting which data types the model can query

- **Structured query filtering:** preventing models from accessing disallowed fields

- **DLP and sensitivity labeling:** applied across all data stores

- **Region-aligned access rules:** ensuring data residency adherence

- **Retrieval Access Flow:** Prompt → Policy Check → Search Index → Sanitization Layer → Model Context Injection

## Access controls for model tuning

Model-tuning operations—evaluation, supervised fine-tuning, or reinforcement learning—require elevated permissions. These processes must be insulated from production operations.

### Model tuning access requirements

- Segregated environments for **development, evaluation, and production**

- Approval workflows for introducing new training datasets

- Verified data lineage and documentation of tuning datasets

- Security scanning of all tuning inputs

- Restricted ability to promote new tuned models into production

## Designing guardrails for grounding data and tuning inputs

Guardrails protect both users and the system by preventing unsafe or non-compliant data from influencing model behavior.

### Examples of guardrails

- Blocklists for prohibited document types

- Sanitization pipelines removing PII or contractual data

- Automated reviews validating safety and policy alignment

- Alerting and anomaly detection for unusual data access or tuning patterns

:::image type="content" source="../media/guardrail-enforcement-model.png" alt-text="Guardrail Enforcement Model.":::

## Operational monitoring and compliance enforcement

Continuous monitoring ensures access controls work as intended.

### Operational controls

- Logging for prompt activity, tuning actions, and retrieval-based access

- Periodic reviews of RBAC assignments

- Automated anomaly alerts for abnormal retrieval patterns

- Governance dashboards tracking how grounding data is used

## References

- [Put responsible AI frameworks into practice](/training/modules/embrace-responsible-ai-principles-practices/7-put-responsible-ai-frameworks)

- [Search data for building a copilot in AI Studio](/training/modules/build-copilot-ai-studio/3-search-data)

- [Grounding data design for AI workloads](/azure/well-architected/ai/grounding-data-design)

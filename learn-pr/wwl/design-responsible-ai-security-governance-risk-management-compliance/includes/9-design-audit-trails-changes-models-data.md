Audit trails are essential for maintaining trust, compliance, and operational integrity across AI-driven systems. Solution architects must design mechanisms that provide full visibility into _who_ made changes, _what_ changes occurred, and _when_ modifications happened across models, data sources, prompts, configuration objects, and agent workflows.

This unit provides patterns for building robust auditing capabilities across Azure AI Foundry, model lifecycles, and data governance processes.

## Purpose of audit trails in AI systems

Audit trails help organizations:

- Track changes to model versions, parameters, training datasets, and evaluation results.

- Diagnose issues, anomalies, and regressions.

- Meet regulatory expectations around transparency and accountability.

- Support investigations during incidents and security reviews.

- Strengthen operational governance by enabling approvals, rollbacks, and lifecycle controls.

A well-designed audit system is continuous, immutable, and integrated into the AI platform's control plane.

## Audit trail requirements for model changes

Model lifecycle events that must be audited include:

- Registration of new model versions

- Tuning operations such as fine-tuning, parameter updates, or evaluation runs

- Promotion of models between dev/test/prod environments

- Rollbacks to previous versions

- Deployment actions, endpoint configuration, scaling changes

- Access attempts to model assets, including unauthorized requests

Recommended architectural attributes include:

- Immutable logs

- Timestamped change records

- Role-based attribution (linked to identity provider)

- JSON-structured logs for machine parsing

- Separation of duties and approval logging

## Audit trail requirements for data changes

Grounding data, training data, memory stores, semantic indexes, and application logs are core inputs into generative systems. 

You must audit:

- Data ingestion events

- Schema changes

- Data refresh cycles

- Sensitivity label changes

- Sanitization or filtering applied

- Data movement across regions

- Access attempts and approvals

Architects must ensure logs capture _metadata_, not _content_, to avoid unnecessary exposure of sensitive information.

## Azure AI Foundry control-plane auditing

Azure AI Foundry provides a centralized control plane for model registration, environment configuration, agent deployment, and diagnostic logging.

Key audit features include:

Foundry activity logs:

Track administrative actions across workspaces, registries, and deployments. Logs support export to:

- Azure Monitor

- Log Analytics

- SIEM tools (such as Microsoft Sentinel)

Foundry diagnostics and tracing:

Diagnostics provide traceability of execution across:

- Model calls

- Pipeline activities

- Tool interactions

- Failures, latency spikes, or unexpected behavior

## Designing audit pipelines with tracing

Tracing allows architects to follow execution paths and debug generative AI behaviors. When integrated into audit trails, tracing provides:

- End-to-end visibility of model inference

- Identification of performance bottlenecks

- Attribution of requests to model versions

- Correlation of user actions to model activity

- Detection of unusual patterns (loops, excessive token spikes, cascading failures)

Recommended tracing fields include:

- Correlation ID

- Model version

- Input metadata (nonsensitive)

- Prompt category or classification

- Response latency

- Downstream tool usage logs

- Safety evaluation outcomes

## Designing audit-ready processes

Governance workflows to include:

- **Approval workflows** for promoting new model versions

- **Mandatory logging** for all model tuning operations

- **Periodic audit reviews** for drift detection

- **Automated evidence collection** for compliance reporting

- **Immutable storage** of audit logs

### Retention policies

Define retention requirements with Legal, Compliance, and Information Security teams.<br>Common patterns:

- 90 days for low-risk workloads

- 12-24 months for regulated workloads

- Indefinite retention for incident-related archives

## References

- [Azure AI Foundry control plane overview](/azure/ai-foundry/control-plane/overview)

- [Tracing a generative AI app](/training/modules/tracing-generative-ai-app/)

- [Enable Azure AI Foundry diagnostics](/training/modules/azure-ai-foundry-secure-environment/enable-foundry-diagnostics)
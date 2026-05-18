Securing AI models is a core responsibility for solution architects who design, deploy, and operate enterprise-grade AI systems. Model security ensures that every model—whether used in Foundry, Azure AI, or integrated within an agent pipeline—remains protected from threats such as unauthorized access, data leakage, adversarial inputs, and compromised identities.

This unit provides a structured approach to designing model-level security using identity governance, workload hardening, threat protection, access control, and continuous monitoring. Solution architects will learn how to apply security guardrails that span development, deployment, and operations.

## Secure identities and authentication

Strong model security begins with strong identity foundations. AI models, endpoints, and inference workloads must authenticate using standardized, secret-free mechanisms.

### Use managed identities

- Assign a **managed identity** to each model endpoint and Foundry workload.

- Remove all secrets, static keys, or embedded credentials from pipelines.

- Enforce an identity lifecycle with rotation, disablement, and review.

### Role-based access control

- Restrict permissions using **least privilege**.

- Grant access based on the model's function, not developer convenience.

- Use **resource-scoped roles** for training, deployment, and inferencing operations.

## Authorization and access boundaries

Solution architects help define the boundaries around what models can access, process, and output.

### Segregate development and production

- Separate inference endpoints for dev, test, and prod.

- Apply tighter RBAC and approval workflows in production environments.

### Limit privileged access

- Restrict model modification, retraining, and redeployment rights.

- Require multi-step approvals for sensitive model updates.

## Protect data used by models

Models interact with sensitive information through training data, memory stores, logs, and output responses.

### Data minimization

- Use the minimum data required for the model's purpose.

- Redact sensitive fields (PII, secrets, financial identifiers) during preprocessing.

### Encryption and residency

- Ensure all data—input, output, and intermediate artifacts—is encrypted at rest and in transit.

- Deploy models in regions that meet your **data residency** and compliance requirements.

### DLP enforcement

- Apply DLP rules to prevent sensitive data from being returned in model responses.

- Implement filters to block harmful or restricted outputs.

## Harden AI workloads

Harden the environment where AI models operate to reduce attack surfaces.

### Model infrastructure hardening

- Use isolated networks or private endpoints.

- Enforce secure build pipelines for training artifacts.

- Block inbound public traffic unless explicitly required.

### Model drift and poisoning safeguards

- Track data lineage for all training sources.

- Validate newly introduced data before using it in retraining pipelines.

- Automate anomaly detection in model behavior and output patterns.

### Model hardening blueprint

| Step | Component | Description / Focus Area  |
|------|---------|---------|
| 1	| Secure Compute | Protect computation environments to ensure model safety and confidentiality.|
| 2 |Private Endpoints | Use private network endpoints to limit exposure and control access.|
| 3 | Threat Protection | Implement safeguards to detect and mitigate security threats. |
| 4 | Validation Pipeline | Validate models and data to maintain quality and compliance. |
| 5 | Monitoring and Drift Detection | Continuously monitor model performance and identify data or model drift. |

## Threat detection and response

Model security is strengthened with continuous threat detection and real-time monitoring.

### Threat protection

- Enable AI-specific threat detection for prompt injection, unauthorized access attempts, and unusual inference patterns.

- Use automated scanning to identify insecure default settings and misconfigurations.

### Logging and monitoring

- Collect logs for identity access, model operations, system events, and output anomalies.

- Route security alerts to SOC workflows for triage and escalation.

### Incident response for AI models

- Predefine steps to disable a compromised model endpoint.

- Preserve inference logs and model artifacts for forensic analysis.

- Establish rollback procedures for restoring prior model versions.

## Governance and lifecycle controls

Strong governance ensures models remain secure throughout their lifecycle.

### Policy-driven model management

- Mandate approval checkpoints for model deployment, retraining, and version promotion.

- Require documentation for model purpose, training data, parameters, and risk profile.

### Lifecycle governance

- Assign retention requirements for training data, logs, and memory stores.

- Review and retire outdated models that no longer meet security or quality standards.

## References

- [Protect AI services with Microsoft Defender for Cloud](/training/paths/defender-for-cloud-ai-foundry-protect/)

- [Manage IAM for AI workloads on Azure](/training/paths/manage-iam-for-ai-workloads-on-azure/)
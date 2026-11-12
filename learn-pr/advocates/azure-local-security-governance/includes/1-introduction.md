Contoso owns and operates healthcare facilities and must comply with the government regulations that apply to its services, locations, and handling of patient information. One of its facilities runs a two-node Azure Local instance that supports clinical and administrative workloads.

Its platform team manages the hosts, and a central security team reviews posture and alerts. Application owners manage workloads, while a separate recovery team holds emergency access and backup material. Contoso's legal, privacy, and compliance teams identify applicable regulatory obligations and the evidence needed to demonstrate that those obligations are met.

The facility wants to install a vendor diagnostic utility, improve its logon notice, and deploy workloads that process patient and clinical data. A dashboard already shows a high compliance score. However, the proposed utility is blocked, one recovery key exists only on the cluster, and the application team assumes that every protected VM supports the same disaster-recovery workflow.

> [!NOTE]
> Applicable requirements depend on the facility's jurisdiction, services, and data. They can include health-information privacy, security, access auditing, records retention, and breach notification. Contoso must map its specific obligations to organizational processes and technical controls. An Azure Local compliance result doesn't, by itself, establish compliance with healthcare regulation.

Your task is to decide what evidence and changes are required before approving the proposal. A successful review doesn't simply make the dashboard green. It explains how the design protects patient information, supports continuity of care, and provides evidence for the applicable regulatory obligations. It also identifies remaining risks and demonstrates that workloads can be operated and recovered through supported procedures.

## Connect intent, enforcement, and evidence

*Security governance* is the process of assigning responsibility for security decisions and proving that approved controls remain effective. Each control needs an intended outcome, an enforcement mechanism, an accountable owner, and retained evidence.

For example, "only approved host software can execute" is an intended outcome. App Control for Business is an enforcement mechanism. The platform team operates it, the security team approves changes to trust, and policy inventory plus application-control events provide evidence.

A *security baseline* is an approved set of configuration values. *Drift* is a difference between the intended configuration and the configuration that actually exists. A drift-control mechanism can restore desired values. A compliance assessment can report differences, but reporting isn't necessarily enforcement.

This distinction explains why a successful policy query isn't proof that an application is safe. A host might have encrypted storage and an enforced baseline while a guest application accepts unauthenticated requests. Equally, a protected VM might resist tampering but fail recovery because its key wasn't backed up.

## Make ownership explicit

Governance and security require ownership because policies and tools don't take responsibility for outcomes. Governance depends on people with the authority to approve decisions, prioritize work, and escalate unresolved risks. Security depends on people maintaining controls, responding to findings, and proving that recovery works. Without clear ownership, teams can assume someone else will act, leaving vulnerabilities unresolved, exceptions in place beyond their expiry, or recovery material unavailable. An accountable owner ensures that responsibilities become tracked actions with clear completion criteria and retained evidence. The owner can delegate tasks, but remains accountable for the outcome.

Use the following ownership model as a starting point. Your organization can assign different teams, but every responsibility still needs an owner.

| Responsibility | Typical accountable owner | Example evidence |
| --- | --- | --- |
| Regulatory interpretation and assurance | Legal, privacy, and compliance teams | Applicable obligations, control mappings, and evidence requirements |
| Supported host configuration and updates | Platform team | Node inventory, solution version, baseline state, remediation and change records |
| Management-network and workload boundaries | Network team | Approved traffic flows, access rules, and connectivity and isolation evidence |
| Privileged cloud identity safeguards | Identity team | Scoped roles, authentication requirements, activation history, and access reviews |
| Risk acceptance and exception approval | Security authority | Approved scope, justification, expiry, compensating controls |
| Guest and application security | Workload owner | Patching records, access tests, data-protection design |
| Recovery material and restore readiness | Recovery custodian and workload owner | Escrow metadata, access approvals, restore-test results |
| Alert triage and evidence retention | Security operations team | Ingestion health, incident records, retention configuration |
| Incident coordination and containment approval | Incident lead | Threat assessment, service-impact decision, approved actions, and recovery acceptance |
| Secure retirement and retained-data obligations | Asset and data owners | Resource cleanup, sanitization evidence, and continuing backup, key, and records custody |

An approval doesn't transfer responsibility to a dashboard or to the product. Contoso must still decide who can retrieve recovery material, how long exceptions last, and what constitutes a successful restore of a clinical service. Its legal and compliance teams must confirm that proposed exceptions remain consistent with applicable obligations. Internal risk acceptance doesn't waive a legal requirement.

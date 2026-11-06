An alert, an investigation, and a recovery decision are different stages. A baseline mismatch or missing event stream might indicate an operational failure, unauthorized change, or compromise. Preserve enough evidence to distinguish them while taking proportionate action against any immediate threat. Waiting for perfect certainty can be unsafe, but an unplanned containment action can also interrupt clinical services.

## Triage and authorize containment

Assign an incident lead who coordinates security operations, the platform team, workload owners, and clinical-service continuity staff. Legal and privacy owners assess notification, evidence-preservation, and patient-information obligations. The incident record should identify the suspected scope, time, affected identities and assets, current confidence, service impact, approved actions, and next decision point.

Use the following response sequence, adapting the timing to the severity and approved incident plan:

1. **Establish the initial facts.** Correlate the alert with host, Azure, identity, vault, and application evidence. Distinguish observed facts from hypotheses, and determine whether an active unauthorized session, execution, or data access is continuing.
1. **Preserve evidence.** Retain relevant original logs and approved exports, record collection times and custodians, and protect the evidence repository. Use approved integrity checks and custody records for forensic material. Don't clear logs, reinstall software, or reboot a suspected host merely to make the alert disappear. Coordinate volatile-evidence collection with qualified responders when needed.
1. **Assess containment choices.** Identify which identities, communication paths, hosts, and workloads need restriction. Evaluate supported actions and their effect on recovery access and clinical services. Record the approver and expected impact before acting, or record the emergency authority used when the response plan permits immediate action.
1. **Contain through the approved path.** Restrict compromised access or affected communication paths using supported identity, network, and platform controls. Don't assume that an endpoint product's generic isolation action is safe or supported for a cluster host. Monitor both threat activity and service health after the change.
1. **Decide the recovery scope.** Determine whether repair can reestablish trust or whether affected components require a supported rebuild. If a host administrator or shared management identity was compromised, investigate other nodes and connected resources rather than declaring them clean because they haven't alerted.
1. **Validate and close.** Restore trusted operation, confirm the required application and security controls, and obtain security and workload-owner acceptance. Retain unresolved questions and corrective actions until assigned owners complete them.

Evidence can contain patient identifiers, account information, or secrets. Limit collection to the approved purpose and restrict access. Share diagnostic material only through an authorized support or investigation channel after reviewing its contents. Legal and privacy owners determine any required external reporting and deadlines rather than inferring them from the infrastructure alert.

## Preserve cluster and clinical-service safety

For Contoso's two-node instance, containment must account for *quorum*, the voting mechanism that helps a cluster determine whether it can continue operating without conflicting ownership of resources. Review the actual node votes, witness state, communication paths, storage health, and remaining compute capacity. Don't assume that one surviving node will always be able to run the cluster. A witness contributes to quorum decisions but doesn't supply another copy of workload compute capacity.

Blocking a host's network can interrupt cluster communication, storage access, the witness path, and the evidence stream at the same time. Stopping a node can also leave insufficient capacity for clinical workloads. Before a planned restriction, determine which services would stop, whether a supported workload move is possible, and what continuity arrangements the application and facility teams must activate. Escalate the tradeoff between continued exposure and service interruption to the authorized incident lead.

Failover isn't a security cleanup operation. Moving a compromised workload can carry the same compromise to its new location, and the VM security-type restrictions still apply. Blocking Azure connectivity alone also doesn't terminate every local session or remove malicious code. Retain an independent, controlled recovery-access path while isolating the affected authority or traffic.

## Recover a trusted service

Select recovery material from a point assessed as suitable for clean recovery, not simply the newest successful backup. Use an isolated environment to check the restored image, application data, credentials, and required keys before reconnecting production services. A clean recovery point might be older than the target RPO. Make the resulting data gap explicit and have the application and clinical-service owners reconcile it through the approved continuity process.

Revoke or rotate compromised credentials and tokens through their supported workflows, update their consumers, and confirm that the old access no longer works after applicable propagation delays. Preserve historical encryption keys still needed by retained backups. Authentication-secret revocation and destruction of recovery keys aren't the same action.

Before return to service, demonstrate required application functions, acceptable data integrity, restored baseline and App Control enforcement, healthy antivirus, approved access, and working cloud and host monitoring. Increase observation for recurrence according to the response plan. Record which evidence supports the restored trust and which limitations remain. A VM booting, an alert closing, or a compliance score returning to green isn't sufficient on its own.

After the incident, update the relevant access rules, exception records, patch priorities, recovery dependencies, and detection coverage. Exercise the revised response without disrupting production, and retain the decisions and evidence under the incident's retention and legal-hold requirements.

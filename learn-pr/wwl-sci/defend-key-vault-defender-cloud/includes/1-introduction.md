Contoso Health's security team ran a review sprint after completing the vault hardening work—and found two problems that hardening doesn't solve. A disk snapshot from a routine scan of a developer virtual machine (VM) revealed plaintext storage account connection strings in a configuration file. The credentials granted access to a patient-facing storage account and sitting there, unknown, for months. Separately, an analyst checking Defender for Cloud noticed that the production Key Vault had no Defender for Key Vault plan active. Defender for Cloud was running on the subscription, but this specific workload protection plan was never enabled. Every access event on the vault was unmonitored. Both gaps were invisible in normal operations—exposed credentials don't announce themselves, and the absence of alerting looks exactly like the absence of threats.

## Recognize the detection gaps

The exposed credential problem isn't a vault misconfiguration—it's a sprawl problem. Secrets that belong in Key Vault ended up in places where Key Vault access controls don't apply: VM disks, deployment templates, and code repositories. Finding them requires a scanner that looks for credential patterns across those surfaces, not a vault audit. Defender Cloud Security Posture Management (CSPM) agentless scanning does exactly that, operating without agents on the systems being scanned.

The missing threat detection problem is different. A properly configured vault with no active monitoring is a secured room with no security camera. If an attacker obtains valid credentials and begins extracting secrets, nothing is watching the access patterns for behavior consistent with credential theft or lateral movement. Defender for Key Vault closes that gap by analyzing access behavior and alerting when it matches known threat patterns—impossible IP locations, access volume anomalies, and operation sequences consistent with credential harvesting.

## Explore what this module covers

This module introduces both protection layers that address what vault hardening leaves exposed. In this module, you:

- Use Defender CSPM agentless scanning to discover secrets exposed outside Key Vault on VM disks, deployment resources, and code repositories
- Enable Microsoft Defender for Key Vault and identify its threat detection capabilities and alert types
- Investigate Key Vault security alerts using a structured four-step response process
- Remediate common alert scenarios and understand when to suppress false positives using alert scoping

In the next unit, you work through the CSPM secret scanning capability and how it surfaces the credentials that escaped the vault.

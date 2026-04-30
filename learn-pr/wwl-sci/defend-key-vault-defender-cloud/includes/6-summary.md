Contoso Health started this module with two open security gaps: a developer virtual machine (VM) carrying plaintext storage account connection strings on its disk, and a production Key Vault with no active threat detection.

## Review what was achieved

Defender Cloud Security Posture Management (CSPM) secret scanning found the misplaced credentials automatically. The disk snapshot analysis surfaced the storage account connection string, identified the file path, and modeled it as an exploitable attack path leading to patient data storage. The remediation is clear: remove the hardcoded credentials from the VM, store them in Key Vault, and reference the vault at runtime.

Enabling Microsoft Defender for Key Vault closed the monitoring gap. Anomalous access patterns—bulk secret reads, access from unrecognized IPs, suspicious policy changes followed by credential queries—now generate alerts with structured investigation guidance. The four-step response process gives the security team a repeatable workflow: identify the source, contain the threat, measure the issue using audit logs, and rotate every affected credential.

## Compare the two layers of protection

These capabilities address fundamentally different risks. **Defender CSPM secret scanning** finds credentials that escaped the vault—sitting in the wrong place where an attacker can read them without ever touching the vault. **Microsoft Defender for Key Vault** watches for threat actors targeting the vault directly, using stolen credentials to harvest secrets from a properly configured vault. Neither is a substitute for the other.

Through this module, Contoso Health hardened its vault configuration, applied access controls, managed object lifecycle, and activated threat detection at both the perimeter and the vault door. The defense-in-depth posture is complete.
## What you learned

In this module, you:

- Used Defender CSPM agentless scanning to discover secrets exposed outside Key Vault on VM disks, deployment resources, and code repositories.
- Enabled Microsoft Defender for Key Vault and identified its threat detection capabilities and alert types.
- Investigated Key Vault security alerts using a structured four-step response process.
- Remediated common alert scenarios and understood when to suppress false positives using alert scoping.
## Learn more

**CSPM secret scanning**

- [Protecting secrets in Defender for Cloud](/azure/defender-for-cloud/secrets-scanning)
- [Machine secrets scanning](/azure/defender-for-cloud/secrets-scanning-servers)
- [Cloud deployment resource scanning](/azure/defender-for-cloud/secrets-scanning-cloud-deployment)
- [Investigate and remediate machine secrets](/azure/defender-for-cloud/remediate-server-secrets)

**Microsoft Defender for Key Vault**

- [Overview of Microsoft Defender for Key Vault](/azure/defender-for-cloud/defender-for-key-vault-introduction)
- [Respond to Microsoft Defender for Key Vault alerts](/azure/defender-for-cloud/defender-for-key-vault-introduction#respond-to-microsoft-defender-for-key-vault-alerts)
- [Microsoft Defender for Key Vault alerts reference](/azure/defender-for-cloud/alerts-azure-key-vault)
- [Azure Key Vault logging](/azure/key-vault/general/logging)
- [Suppress security alerts in Defender for Cloud](/azure/defender-for-cloud/alerts-suppression-rules)

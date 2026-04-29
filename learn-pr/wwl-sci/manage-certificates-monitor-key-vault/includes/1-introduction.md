Contoso Health recently completed an Azure Key Vault audit using the Microsoft Defender for Cloud regulatory compliance dashboard and the Azure Key Vault built-in Azure Policy initiative. The security team held the Security Reader and Key Vault Reader roles—enough to inspect configuration but not to change it. The audit surfaced four findings. Two were remediated: access policies were replaced with Azure RBAC, and soft-delete with purge protection was enabled on all vaults. Two remain: a TLS certificate that autorenewed to a self-signed issuer instead of the approved certificate authority, and production vaults with no diagnostic logging enabled. Both failures are silent until they cause visible damage—a browser trust error, or an alert with no evidence to investigate.

## Recognize unresolved vault risks

The certificate failure produced immediate, patient-facing consequences. TLS validation errors appeared the moment the misconfigured renewal completed. The root cause wasn't a missing autorenewal feature—Key Vault autorenewed the certificate exactly as configured. The policy pointed to the wrong issuer. Every renewal since the original misconfiguration reinforced it. Fixing it requires understanding how Key Vault manages certificate issuance, how to configure an approved CA, and how lifetime actions control the renewal workflow.

The logging gap is less visible but more dangerous operationally. Without diagnostic logging, every security event on the vault—every secret read, every key operation, every policy change—leaves no queryable record. When threat detection alert fires and you need to know which secrets were accessed, by whom, and from which IP, you have no source of evidence. The alert exists; the investigation doesn't.

## Explore what this module covers

This module addresses both audit findings. In this module, you:

- Configure certificate lifecycle management through Azure Key Vault's integrated CA partnerships, including issuer objects, lifetime actions, and autorenewal workflows
- Set certificate contacts and renewal policies so every future renewal follows the approved certificate authority path
- Enable diagnostic logging by routing the AuditEvent category to Log Analytics and identifying the fields that matter during investigations
- Create alert rules for high-severity vault events and understand where Event Grid complements the log strategy

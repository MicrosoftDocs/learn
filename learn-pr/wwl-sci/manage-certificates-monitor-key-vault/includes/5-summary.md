Contoso Health's audit began with four findings. Two are now addressed. The Transport Layer Security (TLS) certificate that renewed to a self-signed issuer has a certificate policy that points to a configured DigiCert issuer object. Autorenewal submits a Certificate Signing Request (CSR) to DigiCert at 80% of the certificate's lifetime. Certificate contacts receive notification if renewal fails. The self-signed issuer is gone from every active policy.

Diagnostic logging is now enabled on the production vaults. The `AuditEvent` category flows to a Log Analytics workspace with alert rules for secret deletion, access failures, key deletion, and vault property changes. Event Grid subscriptions complement the log strategy. The `SecretNearExpiry` and `CertificateNearExpiry` events drive automation and feed the operations team's monitoring channel.

In this module, you:

- Configured certificate lifecycle management through Azure Key Vault's integrated CA partnerships, including issuer objects, lifetime actions, and autorenewal workflows
- Set certificate contacts and renewal policies so every future renewal follows the approved certificate authority path
- Enabled diagnostic logging by routing the AuditEvent category to Log Analytics and identifying the fields that matter during investigations
- Created alert rules for high-severity vault events and understood where Event Grid complements the log strategy

## Reflect on what this module addressed

Both audit findings represented silent failures—a certificate policy pointing to the wrong issuer, and vaults with no evidence trail. Neither produced an error during normal operations. Both caused damage only when it was too late to prevent it: browser trust errors visible to patients, and an alert with no log to investigate.

Issuer objects and lifetime actions eliminate the misconfiguration path for certificate renewal. Diagnostic logging and alert rules make vault operations visible and actionable before an incident forces the investigation.

## Identify next steps

With an audit trail in place, the next area of focus is detecting when something goes wrong despite these controls. Next, look to finding credentials that escaped the vault into VM disks or deployment templates, and identifying threat actors attempting to exploit vault access through anomalous patterns. The diagnostic log you configured provides the evidence layer for that investigation. The log must be accurate, complete, and queryable to be an effective threat detection and response possible.

## Learn more

- [About Azure Key Vault certificates](/azure/key-vault/certificates/about-certificates)
- [Azure Key Vault logging](/azure/key-vault/general/logging)

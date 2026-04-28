Vault controls protect access, certificate validity, and key freshness. But controls without visibility create a different kind of risk. When someone accesses a secret they shouldn't, or a key is deleted unexpectedly, you need evidence. Diagnostic logging on Azure Key Vault isn't a nice-to-have. Logging is the evidence layer that connects an alert to an investigation.

## Recognize how diagnostic logs enable investigations

When Microsoft Defender for Cloud generates an alert for unusual access patterns to a Key Vault secret—for example, a service principal accessing 50 secrets in 10 minutes from an unfamiliar IP address—Defender tells you that something happened. The alert has timestamps, severity, and a description. What it doesn't provide is the specific operation, the caller identity, the calling IP address, and the sequence of events. The previous values are the **AuditEvent** diagnostic log.

Without the diagnostic log enabled, you have an alert and no evidence. With it, you can reconstruct exactly who did what, when, from where, and whether it succeeded or failed. Investigations end in minutes instead of days.

:::image type="content" source="../media/key-vault-observability-architecture.png" alt-text="Architecture diagram showing Key Vault emitting AuditEvent logs to Log Analytics, Storage, and Event Hubs, and lifecycle events to Event Grid for real-time automation." lightbox="../media/key-vault-observability-architecture.png":::

## Enable Key Vault resource logs

Diagnostic logging for Key Vault isn't enabled by default. You enable it through the **Diagnostic settings** screen in the Azure portal.

1. Navigate to your key vault and select **Diagnostic settings** under the **Monitoring** section.
2. Select **Add diagnostic setting**.
3. Name the setting (for example, `keyvault-audit-to-law`).
4. Under **Category details**, select **Audit** (the `AuditEvent` category). This captures all control plane and data plane operations on the vault.
5. Under **Destination details**, choose one or more destinations:
   - **Log Analytics workspace** - recommended for interactive query and alert creation.
   - **Storage account** - for long-term archive retention (useful for compliance requirements with multi-year log retention).
   - **Event Hubs** - for streaming log data into a Security Information and Event Management (SIEM) such as Microsoft Sentinel.
6. Select **Save**.

Log data becomes available in the destination within approximately 10 minutes of the first vault operation after the setting is saved.

:::image type="content" source="../media/key-vault-diagnostic-settings.png" alt-text="Screenshot of the Azure portal Diagnostic settings page for a Key Vault showing the setting name, log category selection, and destination options.":::

> [!TIP]
> For security operations, sending logs to a Log Analytics workspace is the most operationally useful configuration. It enables Kusto Query Language (KQL) queries, workbooks, and alert rules directly against the vault's activity. Long-term archive to a storage account can run in parallel.

## Identify key fields in AuditEvent logs

Every AuditEvent log record captures the context needed for security investigation. The most important fields for a security analyst are:

| Field | Description |
|---|---|
| `operationName` | The action performed—for example, `SecretGet`, `KeyCreate`, `VaultDelete`. |
| `resultType` | `Success` or `Failure`. |
| `callerIpAddress` | The IP address of the caller. Unusual source IPs are often the first indicator in an investigation. |
| `identity` | Claims objects containing the caller's identity. The `appid` claim identifies the calling application. The object identifier and User Principla Name (UPN) are stored under full XML claim URIs—in Log Analytics, use `parse_json(identity_s)` or the flattened identity columns to extract them. |
| `resourceId` | The full resource path of the vault. |
| `time` | UTC timestamp of the operation. |

Operation names follow an `ObjectVerb` pattern: secrets produce `SecretGet`, `SecretList`, `SecretSet`, `SecretDelete`; keys produce `KeyCreate`, `KeySign`, `KeyDecrypt`; vault-level operations produce `VaultGet`, `VaultPut`, `VaultDelete`.

## Configure log-based alert rules

Storing logs isn't enough—you need to act on them. Create KQL-based alert rules in Log Analytics for high-severity vault events that should never happen silently.

Alerts you should configure immediately:

- **Secret deletion** (`operationName == "SecretDelete"` or `operationName == "SecretPurge"`): Deleted secrets with purge protection disabled are recoverable for a limited time, but every deletion warrants review. Purge operations are irreversible.
- **Access failures** (`resultType == "Failure"`): A service principal repeatedly failing to access a secret can indicate a misconfigured application. Or it could be a revoked certificate, or an attacker testing credentials and running into access policy boundaries.
- **Vault property changes** (`operationName == "VaultPatch"`): Changes to vault properties—including network rules, soft-delete settings, and access policy modifications on legacy policy-based vaults—are logged with this operation. For vaults using Azure RBAC, role assignment changes are recorded in the Azure Activity Log under `Microsoft.Authorization/roleAssignments/write` and `Microsoft.Authorization/roleAssignments/delete`, not in the Key Vault AuditEvent log. Alert on both sources for complete coverage.
- **Key deletion** (`operationName == "KeyDelete"` or `operationName == "KeyPurge"`): Deleted keys can break encryption for dependent services. Purged keys destroy access to encrypted data permanently.

Route these alerts to your on-call SOC analyst team, not just an email inbox. Email inboxes don't get triaged at 2 AM; an on-call SOC analyst will.

## Integrate Event Grid for real-time vault events

Diagnostic logs are batch-ingested. Logs are typically available within 10 minutes. For real-time operational automation, **Event Grid** subscriptions on Key Vault complement the log strategy.

Key Vault publishes events to Event Grid for:

- `Microsoft.KeyVault.SecretNewVersionCreated` - a secret rotation completed.
- `Microsoft.KeyVault.SecretNearExpiry` - a secret is approaching expiry and needs rotation.
- `Microsoft.KeyVault.CertificateNearExpiry` - a certificate is approaching expiry.
- `Microsoft.KeyVault.CertificateExpired` - a certificate expired.
- `Microsoft.KeyVault.KeyNearExpiry` - a key is approaching its expiry date.

Event Grid subscriptions trigger automation—the rotation functions from the dual-credential pattern, renewal workflows, or direct notification to an operations channel. Event Grid and diagnostic logs serve different purposes: diagnostic logs provide the complete historical record; Event Grid provides low-latency triggers for automation. Both are part of a complete vault operations posture.

> [!NOTE]
> When Microsoft Defender for Cloud raises an alert for suspicious access, the `AuditEvent` diagnostic log is where you find the evidence to investigate. Plan your log retention and query tooling before an incident occurs—not after.

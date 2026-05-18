Microsoft Defender for Storage provides three complementary detection pillars that work together to identify threats targeting your Azure storage accounts. Unlike network controls that focus on who can connect or access policies that define what actions are allowed, Defender analyzes what is happening—detecting malicious content, suspicious activity patterns, and anomalous access behaviors that indicate a security incident.

:::image type="content" source="../media/defender-storage-three-pillars.png" alt-text="Diagram of the three Defender for Storage detection pillars: activity monitoring, malware scanning, and sensitive data threat detection." lightbox="../media/defender-storage-three-pillars.png":::

| Detection pillar | What it analyzes | Key detection scenarios |
|------------------|------------------|-------------------------|
| Activity monitoring | Data and control plane logs | Suspicious access patterns, geographic anomalies, potential data exfiltration, SAS token misuse |
| Malware scanning | Uploaded file content | Malicious files, polymorphic threats, unknown malware variants |
| Sensitive data threat detection | Activity targeting classified resources | Suspicious operations on resources containing sensitive data |

## Detect suspicious activity patterns with continuous monitoring

Activity monitoring continuously analyzes data and control plane operations across Azure Blob Storage, Azure Files, and Azure Data Lake Storage Gen2. The monitoring operates at the storage service layer, so you don't need to enable diagnostic logs separately or configure log forwarding. Defender receives the activity data automatically as operations occur.

The activity monitoring engine uses Microsoft Threat Intelligence to detect patterns that indicate compromise. When an AI agent or application accesses storage using a SAS token from an unusual geographic location, Defender generates an alert. When sequential read operations suggest automated data exfiltration, the system flags the behavior. When access originates from a Tor exit node, the threat intelligence feed identifies the anonymization attempt.

For organizations deploying AI pipelines, activity monitoring addresses a critical unguarded side: entities without identities. Traditional identity-based security controls work well when users authenticate with Microsoft Entra credentials, but AI agents and automated systems often use SAS tokens for storage access. These tokens grant access without requiring the caller to authenticate with a user or service principal identity. Activity monitoring detects when these tokens are used in ways that suggest compromise—access from unexpected locations, unusual access volumes, or operations that don't match the application's normal behavior patterns.

## Scan uploaded content for malware threats

Malware scanning operates at the file level, analyzing content as it arrives in Blob Storage. The scanning engine uses Microsoft Defender Antivirus to perform full file content analysis, identifying both known malware signatures and behavioral patterns that indicate malicious intent.

The engine performs two types of analysis. Hash reputation analysis compares the file's hash value against databases of known malware, providing fast detection for recognized threats. Full content scanning examines the file structure and code patterns, catching polymorphic malware that changes its signature to evade hash-based detection. This comprehensive approach addresses the Contoso scenario directly: even if a malicious file is unique, the content analysis can identify suspicious behaviors.

Malware scanning operates as a paid add-on feature charged per gigabyte scanned. Organizations configure scanning to run on-upload for real-time protection or on-demand when responding to threat indicators. The service supports Blob Storage accounts, making it ideal for protecting file upload pipelines. It's also ideal for document processing workflows, and AI training data repositories.

## Prioritize alerts based on data sensitivity

Sensitive data threat detection enriches Defender alerts with information about data classification. The feature integrates with Microsoft Purview's sensitive data discovery capabilities, identifying which storage resources contain sensitive information based on your organization's classification policies.

When Defender generates an alert for suspicious activity, the system checks whether the targeted resource contains classified data. If the storage account holds financial records labeled as confidential, or if the blob container stores personal information classified as highly sensitive, Defender adds this context to the alert. The security operations team receives alerts preprioritized by data sensitivity, allowing them to focus on threats targeting the organization's most valuable assets.

Unlike activity monitoring and malware scanning, sensitive data threat detection doesn't generate new alert types. Instead, it enhances existing alerts with classification context. This approach reduces alert fatigue while ensuring that incidents involving sensitive data receive appropriate attention. Organizations enable the feature at no extra cost as part of the Defender for Storage plan.

## Compare the Defender for Storage plan options

Microsoft offers two Defender for Storage plans: the classic plan and the new plan. The classic plan uses per-transaction pricing and includes hash reputation analysis for malware detection. The new plan uses per-storage-account pricing, includes full malware scanning as a configurable add-on, and provides enhanced sensitive data threat detection capabilities.

Organizations using the classic plan should migrate to the new plan to gain access to comprehensive malware scanning, improved detection algorithms, and more predictable pricing. The new plan's per-account pricing model makes cost forecasting easier for organizations with high transaction volumes, and the malware scanning features provide substantially better protection against unknown threats.

All Defender for Storage capabilities operate without requiring agent deployment. The service analyzes activity at the Azure storage service layer, integrating directly with the platform's control and data plane operations. This agentless architecture reduces operational overhead and ensures consistent coverage across all protected storage accounts.

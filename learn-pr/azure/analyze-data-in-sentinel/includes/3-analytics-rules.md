## Types of Analytics rules

You can start search for potential threat by using built in analytic rules. There are currently four types of analytic rules:

- Fusion alerts
- Microsoft Security
- Machine Learning Behavior Analytics
- Scheduled alerts

## Fusion alerts

Fusion alerts identify, anomalous behaviors and suspicious activities at various stages of the kill-chain. Fusion correlates multiple security alerts from various products, and by using Machine Learning can detect advanced multistage attacks.

Fusion detection is enabled by default in Azure Sentinel, but for successful threat detection, the following data connectors must be configured:

- Azure Active Directory Identity Protection.
- Microsoft Cloud App Security.
- Microsoft Defender Advanced Threat Protection.
- Palo Alto Networks.

Some common attack detection scenarios enabled with Fusion:

- **Data exfiltration** - Suspicious activity detected, suspicious forwarding rule in Office 365 mailbox, after a suspicious sign-in to Azure AD account can indicate compromised user&#39;s account.
- **Data destruction** – Anomalous number of unique files that were deleted after a suspicious sign-in to Azure AD account can signal compromised user&#39;s account and was used to destroy data.
- **Denial of service** – Significant number of Azure Virtual Machines (VM) were deleted after a suspicious sign-in to Azure AD account can signal compromised user&#39;s account and is used to destroy organization&#39;s asset.
- **Lateral movement** – Significant number of impersonation actions occurred, after a suspicious sign-in to Azure AD account indicates compromised user&#39;s account and was used for malicious purposes.
- **Ransomware** – After a suspicious sign-in to Azure AD account, unusual user behavior used to encrypt data can trigger ransomware execution alert

> [!Note]
> For more information on the Fusion technology in Azure Sentinel see the following page: [Advanced multistage attack detection in Azure Sentinel](https://docs.microsoft.com/en-us/azure/sentinel/fusion)

## Microsoft security

Microsoft security solutions that are connected to Azure Sentinel, can be configured to automatically create incidents from all alerts generated in the connected service.

The following security solutions can have their alerts passed to Azure Sentinel:

- Microsoft Cloud App Security
- Azure Defender for Server
- Azure Defender for IoT
- Microsoft Defender for Identity
- Microsoft Defender for Office 365
- Azure Active Directory Identity Protection
- Microsoft Defender for Endpoint

> [!Note]

> Microsoft unify SIEM and XDR terminology across their security products.
> - Microsoft Defender for Identity is new name for the product, Azure Advanced Threat Protection.
> - Microsoft Defender for Endpoint replaces Microsoft Defender Advanced Threat Protection.
> - Defender for Office 365, previously known as Office 365 Advanced Threat Protection.
> - Azure Defender for Servers (previously Azure Security Center Standard Edition).
> - Azure Defender for IoT (previously Azure Security Center for IoT).

You can filter these alerts by severity and/or by specific text that is contained in the alert name.

## Machine learning behavioral analytics

These rules are built-in, and you can not edit the, or see the rule settings. They use Microsoft machine learning algorithms for detection of suspicious activity.

For example, with Machine learning behavioral analytics rule you can detect anomalous SSH Login or RDP Login activity.

## Scheduled alerts

These types of analytic rules provide you highest level of customization. You can define your own KQL to filter the security events, and you can set up the schedule when the rule will run.

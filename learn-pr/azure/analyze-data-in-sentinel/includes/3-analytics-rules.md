## Types of analytics rules

You can start search for potential threat by using built in analytics rules. There are currently four types of analytics rules:

- Fusion
- Microsoft Security
- Machine Learning Behavior Analytics
- Scheduled alerts

![Screenshot of rule templates in the Analytics home page](../media/03-rule-templates.PNG)

## Fusion alerts

Fusion alerts identify, anomalous behaviors and suspicious activities at various stages of the cyber kill-chain. Fusion correlates multiple security alerts from various products, and by using Machine Learning can detect advanced multistage attacks.

> [!Note]

> The cyber kill chain describes the typical workflow, including techniques, tactics, and procedures or TTPs, used by attackers to infiltrate an organization’s networks and systems.

Fusion detection is enabled by default in Azure Sentinel, but for successful threat detection, the following data connectors must be configured:

- Azure Active Directory Identity Protection.
- Microsoft Cloud App Security.
- Microsoft Defender Advanced Threat Protection.
- Palo Alto Networks.

Some common attack detection scenarios enabled with Fusion:

- **Data exfiltration** - Suspicious activity detected, such as suspicious forwarding rule in Office 365 mailbox, after a suspicious sign-in to Azure AD account can indicate compromised user account.
- **Data destruction** – Anomalous number of unique files that were deleted after a suspicious sign-in to Azure AD account can signal compromised user&#39;s account and was used to destroy data.
- **Denial of service** – Significant number of Azure Virtual Machines (VM) were deleted after a suspicious sign-in to Azure AD account can signal compromised user&#39;s account and is used to destroy organization&#39;s asset.
<!-- Replace "(VM)" with "(VMs)". -->
- **Lateral movement** – Significant number of impersonation actions occurred, after a suspicious sign-in to Azure AD account indicates compromised user&#39;s account and was used for malicious purposes.
- **Ransomware** – After a suspicious sign-in to Azure AD account, unusual user behavior used to encrypt data can trigger ransomware execution alert

> [!Note]
> For more information on the Fusion technology in Azure Sentinel see the following page: [Advanced multistage attack detection in Azure Sentinel](https://docs.microsoft.com/en-us/azure/sentinel/fusion)

## Microsoft security

Microsoft security solutions that are connected to Azure Sentinel, can be configured to automatically create incidents from all alerts generated in the connected service.
For example, you can configure for Contoso to be alerted, when a user who has been categorized at high risk threats attempt to sign in and access corporate resources.

You can configure the following security solutions to pass their alerts to Azure Sentinel:

- Microsoft Cloud App Security
- Azure Defender for Server
- Azure Defender for IoT
- Microsoft Defender for Identity
- Microsoft Defender for Office 365
- Azure Active Directory Identity Protection
- Microsoft Defender for Endpoint

> [!Note]

> Microsoft unify SIEM and XDR terminology across their security products.

> | Old Name | New Name |
> | --- | --- |
> | Azure Advanced Threat Protection | Microsoft Defender for Identity |
> | Microsoft Defender Advanced Threat Protection | Microsoft Defender for Endpoint |
> | Office 365 Advanced Threat Protection | Defender for Office 365 |
> | Azure Security Center Standard Edition | Azure Defender for Servers |
> | Azure Security Center for IoT | Azure Defender for IoT |

You can filter these alerts by severity and/or by specific text that is contained in the alert name.

## Machine learning behavioral analytics

Azure Sentinel Analytics includes built-in machine learning behavioral analytics rules.You cannot edit these built-in rules, or review the rule settings. These rules use Microsoft machine learning algorithms to detect suspicious activity. Machine Learning algorithms correlate several low fidelity anomalies, into a high fidelity security incidents. This saves hours that you might otherwise spend manually analyzing numerous alerts from different products and correlating them. Machine learning algorithms used in analytics rule also help reduce the noise around alerts by quickly ingesting and connecting the important data.

For example, with machine learning behavioral analytics rule you can detect anomalous secure shell protocol (SSH) Login or remote desktop protocol (RDP) Login activity.

## Scheduled alerts

These types of analytics rules provide you highest level of customization. You can define your own kusto query language (KQL) code to filter the security events, and you can set up a schedule for the rule to run.

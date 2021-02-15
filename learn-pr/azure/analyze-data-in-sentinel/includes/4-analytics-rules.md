By using Azure Sentinel Analytics rules, you can configure notification and alerts based on data coming from the sources that are connected to Azure Sentinel. These alerts will help ensure that the Contoso SOC team knows when a threat occurs, and the team can then appropriately react to prevent the threat from reaching your corporate assets.

## Types of analytics rules

You can search for potential threats by using the built-in analytics rules that Azure Sentinel Analytics provides. There are currently four types of analytics rules:

- Fusion
- Microsoft security
- Machine learning (ML) behavior analytics
- Scheduled alerts

:::image type="content" source="../media/03-rule-templates.png" alt-text="Screenshot of rule templates in the Analytics home page." border="true":::

## Fusion alerts

Fusion alerts identify anomalous behaviors and suspicious activities at various stages of the cyber kill chain. Fusion correlates multiple security alerts from various products and uses machine Learning to detect advanced multistage attacks.

> [!Note]
> The cyber kill chain describes the typical workflow, including techniques, tactics, and procedures (TTPs), used by attackers to infiltrate an organization’s networks and systems.

By default, Fusion detection is enabled in Azure Sentinel. Microsoft is constantly updating Fusion detection scenarios for threat detection. At the time of writing this article, for Fusion detection, you must configure the following data connectors:

- Azure Active Directory Identity Protection
- Microsoft Cloud App Security
- Microsoft Defender Advanced Threat Protection
- Palo Alto Networks

Some of the common attack detection scenarios that Fusion alerts identify include:

- **Data exfiltration**. Suspicious activity detected, such as suspicious forwarding rule in Microsoft 365 mailbox, after a suspicious sign-in to Azure AD account can indicate compromised user account.
- **Data destruction**. Anomalous number of unique files that were deleted after a suspicious sign-in to Azure AD account can signal that a compromised user account was used to destroy data.
- **Denial of service**. Significant number of Azure virtual machines (VMs) deleted after a suspicious sign-in to Azure AD account can signal a compromised user account that can be used to destroy the organization's assets.
- **Lateral movement**. Significant number of impersonation actions that occur after a suspicious sign-in to Azure AD account can indicate a compromised user account that was used for malicious purposes.
- **Ransomware**. After a suspicious sign-in to an Azure AD account, unusual user behavior used to encrypt data can trigger a ransomware execution alert.

> [!Note]
> For more information on the Fusion technology in Azure Sentinel, see [Advanced multistage attack detection in Azure Sentinel](https://docs.microsoft.com/azure/sentinel/fusion)

## Microsoft security

You can configure Microsoft security solutions that are connected to Azure Sentinel to automatically create incidents from all alerts generated in the connected service.
For example, you can configure for Contoso to be alerted when a user who has been categorized as a high-risk threat attempts to sign in and access corporate resources.

You can configure the following security solutions to pass their alerts to Azure Sentinel:

- Microsoft Cloud App Security
- Azure Defender for Server
- Azure Defender for IoT
- Microsoft Defender for Identity
- Microsoft Defender for Office 365
- Azure Active Directory Identity Protection
- Microsoft Defender for Endpoint

> [!Note]
> Microsoft unifies security information and event management (SIEM) and extended detection and response (XDR) terminology across their security products.

You can filter these alerts by severity and by specific text that is contained in the alert name.

## Machine learning behavioral analytics

Azure Sentinel Analytics includes built-in machine learning behavioral analytics rules. You can't edit these built-in rules or review the rule settings. These rules use Microsoft machine learning algorithms to detect suspicious activity. Machine Learning algorithms correlate several low-fidelity incidents into a high-fidelity security incident. This saves hours that you might otherwise spend manually analyzing numerous alerts from different products and correlating them. Machine learning algorithms that analytics rules use also help reduce the noise around alerts by quickly ingesting and connecting important data.

For example, by using a machine learning behavioral analytics rule, you can detect an anomalous secure shell protocol (SSH) Login or remote desktop protocol (RDP) login activity.

## Scheduled alerts

Scheduled alerts analytics rules provide you the highest level of customization. You can define your own expression using Kusto Query Language (KQL) to filter the security events, and you can set up a schedule for the rule to run.

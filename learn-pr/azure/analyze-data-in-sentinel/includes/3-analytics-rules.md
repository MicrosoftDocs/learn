## Types of Analytics rules

You can search for potential threats by using the built-in analytics rules that Azure Sentinel Analytics provides. There are currently four types of analytics rules:

- Fusion alerts
- Microsoft Security<!-- Marjan, couple of these items are capitalized, 2n and 3rd while the other two are in sentence case. Can you please confirm they match the casing as seen in the UI?-->
- Machine Learning Behavior Analytics
- Scheduled alerts

## Fusion alerts

Fusion alerts identify anomalous behaviors and suspicious activities at various stages of the kill-chain.<!--Marjan, is kill chain  jargon or a technical term> Do we need to explain what that means? Or is there more easily understood term we can sue?--> Fusion correlates multiple security alerts from various products and uses machine learning to detect advanced multistage attacks.

By default, Fusion detection is enabled in Azure Sentinel, but for successful threat detection, you must configure the following data connectors:

- Azure Active Directory Identity Protection
- Microsoft Cloud App Security
- Microsoft Defender Advanced Threat Protection
- Palo Alto Networks <!--Marjan, please confirm these options mirror the way they display in the UI. We need to match the casing etc.-->

Some of the common attack detection scenarios that Fusion alerts identify include: <!--Marjan, please check edits-->

- **Data exfiltration**. Suspicious activity detected, such as a suspicious forwarding rule in an Office 365 mailbox, after a suspicious sign-in to Azure AD account can indicate a compromised user account.
- <!--Marjan please check edits.-->
- **Data destruction**.  Anomalous number of unique files that were deleted after a suspicious sign-in to Azure AD account can signal that a compromised user account was used to destroy data.
- **Denial of service**. Significant number of Azure virtual machines (VMs) were deleted after a suspicious sign-in to Azure AD account can signal compromised user account and is used to destroy the organization's assets.
- **Lateral movement**. Significant number of impersonation actions occurred, after a suspicious sign-in to Azure AD account indicates compromised user account and was used for malicious purposes.
- **Ransomware**. After a suspicious sign-in to Azure AD account, unusual user behavior used to encrypt data can trigger ransomware execution alert.

> [!Note]
> For more information on the Fusion technology in Azure Sentinel see the following page: [Advanced multistage attack detection in Azure Sentinel](https://docs.microsoft.com/azure/sentinel/fusion)

## Microsoft security

You can configure Microsoft security solutions that are connected to Azure Sentinel to automatically create incidents from all alerts generated in the connected service. <!--Marjan, this sentence is a bit confusing. Are the solutions creating incidents that cause alerts or is Sentinel creating alerts for incidents caused by the solutions?  >
For example, you can configure for  Contoso to be alerted when a user who has been categorized as a high-risk threat attempts to sign in and access corporate resources. <!--Marjan please check edits to the previous sentence-->

You can configure the following security solutions to pass their alerts to Azure Sentinel: <!--MArjan, I changed this sentence to active voice. Please review.-->

- Microsoft Cloud App Security
- Azure Defender for Server
- Azure Defender for IoT
- Microsoft Defender for Identity
- Microsoft Defender for Office 365
- Azure Active Directory Identity Protection
- Microsoft Defender for Endpoint

> [!Note]
> Microsoft unifies SIEM and XDR terminology across their security products. <!--Marjan, I assume that the bullet list above was meant to be part of the note. I edited to make it so. Also, please provide the expansions for SIEM and XDR>
> - Microsoft Defender for Identity is the new name for Azure Advanced Threat Protection.
> - Microsoft Defender for Endpoint replaces Microsoft Defender Advanced Threat Protection.
> - Defender for Office 365 was previously known as Office 365 Advanced Threat Protection.
> - Azure Defender for Servers (previously Azure Security Center Standard Edition).
> - Azure Defender for IoT (previously Azure Security Center for IoT).
<!--Marjan would this list be better represented by a table with Old name and New name columns? It would be easier to make out what the current name is and avoid confusion.-->
You can filter these alerts by severity and by specific text that is contained in the alert name.

## Machine learning behavioral analytics

Auzre Sentinel Analytics includes built-in machine learning behavioral analytics rules. You cannot edit these built-in rules or review the rule settings. These rules use Microsoft machine learning algorithms to detect suspicious activity. Machine learning algorithms correlate several low fidelity anomalies into a high fidelity security incident. <!--Marja, I find this sentence confusing, Do many low fi incidents become one high fi incident? Are they mapped to one incident? or combined to create one alert? Can this be further clarified--> This saves hours that you might otherwise spend  manually analyzing numerous alerts from different products and correlating them. <!--Marjan, I changed the previous sentence to use active voice.--> Machine learning algorithms used in analytics rules also help reduce the noise around alerts by quickly ingesting and connecting the important data.

For example, with machine learning behavioral analytics rules, you can detect anomalous secure shell protocol (SSH) Login or remote desktop protocol (RDP) Login activity. <!--Marjan, I expanded the two acronyms. Please validate. -->

## Scheduled alerts

Scheduled alerts analytics rules provide you the highest level of customization. You can define your own <!--Marjan, please provide the expansion for KQL-->KQL to filter the security events and you can set up a schedule for the rule to run.

XDR security is a step forward in cyber security because it takes the threat data from systems that were once isolated and unifies them so that you can see patterns and act on them faster.

For example, Microsoft XDR unifies endpoint (endpoint detection and response or EDR), email, app, and identity security in one place.

Microsoft Defender XDR is an **eXtended detection and response (XDR) solution** that automatically collects, correlates, and analyzes signal, threat, and alert data from *across* your Microsoft 365 environment, including *endpoint, email, applications, and identities*. It leverages **artificial intelligence (AI) and automation to *automatically* stop attacks**, and remediate affected assets to a safe state.

## Microsoft recommendations for evaluating Microsoft Defender XDR security

Microsoft recommends you create your evaluation in an existing production subscription of Office 365. This way you will gain real-world insights immediately and can tune settings to work against current threats in your environment. After you've gained experience and are comfortable with the platform, simply promote each component, one at a time, to production.

### Microsoft Defender XDR components secure devices, identity, data, and applications

Microsoft Defender XDR is made up of these security technologies, operating in tandem. You don't need all of these components to benefit from the capabilities of XDR and Microsoft Defender XDR. You will realize gains and efficiencies through using one or two as well.

|Component|Description|Reference material|
|---|---|---|
|Microsoft Defender for Identity|Microsoft Defender for Identity uses Active Directory signals to identify, detect, and investigate advanced threats, compromised identities, and malicious insider actions directed at your organization.|[What is Microsoft Defender for Identity?](/defender-for-identity/what-is)|
|Exchange Online Protection|Exchange Online Protection is the native cloud-based SMTP relay and filtering service that helps protect your organization against spam and malware.|[Exchange Online Protection (EOP) overview - Office 365](/defender-office-365/eop-about)|
|Microsoft Defender for Office 365|Microsoft Defender for Office 365 safeguards your organization against malicious threats posed by email messages, links (URLs) and collaboration tools.|[Microsoft Defender for Office 365 - Office 365](/defender-office-365/defender-for-office-365-whats-new)|
|Microsoft Defender for Endpoint|Microsoft Defender for Endpoint is a unified platform for device protection, post-breach detection, automated investigation, and recommended response.|[Microsoft Defender for Endpoint - Windows security](/defender-endpoint/microsoft-defender-endpoint)|
|Microsoft Defender for Cloud Apps|Microsoft Defender for Cloud Apps is a comprehensive cross-SaaS solution bringing deep visibility, strong data controls, and enhanced threat protection to your cloud apps.|[What is Defender for Cloud Apps?](/cloud-app-security/what-is-cloud-app-security)|
|Microsoft Entra ID Protection|Microsoft Entra ID Protection evaluates risk data from billions of sign-in attempts and uses this data to evaluate the risk of each sign-in to your environment. This data is used by Microsoft Entra ID to allow or prevent account access, depending on how Conditional Access policies are configured. Microsoft Entra ID Protection is licensed separately from Microsoft Defender XDR. It is included with Microsoft Entra ID P2.|[What is Identity Protection?](/azure/active-directory/identity-protection/overview-identity-protection)|

## Microsoft Defender XDR architecture

The diagram below illustrates high-level architecture for key Microsoft Defender XDR components and integrations. *Detailed* architecture for each Defender component, and use-case scenarios, are given throughout this series of articles.

:::image type="content" source="../media/eval-defender-xdr-m365-defender-eval-architecture.png" alt-text="A diagram that shows the high-level architecture of Microsoft Defender XDR." lightbox="../media/eval-defender-xdr-m365-defender-eval-architecture.png":::

In this illustration:

- Microsoft Defender XDR combines the signals from all of the Defender components to provide extended detection and response (XDR) across domains. This includes a unified incident queue, automated response to stop attacks, self-healing (for compromised devices, user identities, and mailboxes), cross-threat hunting, and threat analytics.
- Microsoft Defender for Office 365 safeguards your organization against malicious threats posed by email messages, links (URLs), and collaboration tools. It shares signals resulting from these activities with Microsoft Defender XDR. Exchange Online Protection (EOP) is integrated to provide end-to-end protection for incoming email and attachments.
- Microsoft Defender for Identity gathers signals from servers running Active Directory Federated Services (AD FS) and on-premises Active Directory Domain Services (AD DS). It uses these signals to protect your hybrid identity environment, including protecting against hackers that use compromised accounts to move laterally across workstations in the on-premises environment.
- Microsoft Defender for Endpoint gathers signals from and protects devices used by your organization.
- Microsoft Defender for Cloud Apps gathers signals from your organization's use of cloud apps and protects data flowing between your environment and these apps, including both sanctioned and unsanctioned cloud apps.
- Microsoft Entra ID Protection evaluates risk data from billions of sign-in attempts and uses this data to evaluate the risk of each sign-in to your environment. This data is used by Microsoft Entra ID to allow or prevent account access, depending on how Conditional Access policies are configured. Microsoft Entra ID Protection is licensed separately from Microsoft Defender XDR. It is included with Microsoft Entra ID P2.

<a name='microsoft-siem-and-soar-can-use-data-from-microsoft-365-defender'></a>

## Microsoft SIEM and SOAR can use data from Microsoft Defender XDR

Additional optional architecture components not included in this illustration:

- **Detailed signal data from all Microsoft Defender XDR components can be integrated into Microsoft Sentinel** and combined with other logging sources to offer full SIEM and SOAR capabilities and insights.
- **For more reading on using Microsoft Sentinel, an Azure SIEM, with Microsoft Defender XDR** as an XDR, take a look at this [Overview article](/azure/sentinel/microsoft-365-defender-sentinel-integration) and the Microsoft Sentinel and Microsoft Defender XDR [integration steps](/azure/sentinel/connect-microsoft-365-defender?tabs=MDE).
- For more on SOAR in Microsoft Sentinel (including links to playbooks in the Microsoft Sentinel GitHub Repository), please read [this article](/azure/sentinel/automate-responses-with-playbooks).

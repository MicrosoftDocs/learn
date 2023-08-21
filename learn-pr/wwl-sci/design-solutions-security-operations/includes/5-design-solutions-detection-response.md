Microsoft 365 Defender is an **eXtended detection and response (XDR) solution** that automatically collects, correlates, and analyzes signal, threat, and alert data from _across_ your Microsoft 365 environment, including _endpoint, email, applications, and identities_. It leverages artificial intelligence (AI) and automation to _automatically_ stop attacks, and remediate affected assets into a safe state.

### Microsoft 365 Defender components secure devices, identity, data, and applications

Microsoft 365 Defender is made up of these security technologies, operating in tandem. You don't need all of these components to benefit from the capabilities of XDR and Microsoft 365 Defender. You will realize gains and efficiencies through using one or two as well.

|Component|Description|Reference material|
|---|---|---|
|Microsoft Defender for Identity|Microsoft Defender for Identity uses Active Directory signals to identify, detect, and investigate advanced threats, compromised identities, and malicious insider actions directed at your organization.|[What is Microsoft Defender for Identity?](/defender-for-identity/what-is)|
|Exchange Online Protection|Exchange Online Protection is the native cloud-based SMTP relay and filtering service that helps protect your organization against spam and malware.|[Exchange Online Protection (EOP) overview - Office 365](/microsoft-365/security/office-365-security/eop-about)|
|Microsoft Defender for Office 365|Microsoft Defender for Office 365 safeguards your organization against malicious threats posed by email messages, links (URLs) and collaboration tools.|[Microsoft Defender for Office 365 - Office 365](/microsoft-365/security/office-365-security/)|
|Microsoft Defender for Endpoint|Microsoft Defender for Endpoint is a unified platform for device protection, post-breach detection, automated investigation, and recommended response.|[Microsoft Defender for Endpoint - Windows security](/microsoft-365/security/defender-endpoint/)|
|Microsoft Defender for Cloud Apps|Microsoft Defender for Cloud Apps is a comprehensive cross-SaaS solution bringing deep visibility, strong data controls, and enhanced threat protection to your cloud apps.|[What is Defender for Cloud Apps?](/cloud-app-security/what-is-cloud-app-security)|
|Azure AD Identity Protection|Azure AD Identity Protection evaluates risk data from billions of sign-in attempts and uses this data to evaluate the risk of each sign-in to your environment. This data is used by Azure AD to allow or prevent account access, depending on how Conditional Access policies are configured. Azure AD Identity Protection is licensed separately from Microsoft 365 Defender. It is included with Azure Active Directory Premium P2.|[What is Identity Protection?](/azure/active-directory/identity-protection/overview-identity-protection)|

### Microsoft 365 Defender architecture

The diagram below illustrates high-level architecture for key Microsoft 365 Defender components and integrations. _Detailed_ architecture for each Defender component, and use-case scenarios, are given throughout this series of articles.

![A high-level architecture of the Microsoft 365 Defender portal](../media/m365-defender-eval-architecture.png)

In this illustration:

-   Microsoft 365 Defender combines the signals from all of the Defender components to provide extended detection and response (XDR) across domains. This includes a unified incident queue, automated response to stop attacks, self-healing (for compromised devices, user identities, and mailboxes), cross-threat hunting, and threat analytics.
-   Microsoft Defender for Office 365 safeguards your organization against malicious threats posed by email messages, links (URLs), and collaboration tools. It shares signals resulting from these activities with Microsoft 365 Defender. Exchange Online Protection (EOP) is integrated to provide end-to-end protection for incoming email and attachments.
-   Microsoft Defender for Identity gathers signals from servers running Active Directory Federated Services (AD FS) and on-premises Active Directory Domain Services (AD DS). It uses these signals to protect your hybrid identity environment, including protecting against hackers that use compromised accounts to move laterally across workstations in the on-premises environment.
-   Microsoft Defender for Endpoint gathers signals from and protects devices used by your organization.
-   Microsoft Defender for Cloud Apps gathers signals from your organization's use of cloud apps and protects data flowing between your environment and these apps, including both sanctioned and unsanctioned cloud apps.
-   Azure AD Identity Protection evaluates risk data from billions of sign-in attempts and uses this data to evaluate the risk of each sign-in to your environment. This data is used by Azure AD to allow or prevent account access, depending on how Conditional Access policies are configured. Azure AD Identity Protection is licensed separately from Microsoft 365 Defender. It is included with Azure Active Directory Premium P2.

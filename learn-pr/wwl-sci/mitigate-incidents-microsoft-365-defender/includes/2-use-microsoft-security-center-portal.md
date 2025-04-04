The Microsoft Defender portal ([https://security.microsoft.com/](https://security.microsoft.com/?azure-portal=true)) is a specialized workspace designed to meet the needs of security teams. These solutions are integrated across Microsoft 365 services and provide actionable insights to help reduce risks and safeguard your digital estate.

You can investigate the alerts that affect your network, understand what they mean, and collate evidence associated with the incidents so that you can devise an effective remediation plan.

The Home page shows many of the common cards that security teams need. The composition of cards and data is dependent on the user's role. Because the Microsoft Defender portal uses role-based access control, different roles see cards that are more meaningful to their day-to-day jobs.

This at-a-glance information helps you keep up with the latest activities in your organization. The Microsoft Defender portal brings together signals from different sources to present a holistic view of your Microsoft 365 environment.

The Microsoft Defender portal combines protection, detection, investigation, and response to email, collaboration, identity, device, and app threats, in a central place.

This single pane of glass brings together functionality from existing Microsoft security portals, like the Microsoft Defender portal and the Office 365 Security & Microsoft Purview portal. The Microsoft Defender portal emphasizes quick access to information, simpler layouts, and bringing related information together for easier use. It includes:

- **Microsoft Defender for Office 365** - Microsoft Defender for Office 365 helps organizations secure their enterprise with a set of prevention, detection, investigation and hunting features to protect email, and Office 365 resources.
- **Microsoft Defender for Endpoint** - Delivers preventative protection, post-breach detection, automated investigation, and response for devices in your organization.
- **Microsoft Defender XDR** - is part of Microsoft’s Extended Detection and Response (XDR) solution that uses the Microsoft 365 security portfolio to automatically analyze threat data across domains, and build a picture of an attack on a single dashboard.
- **Microsoft Defender for Cloud Apps** - Is a comprehensive cross-SaaS and PaaS solution bringing deep visibility, strong data controls, and enhanced threat protection to your cloud apps.
- **Microsoft Defender for Identity** - Is a cloud-based security solution that uses your on-premises Active Directory signals to identify, detect, and investigate advanced threats, compromised identities, and malicious insider actions directed at your organization.
- **Microsoft Defender Vulnerability Management** - Delivers continuous asset visibility, intelligent risk-based assessments, and built-in remediation tools to help your security and IT teams prioritize and address critical vulnerabilities and misconfigurations across your organization.
- **Microsoft Defender for IoT** - Operational Technology (OT) involves the specialized hardware and software used to monitor and control physical processes in critical sectors such as manufacturing, utilities, pharmaceuticals, and more. Microsoft Defender for IoT, available within the Microsoft Defender portal, is designed to secure OT environments.
- **Microsoft Sentinel** - Integrate Microsoft Defender XDR with Microsoft Sentinel to stream all Defender XDR incidents and advanced hunting events into Microsoft Sentinel and keep the incidents and events synchronized between the Azure and Microsoft Defender portals.

The **More resources** option in the portal provides a list of these related portals:

| Portal| Description|
| :--- | :--- |
| Microsoft Purview portal| Manage your compliance needs across Microsoft 365 services using integrated solutions for information governance, classification, case management, and more.|
| Microsoft Entra ID| Manage your organization's identities. Set up multifactor authentication, track user sign-ins, edit company branding, and more.|
| Microsoft Entra ID Protection| Detect potential vulnerabilities affecting your organization's identities. Investigate suspicious incidents related to your organization's identities and set up automated responses to resolve them.|
| Azure Information Protection| Configure and manage the Azure Information Protection client and scanner to automatically classify and protect your organization's email and docs. Use reports to monitor label usage and identify sensitive info that should be protected.|
| Microsoft Defender for Cloud| Protect your data centers and get advanced threat protection for your Azure and non-Azure workloads in the cloud and on premises. Secure your Azure services fast with autoprovisioned, native protection.|

## Map Microsoft Defender XDR Unified role-based access control (RBAC) permissions

All permissions listed within the Microsoft Defender XDR Unified RBAC model align to existing permissions in the individual RBAC models. Once you activate the Microsoft Defender XDR Unified RBAC model the permissions and assignments configured in your imported roles replace the existing roles in the individual RBAC models.

This article describes how existing roles and permissions in Microsoft Defender for Endpoint, Microsoft Defender Vulnerability Management, Microsoft Defender for Office 365, Microsoft Defender for Identity, and Microsoft Entra roles map to the roles and permission in the Microsoft Defender XDR Unified RBAC model.

> [!IMPORTANT]
> Microsoft recommends that you use roles with the fewest permissions. This helps improve security for your organization. Global Administrator is a highly privileged role that should be limited to emergency scenarios when you can't use an existing role.

## Map Microsoft Defender XDR Unified RBAC permissions to existing RBAC permissions

> [!IMPORTANT]
> Starting February 16, 2025, the Microsoft Defender XDR Unified RBAC model will be the default permissions model for new Microsoft Defender Endpoint tenants. These new tenants won't have the capability to export roles and permissions from the current model. Defender for Endpoint tenants with roles and permissions assigned or exported prior to this date will maintain their current roles and permissions configuration
>
> Starting March 2, 2025, new Microsoft Defender for Identity tenants will also have the Unified RBAC model as their default permissions model. They won't be able to export roles and permissions from the current model. Existing Defender for Identity tenants maintain their current roles and permissions configuration.

Use the tables in the following sections to learn more about how your existing individual RBAC role definitions map to your new Microsoft Defender XDR Unified RBAC roles:

1. [Map Defender for Endpoint and Defender Vulnerability Management permissions](/defender-xdr/compare-rbac-roles#map-defender-for-endpoint-and-defender-vulnerability-management-permissions-to-the-microsoft-365-defender-rbac-permissions)
1. [Map Defender for Office 365 permissions to the Microsoft Defender XDR Unified RBAC permissions](/defender-xdr/compare-rbac-roles#map-defender-for-office-365-permissions-to-the-microsoft-365-defender-unified-rbac-permissions)
1. [Map Microsoft Defender for Identity permissions](/defender-xdr/compare-rbac-roles#map-microsoft-defender-for-identity-permissions-to-the-microsoft-365-defender-unified-rbac-permissions)
1. [Microsoft Entra Global roles access](/defender-xdr/compare-rbac-roles#azure-active-directory-global-roles-access)

### Map Defender for Endpoint and Defender Vulnerability Management permissions to the Microsoft Defender XDR RBAC permissions

|Defender for Endpoint and Defender Vulnerability Management permissions|Microsoft Defender XDR Unified RBAC permission|
|---|---|---|
|View data - Security operations|Security operations \ Security data \ Security data basics (read)|
|View data - Defender Vulnerability Management|Security posture \ Posture management \ Vulnerability management (read)|
|Alerts investigation|Security operations \ Security data \ Alerts (manage)|
|Active remediation actions - Security operations|Security operations \ Security data \ Response (manage)|
|Active remediation actions - Defender Vulnerability Management - Exception handling|Security posture \ Posture management \ Exception handling (manage)|
|Active remediation actions - Defender Vulnerability Management - Remediation handling|Security posture \ posture management \ Remediation handling (manage)|
|Active remediation actions - Defender Vulnerability Management - Application handling|Security posture \ Posture management \ Application handling (manage)|
|Defender Vulnerability management – Manage security baselines assessment profiles|Security posture \ posture management \ Security baselines assessment (manage)|
|Live response capabilities|Security operations \ Basic live response (manage)|
|Live response capabilities - advanced|Security operations \ Advanced live response (manage) </br> Security operations \ Security data \ File collection (manage)|
|Manage security settings in the Security Center | Authorization and settings \ Security settings \ Core security settings (manage) </br> Authorization and settings\Security settings \ Detection tuning (manage)|
|Manage portal system settings|Authorization and settings \ System setting (Read and manage)|
|Manage endpoint security settings in Microsoft Intune|Not supported - this permission is managed in the Microsoft Intune admin center|

### Map Defender for Office 365 permissions to the Microsoft Defender XDR Unified RBAC permissions

Use the following tables to learn how your existing Email & collaboration and protection-related Exchange Online permissions for Defender for Office 365 map to the new Microsoft Defender XDR Unified RBAC permissions:

- [Email & collaboration permissions mapping](#email--collaboration-permissions-mapping)
- [Exchange Online permissions mapping](#exchange-online-permissions-mapping)

#### Email & collaboration permissions mapping

You configured Email & collaboration permissions in the Defender portal at <https://security.microsoft.com/emailandcollabpermissions>.

|Email & collaboration permission|Type|Microsoft Defender XDR Unified RBAC permission|
|---|---|---|
|Global Reader|Role group|Security operations \ Security data \ Security data basics (read) </br> Security operations \ Raw data (Email & collaboration) \ Email & collaboration metadata (read) </br> Security operations \ Security data \ Response (manage) </br> Authorization and settings \ Security settings \ Core security settings (read) </br> Authorization and settings \ System setting (read)|
|Organization Management|Role group|Security operations \ Security data \ Security data basics (read) </br> Security operations \ Security data \ Alerts (manage) </br> Security operations \ Raw data (Email & collaboration) \ Email & collaboration metadata (read)</br> Security operations \ Security data \ Response (manage) </br> Security operations \ Security data \ Email advanced actions (manage) </br> Security operations \ Security data \ Email quarantine (manage) </br> Authorization and settings \ Authorization (Read and manage) </br> Authorization and settings \ Security setting (All permissions) </br> Authorization and settings \ System settings (Read and manage)|
|Security Administrator|Role group|Security operations \ Security data \ Security data basics (read) </br>Security operations \ Security data \ Alerts (manage) </br> Security operations \ Raw data (Email & collaboration) \ Email & collaboration metadata (read) </br> Security operations \ Security data \ Response (manage) </br> Security operations \ Security data \ Email quarantine (manage) </br> Authorization and settings \ Authorization (read) </br> Authorization and settings \ Security setting (All permissions) </br> Authorization and settings \ System settings (Read and manage)|
|Security Reader|Role group|Security operations \ Security data \Security data basics (read) </br> Security operations \ Raw data (Email & collaboration) \ Email & collaboration metadata (read) </br> Security operations \ Security data \ Response (manage) </br> Authorization and settings \ Security settings \ Core security settings (read) </br> Authorization and settings \ System setting (read)|
|Audit Logs|Role|Security operations \ Security data \ Security data basics (read)|
|Manage Alerts|Role|Security operations \ Security data \ Security data basics (read) </br> Security operations \ Security data \ Alerts (manage)|
|Preview|Role|Security operations\ Security operations \ Raw data (Email & collaboration) \ Email & collaboration content (read)|
|Quarantine|Role|Security operations \ Security data \ Email quarantine (manage)|
|Role Management|Role|Authorization and settings \ Authorization (Read and manage)|
|Search and Purge|Role|Security operations \ Security data \ Email advanced actions (manage)|
|View-Only Manage Alerts|Role|Security operations \ Security data \ Security data basics (read)|
|View-Only Recipients|Role|Security operations \ Security data \ Security data basics (read) </br> Security operations \ Raw data (Email & collaboration) \ Email & collaboration metadata (read)|
|View-only Audit Logs|Role|Security operations \ Security data \ Security data basics (read)|

#### Exchange Online permissions mapping

You configured protection-related Exchange Online permissions in the Exchange admin center (EAC) at <https://admin.exchange.microsoft.com/#/adminRoles>.

|Exchange Online permission|Type|Microsoft Defender XDR Unified RBAC permission|
|---|---|---|
|Hygiene Management|Role group|Security operations \ Security data \ Email quarantine (manage) </br> Authorization and settings \ Security settings \ Core security settings (manage) </br> Authorization and settings \ Security settings \ Detection tuning (manage)|
|Organization Management|Role group|Security operations \ Raw data (email & collaboration) \ Email & collaboration metadata (read) </br> Authorization and settings \ Security settings \ Core security settings (manage) </br> Authorization and settings \ Security settings \ Detection tuning (manage) </br> Authorization and settings \ System settings (Read and manage)|
|Security Administrator|Role group|Authorization and settings \ Security settings \ Detection tuning (manage) </br> Authorization and settings \ System settings (Read and manage)|
|View-Only Organization Management|Role group|Authorization and settings \ Security settings (Read-only) </br> Authorization and settings \ System settings (Read-only)|
|Tenant AllowBlockList Manager|Role|Authorization and settings \ Security settings \ Detection tuning (manage)|
|View-only Recipients|Role|Security operations \ Raw data (email & collaboration) \ Email & collaboration metadata (read)|

### Map Microsoft Defender for Identity permissions to the Microsoft Defender XDR Unified RBAC permissions

|Defender for Identity permission|Defender XDR Unified RBAC permission|
|---|-----|
|MDI admin|Security operations \ Security data \ Security data basics (read)</br>Security operations \ Security data \ Alerts (manage)</br>Authorization and settings \ Authorization (Read and manage) </br>Authorization and settings \ Security setting (All permissions) </br>Authorization and settings \ System settings (Read and manage)|
|MDI user|Security operations \ Security data \ Security data basics (read) </br>Security operations \ Security data \ Alerts (manage)</br>Authorization and settings \ Security setting (All permissions) </br>Authorization and settings \ System setting (read)|
|MDI viewer|Security operations \ Security data \ Security data basics (read)</br>Authorization and settings \ Security settings \ Core security settings (read) </br>Authorization and settings \ System setting (read)|

> [!NOTE]
> Defender for Identity experiences will also adhere to permissions granted from [Microsoft Defender for Cloud Apps](https://security.microsoft.com/cloudapps/permissions/roles). For more information, see [Microsoft Defender for Identity role groups](https://go.microsoft.com/fwlink/?linkid=2202729).
> Exception: If you have configured [Scoped deployment](/defender-cloud-apps/scoped-deployment) for Microsoft Defender for Identity alerts in Microsoft Defender for Cloud Apps, these permissions do not carry over. You need to explicitly grant the Security operations \ Security data \ Security data basics (read) permissions for the relevant portal users.

### Map Microsoft Defender for Cloud Apps permissions to the Microsoft Defender XDR Unified RBAC permissions

> [!IMPORTANT]
> App Governance supports Microsoft Entra roles as described in [Roles in app governance for Microsoft Defender for Cloud Apps](/defender-cloud-apps/app-governance-get-started#roles) and does not support the roles defined in the integration of Defender for Cloud Apps with unified RBAC.</br></br>
> Once you activate the Defender for Cloud Apps integration with Microsoft Defender XDR Unified RBAC, the following roles, configured through [built-in scoped roles](/defender-cloud-apps/manage-admins#roles-and-permissions) in Defender for Cloud Apps, will no longer be supported: **App/instance admin**, **User group admin**, **Cloud Discovery global admin**, and **Cloud Discovery report admin**.

|Defender for Cloud Apps permission|Defender XDR Unified RBAC permission|
|---|-----|
|Local Global administrator|Security operations \ Security data \ Security data basics (read)</br>Security operations \ Security data \ Alerts (manage)</br>Authorization and settings \ Authorization (all permissions) </br>Authorization and settings \ Security settings (all permissions) </br>Authorization and settings \ System settings (all permissions)|
|Local Security operator|Security operations \ Security data \ Security data basics (read) </br>Security operations \ Security data \ Alerts (manage)</br>Authorization and settings \ Authorization (read) </br>Authorization and settings \ Security setting (all permissions) </br>Authorization and settings \ System setting (read)|
|Local Security reader|Security operations \ Security data \ Security data basics (read)</br>Authorization and settings \ Authorization (read) </br>Authorization and settings \ Security settings \ Security settings (read) </br>Authorization and settings \ System settings (read)|
|Local Compliance administrator|Security operations \ Security data \ Security data basics (read)</br>Security operations \ Security data \ Alerts (manage)</br>Authorization and settings \ Authorization (read) </br>Authorization and settings \ Security settings \ Security settings (all permissions) </br>Authorization and settings \ System settings (read)|

### Microsoft Entra Global roles access

Users assigned with Microsoft Entra global roles may also have access to the [Microsoft Defender portal](https://security.microsoft.com).

Use this table to learn about the permissions assigned by default for each workload (Defender for Endpoint, Defender Vulnerability Management, Defender for Office and Defender for Identity) in Microsoft Defender XDR Unified RBAC to each global Microsoft Entra role.

|Microsoft Entra role|Microsoft Defender XDR Unified RBAC assigned permissions for all workloads|Microsoft Defender XDR Unified RBAC assigned permissions – workload specific|
|---|-|---|
|Global administrator|Security operations \ Security data \ Security data basics (read)</br>Security operations \ Security data \ Alerts (manage) </br>Security operations \ Security data \ Response (manage)</br>Security posture \ Posture management \ Secure Score (read) </br> Security posture \ Posture management \ Secure Score (manage)</br>Authorization and settings \ Authorization (Read and manage)</br>Authorization and settings \ Security settings (All permissions)</br>Authorization and settings \ System settings (Read and manage) |_**Defender for Endpoint and Defender Vulnerability Management permissions only permissions**_ </br>Security operations \ Basic live response (manage)</br>Security operations \ Advanced live response (manage) </br> Security operations  \ Security data \ File collection (manage) </br>Security posture \ Posture management \ Vulnerability management (read)</br>Security posture \ Posture management \ Exception handling (manage)</br>Security posture \ Posture management \ Remediation handling (manage)</br>Security posture \ Posture management \ Application handling (manage)</br>Security posture \ Posture management \ Security baseline assessment (manage)</br></br> _**Defender for Office only permissions**_ </br> Security operations \ Security data \ Email quarantine (manage)</br>Security operations \ Security data \ Email advanced actions (manage)</br>Security operations \ Raw data (Email & collaboration) \ Email & collaboration metadata (read)|
|Security administrator|Same as Global administrator|Same as Global administrator|
|Global reader|Security operations \ Security data \ Security data basics (read)</br>Security posture \ Posture management \ Secure Score (read) </br>|_**Defender for Endpoint and Defender Vulnerability Management permissions only permissions**_ </br>Security posture \ Posture management \ Vulnerability management (read)</br></br> _**Defender for Office only permissions**_ </br> Security operations \ Security data \ Response (manage)</br>Security operations \ Raw data (Email & collaboration) \ Email & collaboration metadata (read)</br>Authorization and settings \ Authorization (read) </br></br>_**Defender for Office and Defender for Identity only permissions**_ </br>Authorization and settings \ Security settings \ Core security settings (read)</br>Authorization and settings \ System settings (read)|
|Security reader|Security operations \ Security data \ Security data basics (read)</br>Security posture \ Posture management \ Secure Score (read) </br>|_**Defender for Endpoint and Defender Vulnerability Management permissions only permissions**_ </br>Security posture \ Posture management \ Vulnerability management (read)</br></br> _**Defender for Office only permissions**_ </br> Security operations \ Security data \ Response (manage)</br>Security operations \ Raw data (Email & collaboration) \ Email & collaboration metadata (read) </br></br>_**Defender for Office and Defender for Identity only permissions**_ </br>Authorization and settings \ Security settings \ Core security settings (read)</br>Authorization and settings \ System settings (read)|
|Security operator|Security operations \ Security data \ Security data basics (read)</br>Security operations \ Security data \ Alerts (manage) </br>Security operations \ Security data \ Response (manage)</br>Security posture \ Posture management \ Secure Score (read)</br>Authorization and settings \ Security settings (All permissions)|_**Defender for Endpoint and Defender Vulnerability Management permissions only permissions**_</br>Security operations  \ Security data \ Basic live response (manage)</br>Security operations  \ Security data \ Advanced live response (manage)</br> Security operations \ Security data \ File collection (manage) </br>Security posture \ Posture management \ Vulnerability management (read)</br>Security posture \ Posture management \ Exception handling (manage)</br>Security posture \ Posture management \ Remediation handling (manage)</br></br>_**Defender for Office only permissions**_ </br>Security operations \ Raw data (Email & collaboration) \ Email & collaboration metadata (read)</br>Authorization and settings \ System settings (Read and manage)</br></br>_**Defender for Identity only permissions**_ </br>Authorization and settings \ System settings (read)|
|Exchange Administrator|Security posture \ Posture management \ Secure Score (read) </br> Security posture \ Posture management \ Secure Score (manage) |_**Defender for Office only permissions**_ </br>Security operations \ Security data \ Security data basic (read) </br>Security operations \ Raw data (Email & collaboration) \ Email & collaboration metadata (read) </br>Authorization and settings \ System settings (Read and manage)|
|SharePoint Administrator|Security posture \ Posture management \ Secure Score (read) </br> Security posture \ Posture management \ Secure Score (manage)|not applicable|
|Service Support Administrator|Security posture \ Posture management \ Secure Score (read) |not applicable|
|User Administrator|Security posture \ Posture management \ Secure Score (read) |not applicable|
|HelpDesk Administrator|Security posture \ Posture management \ Secure Score (read) |not applicable|
|Compliance administrator|not applicable|_**Defender for Office only permissions**_ </br> Security operations \ Security data \ Security data basics (read)</br> Security operations \ Security data \ Alerts (manage)|
|Compliance data administrator|not applicable|Same as Compliance administrator|
|Billing admin|not applicable|not applicable|

> [!NOTE]
> By activating the Microsoft Defender XDR Unified RBAC model, users with Security Reader and Global Reader roles can access Defender for Endpoint data.

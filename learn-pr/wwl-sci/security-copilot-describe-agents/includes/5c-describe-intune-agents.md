Security Copilot agents in Microsoft Intune are AI-powered assistants that enhance enterprise endpoint security. They automate tasks for endpoint protection, threat intelligence, and device configuration, helping IT teams quickly address vulnerabilities, policy gaps, and emerging threats. Each agent is tailored to a specific use case and operates within the Microsoft Intune admin center.

> [!NOTE]
> The list of Security Copilot agents in Microsoft Intune is continually growing. This unit is designed to provide a high-level overview of a few of the Security Copilot agents in Microsoft Intune. For more information, see training that relates to Microsoft Intune.

### Microsoft Security Copilot agents in Microsoft Intune

The following Microsoft Security Copilot agents are available in Microsoft Intune. Due to the fast pace at which these agents are released and updated, each agent might have features at various stages of availability.

#### Vulnerability Remediation Agent

The [Vulnerability Remediation Agent](/intune/agents/vulnerability-remediation-agent) uses data from Microsoft Defender Vulnerability Management to identify Common Vulnerabilities and Exposures (CVEs) on managed devices. The results are prioritized for remediation and include step-by-step instructions to guide you in using Intune to remediate the threat.

| Attribute | Description |
|-----------|-------------|
| **Identity** | Runs under the identity and permissions of the admin account used during setup. Agent authentication expires after 90 days and must be renewed. |
| **License** | Microsoft Intune Plan 1, Microsoft Security Copilot with sufficient security compute units (SCUs), and Microsoft Defender Vulnerability Management (provided by Defender for Endpoint P2 or Defender Vulnerability Management Standalone). |
| **Plugins** | Microsoft Intune and Microsoft Defender. |
| **Products** | Security Copilot, Microsoft Intune, and Microsoft Defender Vulnerability Management. |
| **Role-based access** | **Set up**: Security Copilot Owner, Intune Read Only Operator (or custom role with Managed apps/read, Mobile apps/read, Device configurations/read), and Defender Security Reader. **Use**: Security Copilot Contributor and Intune Read Only Operator (or equivalent). |
| **Trigger** | Manually started by an admin. |

#### Change Review Agent

The [Change Review Agent](/intune/agents/change-review-agent) evaluates Multi Admin Approval requests for PowerShell scripts on Windows devices. It aggregates signals from Microsoft Defender Vulnerability Management, Microsoft Entra ID, and Microsoft Intune to provide risk-based recommendations and contextual insights that help administrators make informed decisions about whether to approve or deny requests.

| Attribute | Description |
|-----------|-------------|
| **Identity** | Runs under the identity and permissions of the admin account used during setup. Agent authentication expires after 90 days and must be renewed. |
| **License** | Microsoft Intune Plan 1, Microsoft Entra ID P2, Microsoft Defender Vulnerability Management, and Microsoft Security Copilot with sufficient SCUs. |
| **Plugins** | Microsoft Intune, Microsoft Entra, Microsoft Defender XDR, and Microsoft Threat Intelligence. |
| **Products** | Security Copilot, Microsoft Intune, Microsoft Entra ID, and Microsoft Defender. |
| **Role-based access** | **Set up**: Security Copilot Owner, Microsoft Entra Intune Administrator, Microsoft Entra Security Reader, Entra/Identity risky user (read), and Defender Security Reader (Unified role-based access control (RBAC)) or equivalent. **Use**: Security Copilot Contributor, Intune Read Only Operator (or equivalent), and the same Microsoft Entra and Defender roles. |
| **Trigger** | Manually started by an admin. |

#### Device Offboarding Agent

The [Device Offboarding Agent](/intune/agents/device-offboarding-agent) identifies stale or misaligned devices across Intune and Microsoft Entra ID. It provides actionable insights and requires admin approval before offboarding any devices. The agent complements existing Intune automation by surfacing insights and handling ambiguous cases where automated cleanup may not suffice.

| Attribute | Description |
|-----------|-------------|
| **Identity** | Runs under the identity and permissions of the admin account used during setup. Agent authentication expires after 90 days and must be renewed. |
| **License** | Microsoft Intune Plan 1 and Microsoft Security Copilot with sufficient SCUs. |
| **Plugins** | Microsoft Intune. |
| **Products** | Security Copilot, Microsoft Intune, and Microsoft Entra ID. |
| **Role-based access** | **Set up**: Security Copilot Owner, Intune Read Only Operator (or custom role with Audit data/Read and Organization/Read), and Microsoft Entra Security Reader (or custom role with Microsoft.Directory/Devices/Standard/Read). **Use**: Security Copilot Contributor with the same Intune and Microsoft Entra roles. To take offboarding actions, the Microsoft Entra Disable devices permission is also required. |
| **Trigger** | Manually started by an admin. |

#### Policy Configuration Agent

The [Policy Configuration Agent](/intune/agents/policy-configuration-agent) converts plain-language documents and industry baselines into recommended Intune settings and policies. Admins can upload compliance standards or organizational security policies, and the agent identifies relevant Intune settings catalog settings, recommends values, and guides the creation of configuration profiles.

| Attribute | Description |
|-----------|-------------|
| **Identity** | Runs under the identity and permissions of the account used during setup. Agent authentication expires after 90 days and must be renewed. |
| **License** | Microsoft Intune Plan 1 and Microsoft Security Copilot with sufficient SCUs. |
| **Plugins** | Microsoft Intune. |
| **Products** | Security Copilot and Microsoft Intune. |
| **Role-based access** | **Set up**: Security Copilot Owner and Intune Read Only Operator (or custom role with Device configurations/Read). **Use and create policies**: Security Copilot Contributor and Intune Policy and Profile manager (or custom role with Device configurations/Create and Device configurations/Update). |
| **Trigger** | Manually started by an admin. |

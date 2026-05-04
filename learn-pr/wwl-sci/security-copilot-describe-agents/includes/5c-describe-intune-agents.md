Security Copilot agents in Microsoft Intune are AI-powered assistants that enhance enterprise endpoint security. They automate tasks for endpoint protection, threat intelligence, and device configuration, helping IT teams quickly address vulnerabilities, policy gaps, and emerging threats. These agents are built on Security Copilot's generative AI and automation capabilities—they observe, reason, and act with oversight and review from administrators. Each agent is tailored to a specific use case and operates within the Microsoft Intune admin center.

> [!NOTE]
> The list of Security Copilot agents in Microsoft Intune is continually growing. This unit is designed to provide a high-level overview of the Security Copilot agents in Microsoft Intune. For more information, see training that relates to Microsoft Intune.

### Microsoft Security Copilot agents in Microsoft Intune

The following Microsoft Security Copilot agents are available in Microsoft Intune. Due to the fast pace at which these agents are released and updated, each agent might have features at various stages of availability. All Intune agents share the following common characteristics:

- They run under the identity and permissions of the admin account used during setup.
- Agent authentication expires after 90 days and must be renewed.
- They're supported on the public cloud only and aren't supported on government clouds.
- They require Microsoft Intune Plan 1 and Microsoft Security Copilot with sufficient security compute units (SCUs).

#### Vulnerability Remediation Agent

The [Vulnerability Remediation Agent](/intune/copilot/agents/vulnerability-remediation-agent) uses data from Microsoft Defender Vulnerability Management to identify Common Vulnerabilities and Exposures (CVEs) on managed devices. The results are prioritized for remediation and include step-by-step instructions to guide you in using Intune to remediate the threat.

When the agent runs, it analyzes data from Microsoft Defender Vulnerability Management and provides a prioritized list of suggestions. Each suggestion includes the count of associated CVEs, a Copilot-assisted impact analysis, suggested actions, affected systems, exposed devices, and step-by-step remediation guidance. Once you remediate a suggestion, you can mark it as applied so the agent retains a record for tracking remediation over time.

| Attribute | Description |
|-----------|-------------|
| **Identity** | Runs under the identity and permissions of the admin account used during setup. |
| **License** | Microsoft Intune Plan 1, Microsoft Security Copilot with sufficient SCUs, and Microsoft Defender Vulnerability Management (provided by Defender for Endpoint P2 or Defender Vulnerability Management Standalone). |
| **Plugins** | Microsoft Intune and Microsoft Defender. |
| **Products** | Security Copilot, Microsoft Intune, and Microsoft Defender Vulnerability Management. |
| **Role-based access** | **Set up**: Security Copilot Owner, Intune Read Only Operator (or custom role with Managed apps/Read, Mobile apps/Read, Device configurations/Read), and Defender Security Reader. **Use**: Security Copilot Contributor and Intune Read Only Operator (or equivalent). |
| **Trigger** | Manually started by an admin. |

#### Change Review Agent

The [Change Review Agent](/intune/copilot/agents/change-review-agent) evaluates Multi Admin Approval requests for PowerShell scripts on Windows devices. It aggregates signals from Microsoft Defender Vulnerability Management, Microsoft Entra ID, and Microsoft Intune to provide risk-based recommendations and contextual insights that help administrators make informed decisions about whether to approve or deny requests.

The agent analyzes these signals to assess the potential risk associated with each request and delivers actionable insights to support secure and efficient change management. This helps Intune administrators understand script behavior and associated risks more quickly.

| Attribute | Description |
|-----------|-------------|
| **Identity** | Runs under the identity and permissions of the admin account used during setup. |
| **License** | Microsoft Intune Plan 1, Microsoft Entra ID P2, Microsoft Defender Vulnerability Management, and Microsoft Security Copilot with sufficient SCUs. |
| **Plugins** | Microsoft Intune, Microsoft Entra, Microsoft Defender XDR, and Microsoft Threat Intelligence. |
| **Products** | Security Copilot, Microsoft Intune, Microsoft Entra ID, and Microsoft Defender. |
| **Role-based access** | **Set up**: Security Copilot Owner, Microsoft Entra Intune Administrator, Microsoft Entra Security Reader, Entra/Identity risky user (read), and Defender Security Reader. **Use**: Security Copilot Contributor, Intune Read Only Operator (or equivalent), and the same Microsoft Entra and Defender roles. |
| **Trigger** | Manually started by an admin. |

#### Policy Configuration Agent

The [Policy Configuration Agent](/intune/copilot/agents/policy-configuration-agent) converts plain-language documents and industry baselines into recommended Intune settings and policies. Admins can upload compliance standards or organizational security policies, and the agent identifies relevant Intune settings catalog settings, recommends values, and guides the creation of configuration profiles.

The agent analyzes uploaded documents or industry benchmarks and automatically identifies matching Intune settings. It then guides you through policy creation and helps configure each setting that best suits your organization's needs. This agent currently supports devices running Windows.

| Attribute | Description |
|-----------|-------------|
| **Identity** | Runs under the identity and permissions of the account used during setup. |
| **License** | Microsoft Intune Plan 1 and Microsoft Security Copilot with sufficient SCUs. |
| **Plugins** | Microsoft Intune. |
| **Products** | Security Copilot and Microsoft Intune. |
| **Role-based access** | **Set up**: Security Copilot Owner and Intune Read Only Operator (or custom role with Device configurations/Read). **Use and create policies**: Security Copilot Contributor and Intune Policy and Profile manager (or custom role with Device configurations/Create and Device configurations/Update). |
| **Trigger** | Manually started by an admin. |

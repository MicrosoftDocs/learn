Configuring individual settings is only half the job. To operate securely at scale, you need to target policies correctly, apply a proven baseline, keep systems from drifting, and validate before you enforce.

## Scope and precedence

Security settings follow the standard Group Policy processing order, **LSDOU** (Local, Site, Domain, OU), and you refine which computers receive a GPO with:

- **Enforced** and **Block Inheritance** to override normal precedence.
- **Security filtering** to apply a GPO only to specific computers or groups.
- **WMI filters** to apply a GPO based on attributes such as operating system version.
- **Loopback processing** when you need user-side settings to depend on the computer.

Remember the domain-scope rule from Unit 2: domain Account Policies must live in a **domain-linked** GPO.

## Which GPO for what

Keep your design clear and reversible:

- **Default Domain Policy**: the domain account policy and a small number of domain-wide security settings.
- **Default Domain Controllers Policy**: domain controller user rights and audit settings.
- **Purpose-built GPOs**: everything else, in well-named objects such as *Server Security Baseline*, *Tiered Admin – Deny Logons*, and *Auditing Baseline*, so each concern can be reviewed, linked, and rolled back independently.

## Security baselines with OSConfig

**OSConfig** is the Windows Server 2025-native security-configuration stack: a PowerShell module (also driven from Windows Admin Center) with native APIs and data-driven **scenario** definitions. It applies Microsoft's **role-aware** security baseline and then keeps it enforced with built-in **drift control**.

> [!IMPORTANT]
> OSConfig isn't Group Policy. It applies desired-state configuration **locally** and continuously reverts drift, complementing the GPO-based hardening in this module. Any setting that both mechanisms can control should be owned by **one** of them to avoid conflicting sources of truth.

Key facts about the OSConfig security baseline:

- **Role-aware scenarios**: `SecurityBaseline/WindowsServer/2025/DomainController`, `.../MemberServer` (domain-joined), and `.../WorkgroupMember` (non-domain-joined). Related scenarios cover Microsoft Defender Antivirus, Windows LAPS, Secured-core server, and App Control for Business, which is the preferred Microsoft path for new, robust application-control deployments where feasible.
- **What it changes**: disables legacy protocols and ciphers (TLS 1.2 minimum, SMB 3.0 minimum), enforces many of the Unit 4 and Unit 5 settings, disables RDP drive redirection, and enforces the local-account password policy (complexity and a 14-character minimum, for local accounts only). After you apply the Member server or Workgroup member baseline, you must change the local administrator password to one that meets that policy. It helps you work toward the CIS Benchmarks and DISA STIGs. A restart is required after you apply or remove a baseline.
- **Manage at scale**: drive OSConfig locally with PowerShell or Windows Admin Center. For Azure or Azure Arc-enabled servers, use **Azure Policy** and **Azure Machine Configuration** for compliance monitoring and reporting at scale.

## Compare GPO baselines with the Security Compliance Toolkit

Use the Microsoft Security Compliance Toolkit (SCT) when you need to compare Group Policy baselines or test policy outside the domain rollout path. SCT includes Microsoft security baselines, Policy Analyzer, and LGPO.

- **Policy Analyzer** compares sets of GPOs with Microsoft baselines or another approved baseline, highlights conflicts and differences, and can export results for review.
- **LGPO.exe** automates Local Group Policy for standalone or pilot servers. Use it to import or export local policy, apply security templates or advanced-auditing backups, and test the effect before you convert changes into domain GPOs.
- Keep OSConfig as the Windows Server 2025 role-aware baseline path. Use SCT for GPO comparison, baseline review, and local or nondomain testing; don't create a second owner for settings that OSConfig already enforces.

## Test before you enforce

Validate the effect of a policy before it reaches production:

- **Group Policy Modeling** and **Group Policy Results** in GPMC, `gpresult /h`, and `rsop.msc` show the resultant set of policy.
- **Audit modes** for NTLM restriction, AppLocker, minimum password length, and advanced auditing let you observe impact safely before enforcement.
- **Security Configuration and Analysis** and `secedit /analyze` compare a machine with a known-good `.inf` security template for supported security-template areas. Use RSoP tools, GPO reports, and workload testing for settings outside that scope. On Server Core, use `secedit` and PowerShell rather than the Security Configuration and Analysis MMC snap-in.

## Operate

- Generate GPO reports before and after changes so reviewers can see links, filtering, delegation, and configured settings.
- Back up and version GPOs, including a comment that identifies the change or release.
- Document links, security filters, WMI filters, and staged rollout by OU (pilot, then broad).
- Use `Restore-GPO` to roll back a backed-up GPO in its original domain context. Use `Import-GPO` when you need to copy settings into a different or newly created GPO; use a migration table when security principals or UNC paths must be mapped between domains or forests.
- Review settings periodically against the current baseline.

## Best-practice checklist

- **Design**: dedicated, well-named GPOs; least privilege; tiered administration.
- **Harden**: the GPO settings from Units 2–7, the OSConfig role-aware baseline, and SCT/Policy Analyzer review for GPO baseline comparisons.
- **Audit**: advanced audit policy with adequate log sizing and retention.
- **Operate**: test, stage, back up, and review.

## Apply and validate

Before you apply an OSConfig baseline, use a Windows Server 2025 device and run PowerShell as an administrator. Install or update the `Microsoft.OSConfig` module, then confirm the installed version:

```powershell
# First use on a connected server
Install-Module -Name Microsoft.OSConfig -Scope AllUsers -Force

# Keep the local baseline definitions current
Update-Module -Name Microsoft.OSConfig

# Verify that the module is available and note the version
Get-Module -ListAvailable -Name Microsoft.OSConfig
```

For servers that can't reach PowerShell Gallery, download the `Microsoft.OSConfig` package manually or use `Save-Module` on a connected computer, copy the module to a trusted share, and import it on the target server:

```powershell
# On a connected computer
Save-Module -Name Microsoft.OSConfig -Path "\\Server01\Public"

# On the target server
Import-Module "\\Server01\Public\Microsoft.OSConfig\*\Microsoft.OSConfig.psd1"
```

Apply the Windows Server 2025 baseline with OSConfig:

```powershell
# Member server (domain-joined)
Set-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WindowsServer/2025/MemberServer -Default

# Workgroup member server (non-domain-joined)
Set-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WindowsServer/2025/WorkgroupMember -Default

# Domain controller
Set-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WindowsServer/2025/DomainController -Default
```

Restart the device to complete the change, then verify the baseline and customize only the settings your design requires while keeping drift control:

```powershell
Get-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WindowsServer/2025/MemberServer
Set-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WindowsServer/2025/MemberServer -Setting AuditDetailedFileShare -Value 3
Get-OSConfigDesiredConfiguration -Scenario SecurityBaseline/WindowsServer/2025/MemberServer -Setting AuditDetailedFileShare
```

When a newer baseline is released, update the `Microsoft.OSConfig` module and reapply the same scenario. If OSConfig prompts you to remove the previously applied baseline version, confirm the prompt, reapply the scenario, and restart. If you manage Azure Arc-connected servers through Azure Policy or Azure Machine Configuration and the server role changes after assignment, delete and reapply the assignment so role detection refreshes.

Report and back up before a change:

```powershell
New-Item -ItemType Directory -Path C:\Temp, C:\GPOReports, C:\GPOBackups -Force | Out-Null

gpresult /h C:\Temp\rsop.html
secedit /analyze /db C:\Temp\baseline.sdb /cfg C:\Temp\baseline.inf /overwrite /log C:\Temp\baseline.log
Get-GPOReport -Name "Server Security Baseline" -ReportType Html -Path C:\GPOReports\ServerSecurityBaseline.html
Backup-GPO -Name "Server Security Baseline" -Path C:\GPOBackups -Comment "Pre-change backup"
```

The `/cfg` file (`baseline.inf`) must already be an approved security template. Create and export it with **Security Configuration and Analysis** or `secedit /export`, or copy it from your baseline source, before you analyze. Include `/overwrite` so the template replaces any template already stored in the database; without it, `secedit` *appends* the `/cfg` template to the stored configuration, so repeated analyses against the same `.sdb` build a merged, composite template instead of a clean comparison.

Use restore only when rolling back the same GPO in the original domain context:

```powershell
Restore-GPO -Name "Server Security Baseline" -Path C:\GPOBackups
```

Use import when copying backed-up settings into a new or existing GPO, such as a test GPO or a GPO in another domain. Add `-MigrationTable` when security principals or UNC paths need mapping:

```powershell
Import-GPO -BackupGpoName "Server Security Baseline" -TargetName "Server Security Baseline - Test" -Path C:\GPOBackups -CreateIfNeeded -MigrationTable C:\GPOBackups\DomainMigration.migtable
```

If a backup directory contains multiple backups of the same GPO, use the backup ID to select the exact version. Keep migration tables with the change record so security principal and UNC path mappings are reviewable.

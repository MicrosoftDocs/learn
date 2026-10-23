App Control for Business is both a trust boundary and a maintained operational control. A successful deployment restricts unnecessary code while preserving the complete workload and a viable recovery path.

Base policies intersect. Authorized supplements expand only their linked base. Explicit enforced denies take precedence. File identities, policy identities, signing permissions, and runtime behavior must all agree with the intended design.

Windows Server 2025 provides inbox CiTool and an opt-in OSConfig management path. Use the owner of each policy to change its state. Don't let drift correction and direct file manipulation compete.

PowerShell 7 is the orchestration host for these examples. Explicit 5.1 workers preserve the required Windows module dependencies; they don't remove policy restrictions. Verify local, worker, and remote execution contexts separately, including script block/sandbox decisions and PowerShell audit evidence.

Hyper-V validation must include mobility, drivers, agents, backup, and recovery. Domain controller validation must include authentication, DNS, replication, SYSVOL, and independent administrative access. Host and guest policies protect separate operating systems.

Before approving any release, confirm the following operational conditions:

- The trust model and every effective policy family are understood.
- Rule scope, identities, versions, and signer permissions have been reviewed.
- The approved PowerShell version, required worker modules, and remote endpoint are available and authorized.
- Audit evidence covers complete workload cycles and known negative tests.
- Canary enforcement has passed functional and restart checks.
- Signed-policy updates, signer rollover, and retirement are supported.
- Recovery access and artifacts remain available during an identity or host outage.
- Deployment ownership, monitoring, exceptions, and future servicing are assigned.

## More info

Use these authoritative references for detailed syntax, current platform caveats, and recovery procedures. The Windows Server 2025-specific guidance takes precedence over older-version assumptions in broader articles.

| Reference | Use it for |
| --- | --- |
| [Install PowerShell on Windows](/powershell/scripting/install/install-powershell-on-windows?view=powershell-7.6&preserve-view=true) | Separate PowerShell 7 installation and supported installation methods. |
| [PowerShell 7 module compatibility](/powershell/windows/module-compatibility?view=windowsserver2025-ps&preserve-view=true) | Native and compatibility-layer status for Windows Server modules. |
| [Windows PowerShell compatibility](/powershell/module/microsoft.powershell.core/about/about_windows_powershell_compatibility?view=powershell-7.6&preserve-view=true) | The 5.1 dependency, serialized objects, and compatibility limitations. |
| [New-PSSession](/powershell/module/microsoft.powershell.core/new-pssession?view=powershell-7.6&preserve-view=true) | Explicit local Windows PowerShell workers with `-UseWindowsPowerShell`. |
| [Enable-PSRemoting](/powershell/module/microsoft.powershell.core/enable-psremoting?view=powershell-7.6&preserve-view=true) | Endpoint registration, runtime selection, and configuration side effects. |
| [PowerShell App Control behavior](/powershell/scripting/security/app-control/how-app-control-works?view=powershell-7.6&preserve-view=true) | Version-dependent file authorization, blocking, sandboxing, and lockdown restrictions. |
| [PowerShell App Control audit diagnostics](/powershell/scripting/security/app-control/how-to-use-app-control?view=powershell-7.6&preserve-view=true) | PowerShell 7.4+ audit behavior and event 16387. |
| [Event channel configuration](/windows/win32/wes/eventmanifestschema-channeltype-complextype) | Analytic-log enablement clears existing events. |
| [Analytic-log query restrictions](/troubleshoot/windows-server/system-management-components/error-when-enabling-analytic-debug-event-log) | Circular analytic logs must be disabled before querying. |
| [App Control and AppLocker feature availability](/windows/security/application-security/application-control/app-control-for-business/feature-availability) | Supported capabilities and policy boundaries. |
| [App Control and memory integrity](/windows/security/application-security/application-control/introduction-to-virtualization-based-security-and-appcontrol) | Hardware requirements and the distinction between App Control and memory integrity. |
| [Configure App Control with OSConfig](/windows-server/security/osconfig/osconfig-how-to-configure-app-control-for-business) | Server 2025 scenarios, supplements, effective state, and drift correction. |
| [Install the OSConfig module](/windows-server/security/osconfig/osconfig-how-to-configure-security-baselines#install-the-osconfig-powershell-module) | Online and offline preparation. |
| [Microsoft.OSConfig 1.4.10 package](https://www.powershellgallery.com/packages/Microsoft.OSConfig/1.4.10) | Version-specific implementation, including ConfigCI conversion and the Windows PowerShell scheduled task. |
| [Policy options and file rules](/windows/security/application-security/application-control/app-control-for-business/design/select-types-of-rules-to-create) | Rule levels, options, version bounds, paths, and hashes. |
| [Use multiple App Control policies](/windows/security/application-security/application-control/app-control-for-business/design/deploy-multiple-appcontrol-policies) | Base/supplemental composition and policy identity. |
| [Example base policies](/windows/security/application-security/application-control/app-control-for-business/design/example-appcontrol-base-policies) | Template trust scope and starting points. |
| [ConfigCI cmdlets](/powershell/module/configci/?view=windowsserver2025-ps&preserve-view=true) | Windows Server 2025 authoring and conversion syntax. |
| [New-CIPolicyRule](/powershell/module/configci/new-cipolicyrule?view=windowsserver2025-ps&preserve-view=true) | Targeted rules, fallback levels, and supported parameters. |
| [CiTool reference](/windows/security/application-security/application-control/app-control-for-business/operations/citool-commands) | Policy inventory, activation, refresh, and removal. |
| [Deploy policies using scripts](/windows/security/application-security/application-control/app-control-for-business/deployment/deploy-appcontrol-policies-with-script) | Server-specific deployment and signed-policy placement. |
| [Group Policy deployment](/windows/security/application-security/application-control/app-control-for-business/deployment/deploy-appcontrol-policies-using-group-policy) | The legacy single-policy setting and its limits. |
| [Generate rules from audit events](/windows/security/application-security/application-control/app-control-for-business/deployment/audit-appcontrol-policies) | Candidate generation and missing-file limitations. |
| [Understanding App Control events](/windows/security/application-security/application-control/app-control-for-business/operations/event-id-explanations) | Event IDs, signatures, correlation, and Server Core limitations. |
| [Script enforcement](/windows/security/application-security/application-control/app-control-for-business/design/script-enforcement) | PowerShell, other script hosts, and COM behavior. |
| [App Control and .NET](/windows/security/application-security/application-control/app-control-for-business/design/appcontrol-and-dotnet) | Dynamic Code Security and native-image behavior. |
| [Obtain an internal code-signing certificate](/windows/security/application-security/application-control/app-control-for-business/deployment/create-code-signing-cert-for-appcontrol) | AD CS code-signing templates, enrollment, and the signing user's certificate store. |
| [Certification authority hierarchies](/windows/win32/seccrypto/hierarchies) | Trusted roots, issuing CAs, and end-entity certificate chains. |
| [Signed policy protection](/windows/security/application-security/application-control/app-control-for-business/deployment/use-signed-policies-to-protect-appcontrol-against-tampering) | Signing requirements, authorized signers, and restart testing. |
| [Remove policies and recover from boot failures](/windows/security/application-security/application-control/app-control-for-business/deployment/disable-appcontrol-policies) | Signed-base retirement and emergency recovery. |
| [Known issues and administrative guidance](/windows/security/application-security/application-control/app-control-for-business/operations/known-issues) | Performance, compatibility, signatures, and troubleshooting. |
| [Recommended application block rules](/windows/security/application-security/application-control/app-control-for-business/design/applications-that-can-bypass-appcontrol) | Risk from otherwise trusted applications. |
| [Recommended driver block rules](/windows/security/application-security/application-control/app-control-for-business/design/microsoft-recommended-driver-block-rules) | Vulnerable drivers and safe blocklist deployment. |
| [Managed installer](/windows/security/application-security/application-control/app-control-for-business/design/configure-authorized-apps-deployed-with-a-managed-installer) | Origin claims, prerequisites, and limitations. |
| [Signed catalogs](/windows/security/application-security/application-control/app-control-for-business/deployment/deploy-catalog-files-to-support-appcontrol) | Legacy application capture, signing, and distribution. |
| [Policy lifecycle management](/windows/security/application-security/application-control/app-control-for-business/design/plan-appcontrol-management) | Staged releases, stable identities, and support ownership. |
| [Hyper-V security](/windows-server/virtualization/hyper-v/plan/plan-hyper-v-security-in-windows-server) | Host/guest boundaries and virtualization administration. |
| [Domain-controller security](/windows-server/identity/ad-ds/plan/security-best-practices/securing-domain-controllers-against-attack) | Identity-critical administration and virtual domain controller considerations. |

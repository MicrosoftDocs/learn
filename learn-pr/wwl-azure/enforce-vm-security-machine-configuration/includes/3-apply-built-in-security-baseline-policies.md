Built-in security baseline policies provide audit coverage of industry-standard OS hardening controls. These Microsoft-curated baselines map to the Microsoft Cloud Security Benchmark (MCSB) control PV-4: Audit and enforce secure configurations for compute resources.

Use the following workflow to establish baseline visibility before remediating selected settings.

| Deployment step | Action |
|-----------------|--------|
| 1. Deploy prerequisites | Assign the prerequisite initiative for Azure VMs and verify Arc agent readiness |
| 2. Create remediation tasks | Remediate applicable prerequisite definitions for existing Azure VMs |
| 3. Assign Windows baseline | Apply built-in security baseline policy in audit mode |
| 4. Assign Linux baseline | Apply built-in security baseline policy in audit mode |
| 5. Review compliance | Review guest-assignment provisioning, evaluation time, and compliance details |
| 6. Remediate selected settings | Pilot and deploy a custom change-capable configuration after reviewing the audit findings |

## Check deployment readiness

Before assigning configurations, confirm these requirements:

- **Registration and permissions**: Register `Microsoft.GuestConfiguration` in the relevant subscriptions. Portal assignment can register it automatically, but scripted rollout must account for registration explicitly. Verify policy-authoring and assignment permissions separately from authority to grant roles to deployment identities.
- **Supported machines**: Check the current Azure VM and separate Azure Arc support matrices for the OS version and architecture. Azure VM support excludes ARM64 and uniform VM scale sets; flexible scale sets are supported. Starting in November 2026, new agents introduce PowerShell compatibility changes that require upgrades for some older Linux distributions. Check the current matrix before selecting or upgrading a Linux host.
- **Agent versions**: Keep agents current. Applying configurations requires at least Azure VM extension version 1.26.24 or Connected Machine agent version 1.10.0. These historical feature minimums aren't recommendations to install old agents.
- **Connectivity**: Allow the documented outbound HTTPS connections over TCP 443 to both the Machine Configuration service and configuration-package storage. For Azure NSG-based public connectivity, the documented service tags include both `AzureArcInfrastructure` and `Storage`. Arc servers also need the Connected Machine agent's full endpoint set. A working service connection doesn't prove that a private custom-package URL is reachable.
- **Entitlement and cost**: Defender for Servers Plan 2 provides its documented OS configuration assessment capability. Don't assume that this entitlement includes every Machine Configuration custom-policy or remediation capability. Review applicable Machine Configuration pricing for hybrid targets before expanding coverage.

> [!IMPORTANT]
> Machine Configuration agent support doesn't automatically establish support for a particular security baseline. Check the target OS and version against both the platform support matrix and the selected baseline's catalog. Check customization and per-setting remediation availability separately.
>
> The Windows compute security baseline used here targets supported server editions, not Windows 10 or Windows 11 client workstations. This limitation belongs to the selected baseline, not to every possible Machine Configuration assessment. A workgroup-member Windows Server is still a server, not a client-workstation exception.
>
> Azure VMs and Arc-enabled servers have different private-connectivity setup. The Azure VM `EnablePrivateNetworkGC=TRUE` mechanism isn't an instruction for Arc servers. For Arc, use the supported Azure Arc private-link configuration. Design custom-package storage access, name resolution, and authorization for the actual network path; permission to download a package doesn't establish network connectivity.

## Deploy prerequisite infrastructure

Before any baseline policy can evaluate compliance on an Azure VM, two components must exist: the Azure Machine Configuration VM extension and a system-assigned managed identity. The built-in initiative "Deploy prerequisites to enable Guest Configuration policies on virtual machines" automates this deployment for eligible Azure VMs.

After a pilot, assign this initiative at the management group scope that covers Contoso's factory subscriptions. Its identity policies use `Modify`, and its extension policies use `DeployIfNotExists`. They prepare eligible new or updated Azure VMs when the policies apply. For existing VMs, create remediation tasks for the applicable constituent definitions as described later in this unit.

The policy assignment requires its own managed identity to perform authorized Azure resource deployments or modifications during remediation. During assignment, select **System assigned managed identity** in the remediation settings and specify the appropriate region. The portal can grant the roles listed in each definition's `roleDefinitionIds` only when the operator has authority to create those role assignments. For scripted deployments, explicitly grant and verify those roles at the required scopes. Permission to assign a policy doesn't itself grant permission to assign roles.

The machine's system-assigned identity authenticates its communication with the Machine Configuration service; it isn't the policy assignment's remediation identity. Guest configuration resources execute locally as LocalSystem on Windows or root on Linux. Granting Azure roles to the policy assignment doesn't change that local execution context.

For Arc-enabled servers, the Azure Connected Machine agent already includes the Machine Configuration component and the machine's system-assigned identity. Don't deploy the Azure VM extension separately to Arc servers. Instead, confirm onboarding, agent health, supported versions, and connectivity.

> [!IMPORTANT]
> Audit mode avoids intended changes to the audited settings, but prerequisite deployment and custom resource execution still require a controlled rollout. Adding a system-assigned identity can change which identity an existing application receives from IMDS when it doesn't request a specific user-assigned identity. Confirm application behavior before deploying prerequisites broadly.

## Assign the Windows security baseline

The built-in policy "Windows machines should meet requirements of the Azure compute security baseline" (`72650e9f-97bc-4b2a-ab5f-9781a9fcecbc`) evaluates Windows security settings. This baseline covers account policies (password length, complexity, history), and audit policies (sign-in events, privilege use, system events). It also covers security options (network access controls, user account control behavior), user rights assignments (who can sign in locally, shut down the system, take ownership of files), and Windows Defender configuration.

Assign this policy at the same management group scope where you deployed prerequisites. It uses `AuditIfNotExists` by default—it reports noncompliance without applying the audited settings. This audit-first approach gives Contoso's team visibility into current configuration state before deciding which changes to approve.

For hybrid coverage, set **Include Arc connected servers** (`IncludeArcMachines`) to `true` on both OS baseline assignments after reviewing the charging terms. The parameter defaults to `false`; assigning a policy at a scope containing Arc servers doesn't by itself include them.

After assignment, monitor provisioning and the latest guest-assignment report rather than assuming a fixed waiting period. The agent normally checks for new or changed assignments every five minutes and evaluates a received configuration every 15 minutes. Configurations execute sequentially, and long-running configurations or a custom package frequency can change the observed interval.

Azure Policy separately runs its standard compliance reevaluation approximately every 24 hours and responds to other evaluation triggers. Reporting isn't instantaneous, and there's no universal initial-completion deadline. An on-demand Azure Policy scan retrieves the current Machine Configuration service state; it doesn't force the guest agent to rerun its configuration immediately.

## Assign the Linux security baseline

The companion policy "Linux machines should meet requirements for the Azure compute security baseline" (`fc9b3da7-8347-4380-8e70-0a0361d8dedd`) provides corresponding coverage for supported Linux systems. This baseline evaluates:

- SSH daemon configuration (PermitRootLogin disabled, protocol version, strong ciphers)
- Filesystem permissions and ownership on sensitive directories
- Kernel parameters affecting network security (IP forwarding, SYN cookies, ICMP redirect handling)
- Systemd service states (unnecessary services disabled)
- Package security configurations

Use the same assignment scope and policy settings as the Windows baseline. The policy's applicability rules target Linux machines rather than Windows machines. Contoso's Arc-enrolled Ubuntu servers controlling factory automation equipment are covered when their versions are supported, their agents are healthy, and Arc inclusion is enabled.

Both baselines work together to provide platform-appropriate security controls across the entire server estate. A single compliance dashboard in Azure Policy shows aggregate compliance across both operating system families.

> [!IMPORTANT]
> Before writing a custom resource, check whether the selected baseline supports an approved `BaselineSettings` customization for the audit requirement. In an exported baseline JSON payload, `settings: []` evaluates all rules for the included baseline. A nonempty `settings` array evaluates only the listed rules and values, excluding the remaining rules. Omitting a baseline block excludes that OS or distribution. Don't treat this payload as an additive patch that preserves every other default check.
>
> Compare the selected rules and baseline blocks with the approved coverage before assignment. Keep the payload in source control and get approval for exclusions. The customizable-baseline portal experience is in public preview and isn't available in Azure Government or sovereign clouds. Supported customization varies by baseline and OS. With these audit-only definitions, customizations change auditing, not the underlying OS settings.

## Interpret compliance results

After the initial evaluation cycle completes, navigate to **Azure Policy > Compliance** and filter for your baseline policy assignments. Each policy assignment displays compliance results and noncompliant resources. Check the reporting scope and denominator before comparing percentages across assignments.

Drill into a noncompliant resource to see which specific settings failed evaluation. The compliance detail view shows the expected value (from the baseline definition) and the current value (detected on the VM). For example, a Windows Server might show "Audit: Force audit policy subcategory settings" expected as "Enabled" but currently set to "Disabled."

This detail is valuable when selecting settings for approved custom remediation. Some noncompliance findings represent genuine security gaps—default configurations that should be hardened. Other findings might indicate intentional configuration choices required for application compatibility. A service marked as "should be disabled" might be a legitimate requirement for manufacturing software to function.

Common noncompliance patterns in factory environments include:

- Windows Server baseline settings that don't match the approved values, such as "Scan all downloaded files and attachments" being Disabled when the selected baseline expects Enabled
- Password policies that were never hardened post-deployment (minimum length set to 7 instead of 14)
- Audit policy gaps where critical event categories aren't logged
- User rights assignments that grant excessive privileges to default user groups.

### Diagnose missing reports and failed evaluations

Use this sequence to distinguish a setting mismatch from a deployment or evaluation failure:

1. Confirm that the machine is in scope and matches the definition's OS and workload filters, including the Arc inclusion parameter.
1. Confirm resource-provider registration, Azure VM prerequisites or Arc agent health, and guest-assignment provisioning.
1. Check package reachability, download authorization, and content-hash consistency. For deployment policies, inspect the assignment identity's permissions and initial remediation deployment.
1. Open the latest guest-assignment report and read per-resource reasons and the evaluation timestamp. A missing or stale report, or an execution error, isn't the same diagnosis as an evaluated setting mismatch.
1. Inspect the local Machine Configuration agent log using the platform-specific location below.
1. Reproduce package behavior on an equivalent disposable test machine. Correct the root cause and, if custom package content changes, publish a new version with matching policy metadata and content hash.

The agent logs are stored in the following locations.

| Platform | Log path |
|---|---|
| Windows Azure VM | `C:\ProgramData\GuestConfig\gc_agent_logs\gc_agent.log` |
| Windows Arc-enabled server | `C:\ProgramData\GuestConfig\arc_policy_logs\gc_agent.log` |
| Linux Azure VM | `/var/lib/GuestConfig/gc_agent_logs/gc_agent.log` |
| Linux Arc-enabled server | `/var/lib/GuestConfig/arc_policy_logs/gc_agent.log` |

> [!NOTE]
> For custom configurations, `ApplyAndAutoCorrect` can return a compliant result after correcting drift at the next guest evaluation. Don't treat the compliance dashboard as a complete history of every corrected change. Use additional operational telemetry when that history is a requirement.

## Remediate prerequisites and selected OS settings

For existing Azure VMs, navigate to **Azure Policy > Remediation > Create remediation task** and select the prerequisite initiative assignment. Create a task for each applicable constituent definition, limiting the remediation scope or resource selection to the approved pilot before expanding it. Remediate the applicable identity definitions first and verify the identities, then remediate the extension definitions. Verify the assignment identity's required roles at the target scopes and monitor each task's deployments and failures. The tasks run asynchronously; they don't install anything on Arc-enabled servers.

> [!IMPORTANT]
> The two built-in baseline policies support only `AuditIfNotExists` and `Disabled`, not `DeployIfNotExists`. They don't modify the audited settings and can't be reassigned with a deployment effect to enforce those settings. Azure Policy's assignment enforcement setting is separate from the guest assignment type.

To automatically remediate specific noncompliant settings, review the compliance findings and author a custom `AuditAndSet` package targeting approved settings. Use a policy that deploys its guest assignment with `ApplyAndMonitor` to apply approved changes on remediation or applicable resource creation/update events and then monitor later guest drift, or use `ApplyAndAutoCorrect` to correct subsequent drift at the guest evaluation interval. Changing an assignment setting can't add remediation capability to an audit-only package. The next unit covers packaging, testing, policy generation, and initial remediation for eligible existing machines.

Before authoring custom remediation packages, export the compliance report, identify noncompliant settings, and work with application owners to validate that remediation won't disrupt operations. Baseline parameter customization can address an approved audit requirement; custom resources remain appropriate for unsupported settings, Contoso-specific requirements, and approved remediation.

### Consider baseline remediation in public preview

Azure Machine Configuration also offers security baseline remediation in public preview in Azure public-cloud regions. This is an additional option for selected settings, not a requirement for this module's audit-first exercise. The customizable-baseline preview isn't available in Azure Government or sovereign clouds.

> [!IMPORTANT]
> The audit-only policy definitions used earlier aren't made change-capable by selecting another assignment setting. Before using the preview, inspect the baseline catalog and the actual policy definition/version offered in your environment. Continue only when it supports `DeployIfNotExists`, `RemediationLocations`, and remediation for the selected settings. If those capabilities aren't available, retain the audit workflow and use a tested custom package for approved changes.

The preview includes selected settings in Azure Security Baselines for Windows and Linux, CIS Benchmarks for Linux, and DISA STIG baselines for Linux. Availability varies by OS, baseline version, and individual setting. Agent support alone doesn't establish that a setting can be remediated.

After completing the machine prerequisites, use the following controlled workflow:

1. In Azure Policy's Machine Configuration baseline catalog, select an applicable baseline and open **Modify Settings**. Select the target operating systems and baseline versions.
1. Review the included rules, desired values, and exclusions. Mark only approved, supported settings as **Remediate**. Keep other included settings in **Audit** mode. Excluding a setting removes its assessment coverage, rather than leaving it audited.
1. Create a tightly scoped pilot assignment using the remediation-capable definition. Set **Effect** to `DeployIfNotExists` and select the target machine resource locations in **Remediation Locations** (`RemediationLocations`). An empty location list, or a machine outside those locations, leaves that machine audit-only. All three controls, including each setting's mode, must permit remediation.
1. Configure the policy assignment's managed identity and verify the roles required by the definition. The region chosen for that identity doesn't select the machines to remediate.
1. For existing machines, create a scoped Azure Policy remediation task and monitor its deployments. The effect, setting modes, and locations alone aren't enough to enable remediation on existing machines.
1. Review the resulting guest-assignment type, per-setting results, and application behavior before expanding the pilot. Successful Azure resource deployment doesn't by itself prove OS compliance. During preview, an updated assignment can temporarily have an empty `assignmentReport`; the documented reporting delay after the change can be up to 60 minutes.

> [!WARNING]
> During preview, changing `RemediationLocations` doesn't automatically recalculate existing remediation assignment types. Run another remediation task after adding or removing locations, then verify the resulting assignments. Removing a location isn't an immediate stop switch. Stopping remediation doesn't restore previous settings, so retain an approved restoration procedure.

Use the custom-package workflow for organization-specific requirements, settings without suitable baseline remediation support, or environments where this preview isn't available or approved. Don't run overlapping enforcement configurations that prescribe conflicting values.

### Plan exceptions and restoration

Start with a small, explicitly targeted pilot and get application-owner approval before widening a custom enforcement assignment. Check that Group Policy, other management tools, and other custom packages don't prescribe conflicting values. Record the original settings and the approved restoration procedure.

Document legitimate exceptions and implement them in policy scope or through an authorized policy exemption as appropriate. An exemption doesn't by itself remove an existing guest assignment; inspect existing assignments after scope changes too. When the agent must stop evaluating a configuration, delete the affected guest assignment and verify that another applicable assignment won't recreate coverage. When retiring a configuration, verify cleanup: deleting a standalone policy assignment normally removes its policy-created guest assignment, but initiative-related changes and manually created guest assignments can require manual cleanup. Don't assume that deleting a policy always cleans up every assignment.

> [!WARNING]
> For custom content, the machine tag `CustomGuestConfigurationSetPolicy=disable` disables remediation. It doesn't apply to Microsoft's built-in content, doesn't stop all auditing, and doesn't undo settings already changed. Treat it as a temporary controlled measure, not rollback. Confirm the guest agent has received the change before relying on it, then use the approved restoration procedure and reassess the machine if settings must be reverted. Deleting an assignment also doesn't restore earlier OS settings.

## Contoso's baseline deployment workflow

After a pilot, Contoso assigns the prerequisite initiative at their "Factory Infrastructure" management group, which contains three subscriptions hosting production factory systems. They create scoped remediation tasks for the applicable prerequisite definitions to prepare 47 existing Azure VMs. They separately verify the Connected Machine agents on 23 Arc-enabled servers, which already include the Machine Configuration component.

After verifying readiness, they assign both Windows and Linux baseline policies in audit mode with Arc inclusion enabled. After all 70 eligible machines have reported, 32 machines have at least one failing setting and 38 meet their applicable baseline requirements. On this explicitly unique-machine basis, approximately 54.3% are compliant. This example isn't a claim that every portal percentage uses the same denominator.

Most findings are password policy gaps and unnecessary services. The team reviews each finding, implements an approved exception for one service required by PLC software, and schedules a maintenance window to pilot custom remediation for the rest. They verify application behavior, resolve configuration conflicts, and retain an approved restoration procedure before broadening enforcement.

With your built-in baselines deployed and compliance visibility established, you're ready to extend coverage with custom configurations for Contoso-specific requirements.

In this module, you explored how Azure Machine Configuration assesses operating system settings across Contoso Manufacturing's server estate. You learned to prepare Azure VMs and Arc-enabled servers, assign built-in Windows and Linux audit baseline policies, and author, test, and deploy custom configurations for selected organization-specific requirements.

## Key decisions and deployment principles

Use built-in baseline findings to guide remediation, not as a promise of automatic hardening. The two audit-policy definitions used in this exercise support `AuditIfNotExists` and `Disabled`. The custom workflow uses a tested `AuditAndSet` package and an appropriate guest assignment type. Separately, the baseline-remediation public preview can maintain selected supported settings when the actual definition/version and all required controls permit it. Existing machines need an initial remediation task. Azure Policy's assignment enforcement setting doesn't turn an audit-only definition or package into a change-capable one.

Azure VMs need the Machine Configuration VM extension and a system-assigned managed identity. Use the prerequisite initiative and remediation tasks for existing VMs. Arc-enabled servers already receive the component and identity through the Connected Machine agent; verify agent health, support, and connectivity rather than installing another extension. A deployment policy's assignment identity is separate from the machine identity, and guest resources run locally as LocalSystem or root.

Begin with a small, explicitly targeted pilot and get application-owner approval before widening custom remediation. Check for conflicting values from Group Policy, other management tools, or other packages. Auditing avoids intended setting changes but isn't risk-free. Record original settings and an approved restoration procedure before allowing changes.

Implement approved exceptions through policy scope or authorized exemptions. An exemption doesn't by itself remove an existing guest assignment. When evaluation must stop, delete the affected guest assignment and verify that another applicable assignment won't recreate coverage. Inspect cleanup when retiring configurations; normal policy-assignment deletion and manual or initiative-related guest-assignment lifecycles differ. Deleting assignments or disabling correction doesn't restore previous registry values or service states.

> [!WARNING]
> For custom content, the machine tag `CustomGuestConfigurationSetPolicy=disable` disables remediation. It doesn't apply to Microsoft's built-in content, stop all auditing, or undo previous changes. Confirm the guest agent has received the change before relying on it. Treat it as a temporary control, not rollback; restore settings through the approved procedure and reassess them.

`ApplyAndAutoCorrect` corrects later drift at a guest evaluation after initial deployment. A compliant report can reflect successful correction, so it isn't a complete change history. Use additional operational telemetry when that history is required.

## Learning path completion

This learning path brings together disk-data protection, trusted launch, just-in-time access, Defender for Servers, and OS configuration management. For new Azure VMs, use encryption at host with managed-disk storage-side encryption to cover disk data, host caches, and temporary disks. These Azure encryption settings don't configure encryption on on-premises Arc servers.

> [!NOTE]
> Azure Disk Encryption is scheduled for retirement on September 15, 2028. Plan migration of existing workloads and backups using the documented replacement approach. Migration can require new disks and VMs, and Linux encrypted OS disks have additional restrictions. It isn't an in-place toggle on a VM that previously used Azure Disk Encryption.

You can now assess applicable industry baselines and Contoso-specific requirements through Azure Policy and safely pilot selected custom remediations. These controls complement vulnerability assessment and runtime protection; configuration compliance alone isn't a complete measure of workload security.

## More info

### Plan and assess

Use these resources to plan prerequisites, connectivity, and baseline assessments:

- [Azure Machine Configuration overview and supported machines](/azure/governance/machine-configuration/overview/01-overview-concepts)
- [Prepare Machine Configuration prerequisites](/azure/governance/machine-configuration/overview/02-setup-prerequisites)
- [Plan network connectivity](/azure/governance/machine-configuration/overview/03-network-requirements)
- [Built-in machine configuration policies](/azure/governance/policy/samples/built-in-policies#guest-configuration)
- [Windows baseline policy definition and parameters](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Guest%20Configuration/AzureWindowsBaseline_AINE.json)
- [Linux baseline policy definition and parameters](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Guest%20Configuration/AzureLinuxBaseline_AINE.json)
- [Windows compute-baseline applicability and setting reference](/azure/governance/policy/samples/guest-configuration-baseline-windows)
- [Customize security baseline audits (preview)](/azure/governance/machine-configuration/how-to/assign-security-baselines/overview-page)
- [Understand baseline JSON rule selection and exclusions](/azure/governance/machine-configuration/how-to/assign-security-baselines/understand-baseline-settings-parameter)
- [Remediate selected security baseline settings in public preview](/azure/governance/machine-configuration/how-to/assign-security-baselines/remediate-security-baselines)

### Author and publish

Use these resources to author, test, and publish custom configurations:

- [Set up the authoring environment](/azure/governance/machine-configuration/how-to/develop-custom-package/1-set-up-authoring-environment)
- [Install Azure PowerShell](/powershell/azure/install-azps-windows?view=azps-16.5.0&preserve-view=true)
- [Sign in to Azure PowerShell](/powershell/module/az.accounts/connect-azaccount?view=azps-16.5.0&preserve-view=true)
- [Understand the DSC 2.0 authoring model](/powershell/dsc/overview?view=dsc-2.0&preserve-view=true)
- [Write class-based DSC resources](/powershell/dsc/resources/authoringresourceclass?view=dsc-1.1&preserve-view=true)
- [Create a custom configuration package](/azure/governance/machine-configuration/how-to/develop-custom-package/2-create-package)
- [Test a configuration package](/azure/governance/machine-configuration/how-to/develop-custom-package/3-test-package)
- [Publish a configuration package](/azure/governance/machine-configuration/how-to/develop-custom-package/4-publish-package)
- [Create a custom policy definition](/azure/governance/machine-configuration/how-to/create-policy-definition)
- [GuestConfiguration policy generator and parameter types](https://github.com/Azure/GuestConfiguration/blob/9661f72ee13eb31ff4b50801da5305bf6bc2b92f/source/Public/New-GuestConfigurationPolicy.ps1)
- [Publish policy definitions with Azure PowerShell](/powershell/module/az.resources/new-azpolicydefinition?view=azps-16.5.0&preserve-view=true)
- [Sign configuration packages and configure trust](/azure/governance/machine-configuration/how-to/develop-custom-package/6-sign-package)

### Operate and troubleshoot

Use these resources to manage remediation, monitor assignments, and troubleshoot configurations:

- [Configure remediation behavior](/azure/governance/machine-configuration/concepts/remediation-options)
- [Remediate existing resources with Azure Policy](/azure/governance/policy/how-to/remediate-resources)
- [Understand guest assignment lifecycles](/azure/governance/machine-configuration/concepts/assignments)
- [Troubleshoot Machine Configuration](/azure/governance/machine-configuration/overview/04-operations-troubleshooting)
- [Route policy state-change notifications](/azure/governance/policy/concepts/event-overview)
- [Machine Configuration extension resource limits](/azure/governance/machine-configuration/overview/02-setup-prerequisites#limits-set-on-the-extension)
- [Arc agent custom resource limits](/azure/azure-arc/servers/agent-overview#custom-resource-limits)

### Related security capabilities

Explore these resources for complementary security capabilities and disk encryption guidance:

- [OS configuration assessment in Defender for Servers](/azure/defender-for-cloud/operating-system-misconfiguration)
- [Individual Defender for Cloud recommendations](/azure/defender-for-cloud/transition-grouped-individual-recommendations)
- [Software vulnerability assessment in Defender for Servers](/azure/defender-for-cloud/auto-deploy-vulnerability-assessment)
- [Azure VM disk encryption options](/azure/virtual-machines/disk-encryption-overview)
- [Migrate from Azure Disk Encryption](/azure/virtual-machines/disk-encryption-migrate)

In this module, you connected Azure Local security controls to their enforcement boundaries, owners, and evidence. You learned to distinguish local baseline enforcement from cloud policy assessment, and host protection from guest and application authorization.

You separated network access from transport encryption and cloud privileged-access safeguards from local administration. You mapped requirements to controls and evidence, distinguished policy exemptions from remediation, and planned vulnerability treatment through supported platform and workload update paths.

You inspected protection without retrieving secrets, traced a recurring finding to unsupported configuration drift, and designed an application-control exception that retains enforcement. You compared VM security types by threat model and supported operations rather than by label.

You also established why VM files, protection keys, wrapping keys, identities, and application data must be recoverable together. Independent custody and a successful, measured restore provide stronger evidence than a completed backup job.

You extended the evidence pipeline beyond host events to cloud management, identity, vault, and application activity. You planned containment around both the threat and the cluster's operating requirements, then defined evidence for trusted recovery. Finally, you separated resource retirement from the continuing custody of retained records, backups, and keys.

For Contoso as a healthcare-facility owner, a defensible approval means supported changes, narrow administrative and network access, time-bounded exceptions, accountable vulnerability remediation, appropriate protection of patient information, and a demonstrated clinical-service recovery path. Monitoring, incident decisions, and retirement records must remain attributable to their owners. Its legal, privacy, and compliance teams must also connect the applicable government regulations to controls, owners, and retained evidence. Infrastructure compliance supports that work, but doesn't certify the application or facility as legally compliant.

## More info

The following Microsoft Learn references provide additional product detail and release-specific support information. The module includes the concepts and decision criteria needed for its examples and knowledge check.

- [Azure Local security features](/azure/azure-local/concepts/security-features?view=azloc-2610&preserve-view=true)
- [Manage security defaults and 2610 customization](/azure/azure-local/manage/manage-secure-baseline?view=azloc-2610&preserve-view=true)
- [Manage App Control policies](/azure/azure-local/manage/manage-wdac?view=azloc-2610&preserve-view=true)
- [Local Identity with Azure Key Vault](/azure/azure-local/deploy/deployment-local-identity-with-key-vault?view=azloc-2610&preserve-view=true)
- [Trusted Launch protection and recovery](/azure/azure-local/manage/trusted-launch-vm-overview?view=azloc-2610&preserve-view=true)
- [Manual backup and recovery of guest-state-protection keys](/azure/azure-local/manage/trusted-launch-vm-import-key?view=azloc-2610&preserve-view=true)
- [Confidential VM architecture and restrictions](/azure/azure-local/manage/confidential-vm-overview?view=azloc-2610&preserve-view=true)
- [Supported Azure Local VM operations](/azure/azure-local/manage/virtual-machine-operations?view=azloc-2610&preserve-view=true)
- [Manage secrets rotation](/azure/azure-local/manage/manage-secrets-rotation?view=azloc-2610&preserve-view=true)
- [Manage syslog forwarding](/azure/azure-local/manage/manage-syslog-forwarding?view=azloc-2610&preserve-view=true)
- [Defender for Cloud integration, preview](/azure/azure-local/manage/manage-security-with-defender-for-cloud?view=azloc-2610&preserve-view=true)
- [Azure Local 2610 release information and feature status](/azure/azure-local/whats-new?view=azloc-2610&preserve-view=true)
- [Azure Local firewall requirements and connectivity limitations](/azure/azure-local/concepts/firewall-requirements?view=azloc-2610&preserve-view=true)
- [Azure Arc-enabled server security and administrative boundaries](/azure/azure-arc/servers/security-overview)
- [Microsoft Entra Conditional Access](/entra/identity/conditional-access/overview)
- [Microsoft Entra Privileged Identity Management](/entra/id-governance/privileged-identity-management/pim-configure)
- [Azure Local solution updates and supported update interfaces](/azure/azure-local/update/about-updates-23h2?view=azloc-2610&preserve-view=true)
- [Azure Policy exemption categories, scope, and expiry](/azure/governance/policy/concepts/exemption-structure)
- [Azure Activity Log coverage and retention](/azure/azure-monitor/fundamentals/activity-log)
- [Microsoft Entra diagnostic settings](/entra/identity/monitoring-health/howto-configure-diagnostic-settings)
- [Azure Key Vault audit logging](/azure/key-vault/general/logging)
- [Get-AzPolicyState command and query scope](/powershell/module/az.policyinsights/get-azpolicystate?view=azps-16.5.0&preserve-view=true)
- [Policy Insights policy-state identifiers](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/policyinsights/resource-manager/Microsoft.PolicyInsights/PolicyInsights/stable/2019-10-01/policyStates.json)
- [Trusted Launch key backup sample, reviewed revision d65e8f3](https://github.com/Azure-Samples/AzureLocal/blob/d65e8f3a576445758b045690df256e41a0dd31b8/trusted-launch-vms/TvmBackupUtils.psm1)

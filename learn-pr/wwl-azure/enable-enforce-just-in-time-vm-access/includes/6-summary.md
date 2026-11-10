In the Contoso Manufacturing scenario, you learned how to address broad direct management-port exposure by reviewing existing rules, configuring just-in-time (JIT) access, and validating the effective access paths. Bastion remains the approved private path for normal administration, while JIT provides narrow network-access windows for direct maintenance exceptions. The retained Bastion path is still standing network access, not a claim of zero standing access on every path.

In this module, you learned to:

- **Examine JIT requirements**: Use Defender for Servers Plan 2, Azure Resource Manager VMs, a supported NSG or firewall configuration, and the permissions required for the operation. Check each VM's effective plan coverage, including resource-level overrides, rather than relying only on the subscription setting. Neither **Not configured** nor **Configured** alone proves the VM's exposure.
- **Enable and configure policies**: Review the ports, protocol, sources, and maximum duration, then save. Defender for Cloud recommends common management ports for review. The individual VM shortcut initially protects RDP on Windows or SSH on Linux with a three-hour maximum and Any source.
- **Request access and audit activity**: Request the required ports, connection source, and time window. Audit control-plane operations in Activity Log and correlate them with available JIT request details. Use guest records when evidence of actual VM use is required.
- **Monitor and operationalize adoption**: Use Azure Policy for assessment-based monitoring and configure required JIT policies through an approved provisioning workflow. The audit built-in doesn't deploy JIT or block VM creation.

## Key decisions

Use these decisions to guide JIT configuration and ongoing operations:

- **Resolve existing allow rules**: Existing rules can take precedence over JIT restrictions. Verify effective rules and new connections before declaring an exposure resolved.
- **Separate administrative responsibilities**: JIT request permissions don't authorize network-rule changes, effective-rule inspection, Activity Log access or export, or policy assignment. Coordinate these operations with appropriately authorized administrators.
- **Separate network grants from sessions**: Expiration restores network rules but doesn't disconnect established sessions. JIT doesn't grant guest credentials or provide a separate human approval queue.
- **Use the actual connection source**: Source restrictions narrow which addresses can use a grant. Shorter durations reduce its availability for new connections. For the dedicated Bastion deployment in this scenario, Bastion-to-VM traffic originates from AzureBastionSubnet, not the browser user's public IP.
- **Preserve configuration safely**: Retain unaffected entries when updating shared policies. The typed PowerShell example is for NSG-only policies. Use a workflow that represents the Firewall association when that integration is present. Establish any required replacement restriction before removing JIT protection, then inspect the resulting rules.
- **Plan audit retention**: Activity Log retains events for 90 days by default. Export required events before a quarterly review period begins and retain request details and guest evidence where required.
- **Distinguish compliance from universal coverage**: The audit definition accepts healthy or not-applicable assessments. Combine its results with a JIT configuration inventory, controlled provisioning, and drift review. Include resource-level plan overrides and approved coverage exceptions.

## More info

Use the following Microsoft Learn resources for more information:

- [Just-in-time VM access overview](/azure/defender-for-cloud/just-in-time-access-overview)
- [Enable just-in-time access](/azure/defender-for-cloud/enable-just-in-time-access)
- [Defender for Servers plans and deployment scope](/azure/defender-for-cloud/plan-defender-for-servers-select-plan#decide-on-deployment-scope)
- [Configure individual machines and review Defender for Servers coverage](/azure/defender-for-cloud/tutorial-enable-servers-plan)
- [Defender for Servers support and cloud availability](/azure/defender-for-cloud/support-matrix-defender-for-servers)
- [Network security group rules and stateful connections](/azure/virtual-network/network-security-groups-overview#security-rules)
- [Security Reader permissions](/azure/role-based-access-control/built-in-roles/security#security-reader)
- [Azure Resource Manager overview](/azure/azure-resource-manager/management/overview)
- [Configure NSG rules for Azure Bastion](/azure/bastion/bastion-nsg#target-vm-subnet)
- [Azure Bastion SKU requirements](/azure/bastion/bastion-sku-comparison#feature-comparison)
- [Diagnose VM network traffic filtering](/azure/virtual-network/diagnose-network-traffic-filter-problem)
- [Network interface permissions](/azure/virtual-network/virtual-network-network-interface#permissions)
- [Manage network security groups and security rules](/azure/virtual-network/manage-network-security-group)
- [Configure JIT with PowerShell](/powershell/module/az.security/set-azjitnetworkaccesspolicy)
- [Request JIT access with PowerShell](/powershell/module/az.security/start-azjitnetworkaccesspolicy)
- [Read JIT policies and requests with PowerShell](/powershell/module/az.security/get-azjitnetworkaccesspolicy)
- [JIT PowerShell VM model](/dotnet/api/microsoft.azure.commands.security.models.jitnetworkaccesspolicies.pssecurityjitnetworkaccesspolicyvirtualmachine)
- [JIT PowerShell request-port model](/dotnet/api/microsoft.azure.commands.security.models.jitnetworkaccesspolicies.pssecurityjitnetworkaccesspolicyvirtualmachineport)
- [JIT deployment resource reference](/azure/templates/microsoft.security/locations/jitnetworkaccesspolicies)
- [Activity Log retention and export](/azure/azure-monitor/fundamentals/activity-log)
- [Activity Log event schema](/azure/azure-monitor/fundamentals/activity-log-schema)
- [Azure Monitor roles and permissions](/azure/azure-monitor/fundamentals/roles-permissions-security)
- [Diagnostic-setting destinations and requirements](/azure/azure-monitor/data-collection/diagnostic-settings#destinations)
- [Defender for Cloud built-in Azure Policy definitions](/azure/defender-for-cloud/policy-reference)
- [Azure Policy evaluation triggers](/azure/governance/policy/how-to/get-compliance-data#evaluation-triggers)
- [Azure Policy remediation tasks](/azure/governance/policy/how-to/remediate-resources)
- [Azure Policy RBAC permissions](/azure/governance/policy/overview#azure-rbac-permissions-in-azure-policy)

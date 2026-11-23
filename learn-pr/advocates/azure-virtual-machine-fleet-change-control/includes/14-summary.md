The most important entry in your change record is the one a fleet dashboard could hide: at 09:05 one command failed **and** one backend changed. The other 189 portal backends were still serving the old link. Keeping both facts explains why you stopped, why the correction didn't need another write, and why expansion required a separate approval.

The example change closes with all 200 VMs accounted for: 60 changed and were restored, 130 portal VMs were deferred, and 10 staff VMs were excluded. In a live rollout, support those totals with per-instance results, timestamped approvals, and direct application checks. Keep any missing result open rather than counting it as a success.

After closure, keep checking whether the fleet serves users, whether its Azure resources match the approved design, and whether security sensors are reporting. A healthy application doesn't establish that a sign-in was legitimate. Missing telemetry or a missing policy result is a gap to investigate.

For lifecycle changes, pick the test that matches the promise: drain a backend and measure the survivors, launch a replacement from the image, restore a known record in isolation, or read the certificate the listener actually serves. Those observations tell you when it's safe to retire the old capacity, copy, or credential.

## More info

These Microsoft Learn references provide additional detail on the tools and procedures used throughout the module.

- [Azure Load Balancer health probes and existing connections](/azure/load-balancer/load-balancer-custom-probe-overview)
- [Expand a managed disk and its Windows volume](/azure/virtual-machines/windows/expand-disks)
- [Azure platform maintenance and VM Scheduled Events](/azure/virtual-machines/maintenance-and-updates)
- [Use Boot diagnostics to investigate VM startup](/azure/virtual-machines/boot-diagnostics)
- [Restore a VM or disks with Azure Backup](/azure/backup/backup-azure-arm-restore-vms)
- [Run an isolated Azure Site Recovery drill](/azure/site-recovery/azure-to-azure-tutorial-dr-drill)
- [Reprotect failed-over VMs before failback](/azure/site-recovery/azure-to-azure-how-to-reprotect)
- [Build reusable OS images with Azure VM Image Builder](/azure/virtual-machines/image-builder-overview)
- [Choose a scale-set upgrade policy](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-upgrade-policy)
- [Deliver certificates with the Key Vault VM extension for Windows](/azure/virtual-machines/extensions/key-vault-windows)
- [Rotate secrets for services with two credentials](/azure/key-vault/secrets/tutorial-rotation-dual)
- [Analyze resource costs in Azure Cost Management](/azure/cost-management-billing/costs/quick-acm-cost-analysis)
- [Understand VM power states and billing](/azure/virtual-machines/states-billing)
- [Review disks and networking resources before VM deletion](/azure/virtual-machines/delete)
- [Publish and manage versioned VM Applications in Azure Compute Gallery](/azure/virtual-machines/vm-applications)
- [Assess available updates with Azure Update Manager](/azure/update-manager/view-updates)
- [Schedule guest patching with maintenance configurations](/azure/update-manager/scheduled-patching)
- [Select updates and reboot options for an installation](/azure/update-manager/deploy-updates)
- [Azure RBAC best practices](/azure/role-based-access-control/best-practices)
- [Check access to an Azure resource](/azure/role-based-access-control/check-access)
- [Configure PIM role settings for Azure resources](/entra/id-governance/privileged-identity-management/pim-resource-roles-configure-role-settings)
- [Microsoft Entra sign-in and login roles for Windows VMs](/entra/identity/devices/howto-vm-sign-in-azure-ad-windows)
- [Defender for Servers coverage and capabilities](/azure/defender-for-cloud/defender-for-servers-overview)
- [Investigate security alerts in Defender for Cloud](/azure/defender-for-cloud/manage-respond-alerts)
- [Device logon events in Microsoft Defender advanced hunting](/defender-xdr/advanced-hunting-devicelogonevents-table)
- [Monitor Azure virtual machines: host metrics, guest data, and alerts](/azure/azure-monitor/vm/monitor-vm)
- [Heartbeat table in Azure Monitor Logs](/azure/azure-monitor/reference/tables/heartbeat)
- [Create a metric alert rule in Azure Monitor](/azure/azure-monitor/alerts/alerts-create-metric-alert-rule)
- [Get Azure Policy compliance data](/azure/governance/policy/how-to/get-compliance-data)
- [Azure Policy compliance queries for Resource Graph](/azure/governance/policy/samples/resource-graph-samples)
- [Investigate resource changes with Azure Resource Graph](/azure/governance/resource-graph/changes/get-resource-changes)
- [Find Azure resources with Azure Resource Graph](/azure/governance/resource-graph/overview)
- [How Azure Automation runs a runbook](/azure/automation/automation-runbook-execution)
- [Automate Windows Server VM configuration](/training/modules/automate-configuration-of-windows-server-iaas-virtual-machines/)
- [Enforce security with Azure Machine Configuration](/training/modules/enforce-vm-security-machine-configuration/)
- [Bicep what-if and validation levels](/azure/azure-resource-manager/bicep/deploy-what-if)
- [Incremental and complete deployment semantics](/azure/azure-resource-manager/templates/deployment-modes)
- [Run Command options](/azure/virtual-machines/run-command-overview)
- [Managed Run Command behavior and instance view on Windows](/azure/virtual-machines/windows/run-command-managed)
- [Custom Script for Windows](/azure/virtual-machines/extensions/custom-script-windows)
- [Custom Script for Linux](/azure/virtual-machines/extensions/custom-script-linux)

Azure Local VM operations span Azure ownership, local infrastructure, guest management, and applications. Reliable operations keep those responsibilities distinct while correlating their evidence.

You learned to select management tools, assess capacity and placement, prepare compatible dependencies, and provision through the correct resource model. You also learned to interpret independent health states, route alerts, investigate common failures and management outages, and coordinate supported VM changes, guest servicing, and host maintenance.

Routine protection and tested recovery complete the operating model. Images and checkpoints aren't substitutes for supported backup, guest connectivity isn't application health, and a successful restore doesn't automatically preserve Azure lifecycle ownership. Protected state and GPU resources require additional support and recovery checks.

For any operational change, identify the exact VM and ownership model, consult the current support matrix, reserve the required capacity, prepare recovery, and validate the outcome at every relevant layer. If the supported recovery or maintenance path doesn't meet the workload's requirements, change the design before deployment rather than relying on an unsupported shortcut.

## More info

Use the following Microsoft documentation to check current requirements and operation-specific details.

- [Azure Local VM management architecture](/azure/azure-local/manage/azure-arc-vm-management-overview?view=azloc-2610)
- [VM management prerequisites](/azure/azure-local/manage/azure-arc-vm-management-prerequisites?view=azloc-2610)
- [Azure Local platform metrics and performance workbooks](/azure/azure-local/manage/monitor-cluster-with-metrics?view=azloc-2610)
- [Monitor an Azure Local instance with Insights](/azure/azure-local/manage/monitor-single-23h2?view=azloc-2610)
- [Azure Local cluster performance history](/azure/azure-local/manage/health-service-cluster-performance-history?view=azloc-2610)
- [Performance-history series and timeframes](/windows-server/storage/storage-spaces/performance-history)
- [Recommended alert rules for Azure Local](/azure/azure-local/manage/set-up-recommended-alert-rules?view=azloc-2610)
- [Azure Local solution updates and supported servicing interfaces](/azure/azure-local/update/about-updates-23h2?view=azloc-2610)
- [Schedule guest patching with Azure Update Manager](/azure/update-manager/scheduled-patching)
- [Azure Update Manager update sources and types](/azure/update-manager/support-matrix)
- [Manage Connected Machine agent versions](/azure/azure-arc/servers/manage-agent)
- [Automatic extension upgrades for Arc-enabled servers](/azure/azure-arc/servers/manage-automatic-vm-extension-upgrade)
- [Back up and recover Azure Local VMs with MABS](/azure/backup/back-up-azure-stack-hyperconverged-infrastructure-virtual-machines)
- [Create Azure Local VMs](/azure/azure-local/manage/create-arc-virtual-machines?view=azloc-2610)
- [Supported VM operations](/azure/azure-local/manage/virtual-machine-operations?view=azloc-2610)
- [Azure CLI managed-VM command reference](/cli/azure/stack-hci-vm?view=azure-cli-latest)
- [Azure PowerShell managed-VM module reference](/powershell/module/az.stackhcivm/?view=azps-16.5.0)
- [Compare VM management models and capabilities](/azure/azure-local/concepts/compare-vm-management-capabilities?view=azloc-2610)
- [Manage VMs and enable guest management](/azure/azure-local/manage/manage-arc-virtual-machines?view=azloc-2610)
- [Troubleshoot Azure Local VMs](/azure/azure-local/manage/troubleshoot-arc-enabled-vms?view=azloc-2610)
- [GPU preparation and supported configurations](/azure/azure-local/manage/gpu-preparation?view=azloc-2610)
- [GPU partitioning and migration requirements](/windows-server/virtualization/hyper-v/gpu-partitioning)
- [Trusted Launch overview](/azure/azure-local/manage/trusted-launch-vm-overview?view=azloc-2610)
- [Confidential VM overview](/azure/azure-local/manage/confidential-vm-overview?view=azloc-2610)
- [Azure Local 2610 release information](/azure/azure-local/whats-new?view=azloc-2610)

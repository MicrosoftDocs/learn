Any VMs that you deploy as part of Contoso's Azure subscription need to be secure. You can use Azure Change Tracking and Inventory to audit configuration changes and maintain an inventory of Contoso's Windows Server infrastructure.

## What is Change Tracking and Inventory?

Azure Change Tracking and Inventory is an Azure service that monitors configuration changes and provides inventory logs for Azure VMs, Azure Arc-enabled servers, and virtual machine scale sets. It can help you detect configuration drift, investigate unexpected changes, and maintain visibility into system assets.

On Windows machines, Change Tracking and Inventory tracks:

- Windows software
- Windows files
- Windows registry keys
- Windows services

In addition, you can track the following Linux components:

- Linux daemons
- Linux software (packages)
- Linux files

The current version uses the Azure Monitor Agent (AMA), the Change Tracking extension, and a data collection rule (DCR). The DCR defines what data is collected and the Log Analytics workspace where Azure Monitor stores it. Change metadata is stored in the `ConfigurationChange` table, and inventory metadata is stored in the `ConfigurationData` table.

> [!IMPORTANT]
> The legacy Change Tracking and Inventory implementation that used the Log Analytics agent and Azure Automation was retired on August 31, 2024. Use the AMA-based service for new and existing deployments.

For more information about the service architecture, see [Azure Change Tracking and Inventory overview](/azure/azure-change-tracking-inventory/overview-monitoring-agent).

### Limitations

Change Tracking and Inventory has the following limitations:

- It doesn't support recursive Windows registry tracking, registry hives other than `HKEY_LOCAL_MACHINE`, or network file systems.
- It tracks up to 500 files and 250 registry keys per machine.
- Tracked files must be 5 MB or smaller.
- Collecting more than 2,500 files during a 30-minute cycle can reduce performance.
- Change records can take up to six hours to appear during periods of high network traffic.

For current limits, collection frequencies, and supported regions, see the [Change Tracking and Inventory support matrix](/azure/azure-change-tracking-inventory/change-tracking-inventory-support-matrix).

## Requirements for Change Tracking and Inventory

To enable Change Tracking and Inventory, you need an Azure subscription and a supported Azure VM or Azure Arc-enabled server. The onboarding process configures AMA, the Change Tracking extension, a DCR, and a Log Analytics workspace. An Azure Automation account isn't required.

### Supported operating systems

Change Tracking and Inventory supports Windows and Linux operating systems that meet the current AMA requirements. Because agent support changes over time, verify the operating system version in [Azure Monitor Agent supported operating systems](/azure/azure-monitor/agents/agents-overview#supported-operating-systems) before onboarding a machine.

### Network requirements

Machines must meet the [Azure Monitor Agent network requirements](/azure/azure-monitor/agents/azure-monitor-agent-network-configuration). AMA sends data to Azure Monitor over outbound TCP port 443. If your organization uses private links, proxies, or firewalls, allow the endpoints required for AMA, Azure Monitor, and the selected Log Analytics workspace.

### Azure region requirements

The AMA-based service supports Log Analytics workspaces in specific Azure regions. Region support isn't based on Automation account and workspace pairings. Review the current regional list in the [Change Tracking and Inventory support matrix](/azure/azure-change-tracking-inventory/change-tracking-inventory-support-matrix#supported-regions-and-mappings-for-change-tracking-and-inventory-with-the-azure-monitor-agent).

## Enable Change Tracking and Inventory

You can enable Change Tracking and Inventory for individual or multiple Azure VMs and Azure Arc-enabled servers. For larger deployments, use Azure Policy to deploy the required resources consistently.

### Enable Change Tracking and Inventory from the Azure portal

Use the following high-level procedure to enable Change Tracking and Inventory for a single Azure VM:

1. In the Azure portal, go to **Virtual machines**, and then select the VM.
2. Search for and select **Change tracking** to open the **Change Tracking and Inventory** pane.
3. Select **Enable change tracking and inventory feature with AMA**.
4. Select **Enable**.

Onboarding usually takes two to three minutes. During enablement, Azure associates a DCR with the VM and deploys the required monitoring components.

## Additional reading

To learn more, review the following documents:

- [Enable Change Tracking and Inventory for machines](/azure/azure-change-tracking-inventory/quickstart-monitor-changes-collect-inventory-azure-change-tracking-inventory)
- [Create a Change Tracking and Inventory data collection rule](/azure/azure-change-tracking-inventory/create-data-collection-rule)
- [Manage Change Tracking and Inventory by using Azure Policy](/azure/azure-change-tracking-inventory/enable-change-tracking-at-scale-policy)

Azure Update Manager is a unified service for managing operating system updates on Windows and Linux machines. It supports Azure virtual machines (VMs) and servers outside Azure that you connect by using Azure Arc.

## Azure Update Manager capabilities

Update Manager provides these capabilities from the Azure portal:

- View update compliance for Azure VMs and Azure Arc-enabled servers.
- Check for updates on demand or use periodic assessment to check every 24 hours.
- Install selected updates immediately with a one-time deployment.
- Schedule recurring deployments within maintenance windows.
- Target machines individually or use dynamic scopes based on Azure subscriptions, resource groups, locations, operating systems, and tags.
- Review assessment and deployment history and build reports from Azure Resource Graph data.

Update Manager is native to Azure VMs and Azure Arc-enabled servers. It doesn't depend on Azure Automation, Log Analytics, or Azure Monitor Agent. Azure automatically installs the required update extension when you start an Update Manager operation.

Azure RBAC controls access to Update Manager operations at the resource level. Use built-in roles or create a custom role with only the permissions required for specific update operations.

## Understand update sources

Update Manager orchestrates assessment and installation, but it doesn't publish updates. Each machine uses its configured update source:

- Windows machines use the Windows Update client and connect to Windows Update, Microsoft Update, or WSUS.
- Linux machines use their package manager and configured repositories.

The updates available in Update Manager reflect the updates returned by these sources. Network rules must allow each machine to reach its configured source.

### Use WSUS with Update Manager

Contoso can continue to use WSUS to download, test, and approve updates while Update Manager assesses and patches machines. Configure the Windows Update client to use the appropriate WSUS server through Group Policy or another management method.

When WSUS is the configured source, Update Manager only installs updates that WSUS approves and offers to the machine. A deployment can't install an update that isn't approved in WSUS.

> [!IMPORTANT]
> Update Manager doesn't override Windows Update client settings. Review policies that control update sources, automatic installation, and restarts before you schedule deployments.

## Store and query update data

Update Manager stores assessment and deployment data in Azure Resource Graph. Use the built-in views for daily operations, or create Azure Workbooks and Resource Graph queries for custom compliance reports. This data model doesn't require a Log Analytics workspace.

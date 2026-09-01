
Azure Update Manager provides native update assessment and patching for Azure virtual machines (VMs) and Azure Arc-enabled servers. It doesn't require an Azure Automation account, a Log Analytics workspace, or Azure Monitor Agent.

## Prepare machines for Update Manager

Azure VMs require no separate onboarding. The first time you start an Update Manager operation, Azure automatically installs the required VM extension.

For servers outside Azure, first connect each server to Azure by using Azure Arc. Update Manager then uses the Connected Machine agent and automatically deploys an update extension to assess and install updates.

> [!IMPORTANT]
> Register the **Microsoft.Compute** resource provider in the subscription that contains the Azure Arc-enabled servers. Update Manager requires this provider for Azure Arc operations and automatic extension upgrades.

Before you manage updates, verify the following prerequisites:

- Update Manager supports the operating system, update source, Azure region, and VM image.
- Each machine can reach its configured update source, such as Windows Update, Microsoft Update, WSUS, or a Linux package repository.
- Each machine can reach the endpoints required by Azure or Azure Arc.
- Each Linux machine runs Python 2.7 or later, and its root account has the required `sudo` permissions in `/etc/sudoers`.
- Your Azure role includes the permissions required for your update operations.

The built-in roles that include all Update Manager permissions are:

- **Azure Virtual Machine Contributor** or **Owner** for Azure VMs.
- **Azure Connected Machine Resource Administrator** for Azure Arc-enabled servers.

You can instead use a custom role that grants the permissions required for specific operations.

> [!NOTE]
> Update Manager stores update status in Azure Resource Graph. It doesn't use a Log Analytics workspace for update data.

## Enable periodic assessment

Periodic assessment checks a machine for available updates every 24 hours. Enable this setting so that Update Manager displays current compliance information.

To enable periodic assessment for one or more machines:

1. In the Azure portal, search for and select **Azure Update Manager**.
2. Under **Manage**, select **Machines**.
3. Select the machines, and then select **Update settings**.
4. Set **Periodic assessment** to **Enable**.
5. Select **Save**.

You can also enable periodic assessment at scale by assigning an Azure Policy definition for Azure VMs or Azure Arc-enabled servers.

## Configure patching options

Update Manager supports several patching approaches:

- **One-time update** installs selected updates immediately.
- **Scheduled patching** uses a guest-scope maintenance configuration for recurring deployments.
- **Automatic VM guest patching** lets Azure orchestrate updates for supported Azure VMs.
- **Hotpatching** applies supported security updates without a restart on eligible machines.

For scheduled patching on Azure VMs, set patch orchestration to **Customer Managed Schedules**. This setting configures the patch mode as `AutomaticByPlatform` and enables customer-managed schedules to bypass platform safety checks. Azure Arc-enabled servers don't require this patch-orchestration setting.

## Learn more

- [What is Azure Update Manager?](/azure/update-manager/overview)
- [Prerequisites for Azure Update Manager](/azure/update-manager/prerequisites)
- [Roles and permissions in Azure Update Manager](/azure/update-manager/roles-permissions)
- [Assessment options in Update Manager](/azure/update-manager/assessment-options)
- [Update options and orchestration in Azure Update Manager](/azure/update-manager/updates-maintenance-schedules)

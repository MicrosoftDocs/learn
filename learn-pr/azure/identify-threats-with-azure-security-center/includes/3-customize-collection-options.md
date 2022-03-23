You can customize various global Microsoft Defender for Cloud settings by using the **Environment settings** option on the Defender for Cloud menu. These settings are established on a per-subscription basis. This way, you have complete control over what's monitored, what data is collected, and where it's stored.

There are four areas you can influence.

- **Defender plans**: Information about Defender plans by resource type, including the number of resources and price.
- **Integrations**: You can control how Defender for Cloud integrates with other Microsoft security services, like Defender for Cloud Apps.
- **Auto provisioning**: You can enable _auto-provisioning_ to install a monitoring agent on all VMs in your subscription so Defender for Cloud can collect security information from Windows and Linux virtual machines (VMs).
- **Email notifications**: Security contact details and email notifications for high security alerts.

Here's an image of the **Environment settings** pane with the **Integrations** area selected.

:::image type="content" source="../media/3-defender-for-cloud-settings-integrations.png" alt-text="Screenshot that shows the Integrations pane.":::

**Auto provisioning** is an interesting feature. Defender for Cloud can collect security data and events from your VMs when you enable certain extensions.

1. **Log Analytics agent for Azure VMs**: Collects security-related configurations and event logs from the machine and stores the data in your Log Analytics workspace for analysis.
1. **Log Analytics agent for Azure Arc Machines (preview)**: Collects security-related configurations and event logs from the machine and stores the data in your Log Analytics workspace for analysis.
1. **Vulnerability assessment for machines**: Enables vulnerability assessment on your Azure and hybrid machines.
1. **Guest Configuration agent (preview)**: Checks machines running in Azure and Arc Connected Machines for security misconfigurations.

You can also activate these options when you create new VMs. Here's an image of the **Management** tab while creating a new Windows-based VM with the Azure portal that shows the Microsoft Defender for Cloud options being set.

:::image type="content" source="../media/3-create-vm-monitoring-options.png" alt-text="Screenshot that shows the VM management options when creating a vm":::

By default, a storage account will be selected (or created) to hold the logs, but you can customize that on a per-VM basis as needed.

With this collected data, Microsoft Defender for Cloud can start making observations about how each of your configured workloads match up to your security policy.

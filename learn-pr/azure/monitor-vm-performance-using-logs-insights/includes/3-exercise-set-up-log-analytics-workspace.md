In the previous unit, recall that you need to explore Azure native monitoring tools for your company. To further your knowledge, you'll need to know how to provision a Log Analytics workspace with the right permissions model, and you'll need to configure Azure Monitor for VMs to complete the process.

In this unit, you'll:

1. Create a Log Analytics workspace.
1. Configure the Log Analytics workspace permissions model for the environment you're supporting.
1. Create two virtual machines and onboard both to Azure Monitor for VMs.

## Create and configure Log Analytics workspace

1. In the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true), search for and select **Log Analytics workspaces**.

1. Select **Add**.

1. Enter the following values to build the Log Analytics workspace. Note, the Log Analytics workspace name must be globally unique, so we suggest using your initials or first name before the Log Analytics resource name (*xxx-log-analytics* will represent the unique name for this module).

    | Property | Value |
    | ---- | ---- |
    | Subscription | Select Learn subscription |
    | Resource group | Select Learn resource group |
    | Name | xxx-log-analytics |
    | Region | Select the region closest to you

    :::image type="content" source="../media/3-create-log-analytics-workspace.png" alt-text="Screen shot of declaring the Log Analytics resource name, placing everything in the Concierge Subscription for Learn, and selecting Review + Create.":::

1. Once all fields are filled out, select **Review + Create**.

1. After the resource deploys, select **Properties** underneath the **General** section of the Log Analytics workspace resource.

1. Look for the access control mode and select **Use resource or workspace permissions**. This setting changes the access mode to use resource permissions.

    :::image type="content" source="../media/3-check-log-analytics-resource-context.png" alt-text="Screen shot of changing access control mode for Log Analytics workspace." lightbox="../media/3-check-log-analytics-resource-context.png":::

    If you configure this setting after building the workspace, it ensures the deployment matches your company's want for log access.

## Set up your environment

1. Make sure you are still signed into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. Select **Cloud Shell** from the menu bar in the upper right.

1. Select **Bash**.

1. Run the following command. Change the resource group name to be reflective of your sandbox environment resource group name, which gets created upon sandbox activation.

    ```bash
    az vm create \
      --resource-group <rgn>[sandbox resource group name]</rgn> \
      --location westus \
      --name SampleVM1 \
      --image UbuntuLTS \
      --admin-username azureuser \
      --generate-ssh-keys \
      --verbose
    ```

1. Run the command above once more, but change the virtual machine name to **SampleVM2**. This way you'll have two virtual machines to experiment with as you move on in the module.

## Onboard virtual machines to Azure Monitor for VMs

1. Select each virtual machine from the portal.

1. Select **Insights** on the far left under **Monitoring** and select **Enable**.

1. Leave the **Workspace Subscription** unchanged and select the Log Analytics workspace you configured for **Choose a Log Analytics Workspace** (note: onboarding Azure Monitor for VMs takes a few minutes).

    :::image type="content" source="../media/3-enable-azure-monitor-vms.png" alt-text="Enable Azure Monitor for VMs after selecting the right subscription and Log Analytics workspace." lightbox="../media/3-enable-azure-monitor-vms.png":::

1. After 5-10 minutes have passed, go into the **Insights** section of each virtual machine underneath the **Monitoring** section.

1. The first view into this section will show you a map of dependencies like processes running, ports open, along with information about connection details, health of the virtual machine, machine properties, and Azure virtual machine properties.

    :::image type="content" source="../media/3-azure-monitor-vms-map.png" alt-text="Azure Monitor for VMs screenshot, showcasing dependences and information about virtual machine." lightbox="../media/3-azure-monitor-vms-map.png":::

1. Next, select **Performance** at the top, right next to **Map**.

    :::image type="content" source="../media/3-virtual-machine-insights.png" alt-text="Screen shot after enabling Azure Monitor for VMs." lightbox="../media/3-virtual-machine-insights.png":::

1. Explore the different graphs for: 
- Logical Disk Performance
- CPU Utilization
- Available Memory
- Logical Disk IOPS
- Logical Disk MB/s
- Logical Disk Latency (ms)
- Max Logical Disk Used %
- Bytes Sent Rate
- Bytes Received Rate.

1. Experiment with different settings by moving from **Avg**, to **Min**, to **Max**, and so on (note, the virtual machines were only created a few minutes ago, so there might not be much data generated).

1. Select **Log Events** on the right-hand side of the page.

    :::image type="content" source="../media/3-log-events.png" alt-text="Screenshot of where Log Events show up within Azure Monitor for VMs." lightbox="../media/3-log-events.png":::

1. Select the **InsightsMetrics** table.

    :::image type="content" source="../media/3-azure-monitor-logs-data-summary.png" alt-text="Screen shot after selecting Log Events from the Azure Monitor for VMs pane.":::

1. The logs section of a Log Analytics workspace opens with a pre-populated query showing the data being collected.

    :::image type="content" source="../media/3-insights-metrics-log-analytics.png" alt-text="Screen shot after selecting the InsightsMetrics table and Log Analytics opening up for further query writing." lightbox="../media/3-insights-metrics-log-analytics.png":::

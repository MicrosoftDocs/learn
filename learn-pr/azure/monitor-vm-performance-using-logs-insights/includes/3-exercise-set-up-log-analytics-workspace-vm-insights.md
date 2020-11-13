In the previous unit, recall that you need to explore Azure native monitoring tools for workloads being deployed in Azure. To further your knowledge, you'll need to know how to provision a Log Analytics workspace with the right permissions model, connect virtual machines to the workspace, and also need to onboard Azure Monitor for VMs to complete the process.

In this unit, you'll:

1. Create a Log Analytics workspace.
1. Configure the Log Analytics workspace permissions model for the environment you're supporting.
1. Create two virtual machines and onboard both Azure Monitor for VMs.

## Create and configure Log Analytics workspace

1. Log into [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) with the account you used to activate the sandbox.

1. At the top, select **All services.**

1. In the list of resources, type Log Analytics. As Log Analytics is typed in, the list will filter based upon input. Select **Log Analytics workspaces**.

    :::image type="content" source="../media/3-set-up-log-analytics.png" alt-text="Screen shot of selecting Log Analytics from menu.":::

1. Select Add.

1. Select a subscription, resource group, and location.

1. Provide a name for the new Log Analytics workspace and note the name must be globally unique, but there are no capitalization rules like with a storage account. For the screenshot, the Learn resource group name is used.

    :::image type="content" source="../media/3-create-log-analytics-workspace.png" alt-text="Screen shot of declaring the Log Analytics resource name, placing everything in the Concierge Subscription for Learn, and selecting Review + Create.":::

1. Once completed, select **Review + Create.**

1. Once deployed, select Properties underneath the General section of the Log Analytics workspace resource.

1. Look for the access control mode and select **Use resource or workspace permissions**.

    :::image type="content" source="../media/3-check-log-analytics-resource-context.png" alt-text="Screen shot of changing access control mode for Log Analytics workspace.":::

1. Configuring this setting after building the workspace ensures this deployment matches your company's want for business units to be able to only see log data for the Azure resources they deploy.

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

1. Select **Insights** on the far left and select **Enable**.

    :::image type="content" source="../media/3-enable-virtual-machine-insights.png" alt-text="Screen shot of enabling Azure Monitor for VMs.":::

1. This will open up another pane for some additional selections.

1. Leave the **Workspace Subscription** unchanged and select the Log Analytics workspace you just configured for **Choose a Log Analytics Workspace** (note: onboarding Azure Monitor for VMs takes a few minutes).

    :::image type="content" source="../media/3-enable-azure-monitor-vms.png" alt-text="Enable Azure Monitor for VMs after selecting the right subscription and Log Analytics workspace.":::

1. Once enabled, go into the **Insights** section of each VM underneath the Monitoring area.

1. After the pane opens, examine the **Map**.

1. This will show you a map of dependencies like processes running, ports open, along with information about connection details, health of the virtual machine, machine properties, and Azure virtual machine properties.

    :::image type="content" source="../media/3-azure-monitor-vms-map.png" alt-text="Azure Monitor for VMs screen shot, showcasing dependences and information about virtual machine.":::

1. From there, select **Performance.**

    :::image type="content" source="../media/3-virtual-machine-insights.png" alt-text="Screen shot after enabling Azure Monitor for VMs.":::

1. Explore the different graphs for: Logical Disk Performance, CPU Utilization, Available Memory, Logical Disk IOPS, Logical Disk MB/s, Logical Disk Latency (ms), Max Logical Disk Used %, Bytes Sent Rate, and Bytes Received Rate.

1. Experiment with different settings. Move from **Avg**, to **Min**, to **Max**, and so on.

1. Select **Log Events** on the right-hand side of the page.

    :::image type="content" source="../media/3-log-events.png" alt-text="Screenshot of where Log Events show up within Azure Monitor for VMs.":::

1. This will bring up a summary pane that highlights the event type and count of captured Azure Monitor Logs data that can be further analyzed inside a Log Analytics workspace.

    :::image type="content" source="../media/3-azure-monitor-logs-data-summary.png" alt-text="Screen shot after selecting Log Events from the Azure Monitor for VMs pane.":::

1. Select the **InsightsMetrics** table.

1. The logs section of a Log Analytics workspace will open and you will see a pre-populated query that outlines the data being collected inside that table after enabling Azure Monitor for VMs.

    :::image type="content" source="../media/3-insights-metrics-log-analytics.png" alt-text="Screen shot after selecting the InsightsMetrics table and Log Analytics opening up for further query writing.":::
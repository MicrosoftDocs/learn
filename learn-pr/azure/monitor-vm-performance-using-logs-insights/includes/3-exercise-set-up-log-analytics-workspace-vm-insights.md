In the previous unit, recall that you need to explore Azure native monitoring tools for workloads being deployed in Azure. To further your knowledge, you'll need to know how to provision a Log Analytics workspace with the right permissions model and also need to onboard Virtual Machine Insights to complete the process.

In this unit, you'll:

1. Create a Log Analytics workspace.
1. Configure the Log Analytics workspace permissions model for the environment you're supporting.
1. Create two virtual machines and onboard both to Log Analytics plus Virtual Machine Insights.

## Create and configure Log Analytics workspace

1. Log into [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) with the account you used to activate the sandbox.

1. At the top, select **All services.**

1. In the list of resources, type Log Analytics. As Log Analytics is typed in, the list will filter based upon input. Select **Log Analytics workspaces**.

    :::image type="icon" source="../media/3-set-up-log-analytics.png" border="false" alt-text="Screen shot of selecting Log Analytics from menu.":::

1. Select Add.

1. Select a subscription, resource group, and location.

1. Provide a name for the new Log Analytics workspace and note the name must be globally unique, but there are no capitalization rules like with a storage account. For the screenshot, the Learn resource group name is used.

    :::image type="icon" source="../media/3-create-log-analytics-workspace.png" border="false" alt-text="Screen shot of declaring the Log Analytics resource name, placing everything in the Concierge Subscription for Learn, and selecting Review + Create.":::

1. Once completed, select **Review + Create.**

1. Once deployed, select Properties underneath the General section of the Log Analytics workspace resource.

1. Look for the access control mode and select **Use resource or workspace permissions**.
    
    :::image type="icon" source="../media/3-check-log-analytics-resource-context.png" border="false" alt-text="Screen shot of changing access control mode for Log Analytics workspace.":::

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

1. Run the command above once more, but change the virtual machine name to SampleVM2. This way you'll have two virtual machines to experiment with as you move on in the module.

## Onboard virtual machines to Log Analytics workspace

1. After both virtual machines are created, select the Log Analytics workspace resource you created earlier in this unit.

1. Underneath Workspace Data Sources, select **Virtual machines**.

1. Once the results display on the right, you should see the **Log Analytics connection status** for the virtual machines.

1. You will either see that the virtual machines are listed as **Not connected** or **Connected to other workspace**.

1. For the sandbox, both virtual machines should show as not connected, so select **Connect** on each virtual machine.

    :::image type="icon" source="../media/3-connected-not-connected-disconnect.png" border="false" alt-text="Screen shot of virtual machine not connected to a Log Analytics workspace.":::

1. After connecting the virtual machines, the Log Analytics virtual machine extension will automatically install and be configured for your Log Analytics workspace.

1. This process takes a few minutes, during which time the **Status** shows as **Connecting**. Once connected, the status will say **Connected**.

## Onboard virtual machines to Virtual Machine Insights

1. Once both virtual machines are connected to your Log Analytics workspace, you'll need to onboard both to Virtual Machine Insights.

1. Select each virtual machine from the portal. 

1. Select **Insights** on the far left and select **Enable**. Onboarding Virtual Machine Insights takes a few minutes.

    :::image type="icon" source="../media/3-enable-virtual-machine-insights.png" border="false" alt-text="Screen shot of enabling Virtual Machine Insights.":::

1. Once enabled, go into the **Insights** section of each VM underneath the Monitoring area.

1. After the pane opens, select **Performance.**

:::image type="icon" source="../media/3-virtual-machine-insights.png" border="false" alt-text="Screen shot after enabling Virtual Machine Insights.":::

1. Explore the different graphs for: Logical Disk Performance, CPU Utilization, Available Memory, Logical Disk IOPS, Logical Disk MB/s, Logical Disk Latency (ms), Max Logical Disk Used %, Bytes Sent Rate, and Bytes Received Rate.

1. Experiment with different settings. Move from **Avg**, to **Min**, to **Max**, and so on.

1. Take note of how easy it is to drill into Log Events on the far right-hand side of the page.
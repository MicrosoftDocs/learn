In the previous unit, recall that you need to explore Azure native monitoring tools for workloads being deployed in Azure. To further your knowledge, you'll need to know how to provision a Log Analytics workspace with the right permissions model and also need to onboard Virtual Machine Insights to complete the process.

In this unit, you'll:

1. Create a Log Analytics workspace.
1. Check the permissions model for the environment you're supporting.
1. Create two virtual machines and onboard both to Log Analytics plus Virtual Machine Insights.

## Create and configure Log Analytics workspace

1. Log into Azure portal with the account you used to activate the sandbox.

1. At the top, select "All services." 

1. In the list of resources, type Log Analytics. As Log Analytics is typed in, the list will filter based upon input. Select Log Analytics workspaces.

<!--[PLACEHOLDER - SCREEN SHOT - LOCATE LOG ANALYTICS]-->

1. Select Add.

1. Provide a name for the new Log Analytics workspace and note the name must be globally unique, but there are no capitalization rules like with a storage account.

1. Select a subscription, resource group, and location.

1. Leave the Pricing tier at "Per GB" (this setting will be configured by default on all new Log Analytics workspaces).

<!--[PLACEHOLDER - SCREEN SHOT - SET UP LOG ANALYTICS WORKSPACE]-->

1. Once deployed, select Properties underneath the General section of the Log Analytics workspace resource.

1. By default, you should see use resource or workspace permissions, which is the right Access Control mode for your company.

<!--[PLACEHOLDER - CHECK RESOURCE CONTEXT]-->

## Set up your environment

1. Sign into the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) using the same account you activated the sandbox with.

1. Select **Cloud Shell** from the menu bar in the upper right.

1. Select **Bash**.

1. Run the following command. Change the resource group name to be reflective of your sandbox environment's resource group that gets created upon sandbox activation.

    ```bash
    az vm create \
      --resource-group [sandbox resource group name] \
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

1. Underneath Workspace Data Sources, select Virtual machines.

1. Once the results display on the left, select SampleVM1 and SampleVM2. You should see the **Log Analytics connection status** for the virtual machine indicates that it is **Not connected**.

<!--[PLACEHOLDER - SCREEN SHOT - CONNECTED VS. NOT CONNECTED]-->

1. Select **Connect** for both virtual machines. 

1. The agent will automatically install and be configured for your Log Analytics workspace.

1. The process takes a few minutes, during which time the **Status** shows as **Connecting**. Once connected, the status will say **Connected**.

## Onboard virtual machines to Virtual Machine Insights

1. Once both virtual machines are connected to your Log Analytics workspace, you'll need to onboard both to Virtual Machine Insights. Select each virtual machine from the portal. Select "Insights" on the far left and select "Enable." Onboarding Virtual Machine Insights takes a few minutes.

<!--[PLACEHOLDER - SCREEN SHOT - ENABLE VM INSIGHTS]-->

1. Once enabled, go into the "Insights" section of each VM underneath the Monitoring area.

1. Once the pane opens, select "Performance."

1. Explore the different graphs for: Logical Disk Performance, CPU Utilization, Available Memory, Logical Disk IOPS, Logical Disk MB/s, Logical Disk Latency (ms), Max Logical Disk Used %, Bytes Sent Rate, and Bytes Received Rate.

<!--[PLACEHOLDER - SCREEN SHOT - GRAPHS]-->

1. Experiment with different settings. Move from "Avg", to "Min", to "Max", and so on.

1. Take note of how easy it's to drill into Log Events on the far right-hand side of the page.
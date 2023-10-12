Azure Monitor includes VM Insights, a curated workbook of useful VM metrics visualizations for managing your VM health. VM Insights also collects client and workload metrics. In this unit, you enable VM Insights and use it to monitor host performance and guest OS metrics.

VM Insights gets you started monitoring client and workload metrics quickly by automatically:

- Setting up a default Log Analytics workspace that VM Insights can collect data to.
- Installing Azure Monitor Agent on guest VMs.
- Installing the Dependency Agent if **Enable processes and dependencies (Map)** is selected.
- Creating a predefined DCR with a set of useful metrics for monitoring VM clients and workloads.
- Setting up out-of-the-box workbooks that visualize VM performance trends over time.

VM Insights installs *Azure Monitor Agent*, an agent that collects data from inside guest VMs. In the next unit, you use a *data collection rule (DCR)* to select which guest metrics Azure Monitor Agent collects and where it sends the data.

## Enable VM Insights

1. In the Azure portal, on your VM's **Overview** page, select **Insights** from the left navigation menu under **Monitoring**.
1. On the **Insights** page, select **Enable**.
1. On the **Monitoring configuration** page, for **Enable insights using**, select **Azure Monitor Agent (recommended)**.
1. For **Data collection rule**, accept the default. Ensure that **Processes and dependencies (Map)** is set to **Enabled**.
1. Select **Configure**.

:::image type="content" source="../media/enable-insights.png" alt-text="Screenshot that shows enabling and configuring VM Insights.":::

Configuration of the workspace and the agent installation typically takes 5 to 10 minutes. It can take another 5 to 10 minutes for data to become available to view in the portal.

When the deployment finishes, confirm that the Azure Monitor Agent and the Dependency Agent are installed by looking under **Extensions + applications** at the bottom of the VM's **Overview** page, on the **Properties** tab. On the **Monitoring** tab, under **Performance and utilization**, you can see that **Guest OS metrics** are now being collected.

:::image type="content" source="../media/guest-os-metrics.png" alt-text="Screenshot that shows Guest OS metrics on the VM's Monitoring tab.":::

## View VM Insights

To view the default VM Insights Performance workbooks and maps, select **Insights** from the VM's left navigation menu under **Monitoring**.

Near the top of the **Insights** page, select the **Performance** tab.

The prebuilt VM Insights Performance workbook shows charts and graphs with performance-related data for the current VM. You can customize the view by specifying a different **Time range** at the top of the page, and different aggregations at the top of each graph.

:::image type="content" source="../media/vm-insights-performance.png" alt-text="Screenshot that shows the prebuilt VM Insights performance workbook.":::

You can select **View Workbooks** at upper right to select from other available prebuilt workbooks. Select **Gallery** to choose from other available prebuilt workbooks, or edit and create your own workbooks.

Select the **Map** tab to see the workbook for the Map feature.

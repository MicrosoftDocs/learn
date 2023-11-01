The last time your band went on tour, your website went down while your fans were trying to buy tickets. You're not sure if the web server ran out of memory, or if the virtual machine (VM) wasn't the right size. For your new tour, you'd like a dashboard to keep track of the VM's traffic, memory, and CPU usage.

In this exercise, you install the Azure Monitor Agent on your new VM to collect near real-time metrics at the guest OS level. After you install the agent, you create a KPI dashboard to view the new metrics being captured.

## Install the Azure Monitor agent by using data collection rules

1. In the [Azure portal](https://portal.azure.com?azure-portal=true), search for Monitor.
1. Under **Settings**, select **Data Collection Rules**.
1. Select **Create**.

    :::image type="content" source="../media/6-dcr-empty-landing-page.png" alt-text="Screenshot of the data collection rules landing page" lightbox="../media/6-dcr-empty-landing-page.png":::

1. Enter the following values.

   | Setting     | Value |
   |---------|---------|
   |Rule Name    |   MyPerformanceMetrics |
   |Subscription  |   Your subscription  |
   |Resource group   |  Resource group that contains the VM    |
   |Region  | Region where the VM is located     |
   |Platform Type  | Linux     |

    :::image type="content" source="../media/6-dcr-name-and-location.png" alt-text="Screenshot of the data collection rules basics":::

1. On the **Resources** tab, select **Add resources**.
1. On the **Select a scope** pane, select the **monitored-linux-vm** VM you created, and select **Apply**.
1. Review the result on the **Resources** tab.

    :::image type="content" source="../media/6-dcr-add-resources.png" alt-text="Screenshot of the data collection rules resources" lightbox="../media/6-dcr-add-resources.png":::

1. On the **Collect and deliver** tab, select **Add data source** to configure the data to be collected and the destination to send it to.

    You have different configuration options depending on the OS installed on the VM. At the basic level, these options are performance counters (CPU, Memory, Disk and Network) which can be sent to Azure Monitor Metrics and/or Azure Monitor Logs. However, you can also choose to collect custom metrics like percentage of free disk space on Windows, or the amount of swap available on Linux.

1. For **Data source type**, select **Performance Counters**.

    :::image type="content" source="../media/6-add-data-sources.png" alt-text="Screenshot of the data collection rules performance counters." lightbox="../media/6-add-data-sources.png":::
1. Change the **Sample rate (seconds)** for each counter to *60*. 
1. Select the **Destination** tab to view the default destination for Performance Counters, Azure Monitor Metrics.

    :::image type="content" source="../media/6-add-dcr-destinations.png" alt-text="Screenshot of the data collection rules performance counters destination.":::

    Confirm your settings include a destination type of Azure Monitor metrics.

1. On the bottom of the pane, select **Add data source**.
1. Select **Review and create** > **Create**. This command installs the Azure Monitor Agent on the selected VM, and starts data collection with the parameters defined in the rule you created.

## Confirm that the agent is installed on the VM

1. In the Azure portal, search for and select Virtual Machines.
1. Select the virtual machine you created in the previous exercise.
1. On the VM overview page, under **Extensions**, you should see **AzureMonitorLinuxAgent** listed.

    :::image type="content" source="../media/6-agent-on-vm.png" alt-text="Screenshot of the virtual machine overview page with the agent Installed.":::

## Create a custom KPI dashboard

1. In the left menu pane, under **Monitoring**, select **Metrics**. The **Metrics** pane appears for your VM.

1. Select the following values:

   | Setting     | Value |
   |---------|---------|
   |Metric Namespace    |   azure.vm.linux.guestmetrics |
   |Metric    |   net/bytes_total  |
   |Aggregation    |    Max     |

   If the metric namespace **azure.vm.linux.guestmetrics** isn't listed, wait a few minutes and try again.

1. Select the **Finish editing metric** check mark.

1. At the top right of the chart, select **Save to dashboard** > **Pin to dashboard**. The **Pin to dashboard** pane appears.

1. Select the **Create new** tab.

1. For **Type**, select **Private**. If you're using your own subscription, you can create a shared dashboard.

1. In the **Dashboard name** field, enter *KPI Dashboard*.

   :::image type="content" source="../media/6-create-dashboard.png" alt-text="Screenshot that shows the 'Pin to another dashboard' pane filled out.":::

1. Select **Create and pin**. The **Metrics** pane reappears.

### Add a free memory percentage graph

1. In the top menu bar, select **New chart**.

1. Select the following values:

   | Setting     | Value |
   |---------|---------|
   |Metric Namespace    |   azure.vm.linux.guestmetrics      |
   |Metric     |   mem/available_percent  |
   |Aggregation    |    Max     |

1. Select the **Finish editing metric** check mark.

1. At the top right of the chart, select **Save to dashboard** > **Pin to dashboard**. The **Pin to dashboard** pane appears.

1. In the **Dashboard** dropdown field, select **KPI Dashboard**.

1. Select **Pin**. The **Metrics** pane for your VM reappears.

### Add a CPU usage graph

1. Select **New chart**.

1. Select the following values:

   | Setting     | Value |
   |---------|---------|
   |Metric Namespace    |   azure.vm.linux.guestmetrics  |
   |Metric     |   cpu/usage_active  |
   |Aggregation    |    Max     |

1. Select the **Finish editing metric** check mark.

1. At the top right of the chart, select **Save to dashboard** > **Pin to dashboard**.

1. In the **Dashboard** dropdown field, select **KPI Dashboard**.

1. Select **Pin**. The **Metrics** pane for your VM reappears.

### View the new dashboard

1. At the top left of the portal, select the **&#9776;** icon, and then select **Dashboard**. The **KPI Dashboard** appears.

    :::image type="content" source="../media/6-view-dashboard.png" alt-text="Screenshot that shows the dashboard selection dropdown list.":::

1. Explore the dashboard. Try changing the **UTC Time** range to **Past 30 minutes**, and select **Apply**.

    :::image type="content" source="../media/6-kpi-dashboard.png" alt-text="Screenshot that shows the new KPI dashboard with the three graphs created earlier." lightbox="../media/6-kpi-dashboard.png":::

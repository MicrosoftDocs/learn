The last time your band went on tour, your website went down while your fans were trying to buy tickets. You're not sure if the web server ran out of memory, or if the virtual machine (VM) wasn't the right size. For your new tour, you'd like a dashboard to keep track of the VM's traffic, memory, and CPU usage.

In this exercise, you'll install the Azure Diagnostics extension on your new VM to collect near real-time metrics for the OS level. After you install the extension, you'll change the sample rate to every minute. Then, you'll create a KPI dashboard to view the new metrics being captured.

## Install the Azure Diagnostics extension

Use the portal to enable guest-level metric monitoring of the VM. When you enable this monitoring, Azure installs and configures the Azure Diagnostics extension for you.

1. Go to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) and sign in with the account that you used to enable the sandbox.

1. On the Azure portal menu or from the **Home** page, select **Virtual machines**.

1. Select the **monitored-linux-vm** virtual machine that you created. The **monitored-linux-vm** virtual machine pane appears.

1. In the left menu pane, under **Monitoring**, select **Diagnostic settings**. The **Diagnostics settings** pane appears for your virtual machine.

    ![Screenshot that shows the monitoring section for a VM.](../media/6-scroll-to-monitoring.png)

1. On the **Overview** tab, select **Enable guest-level monitoring**. If the storage account isn't listed, wait several minutes, and refresh the page until it appears, and then select **Enable guest-level monitoring** again.

    ![Screenshot that shows the button for enabling guest-level monitoring.](../media/6-enable-guest-level-monitoring.png)

    Wait until the diagnostic settings are configured. This process might take a minute.

## Configure the extension

1. After the extension is installed, the **Diagnostics settings** pane appears highlighting the **Overview** tab.

1. Select the **Metrics** tab.

    ![Screenshot that shows the Overview page.](../media/6-diagnostics-enabled.png)

1. Change all the **Sample rates** to **60** seconds, and in the top menu bar, select **Save**.

    ![Screenshot that shows changing the sample rate to 60 seconds.](../media/6-change-sample-rate.png)

   It might take a minute to save your updates.

## Create a custom KPI dashboard

1. In the left menu pane, under **Monitoring**, select **Metrics**. The **Metrics** pane appears for your VM.

1. Select the following values:

   | Setting     | Value |
   |---------|---------|
   | Metric Namespace    |   Guest (classic) |
   | Metric    |   Network in guest OS  |
   | Aggregation    |    Max     |

1. Select the **Finish editing metric** check mark.

1. At the top right of the chart, select **Pin to dashboard**. The **Pin to dashboard** pane appears.

1. Select the **Create new** tab.

1. For **Type**, select **Private**. If you're using your own subscription, you can create a shared dashboard.

1. In the **Dashboard name** field, enter *KPI Dashboard*.

    ![Screenshot that shows the "Pin to another dashboard" pane filled out](../media/6-create-dashboard.png)

1. Select **Create and pin**. The **Metrics** pane reappears.

### Add a free memory percentage graph

1. In the top menu bar, select **New chart**.

1. Select the following values:

   | Setting     | Value |
   |---------|---------|
   | Metric Namespace    |   Guest (classic)      |
   | Metric     |   Mem. percent available  |
   | Aggregation    |    Max     |

1. Select the **Finish editing metric** check mark.

1. At the top right of the chart, select **Pin to dashboard**. The **Pin to dashboard** pane appears.

1. In the **Dashboard** dropdown field, select **KPI Dashboard**.

1. Select **Pin**. The **Metrics** pane for your VM reappears.

### Add a CPU usage graph

1. Select **New chart**.

1. Select the following values:

   | Setting     | Value |
   |---------|---------|
   | Metric Namespace    |   Guest (classic)   |
   | Metric     |   CPU percentage guest OS   |
   | Aggregation    |    Max     |

1. Select the **Finish editing metric** check mark.

1. At the top right of the chart, select **Pin to dashboard**.

1. In the **Dashboard** dropdown field, select **KPI Dashboard**.

1. Select **Pin**. The The **Metrics** pane for your VM reappears.

### View the new dashboard

1. At the top left of the portal, select the **&#9776;** icon, and then select **Dashboard**. The **KPI Dashboard** appears.

    ![Screenshot that shows the dashboard selection dropdown list.](../media/6-view-dashboard.png)

1. Explore the dashboard. Try changing the **UTC Time** range to **Past 30 minutes**, and select **Apply**.

    ![Screenshot that shows the new KPI dashboard with the three graphs created earlier.](../media/6-explore-kpi-dashboard.png)

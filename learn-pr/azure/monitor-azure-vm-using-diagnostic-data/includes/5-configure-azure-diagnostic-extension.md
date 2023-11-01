If you need to capture Guest OS performance metrics in addition to the standard virtual machine host metrics, install the Azure Monitor Agent. You install the agent and configure the data to be collected using Data Collection Rules.

Your band is on tour next month, and you have identified specific metrics that will help you monitor the health of your virtual machine (VM). The metrics that you want to monitor go beyond the standard virtual machine host metrics available in the Azure portal. You've decided to use the Azure Monitor Agent for guest OS visibility.

In this unit, you see how to install the Azure Monitor Agent to monitor the health of a VM. You learn how to enable the agent for an existing VM.

## Install the Azure Monitor Agent by using data collection rules

The Azure Monitor Agent allows you to collect near real-time performance metrics from the guest operating system, along with log events, and store the results in Azure Monitor Metrics and Azure Monitor Logs.

If you've already created the VM, the easiest way to add the agent is by going to **Azure Monitor** > **Data Collection Rules** to create a new Data Collection Rule and add the VM as a resource.

Data collection rules define:

- The scope of VMs where data is captured.
- The metrics or logs to be collected.
- The destination or destinations where the data is stored.

:::image type="content" source="../media/5-dcr-landing-page.png" alt-text="Screenshot of the Data Collection Rules Landing Page with rule." lightbox="../media/5-dcr-landing-page.png":::

Resources allow you to select which VM(s) to collect data from for monitoring. Data sources define the metrics and logs you want to collect and where that data is sent and stored.

:::image type="content" source="../media/5-dcr-definition.png" alt-text="Screenshot of the data collection rules definition." lightbox="../media/5-dcr-definition.png":::

Performance Counters to be collected can be selected from a **Basic** set or customized and filtered from an expanded **Custom** list.

:::image type="content" source="../media/5-dcr-data-sources.png" alt-text="Screenshot of the data collection rules data sources." lightbox="../media/5-dcr-data-sources.png":::

Performance counters can be sent to Azure Monitor Metrics and/or Azure Monitor Logs. Azure Monitor Metrics is a time-series data store optimized for near-real time visualizations and alerts. Azure Monitor Logs supports more sophisticated data analysis such as trending and pattern recognition using queries.

:::image type="content" source="../media/5-dcr-destinations.png" alt-text="Screenshot of the data collection rules destinations." lightbox="../media/5-dcr-destinations.png":::

The Azure Monitor Agent can collect metrics and logs and can send the data to Azure Monitor metrics and/or multiple Azure Monitor Logs workspaces. However, this unit only focuses on the metric collection capabilities of the Azure Monitor Agent.

Azure Monitor is based on a [common monitoring data platform](/azure/azure-monitor/data-platform) that enables you to view, analyze, and work with data gathered from your resources. The platform offers many features that support two primary components: **Logs** and **Metrics**.

[Azure Monitor Logs](/azure/azure-monitor/logs/data-platform-logs) lets you collect and organize data from resources that you monitor. You configure what data is gathered and organized on the platform. Other features in Azure Monitor automatically store their data in Logs. You can use the stored data with your collected data to help monitor the performance of your environment.

[Azure Monitor Metrics](/azure/azure-monitor/essentials/data-platform-metrics) captures numerical data from your monitored resources and stores the results in a time-organized database. Metrics are collected at intervals you specify. You can use metrics to check how your system is performing at a particular time or under certain circumstances.

Azure Monitor collects many different data sources. 

:::image type="content" source="../media/azure-monitor-source.png" alt-text="Diagram that shows sources of monitoring data for Azure Monitor." border="false":::

As the CTO for Tailwind Traders, think about your environment. What sources of monitoring data do you want to collect? What analysis or other actions might you want to take on your collected data?

### Things to know about Azure Monitor

As you develop your monitoring plan, consider these characteristics of Azure Monitor.

- Data from multiple resources can be collected into Azure Monitor and analyzed together by using a common set of tools.

- Logs enable complex analysis by using log queries.

- Metrics support near-real-time scenarios like priority alerts and responding to critical issues.

- Monitoring data can be sent to other locations to support certain scenarios, such as tracking and reporting.

- Sources of monitoring data from Azure applications can be organized into tiers, and each tier can be accessed in different ways.
   - The highest tiers are for your application itself.
   - The lower tiers are components of the Azure platform.

### Things to consider when using Azure Monitor

You reviewed how Azure Monitor uses Logs and Metrics. Now consider how to implement these features in your monitoring solution for Tailwind Traders.

- **Consider data sources and data access**. Azure Monitor collects data using Data Collection Rules (DCRs), which define what data to collect, how to filter and transform it, and where to send it. DCRs are created centrally and assigned to resources via data collection rule associations. The following data types are collected through DCRs by the Azure Monitor Agent (AMA):

   - **Windows events**. Information sent to the Windows event logging system, including sysmon events.	

   - **Performance counters**. Numerical values measuring performance of different aspects of operating system and workloads.	

   - **Syslog**. Information sent to the Linux event logging system.
 
   - **IIS logs**. Internet Information Service (IIS) logs from the local disk of Windows machines.

   - **Custom logs (text and JSON)**. Information sent to text or JSON log files on a local disk, collected via AMA with a custom table schema defined in the DCR.

- **Consider queries on Logs data**. Write log queries to analyze your collected data for Tailwind Traders. For more information about log queries, see [Log queries in Azure Monitor](/azure/azure-monitor/logs/log-query-overview).

- **Consider alerts based on Logs and Metrics data**. Set up alert rules based on Logs data to be proactively notified about system issues. Use Metrics data to identify when critical Tailwind Traders issues occur, such as values that exceed defined limits.

- **Consider Data Collection Rules for all agent-based data**. Create DCRs in Azure Monitor and assign them to your VMs and hybrid machines using resource associations. Use Azure Policy to enforce DCR assignment at scale. Read more about [Data Collection Rules in Azure Monitor](/azure/azure-monitor/data-collection/data-collection-rule-overview).

- **Consider Metrics Explorer to analyze metrics interactively**. Define metrics to monitor about your Tailwind Traders resources, such as peak usage rates, access information, workloads, or incident scenarios. Use the [Metrics Explorer](/azure/azure-monitor/metrics/analyze-metrics) to investigate the collected data. 

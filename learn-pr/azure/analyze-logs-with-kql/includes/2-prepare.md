You'll be writing KQL queries to extract, transform, and visualize data that helps you address the IT issues your retail chain is experiencing. Here, we'll discuss the approach we'll take to making sense of data in Azure Monitor Logs and extracting meaningful insights and answers to operational and business questions. 


## Project overview

The goal of the project is to translate log data into information that helps you understand how you can address and mitigate the computer performance issues in your stores. 

The key tasks you'll need to perform are:

1. Set the scope of your analysis. Which questions do you want to answer and which data do you need to answer these questions?
1. Find the tables and columns that hold the log data relevant to your analysis.
1. Write KQL queries to extract the data you need from your logs. 

The following diagram depicts the approach to log analysis you'll be following throughout this project:

:::image type="content" source="../media/kql-log-analysis-azure-monitor-log-analytics.png" alt-text="A diagram that depicts the flow of defining questions, finding relevant log data and writing KQL queries. ":::

## Set analysis goals

Recall that your IT team has noticed recurring issues related to virtual machines with high CPU usage and insufficient free space. 

You want to ensure that you're getting data about all active virtual machines in your network. You need to be able to identify machines that stop sending data, so that you can investigate and ensure the full visibility of the status of your virtual machines.

Therefore, for your analysis, you'll need data about:

- Virtual machines that stop sending data. 
- CPU usage of virtual machines.
- Virtual machine free space statistics.

## Assess logs

Which tables hold data that's relevant to your analysis goals?

| Analysis goal | Log table with relevant data |
| --- | --- |
|  Virtual machines that stop sending data | The [Heartbeat](/azure/azure-monitor/reference/tables/heartbeat) table collects virtual machine health data from each virtual machine at one-minute intervals. |
| CPU usage of virtual machines | The [Perf](/azure/azure-monitor/reference/tables/perf) table collects data about the performance of hardware components, operating systems, and applications. |
| Virtual machine free space statistics | The [Perf](/azure/azure-monitor/reference/tables/perf) table. |
## Write queries

In the following units, you'll write KQL queries to extract and transform data based on your analysis goals. 


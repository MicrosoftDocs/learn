Kusto Query Language (KQL) is the query language used to perform analysis on data to create Analytics, Workbooks, and perform Hunting in Microsoft Sentinel and Microsoft Defender XDR. Understanding how to summarize and visualize data with a KQL statement provides the foundation to build efficient threat detections.

You're a Security Operations Analyst working at a company that is implementing Microsoft Sentinel. You're responsible for performing log data analysis to search for malicious activity, display visualizations, and perform threat hunting.  To query log data, you use the Kusto Query Language (KQL). You write KQL statements that aggregate and correlate data that allows for pattern detection. One such aggregation might be the number of failed logons. This information, combined with a predetermined threshold, can be used to generate an alert for "Account with over 10 failed logons in the past hour" as an example.  

The KQL summarize operator performs the calculations, and produces a table that aggregates the contents of the input table. To quickly see a pattern, an analyst can visualize the results in a graph. The KQL render operator performs the visualization. Combining the summarize and render operators provides the foundation for advanced visualizations, including time bucketing and time slicing.

>[!TIP]
>You can test the following KQL query examples in the [LA Demo site](https://ms.portal.azure.com/#view/Microsoft_OperationsManagementSuite_Workspace/LogsDemo.ReactView/). If you receive the message "No results found," try changing the time range.

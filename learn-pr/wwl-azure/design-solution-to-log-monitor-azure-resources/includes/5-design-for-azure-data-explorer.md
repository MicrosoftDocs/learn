[Azure Data Explorer](/azure/data-explorer/data-explorer-overview) is a platform for big data that helps you analyze high volumes of data in near real time. Azure Data Explorer comes equipped with features to help you configure an end-to-end solution for ingesting and managing your data, running queries, and generating visualizations.

### Things to know about Azure Data Explorer

Consider these characteristics of Azure Data Explorer that can help enhance your monitoring solution for Tailwind Traders.

- Azure Data Explorer is a fast and highly scalable data exploration service for log and telemetry data.

- Azure Data Explorer helps you handle multiple data streams, so you can collect, store, and analyze your data from all resources.

- Analyze large volumes of diverse data from any data source, such as websites, applications, IoT devices, and more.

- Use Azure Data Explorer for diagnostics, monitoring, reporting, machine learning, and other analytics tasks.

### Things to consider when using Azure Data Explorer

The following diagram shows a hybrid end-to-end monitoring solution integrated with Microsoft Sentinel and Azure Monitor. This configuration ingests streamed and batched logs from multiple sources, on-premises, or any cloud within an enterprise ecosystem. Consider how this solution could be implemented in the Tailwind Traders architecture to monitor various logs. 

:::image type="content" source="../media/azure-data-explorer.png" alt-text="Diagram of an end-to-end monitoring solution integrated with Azure Monitor for ingesting streamed and batched logs from diverse sources." lightbox="../media/azure-data-explorer-expanded.png" border="false":::

- **Consider native capabilities in Azure Monitor**. Implement the native capabilities of Azure Monitor to monitor Tailwind Traders IT assets, run and monitor tasks from the dashboard, and set up alerts to ingest logs from VMs and services.

- **Consider features of Microsoft Sentinel**. Combine features provided by Microsoft Sentinel and Azure Monitor with Azure Data Explorer to build a flexible and cost-optimized end-to-end monitoring solution for Tailwind Traders.

- **Consider advantages of Azure Data Explorer**. Take advantage of the flexibility and control offered by Azure Data Explorer for all aspects and types of logs in the following scenarios:

   - Microsoft Sentinel and Azure Monitor SaaS solutions don't offer out-of-the-box support for certain scenarios like application trace logs. You can use Azure Data Explorer to provide monitoring support for all aspects and for all types of logs for Tailwind Traders.
	  
   - Azure Data Explorer provides greater flexibility for building quick and easy near-real-time analytics dashboards, pattern recognition, and [time series analysis](/azure/data-explorer/time-series-analysis). The tool supports granular role-based access control, [anomaly detection and forecasting](/azure/data-explorer/anomaly-detection), and machine learning.
	  
   - Azure Data Explorer is well integrated with ML services, such as Databricks and Azure Machine Learning. You can build models for Tailwind Traders by using other tools and services, and export ML models to Azure Data Explorer for scoring data.

   - Azure Data Explorer supports long data retention in a cost effective manner.
	  
   - Azure Data Explorer, as a unified big data analytics platform, allows you to build advanced analytics scenarios. You can have a centralized Tailwind Traders repository for different types of logs.
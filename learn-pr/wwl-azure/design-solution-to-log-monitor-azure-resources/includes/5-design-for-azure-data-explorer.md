Azure Data Explorer is a fast and highly scalable data exploration service for log and telemetry data. It helps you handle the many data streams emitted by modern software, so you can collect, store, and analyze data. Azure Data Explorer is ideal for analyzing large volumes of diverse data from any data source, such as websites, applications, IoT devices, and more. This data is used for diagnostics, monitoring, reporting, machine learning, and additional analytics capabilities.

Below is an example of a hybrid end-to-end monitoring solution integrated with Azure Sentinel and Azure Monitor for ingesting streamed and batched logs from diverse sources, on-premises, or any cloud within an enterprise ecosystem. This could be a solution used in Tailwind Traders architecture to monitor various logs. 

 

:::image type="content" source="../media/azure-data-explorer.png" alt-text="end-to-end monitoring solution integrated with Azure Monitor for ingesting streamed and batched logs from diverse sources.":::

 

Combine features provided by Microsoft Sentinel and Azure Monitor with Azure Data Explorer to build a flexible and cost-optimized end-to-end monitoring solution. Below are some examples:

- Use Azure Monitor’s native capabilities for IT asset monitoring, dashboarding, and alerting so you can ingest logs from VMs, services, and so on.

- Use Azure Data Explorer for full flexibility and control in all aspects for all types of logs in the following scenarios:

	- No out of the box features provided by Microsoft Sentinel and Azure Monitor SaaS solutions such as application trace logs.

	- Greater flexibility for building quick and easy near-real-time analytics dashboards, granular role-based access control, [time series analysis](/azure/data-explorer/time-series-analysis), pattern recognition, [anomaly detection and forecasting](/azure/data-explorer/anomaly-detection), and [machine learning](/azure/data-explorer/machine-learning-clustering). Azure Data Explorer is also well integrated with ML services such as Databricks and Azure Machine Learning. This integration allows you to build models using other tools and services and export ML models to Azure Data Explorer for scoring data.

	- Longer data retention is required in cost effective manner.

	- Centralized repository is required for different types of logs. Azure Data Explorer, as a unified big data analytics platform, allows you to build advanced analytics scenarios.
Now that you've been introduced to KQL, let's see the different query environments where you can use KQL in Microsoft products.

The environments described in this unit are [Azure Data Explorer](#azure-data-explorer), [Synapse Real-Time Analytics in Microsoft Fabric (Preview)](#synapse-real-time-analytics-in-microsoft-fabric-preview), [Azure Monitor](#azure-monitor), [Microsoft Sentinel](#microsoft-sentinel), [Azure Resource Graph](#azure-resource-graph), [Microsoft 365 Defender](#microsoft-365-defender), and [Configuration Manager](#configuration-manager).

## Azure Data Explorer

Azure Data Explorer is a fully managed, high-performance, big data analytics platform that makes it easy to analyze high volumes of data in near real-time. The Azure Data Explorer toolbox gives you an end-to-end solution for data ingestion, query, visualization, and management.

By analyzing structured, semi-structured, and unstructured data across time series, and by using Machine Learning, Azure Data Explorer makes it simple to extract key insights, spot patterns and trends, and create forecasting models. Azure Data Explorer is scalable, secure, robust, and enterprise-ready, and is useful for log analytics, time series analytics, IoT, and general-purpose exploratory analytics.

:::image type="content" source="../media/7-azure-data-explorer.png" alt-text="Screenshot of query environment in Azure Data Explorer." lightbox="../media/7-azure-data-explorer.png":::

KQL was developed for Azure Data Explorer and can be used in a variety of environments, including the [web UI](/azure/data-explorer/web-ui-query-overview), [Kusto CLI](/azure/data-explorer/kusto/tools/kusto-cli), and the desktop app [Kusto.Explorer](/azure/data-explorer/kusto/tools/kusto-explorer). You can find the full query language documentation set at [KQL overview](/azure/data-explorer/kusto/query/).

For more product information, see [What is Azure Data Explorer?](/azure/data-explorer/data-explorer-overview)

## Synapse Real-Time Analytics in Microsoft Fabric (Preview)

Microsoft Fabric is an all-in-one analytics solution for enterprises that covers everything from data movement to data science, near real-time analytics, and business intelligence. It offers a comprehensive suite of services, including a data lake, data engineering, and data integration, all in one place. Real-Time Analytics is a fully managed big data analytics platform optimized for streaming and time-series data. Real-Time Analytics contains what can be thought of as the SaaS version of Azure Data Explorer. Specifically, you can use KQL in KQL Querysets to run queries, view, and customize query results on data from a KQL Database and save queries for later use, or share with others to collaborate on data exploration. 

:::image type="content" source="../media/7-real-time-analytics.png" alt-text="Screenshot of query in Real-Time Analytics." lightbox="../media/7-real-time-analytics.png":::

For more information, see [Query data in a KQL Queryset](/fabric/real-time-analytics/kusto-query-set). 

For more product information, see [What is Real-Time Analytics in Fabric?](/fabric/real-time-analytics/overview)

## Azure Monitor

Azure Monitor collects, analyzes, and responds to telemetry from your Azure, multicloud, and on-premises environments to help maximize the availability and performance of your applications and services. Azure Monitor correlates data from multiple sources - including metrics, logs, traces, and changes - and provides a set of tools for analyzing, visualizing, and responding to the data, such as insights, alerts, autoscale, and automated artificial intelligence for IT operations (AIOps) capabilities. 

The Log Analytics tool in the Azure portal lets you edit and run log queries against data in the Azure Monitor Logs store.

:::image type="content" source="../media/7-monitor.png" alt-text="Screenshot of the Azure Monitor Log Analytics user interface for running queries." lightbox="../media/7-monitor.png":::

Azure Monitor uses the same KQL as Azure Data Explorer, with some minor differences. For reference, see [Language differences](/azure/azure-monitor/logs/log-query-overview#language-differences).

For more product information, see [Azure Monitor overview](/azure/azure-monitor/overview).

## Microsoft Sentinel

Microsoft Sentinel is a scalable, cloud-native solution that provides security information and event management (SIEM), and security orchestration, automation, and response (SOAR). Many features in Microsoft Sentinel utilize KQL. Proficiency with KQL is particularly valuable though when using Microsoft Sentinel's hunting search-and-query tools to proactively and reactively hunt for security threats across your organization's data sources. For more information, see [Hunt for threats with Microsoft Sentinel](/azure/sentinel/hunting).

:::image type="content" source="../media/7-sentinel.png" alt-text="Screenshot of Microsoft Sentinel threat hunting environment." lightbox="../media/7-sentinel.png":::

But that's just a start. Microsoft Sentinel uses KQL for alerts, workbook visualizations, parsers, and transforming data. Since Microsoft Sentinel is built on top of the Azure Monitor service and uses Azure Monitor's Log Analytics workspaces to store all of its data, Microsoft Sentinel also provides a **Logs** view for direct table queries to find connections in the data. 

For more product information, see [What is Microsoft Sentinel?](/azure/sentinel/overview)

## Azure Resource Graph

Azure Resource Graph is an Azure service designed to extend Azure Resource Management by providing efficient and performant resource exploration with the ability to query at scale across a given set of subscriptions so that you can effectively govern your environment. With Azure Resource Graph, you can access the properties returned by resource providers without needing to make individual calls to each resource provider.

:::image type="content" source="../media/7-resource-graph.png" alt-text="Screenshot of query environment in Azure Resource Graph." lightbox="../media/7-resource-graph.png":::

Azure Resource Graph supports a subset of KQL data types, scalar functions, scalar operators, and aggregation functions. Specific tabular operators are supported by Resource Graph, some of which have different behaviors. This behavior is summarized in [Supported KQL language elements](/azure/governance/resource-graph/concepts/query-language#supported-kql-language-elements).

For more product information, see [What is Azure Resource Graph?](/azure/governance/resource-graph/overview)

## Microsoft 365 Defender

Microsoft 365 Defender is a unified pre- and post-breach enterprise defense suite that natively coordinates detection, prevention, investigation, and response across endpoints, identities, email, and applications to provide integrated protection against sophisticated attacks. While your security operations team receives an alert within the Microsoft 365 Defender portal whenever a malicious or suspicious activity or artifact is detected, it's not enough to respond to attacks as they occur. For extended, multi-phase attacks such as ransomware, you must proactively search for the evidence of an attack in progress and take action to stop it before it completes.

:::image type="content" source="../media/7-defender.png" alt-text="Screenshot of Microsoft 365 Defender threat hunting environment." lightbox="../media/7-defender.png":::

Advanced hunting is a query-based threat hunting tool that lets you explore up to 30 days of raw data. You can proactively inspect events in your network to locate threat indicators and entities. The flexible access to data enables unconstrained hunting for both known and potential threats. For more information, see [Proactively hunt for threats with advanced hunting in Microsoft 365 Defender](/microsoft-365/security/defender/advanced-hunting-overview).

For more product information, see [What is Microsoft 365 Defender?](/microsoft-365/security/defender/microsoft-365-defender)

## Configuration Manager

Configuration Manager is part of the Microsoft Intune family of products, which provides a large centralized store of device data that customers use for reporting purposes.  CMPivot is an in-console utility that provides access to real-time state of devices in your environment.

:::image type="content" source="../media/7-cm-pivot.png" alt-text="Screenshot of query environment in CM Pivot in Configuration Manager." lightbox="../media/7-cm-pivot.png":::

CMPivot uses a subset of the KQL to search terms, identify trends, analyze patterns, and provide many other data-driven insights.  For more information, see [CMPivot queries](/mem/configmgr/core/servers/manage/cmpivot-overview#queries).

For more product information, see [What is Configuration Manager?](/mem/configmgr/core/understand/introduction)

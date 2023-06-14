## Azure Data Explorer

Azure Data Explorer is a fully managed, high-performance, big data analytics platform that makes it easy to analyze high volumes of data in near real time. The Azure Data Explorer toolbox gives you an end-to-end solution for data ingestion, query, visualization, and management.

By analyzing structured, semi-structured, and unstructured data across time series, and by using Machine Learning, Azure Data Explorer makes it simple to extract key insights, spot patterns and trends, and create forecasting models. Azure Data Explorer is scalable, secure, robust, and enterprise-ready, and is useful for log analytics, time series analytics, IoT, and general-purpose exploratory analytics.

:::image type="content" source="../media/7-azure-data-explorer.png" alt-text="Screenshot of query environment in Azure Data Explorer.":::

Kusto Query Language was developed for Azure Data Explorer and can be used in a variety of environments, including the [web UI](/azure/data-explorer/web-ui-query-overview), [Kusto CLI](/azure/data-explorer/kusto/tools/kusto-cli), and the desktop app [Kusto.Explorer](/azure/data-explorer/kusto/tools/kusto-explorer). You can find the full query language documentation set at [KQL overview](/azure/data-explorer/kusto/query/).

## Azure Monitor

Azure Monitor is a comprehensive monitoring solution for collecting, analyzing, and responding to telemetry from your cloud and on-premises environments. Log Analytics is a tool in the Azure portal that's used to edit and run log queries against data in the Azure Monitor Logs store.

:::image type="content" source="../media/7-monitor.png" alt-text="Screenshot of Azure Monitor Log Analytics query workspace." lightbox="../media/7-monitor.png":::

Azure Monitor uses the same KQL as Azure Data Explorer, with some differences. For reference, see [Language differences](/azure/azure-monitor/logs/log-query-overview#language-differences).

<!-- Guy please add information -->

## Microsoft Sentinel

Microsoft Sentinel is a scalable, cloud-native solution that provides security information and event management (SIEM), and security orchestration, automation, and response (SOAR). Using Microsoft Sentinel's  hunting search-and-query tools, based on the MITRE framework, you can proactively hunt for security threats across your organization’s data sources, before an alert is triggered.

:::image type="content" source="../media/7-sentinel.png" alt-text="Screenshot of Microsoft Sentinel threat hunting environment." lightbox="../media/7-sentinel.png":::

Microsoft Sentinel is built on top of the Azure Monitor service and it uses Azure Monitor’s Log Analytics workspaces to store all of its data. For more information, see [Hunt for threats with Microsoft Sentinel](/azure/sentinel/hunting).

## Azure Resource Graph

Azure Resource Graph is an Azure service designed to extend Azure Resource Management by providing efficient and performant resource exploration with the ability to query at scale across a given set of subscriptions so that you can effectively govern your environment. With Azure Resource Graph, you can access the properties returned by resource providers without needing to make individual calls to each resource provider.

:::image type="content" source="../media/7-resource-graph.png" alt-text="Screenshot of query environment in Azure Resource Graph.":::

Azure Resource Graph supports a subset of KQL data types, scalar functions, scalar operators, and aggregation functions. Specific tabular operators are supported by Resource Graph, some of which have different behaviors. This behavior is summarized in [Supported KQL language elements](/azure/governance/resource-graph/concepts/query-language#supported-kql-language-elements).

## Microsoft 365 Defender

Microsoft 365 Defender is a unified pre- and post-breach enterprise defense suite that natively coordinates detection, prevention, investigation, and response across endpoints, identities, email, and applications to provide integrated protection against sophisticated attacks. While your security operations team receives an alert within the Microsoft 365 Defender portal whenever a malicious or suspicious activity or artifact is detected, it's not enough to respond to attacks as they occur. For extended, multi-phase attacks such as ransomware, you must proactively search for the evidence of an attack in progress and take action to stop it before it completes.

:::image type="content" source="../media/7-defender.png" alt-text="Screenshot of Microsoft 365 Defender threat hunting environment." lightbox="../media/7-defender.png":::

Advanced hunting is a query-based threat hunting tool that lets you explore up to 30 days of raw data. You can proactively inspect events in your network to locate threat indicators and entities. The flexible access to data enables unconstrained hunting for both known and potential threats. For more information, see [Proactively hunt for threats with advanced hunting in Microsoft 365 Defender](/microsoft-365/security/defender/advanced-hunting-overview).

## Configuration Manager

Configuration Manager is part of the Microsoft Intune family of products, which provides a large centralized store of device data that customers use for reporting purposes.  CMPivot is an in-console utility that provides access to real-time state of devices in your environment.

:::image type="content" source="../media/7-cm-pivot.png" alt-text="Screenshot of query environment in CM Pivot in Configuration Manager.":::

CMPivot uses a subset of the Kusto Query Language to search terms, identify trends, analyze patterns, and provide many other data-driven insights.  For more information, see [CMPivot queries](/mem/configmgr/core/servers/manage/cmpivot-overview#queries).


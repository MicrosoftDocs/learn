
## Azure Data Explorer

## Azure Monitor

Azure Monitor collects, analyzes, and responds to telemetry from your Azure, multicloud, and on-premises environments to help maximize the availability and performance of your applications and services. Azure Monitor correlates data from multiple sources - including metrics, logs, traces, and changes - and provides a set of tools for analyzing, visualizing, and responding to the data, such as insights, alerts, autoscale, and automated Artificial Intelligence for IT Operations (AIOps) capabilities. 

The Log Analytics tool in the Azure portal lets you edit and run log queries against data in the Azure Monitor Logs store.

:::image type="content" source="../media/7-monitor.png" alt-text="Screenshot of the Azure Monitor Log Analytics user interface for running queries." lightbox="../media/7-monitor.png":::

Azure Monitor uses the same KQL as Azure Data Explorer, with some minor differences. For reference, see [Language differences](/azure/azure-monitor/logs/log-query-overview#language-differences).

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
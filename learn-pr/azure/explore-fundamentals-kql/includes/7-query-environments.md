
## Azure Data Explorer

## Azure Monitor

Azure Monitor is a comprehensive monitoring solution for collecting, analyzing, and responding to telemetry from your cloud and on-premises environments. Log Analytics is a tool in the Azure portal that's used to edit and run log queries against data in the Azure Monitor Logs store.

Azure Monitor uses the same KQL as Azure Data Explorer, with some differences. For reference, see [Language differences](/azure/azure-monitor/logs/log-query-overview#language-differences)
<--! Guy please add information -->

## Microsoft Sentinel

Microsoft Sentinel is a scalable, cloud-native solution that provides security information and event management (SIEM), and security orchestration, automation, and response (SOAR). Using Microsoft Sentinel's  hunting search-and-query tools, based on the MITRE framework, you can proactively hunt for security threats across your organization’s data sources, before an alert is triggered. Microsoft Sentinel is built on top of the Azure Monitor service and it uses Azure Monitor’s Log Analytics workspaces to store all of its data. 

## Azure Resource Graph

Azure Resource Graph is an Azure service designed to extend Azure Resource Management by providing efficient and performant resource exploration with the ability to query at scale across a given set of subscriptions so that you can effectively govern your environment. With Azure Resource Graph, you can access the properties returned by resource providers without needing to make individual calls to each resource provider.

These queries provide the following abilities:

- Query resources with complex filtering, grouping, and sorting by resource properties.
- Explore resources iteratively based on governance requirements.
- Assess the impact of applying policies in a vast cloud environment.
- Query changes made to resource properties (preview).

Azure Resource Graph supports a subset of KQL data types, scalar functions, scalar operators, and aggregation functions. Specific tabular operators are supported by Resource Graph, some of which have different behaviors. This behavior is summarized in [Supported KQL language elements](/azure/governance/resource-graph/concepts/query-language#supported-kql-language-elements).

## Microsoft 365 Defender

Microsoft 365 Defender is a unified pre- and post-breach enterprise defense suite that natively coordinates detection, prevention, investigation, and response across endpoints, identities, email, and applications to provide integrated protection against sophisticated attacks. While your security operations team receives an alert within the Microsoft 365 Defender portal whenever a malicious or suspicious activity or artifact is detected, it's not enough to respond to attacks as they occur. For extended, multi-phase attacks such as ransomware, you must proactively search for the evidence of an attack in progress and take action to stop it before it completes.

Advanced hunting is a query-based threat hunting tool that lets you explore up to 30 days of raw data. You can proactively inspect events in your network to locate threat indicators and entities. The flexible access to data enables unconstrained hunting for both known and potential threats. 
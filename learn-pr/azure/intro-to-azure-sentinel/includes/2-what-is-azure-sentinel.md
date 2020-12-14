Let's start with a few definitions and a look at *security information and event management* (SIEM) systems and Azure Sentinel.

## What is security incident and event management (SIEM)?

A SIEM system is a tool that an organization uses to collect, analyze, and perform security operations on its computer systems. Those systems can be hardware appliances, applications, or both.

In its simplest form, a SIEM system enables you to:

- Collect and query logs.
- Do some form of correlation or anomaly detection.
- Create alerts and incidents based on your findings.

A SIEM system might offer functionality such as:

- **Log management**: The ability to collect, store, and query the log data from resources within your environment.

- **Alerting**: A proactive look inside the log data for potential security incidents and anomalies.

- **Visualization**: Graphs and dashboards that provide visual insights into your log data.

- **Incident management**: The ability to create, update, assign, and investigate incidents that have been identified.

- **Querying data**: A rich query language, similar to that for log management, that you can use to query and understand your data.

## What is Azure Sentinel?

Azure Sentinel is a cloud-native SIEM system that a security operations team can use to:

- Get security insights across the enterprise by collecting data from virtually any source.
- Detect and investigate threats quickly by using built-in machine learning and Microsoft threat intelligence.
- Automate threat responses by using playbooks and by integrating Azure Logic Apps.

Unlike with traditional SIEM solutions, to run Azure Sentinel, you don't need to install any servers either on-premises or in the cloud. Azure Sentinel is a service that you deploy in Azure. You can get up and running with Sentinel in just a few minutes in the Azure portal.

Azure Sentinel is tightly integrated with other cloud services. Not only can you quickly ingest logs, but you can also use other cloud services natively (for example, authorization and automation).

Azure Sentinel helps you enable end-to-end security operations including collection, detection, investigation, and response:

:::image type="content" source="../media/02-end-to-end.svg" alt-text="This diagram shows the end-to-end functionality of Azure Sentinel.":::

Let's take a look at the key components in Azure Sentinel.

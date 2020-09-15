Let's start with a few definitions and a look at *security information and event management* (SIEM) systems and Azure Sentinel.

## What is security incident and event management (SIEM)?

A SIEM is a tool that enables organizations to collect, analyze, and perform security operations on their computer systems, whether those be hardware appliances, applications, or both.

In its simplest form, a SIEM will enable you to collect logs, query them, do some form of correlation or anomaly detection and create alerts and incidents based on findings.

The functionality that a SIEM may offer could include:

- **Log Management**: The ability to collect, store, and query the log data from resources within our environment.

- **Alerting**: Proactively looking within the log data for potential security incidents and Anomalies.

- **Visualization**: Graphs and Dashboards that enable us to gain visual insights into our log data.

- **Incident Management**: Creating, updating, assigning, and investigating incidents that have been identified.

- **Querying Data**: Similar to Log Management, there should be a rich query language to enable us to query and understand our data.

## What is Azure Sentinel?

Azure Sentinel is a cloud-native SIEM that enables the security operations team to:

- Get security insights across the enterprise by collecting data from virtually any source.
- Detect and investigate threats quickly with built-in machine learning and Microsoft threat intelligence.
- Automate threat responses with playbooks and integration of Azure Logic Apps.

Unlike traditional SIEM solutions, you don't need to install any servers either on-premises or in the cloud to run the solution. Azure Sentinel is a service you deploy in Azure. You can get up and running with Sentinel in just a few minutes in the Azure portal.

Azure Sentinel is tightly integrated with other cloud services, enabling you to not only ingest logs at the click of a button, but to leverage other cloud services natively such as authorization and automation.

Azure Sentinel is designed to help you enable end to end security operations including collection, detection, investigation, and response.

:::image type="content" source="../media/02-end-to-end.png" alt-text="Diagram showing the end to end functionality of Azure Sentinel":::

Let's take a look at the key components that make up Azure Sentinel.

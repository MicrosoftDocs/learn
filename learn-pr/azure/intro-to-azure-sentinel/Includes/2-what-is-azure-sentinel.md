Let's start with a few definitions and a look at *security information and event management* (SIEM) systems and Azure Sentinel.

## What is security incident and event management (SIEM)?

A SIEM is a tool that enables organizations to collect, analyze and perform security operations on their computer systems, wether those be hardware appliances, applications, or both.

In it's simplest form, a SIEM will enable you to collect logs, query them, do some form of correlation or anomaly detection and create alerts and incidents based on findings.

The functionality that a SIEM may offer could include:

- **Log Management**: The ability to collect, store and query the log data from resources within our environment.

- **Alerting**: Proactively looking within the log data for potential security incidents and Anomalies.

- **Visualization**: Graphs and Dashboards that enable us to gain visual insights into our log data.

- **Incident Management**: Creating, updating, assigning and investigating incidents that have been identified.

- **Querying Data**: Similar to Log Management, there should be a rich query language to enable us to query and understand our data.

## What is Azure Sentinel?

Azure Sentinel is a cloud-native SIEM solution. This means that, unlike traditional SIEM solutions, you don't need to install any servers either on premises or in the cloud. Azure Sentinel is a service you deploy in Azure. You can get up and running with Sentinel in just a few clicks in the Azure portal.

It also means that Azure Sentinel is tightly integrated with other cloud services, enabling you to not only ingest logs at the click of a button, but to leverage other cloud services natively such as authorization and automation.

For example, Azure Sentinel supports Role Based Access control, so you can give different people in your team different permissions depending on their role.

It is designed to help you enable end to end security operations including collection, detection, investigation and response.

![Diagram showing the end to end functionality of Azure Sentinel](../media/02_end-to-end.png)

Let's take a look at the key components that make up Azure Sentinel.

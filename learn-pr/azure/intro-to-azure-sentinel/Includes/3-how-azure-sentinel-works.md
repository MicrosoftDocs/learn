As you've already learned, Azure Sentinel is designed to help you enable end to end security operations starting from log ingestion, through to automated response to security alerts.

Here are the key features and components of Azure Sentinel.

## Data connectors

The first thing you need to do is get your data ingested into Azure Sentinel. Data connectors enable you to do just that. Some services are able to be added with a simple click of a button, such as Azure activity logs. Others require a little configuration, such as syslog. There are data connectors that cover all scenarios and sources, including, but not limited to syslog, CEF, TAXII (threat intelligence), Azure and AWS services.

![Azure Log Analytics Interface](../media/03_data_connectors.png)

## Log retention

Once your data is within Azure Sentinel, it's stored using Azure Log Analytics. This gives you a number of benefits, including the ability to use the Kusto Query Language (KQL) to query your data. KQL is a rich query language that gives you lots of power to dive into and gain insights from our data.

![Azure Log Analytics Interface](../media/03_log_analytics.png)

## Workbooks

Workbooks enable you to visualize your data within Azure Sentinel. You can think of these as dashboards, each component in the dashboard is built using an underlying Kusto Query Language (KQL) query over your data. You can use a number of built in workbooks within Azure Sentinel, edit them to meet your own needs, or create your own workbooks from scratch. If you've used Azure Monitor workbooks this will be very familiar, as it's Sentinel's implementation of Monitor workbooks.

![Example Workbook](../media/03_workbooks.png)

## Analytics alerts

Now you have your logs, and you have some visualization, it would be great to have some proactive analytics across your data to be notified when something suspicious occurs. There are a number of built in analytics alerts that you can enable within your Sentinel workspace. There are various types of alerts, some of which you can edit to your own needs, others which are built on proprietary Microsoft machine learning models. You can also create custom scheduled alerts from scratch too.

![Built in Analytics Alerts](../media/03_analytics_alerts.png)

## Threat hunting

We won't dive too deep into threat hunting in this module, but if SOC Analysts need to hunt for suspicious activity, there are some built in hunting queries that they can leverage, they can also create their own too. Sentinel also integrates with Azure Notebooks, and provides a number of example notebooks too, for the more advanced hunter who wants to leverage the full power of a programming language to hunt through their data.

![Threat Hunting](../media/03_hunting.png)

## Incidents and investigations

An incident is created when an alert that you've enabled is triggered. You can perform standard incident management in Azure Sentinel such as changing status or assigning them to individuals for investigation. Azure Sentinel also has a investigation functionality which enables you to visually investigate incidents by mapping entities across log data along a timeline.

![Incident Investigation Graph within Azure Sentinel](../media/03_investigate_incidents.png)

## Automation playbooks

Being able to respond to incidents automatically, enables you to automate some of your security operations and make your SOC more productive. Azure Sentinel integrates with Azure Logic Apps, enabling you to create automated workflows in response to events. This could be used to perform Incident Management, enrichment, investigation or remediation. This is often referred to as *security orchestration, automation and  response* (SOAR).

![Example Logic App to remediate a security incident](../media/03_logic_apps.png)

As the SOC Analyst within Contoso, you can now start to see how Azure Sentinel might help you achieve your goals. For example, you could ingest data from your multiple cloud and on premises environments, perform analytics on that data, manage and investigate any incidents that occur, or even automatically respond using playbooks. Giving you an end to end solution for your security operations.

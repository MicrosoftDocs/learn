As you've already learned, Azure Sentinel helps you enable end-to-end security operations. It starts with log ingestion and continues through to automated response to security alerts.

Here are the key features and components of Azure Sentinel.

## Data connectors

The first thing to do is to have your data ingested into Azure Sentinel. Data connectors enable you to do just that. You can add some services, such as Azure activity logs, just by selecting a button. Others, such as syslog, require a little configuration. There are data connectors that cover all scenarios and sources, including but not limited to:

- syslog
- Common Event Format (CEF)
- Trusted Automated eXchange of Indicator Information (TAXII) (for threat intelligence)
- Azure
- AWS services

:::image type="content" source="../media/03-data-connectors.png" alt-text="This screenshot shows a partial list of data connectors in the Azure Sentinel UI in the Azure portal." lightbox="../media/03-data-connectors.png":::

## Log retention

After it's been ingested into Azure Sentinel, your data is stored by using Log Analytics. The benefits of using Log Analytics include the ability to use the Kusto Query Language (KQL) to query your data. KQL is a rich query language that gives you the power to dive into and gain insights from our data.

:::image type="content" source="../media/03-log-analytics.png" alt-text="This screenshot shows the Log Analytics interface in the Azure portal." lightbox="../media/03-log-analytics.png":::

## Workbooks

You use workbooks to visualize your data within Azure Sentinel. Think of workbooks as dashboards. Each component in the dashboard is built by using an underlying KQL query of your data. You can use the built-in workbooks within Azure Sentinel, edit them to meet your own needs, or create your own workbooks from scratch. If you've used Azure Monitor workbooks, this feature will be familiar to you because it's Sentinel's implementation of Monitor workbooks.

:::image type="content" source="../media/03-workbooks.png" alt-text="This screenshot shows an example of a workbook in Azure Sentinel." lightbox="../media/03-workbooks.png":::

## Analytics alerts

So far, you have your logs and some data visualization. Now it would be great to have some proactive analytics across your data, so you're notified when something suspicious occurs. You can enable built-in analytics alerts within your Sentinel workspace. There are various types of alerts, some of which you can edit to your own needs. Other alerts are built on machine-learning models that are proprietary to Microsoft. You can also create custom, scheduled alerts from scratch.

:::image type="content" source="../media/03-analytics-alerts.png" alt-text="This screenshot shows some of the built-in analytics alerts available in an Azure Sentinel workbook." lightbox="../media/03-analytics-alerts.png":::

## Threat hunting

We won't dive deeply into threat hunting in this module. However, if SOC analysts need to hunt for suspicious activity, there are some built-in hunting queries that they can use. Analysts can also create their own queries. Sentinel also integrates with Azure Notebooks. It provides example notebooks for advanced hunters who want to use the full power of a programming language to hunt through their data.

:::image type="content" source="../media/03-hunting.png" alt-text="This screenshot shows the threat-hunting interface in Azure Sentinel." lightbox="../media/03-hunting.png":::

## Incidents and investigations

An incident is created when an alert that you've enabled is triggered. In Azure Sentinel, you can do standard incident management tasks like changing status or assigning incidents to individuals for investigation. Azure Sentinel also has investigation functionality, so you can visually investigate incidents by mapping entities across log data along a timeline.

:::image type="content" source="../media/03-investigate-incidents.png" alt-text="This screenshot shows an incident-investigation graph within Azure Sentinel." lightbox="../media/03-investigate-incidents.png":::

## Automation playbooks

With the ability to respond to incidents automatically, you can automate some of your security operations and make your SOC more productive. Azure Sentinel integrates with Azure Logic Apps, enabling you to create automated workflows, or *playbooks*, in response to events. This functionality could be used for incident management, enrichment, investigation, or remediation. These capabilities are often referred to as *security orchestration, automation, and  response (SOAR)*.

:::image type="content" source="../media/03-logic-apps.png" alt-text="This screenshot shows an example use of Azure Logic Apps to remediate a security incident." lightbox="../media/03-logic-apps.png":::

As the SOC Analyst, you now start to see how Azure Sentinel might help you achieve your goals. For example, you could:

- Ingest data from your cloud and on-premises environments.
- Perform analytics on that data.
- Manage and investigate any incidents that occur.
- Perhaps even respond automatically by using playbooks.

In other words, Azure Sentinel gives you an end-to-end solution for your security operations.

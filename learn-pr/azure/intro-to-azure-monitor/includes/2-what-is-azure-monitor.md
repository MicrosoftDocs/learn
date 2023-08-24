This unit provides an introduction to monitoring and an overview of Azure Monitor capabilities. This overview explains how Azure Monitor can be an important part of your Azure web application deployment.

## Introduction to monitoring

Monitoring tracks the state, health, behavior, and performance of your IT environment. Besides applications, your environment might contain other resources and services, networks, and infrastructure. The goals of monitoring are to ensure that your applications and IT environment operate optimally, securely, and reliably, and to detect and address any issues that arise.

Monitoring includes the following key activities:

- **Data collection** gathers data, such as metrics, logs, and log traces, to provide insights into the functioning and performance of the monitored applications and components.
- **Data analysis** identifies patterns, trends, anomalies, and deviations from normal behavior, to understand current state and predict potential issues.
- **Alerting** sets up alerts and notifications that trigger when specific conditions are met, such as high CPU usage or low disk space, to notify administrators or relevant teams.
- **Visualization** presents the collected data in a user-friendly visual format to help administrators quickly assess the status of systems and resources.
- **Diagnostics and troubleshooting** analyze collected data to help identify the root causes of problems and make informed decisions to address them.

Nonitoring provides the following important benefits:

- **Performance and cost optimization** identify performance bottlenecks and areas for improving resource utilization, efficiency, and costs. 
- **Reliability and proactive management** take proactive rather than reactive measures to prevent downtime, disruptions, and other problems. When problems occur, monitoring enables quick identification, troubleshooting, and recovery.
- **Capacity planning** analyzes historical usage patterns to help with forecasting, planning, and scaling your infrastructure.
- **Security monitoring** detects and responds to security threats, breaches, and suspicious activities to help maintain your system's security posture.
- **Compliance and governance monitoring** help ensure adherence to standards, regulations, and policies.

## Overview of Azure Monitor

When you run an application built on various services and resources, a key element of monitoring is the ability to correlate your application's performance and health to the services and resources it's built on. This ability, called *observability*, lets you analyze and troubleshoot application issues effectively. Azure Monitor provides features and tools for collecting, managing, and analyzing IT data from all of your Azure, other cloud, and on-premises resources.

The following diagram shows a high-level architectural view of Azure Monitor.

:::image type="content" source="media/overview-simple.svg" alt-text="Diagram that shows an overview of Azure Monitor with data sources on the left sending data to a central data platform and features of Azure Monitor on the right that use the collected data." border="false" lightbox="media/overview-blowout.svg":::

### Data collection and storage

Azure Monitor provides the following capabilities for collecting, storing, and managing monitoring data:

- Native monitoring of your entire Azure deployment.
- Tools for monitoring all layers in your stack, including applications and infrastructure, in and outside of Azure.
- Native integration with the Azure Event Hubs data streaming service.

Azure Monitor offers the following features for flexible data collection, ingestion, and storage:

- Data collection agents and APIs.
- Data transformations during ingestion to let you filter out data you don't need.
- Configurable data retention periods, archiving, and restore options.
- Pricing tier discounts based on data volume.
- A low-cost Basic logs plan for collecting and storing high-volume verbose logs you use for debugging, troubleshooting, and auditing, but not for analytics and alerts.

### Data analysis and response

Azure Monitor offers a broad set of tools and capabilities that help you analyze and gain insights into your monitoring data. You can customize monitoring and responses to your needs. Options include the following features:

- An easy-to-use portal UI that lets you view, filter, and manipulate monitoring data.
- Kusto Query Language (KQL), a powerful query language that's optimized for ad-hoc queries, data exploration, and near-real time analysis of large volumes of data streamed from multiple sources.
- A range of tools for customizing your analysis, visualizations, alerting, and responses.
- Out-of-the-box recommended alerts.
- Ready-to-use monitoring experiences with advanced, built-in analysis and visualizations of your IT deployment.
- Autoscale, which you can use to automatically add and remove resources according to the load on your application.
- Native machine learning and artificial intelligence capabilities that help you detect and respond to anomalies.

## Web application monitoring

To evaluate the performance of your web application, you need monitoring where and when application experiences demand it. For the annual back-to-school campaign, you want to evaluate the impact of user demand on your application performance. Azure Monitor can help you evaluate this aspect of your web app deployment.

As soon as you start adding resources such as web apps to an Azure subscription, Azure Monitor starts collecting data. Azure activity logs record when resources are created or modified. You can use the activity log information to trace the history of the resource creation and modifications.

### Performance metrics

Azure Monitor Metrics tell you how your application is performing, and any other resources that it's consuming. A list of resource-specific metrics is automatically available for each resource type in your subscription. To see resource metrics in the Azure portal, select **Metrics** under **Monitoring** in the left navigation for your application or other resource, and then select the metric you need from the **Metric** dropdown.

The following metrics chart shows the **Requests** metric for a web application. The chart displays the sum aggregation of requests for the web app in a line chart.

:::image type="content" source="../media/web-app-metrics.png" alt-text="Screenshot of the Monitoring option selected in the Azure portal for a web app, showing chart of requests for the web app.":::

The next unit tells you more about Azure Monitor Metrics.

### Other monitoring options

Interactive monitoring is one way to monitor your application. Another option is to configure alerts to send a text message or email to a person or team for further investigation. You can also configure the alert to trigger an action in response to certain situations.

Azure Monitor workbooks provide a flexible canvas for analyzing data and creating rich visual reports in the Azure portal. Workbooks let you tap into multiple Azure data sources and combine them into unified interactive experiences. You can use the workbooks that Azure provides, or create your own workbooks from predefined templates.

The following image shows three types of workbooks that display logged data in different chart and table formats.

:::image type="content" source="../media/workbooks.png" alt-text="Screenshots of three workbooks displaying logged data in various chart and table formats.":::

You can add visualizations you create in Azure Monitor to Azure dashboards, which let you combine different kinds of data into a single pane in the Azure portal.

:::image type="content" source="../media/dashboard.png" alt-text="Screenshot of an Azure dashboard displaying metrics in graph format for application performance metrics on the left and security incidents on the right.":::

Unit 4 has more information about Azure Monitor Insights, workbooks, visualizations, and automated actions.

Monitoring is the act of collecting and analyzing data to determine the performance, health, and availability of your business application and the resources that it depends on. What if you ran an operations team responsible for resources running on Azure, what would you do to ensure you had visibility into the health of your systems? If something happens, who finds out first, your team or your end users? An effective monitoring strategy helps you focus on the health of your application. It also helps you increase your uptime by proactively notifying you of critical issues so that you can resolve them before they become problems. 

When it comes to monitoring and analytics on Azure, we can bundle services into three specific areas of focus: deep application monitoring, deep infrastructure monitoring, and core monitoring. In this unit, we'll take a look through each of these bundles, and how Azure services enable these capabilities for your architecture. Even though we've grouped these services together, there are several integration points between them, allowing for sharing of important monitoring data points between them.

![Monitoring overview](../media/3-use-monitoring-and-analytics-to-gain-operational-insights/monitoring-products-overview.png)

## Core monitoring

Core monitoring provides fundamental, required monitoring across Azure resources. When we talk about fundamental monitoring, you can think of this as monitoring what is happening with your resources at the Azure fabric level. This area of focus gives you insight into things like the health of the Azure platform, insight into changes being made to your resources, and performance metrics.

Familiarizing yourself with the core monitoring components will ensure you have the required knowledge to run your workloads on Azure with confidence. Each of the core monitoring components: Activity Log, Service Health, Azure Monitor, and Azure Advisor will be briefly explained here but we recommend trying them out yourself.

The **Activity log** is the place where you'd look to get more information on what is happening with your resources at the Azure fabric level. Consider some of the following examples: Who has added a disk to this virtual machine? When was this machine shutdown? Who has changed the load balancer configuration? Why did the autoscale operation on my virtual machine scale set failed. Answering these questions will allow you to learn a great deal of what and why something is happening. The information Activity log provides might come in handy when performing root cause analysis for a certain issue. The knowledge gained from the Activity Log can be used to update operational procedures or configuration so that the issue can be avoided in the future. One important limitation about the activity log is that data is only stored for 90 days. If you're interested, or have a requirement to store these events longer, you can decide to archive them on a storage account or send them to Log Analytics.

In some occasions, you might be investigating an issue with a resource and the activity log isn't showing any indication explaining your issue. Maybe there's an Azure platform issue going on, resulting in your resource to be unavailable or
malfunctioning. The Azure portal informs you of the health of its services through the **Service Health** component. The Service Health component will provide information, and if you configure them, alerts, when a service that you are using is impacted.

Both the Activity Log and Service Health are great to have in your tool belt. But they might not explain all issues you're seeing. What if there are complaints for a virtual machine and its performance? Why is Application Gateway blocking a request to a web page. Is the storage account transaction count being throttled? Unlike traditional on-premises services, Azure services have a common way of showing health, metric or diagnostic information. **Azure Monitor** is a standard approach all services use to show metrics from the platform to you. This information can be used for all kinds of purposes such as right-sizing, root cause analysis or just monitoring. Azure Monitor makes it easy to look at the metrics. In the next section, we'll cover Log Analytics as part of deep infrastructure monitoring and you'll learn how all the information Azure monitor provides can be further analyzed using Log Analytics advanced capabilities.

When we think of monitoring typically, we think of the health of a resource. But even when a resource is healthy, monitoring might inform you of changes that will result in a better availability, reduced cost or avoid security issues. Commonly when a solution is deployed all of these items are accounted for. For example, every virtual machine is deployed on a subnet with a network security group attached to it. Or virtual machines are placed in availability sets to ensure high availability. The challenge organizations are facing is that deployed solutions aren't static. They are continuously evolving which opens the door for issues to sneak in. **Azure Advisor** can help by keeping an eye out for potential performance, high availability, or security issues introduced by one of these changes. Azure Advisor requires little to no configuration and is free to use. A typical example where Azure Advisor can alert you: someone has created a new virtual machine but has forgotten to configure backup.

## Deep infrastructure monitoring

While the monitoring components we covered are great at offering insights, they only provide insights from the Azure fabric point of view. For typical IaaS workloads, there's more metrics and diagnostic information to gather from the network or the actual operating systems. For example is SQL Server running on a Windows VM configured as per best practices? How is the free disk space looking across all servers? Can all subnets be reached and over what latency? These are common examples where **Log Analytics** could be a solution.

There's some overlap with what Azure monitor can display and Log Analytics can gather. But Log Analytics supports more sources, even on-premises sources, and comes with a query language and analytics engine.

When designing a monitoring approach for a given workload, it's important to include every component in the application chain. Each component of the workload might have different requirements or options to integrate with a monitoring solution. Understanding the various data collection methods Log Analytics supports is a good start. Services supporting Azure Monitor can be easily configured to send their data a Log Analytics workspace. Other systems like virtual machines might come with an agent installed or send their data to a storage account, which then can be read by Log Analytics. As you can see there's quite a variety of options and in most cases, there should be a way to get your data into Log Analytics. The image below provides an overview of these options.

![Collecting Data](../media/3-use-monitoring-and-analytics-to-gain-operational-insights/collecting-data.png)

Once the data is uploaded to the Log Analytics workspace, you'll want to choose what kind of retention you want to apply to the data. The retention is important as it will allow you to go back one month or several months depending on the choice you made. The situation where you are analyzing an issue, or the history of an issue, and lack access to the required data because it's purged, is something you'd rather want to avoid.

Log Analytics allows you to query the raw data and let you apply your knowledge of the data to visualize what you think is important. For a lot of well known services, there are management solutions readily available that visualize the most important aspects on a dashboard. These solutions can give you a jump start and makes monitoring those components a breeze. Sometimes these solutions focus on grouping and visualize the data, but there are various solutions such as those for monitoring Active Directory or SQL Server that warn you when certain best practices aren't followed which could put your infrastructure at risk. You're free to use these dashboards as is or you could steal whatever information you want on your dashboards. Maybe you want to set up different dashboards across the same data for different teams.

Log Analytics allows you to create queries and interact with other systems based on those queries. The most common example is an alert. Maybe you want to receive an email when a system runs out of disk space or a best practice on SQL server is no longer followed. As you can see on the previous image, alerts is one example of the interactions Log Analytics supports. These interactions can range to contacting someone of the on call staff to deploying a Resource Manager template that will automatically add another system to a cluster.

Below is a screenshot of an Azure SQL analytics solution. This is a nice example of Log Analytics gathering various metrics and visualizing them on a dashboard. In this example the Azure SQL is a PaaS service that interacts nicely with the Log Analytics service.

![Azure SQL Overview](../media/3-use-monitoring-and-analytics-to-gain-operational-insights/azure-sql-sol-overview.png)

## Deep application monitoring

Detecting and diagnosing issues for web applications might benefit from being closer to the actual application than what you can get from the operating system level monitoring. [Application Insights](https://docs.microsoft.com/en-us/azure/application-insights/) allows you to do exactly that. Application Insights uses a similar platform as Log Analytics, so it comes with query and visualization capabilities. The strength of Application Insights is that it requires little to no changes to your code but still offers you detailed information.

This solution is not limited to .NET, other platforms such as Node.js or Java can also benefit from Application Insights. While knowing when your application is unavailable, is important, there's so much more to know. For instance, what is the impact of deploying a new version of your application? How is the platform handling the load of the additional visitors in a peak period? Scaling up your infrastructure, be it IaaS or PaaS, has a direct impact on your bill. So it's important to only scale up when needed.

Even something as simple as how is the response time of the application might be complex to troubleshoot. Application Insights will uncover all of that complexity and will show you which components in your applications are slowing down your requests. Is it the web server being overloaded? Is it a specific SQL query that's not optimized. Is the API that you're calling performing slower than usual? Without an application performance monitoring solution like application insights, you are running blind. Your users might report that things are going slower than normal. But most likely this is based on a feeling and without application insights you don't have a baseline to compare with. Here's an extract of a graph showing the response time over the past few hours.

![Application Insights Performance](../media/3-use-monitoring-and-analytics-to-gain-operational-insights/05-perfmetrics.png)

Application performance monitoring through Application Insights allows you to see the impact on the performance or stability when you release a new version. This information will tell you whether you need to scale up or if there are issues that require a resolution. Using smart detection, application insights will inform you that a certain number of users are encountering more failures than normally seen. This will allow you to detect issues before users start calling them in.

Application insights will help you monitor both performance and availability allowing you to respond to failure, even partial failure a lot quicker. Here's an example of an test showing the availability. When a new version is released this can be used to determine if there's something abnormal.

![Application Insights Availability](../media/3-use-monitoring-and-analytics-to-gain-operational-insights/04-webtests.png)

## Shared capabilities

The core and deep monitoring services share functionality which provides alerting, dashboards, and Metrics Explorer.

Azure alerts proactively notify you of critical conditions and potentially take corrective action. Alert rules can use data from multiple sources, including metrics and logs. They use action groups, which contain unique sets of recipients and actions in response to an alert. Based on your requirements, you can have alerts start external actions by using webhooks and integrate with your ITSM tools.

You can use Azure dashboards to combine different kinds of data into a single pane in the Azure portal. You can then share the dashboard with other Azure users. For example, you can create a dashboard that combines:

- Tiles that show a graph of metrics
- A table of activity logs
- A usage chart from Application Insights
- The output of a log search in Log Analytics

You can also export Log Analytics data to Power BI. There, you can take advantage of additional visualizations. You can also make the data available to others within and outside your organization.

Metrics are numerical values generated by an Azure resource to help you understand the operation and performance of the resource. By using Metrics Explorer, you can send metrics to Log Analytics for analysis with data from other sources.

## Monitoring at Lamna Healthcare

Lamna Healthcare is...

## Summary

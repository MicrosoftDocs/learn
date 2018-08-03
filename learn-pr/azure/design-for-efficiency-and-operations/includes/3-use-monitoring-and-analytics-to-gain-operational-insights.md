# Use monitoring and analytics to gain operational insights

Monitoring is often overlooked and given less priority than for instance high availability. Which at first hand might look more importantly than monitoring. But this assumption is wrong! Without the presence of any monitoring solution it's impossible to know when one the components ensuring the workload is high available is failing. Once a part failed an additional failure might cause the whole application to become unavailable. So the lack of monitoring completely might negate all the investments in high availability.

There are various depths of monitoring that can be applied. The diagram below provides an overview of some of the Azure monitoring capabilities as well as how we can group them together.

![Monitoring overview](../media/3-use-monitoring-and-analytics-to-gain-operational-insights/monitoring-products-overview.png)

## Core Monitoring

The various solutions we group under core monitoring all provide fundamental capabilities which are very close to the actual resource rather than the workload or application as a whole. They offer you more insights on how your resources are performing while showing that from an Azure platform point of view.

For instance if you want to determine who has changed the configuration of a certain resource, who has shutdown a specific virtual machine or why an autoscale operation has failed you could be looking in the Activity Log. This might be a great asset when performing root cause analysis which in turn can result in operational procedures to be changed avoiding the issue in the future. One important limitation about the activity log is that data is only stored for 90 days. If you're interested or have a requirement to store these events longer you can decide to archive them on a storage account or send them to Log Analytics.

There might be occasions where an issue on the Azure platform for a given service has a potential impact on your resources. In order to avoid you are verifying everything that's within your control and potentially losing a lot of time Azure informs you of the health of it's services through the Service Health component. Service Health provides alerts when a service that you are using is potentially impacted.

A lot of the services Azure provides are part of the platform. Unlike traditional on-premises services they don't each have an own system on how they provide health, metric or diagnostic information. The way Azure handle is this is through the use of Azure Monitor which is a standard approach all services leverage to expose data from the platform to you. This information can be used for all kinds of purposes such as right-sizing, root cause analysis or just operational monitoring. When covering deep infrastructure monitoring we'll cover Log Analytics and you'll see how all the information Azure monitor provides of each individual service can be combined and leveraged in Log Analytics.

When operating and maintaining a workload on Azure it might be a good idea to keep an eye out for possible optimizations or things that might have been discussed but missed at implementation time. Maybe a virtual machine a virtual machine was deployed later and backup was not configured. Potentially a virtual machine required quite a bit of performance initially but due to a shifting focus that virtual machine is now oversized.

Infrastructure is typically continuously evolving. The needs of the end users change and so components or added or removed. Azure Advisor can help by keeping an eye out for potential performance, high availability or security issues introduced by one of this changes. Azure Advisor requires little to no configuration and is free to use!

## Deep infrastructure Monitoring

Azure monitor can provide quite a bit of detailed information concerning the workload, but it doesn't have all the information. There's some overlap as to the information Azure monitor can expose and Log Analytics can gather but Log Analytics supports more sources, even on-premises sources, as wel as it comes with a query language and analytics engine.

When designing monitoring for a given workload it's important to include every dependency (component) in the application chain. Every component making up the workload might have different requirements or capabilities to integrate with a monitoring solution. Understanding the various data collection methods log analytics supports is a good start. Services supporting Azure Monitor can be easily configured to send their data a log analytics workspace. Other systems like virtual machines might support an agent being installed in the guest operating system or send their data to a storage account which then can be read by log analytics. As you can see there's quite a variety of capabilities and in most cases there should be a way to get your data into log analytics.

![Collecting Data](../media/3-use-monitoring-and-analytics-to-gain-operational-insights/collecting-data.png)

Once the data is available in the log analytics workspace you can start by defining what kind of retention you want to apply to the data. This is important as this will allow you to go back one month or several months depending on the choice you made. Having to come to a point where you are analyzing an issue or the history of an issue and not having access to the required data because it's purged is something you'd rather want to avoid.

Log analytics allows you to query the raw data and let you apply your knowledge of the data to visualize what you think is important. However for a lot of well known services there are management solutions readily available that visualize the most important aspects of a certain data set on a dashboard. This can give you a jump start and makes monitoring those components a breeze. Sometimes these solutions merely group and visualize the data but there are various solutions such as those for monitoring Active Directory or SQL Server that warn you when certain best practices aren't followed which could put your infrastructure at risk. You're free to use these dashboards as is or you could steal whatever information you want or your dashboards. Maybe you want to set up different dashboards across the same data for different teams.

Log analytics allows you to create queries and create alerts on top of those. As you can see on the previous image alerts is way to narrow to describe what systems log analytics can interact with based on the data that triggers that interaction. This kind of interactions can range to contacting someone of the on call staff to running an ARM template that will automatically add another system to a farm.

![Azure SQL Overview](../media/3-use-monitoring-and-analytics-to-gain-operational-insights/azure-sql-sol-overview.png)

# Deep application monitoring

For web applications detecting and diagnosing issues might require you to go deeper or closer to the actual application than what you can get from the operating system level monitoring. [Application Insights](https://docs.microsoft.com/en-us/azure/application-insights/) allows you to do exactly that. Application Insights uses a similar platform as Log Analytics so it comes with query and visualization capabilities. The strength of a solution like Application Insights is that it requires little to no changes to your code but still offers you a wealth of information.

This solution is not limited to .NET, other platforms such as Node.js or Java can also benefit from Application Insights. By having application performance monitoring you can see the impact on the performance when you change your application. This allows you to make well grounded sizing decision. Using smart detection application insights will inform you that a certain amount of users are encountering failures which is higher than normal. THis will allow you to detect issues before users start calling them in.

![Application Insights Availability](../media/3-use-monitoring-and-analytics-to-gain-operational-insights/04-webtests.png)

Application insights will help you monitor both performance and availability allowing you to respond to failure, even partial failure a lot quicker.

![Application Insights Performance](../media/3-use-monitoring-and-analytics-to-gain-operational-insights/05-perfmetrics.png)

In today's fast-paced, digital world, your users expect more from your applications. You want them to have a great experience and not be affected by performance issues. How do you identify potential performance bottlenecks in your architecture?

In this unit, you'll look at processes and tools that can help you make sure that your application performs well. They also can help you discover the cause if your application doesn't perform well.

## Performance requirements

Before we talk about performance, it's important to talk about requirements. In theory, you could keep improving scalability and performance further and further without end. At some point, though, more improvement is prohibitively expensive, difficult, and doesn't have enough business impact to be worthwhile.

*Nonfunctional requirements* help you find that point. These particular requirements don't tell you what your app must *do*. Instead, they tell you what quality levels it must meet. For example, you can define nonfunctional requirements to discover:

- How fast a transaction must return under a given load.
- How many simultaneous connections your application needs to support before it begins to return errors.
- If there's server failure, what's the maximum amount of time your application is allowed to be down before a backup is online.

Defining these requirements in advance of building your solution is critical. They ensure that your application meets expectations but doesn't require more effort or cost more money than necessary. You can also plan your monitoring and operations rules around these nonfunctional requirements.

You should discuss requirements with your stakeholders or customers, document them, and communicate them broadly to ensure that everyone agrees on what good performance means.

In the following section, let's look at some ways to track performance in your applications.

## Performance monitoring options in Azure

Monitoring is the act of collecting and analyzing data to determine the performance, health, and availability of your business application and associated resources.

You want to be kept informed that your applications are running smoothly. Proactive notifications can be used to inform about critical issues that arise. There are many layers of monitoring to consider. Let's focus on the infrastructure layer and the application layer.

### Azure Monitor

Azure Monitor provides a single management point for infrastructure-level logs and monitoring for most of your Azure services. Azure Monitor maximizes the availability and performance of your applications by delivering a comprehensive solution for collecting, analyzing, and acting on telemetry from your cloud and on-premises environments.

The following diagram depicts a high-level view of Azure Monitor. At the center of the diagram are the data stores for metrics and logs. These are the two fundamental types of data that Azure Monitor uses. On the left side are the sources of monitoring data that populate these data stores. On the right side are the different functions that Azure Monitor performs with this collected data, such as analysis, alerting, and streaming to external systems.

![Diagram that depicts a high-level view of Azure Monitor.](../media/5-azure-monitor.png)

Azure Monitor can collect data from a variety of sources. You can think of monitoring data for your applications as occurring in tiers that range from your application to any OS and the services it relies on to the platform itself. Azure Monitor collects data from each of the following tiers:

- **Application monitoring data**: Data about the performance and functionality of the code you've written, regardless of its platform.
- **Guest OS monitoring data**: Data about the OS on which your application is running. This OS might be in Azure, another cloud, or on-premises.
- **Azure resource monitoring data**: Data about the operation of an Azure resource.
- **Azure subscription monitoring data**: Data about the operation and management of an Azure subscription, and data about the health and operation of Azure itself.
- **Azure tenant monitoring data**: Data about the operation of tenant-level Azure services, such as Azure Active Directory (Azure AD).

As soon as you create an Azure subscription and start adding resources, such as VMs and web apps, Azure Monitor starts collecting data. Activity logs record when resources are created or modified. Metrics tell you how the resource is performing and the resources that it's consuming. You can also extend the data you collect. You can enable diagnostics in your apps and add agents to collect telemetry data from Linux and Windows or Application Insights.

Azure Monitor is the place to start for all your resource metric insights gathered in near real time. Many Azure resources start outputting metrics automatically after they're deployed. For example, web apps built with the Web Apps feature of Azure App Service output compute and application request metrics. Metrics from Application Insights are also collated here in addition to VM host diagnostic metrics. VM guest diagnostic metrics also appear after you opt in.

### Log Analytics

Centralized logging can help you uncover hidden issues that might be difficult to track down. With Log Analytics, you can query and aggregate data across logs. This cross-source correlation can help you identify issues or performance problems that might not be evident when you look at logs or metrics individually. The following illustration shows how Log Analytics acts as a central hub for monitoring data. Log Analytics receives monitoring data from your Azure resources and makes it available to consumers for analysis or visualization.

![An illustration showing the role of Log Analytics in resource monitoring.](../media/5-log-analytics.png)

You can collate a wide range of data sources, security logs, Azure activity logs, and server, network, and application logs. You can also push on-premises System Center Operations Manager data to Log Analytics in hybrid deployment scenarios. Then Azure SQL Database can send diagnostic information directly into Log Analytics for detailed performance monitoring.

Centralized logging can be highly beneficial for troubleshooting all types of scenarios. You can use it to troubleshoot performance issues. Centralized logging is a key part of a good monitoring strategy for any architecture.

## Application performance management

Deep application issues are often tricky to track down. This type of scenario is when it can be beneficial to integrate telemetry into your application by using an application performance management (APM) solution. An APM solution helps you to track down low-level application performance and behavior. Telemetry can include individual page request times, exceptions within your application, and even custom metrics to track business logic. This telemetry can provide a wealth of insight into what's going on within your application.

Application Insights is an Azure service that provides this deep application performance management. You install a small instrumentation package in your application and then set up an Application Insights resource in the Azure portal. The instrumentation monitors your app and sends telemetry data to the portal.

You can use Application Insights to consume telemetry from the host environments, such as performance counters, Azure diagnostics, and Docker logs. You can also set up web tests that periodically send synthetic requests to your web service. You could even configure your application to send custom events and metrics that you write yourself in the client or server code. For example, you can track application-specific events such as items sold or games won.

Application Insights stores its data in a common repository, and metrics are shared with Azure Monitor. Application Insights can also take advantage of shared functionality such as alerts, dashboards, and deep analysis with the Log Analytics query language.

A common pattern used to determine the availability of a web application is the health endpoint monitoring pattern. This pattern is used to monitor web applications and their associated back-end services to ensure that they're available and performing correctly. The pattern is implemented by querying a particular URI. The endpoint checks on the status of many components. Even the back-end services that the app depends on are checked instead of only the availability of the front end itself. The health endpoint monitoring pattern acts as a service-level health check that returns an indication of the overall health of the service.

You should use an APM solution such as Application Insights to gain a deep understanding of your application and to correlate activity across your application. An APM solution can help you understand how a specific action works in the client browser, on the server, and through to downstream services. It also provides insight into trends. An APM solution provides notifications when there's a problem, helps to identify where the problem is, and informs you on how to fix it before your users are aware of it.

# Identify performance bottlenecks in your application

## Motivation

End users are expecting more from their applications. They want to have a great user experience and not be impacted by performance issues. Throughout this unit, we will understand how Lamna Healthcare has defined their requirements utilized DevOps to improve their application performance. We will also discuss Azure Monitor, Azure Logic Analytics, and Azure Application Insights and how they can help provide a great user experience by identifying performance bottlenecks.

## Importance of requirements

Before we talk about performance bottlenecks, it's important to talk about requirements. When we design a solution for a business purpose, there's an expectation for some level of service to be provided. That might be the Service Level Availability (SLA) or the number of expected users (both concurrently and overtime).

Defining these requirements in advance of building your solution is critical. Those requirements enable you to clearly architect the solution to meet certain non-functional requirements, and plan associated monitoring and operations rules.

 It is important that you identify bottlenecks in the context of an application's non-functional requirements, and what the expectation is from the business or our end users.

## DevOps and application performance

DevOps is the union of people, process, and products to enable continuous delivery of value to our end users.

The idea behind DevOps is that we do not have silos in our organization of infrastructure and development. We are collectively working together to build solutions for our users where they have a great user experience. To ensure they have that great user experience, we need to make sure we're building something that is in line with our requirements. We also want to make sure we have some way of measuring (or monitoring) how we are performing against those requirements.

The planning, development, testing, and monitoring is carried out in an iterative approach. Performance and quality of our application then become a part of our ongoing software development life cycle, rather than an after thought as we think about deploying into a live environment.

![DevOps Cycle](devops-cycle.png)

This approach aligns with a DevOps concept called "shifting left". In other words, you want to bring your quality control checks earlier into your deployment and release process, so that you are catching any issues that may impact the end-user experience. As we are operating in a continuous cycle, we limit the amount of manual interaction and automate as much as possible.

* This could be writing unit tests to ensure that specific units of code work as expected
* This could be integration tests to ensure that those units of code work together with other units and produce a desired output
* This could be creating performance or load tests to ensure the application meets those non-functional requirements prior to a deployment into production

The point here is that you are taking every opportunity to find issues as early on (left) in the development cycle as possible and to avoid impacting your end-users experience in a live environment.

Let's think about performance and load testing for a moment. We want to ensure that our application performs as expected and are limiting any performance bottlenecks. As part of each iteration in our development effort, we could be introducing new regressions or bugs.

Wouldn't it  make sense if we could carry out some performance and load tests in an environment that is exactly representative of production? That is one of the benefits of the cloud. As part of this pipeline, you can automate the creation of such an environment, run those tests, destroy the environment to save on costs, and have the reassurance that your application will scale to our requirements (making sure we check for any anticipated growth of the platform as well!)

Application performance monitoring becomes a core part of this mindset. If we are running performance and load tests on our application, then we want to understand what aspects of our application are struggling. We will discuss monitoring options further in the next section.

Before moving on, it's worth noting that DevOps is a subject that could have its own set of modules in its own right. We have only scratched the surface in the context of performance bottlenecks. You can find out more information about [DevOps and Microsoft][devops-and-microsoft].

## Monitoring options in Azure

Monitoring is the act of collecting and analyzing data to determine the performance, health, and availability of your business application and the resources that it depends on.

When we think about monitoring, we are concerned with the ways in which we can be informed that our application is performing as we would expect it to. In particular, that we can be kept notified, even proactively, about critical issues that arise. There are numerous layers of monitoring to consider, primarily the infrastructure layer and the application layer.

### Azure Monitor

Azure Monitor enables core monitoring for Azure services by allowing the collection of metrics, activity logs, and diagnostic logs. For example, the activity log tells you when new resources are created or modified. It could be considered our primary single pane of glass for our monitoring needs in Azure. Azure monitor provides us with a range of capabilities including:

* [Azure alerts][azure-alerts] to proactively notify or take action of any breaches to metrics or activities arising
* Use [Azure Dashboards][azure-dashboards] to combine multiple monitoring sources into one view for our application

Azure Monitor is the place to start for all your [near real time resource metric insights][az-mon-metrics]. Many Azure resources will start outputting metrics automatically once deployed into your subscription, for example [Azure Web App instances][az-mon-webapp-metrics] will output compute and application request metrics. Application Insights metrics, including multi-deimensional metrics, are also collated here in addition to VM host diagnostic metrics. [VM guest diagnostic metrics will also appear once you opt-in.][az-mon-vm-guest-metrics]

### Log Analytics

From an Infrastructure monitoring perspective, we may want to consider using Log Analytics. [Log Analytics][log-analytics] plays a central role in Azure monitoring by collecting data from a variety of resources (including non-Microsoft tools) into a single repository. There, you can analyze the data by using a [query language][log-analytics-query-language].

You just need to create a workspace to enable collection. You can then install agents on virtual machines to include them in the workspace and enable management solutions that include logic to provide additional insights into different applications.

![Log Analytics Sources](log-analytics.png)

Using Log Analytics you can collate a wide range of data sources, including Security Logs, Azure Activity Logs, Server, network and Application logs. [You can also push On-premises SCOM data to Log Analytics in hybrid deployment scenarios.][scom-to-la]

## Application Insights

Application Insights is a service to help with your monitoring needs. Application Insights focuses on application performance Monitoring, rather than infrastructure monitoring. You can use Azure Application Insights to monitor availability, performance, and usage of your web applications on multiple platforms.

You install a small instrumentation package in your application, and set up an Application Insights resource in the Microsoft Azure portal. The instrumentation monitors your app and sends telemetry data to the portal.

In addition, you can pull in telemetry from the host environments such as performance counters, Azure diagnostics, or Docker logs. You can also set up web tests that periodically send synthetic requests to your web service. You could even configure your application to send custom events and metrics that you write yourself in the client or server code. This could track business / application-specific events such as items sold or games won.

Application Insights stores its data in a common repository and Metrics are shared with Azure Monitor. It can take advantage of shared functionality such as alerts, dashboards, and deep analysis with the Log Analytics query language.

A common pattern used in determining the availability of a web application is the [health endpoint monitoring pattern][health-endpoint-monitoring-pattern]. This pattern is used to monitor web applications and associated back-end services, to ensure they're available and performing correctly.

The pattern is implemented by querying a particular endpoint that has been implemented. THe endpoint checks on the status of multiple components (that is, those backend services that the app depends on) rather than just the availability of the front end itself. This then allows a solution level health check on the solution  and returns an indication of its status.

Use Application Insights to gain a deep understanding of your application and correlate activity from different areas of your application. Understand how a specific action perfroms in the client browser, on the server and through to any dependent call to downstream services or database. Use Application Insights for trend analysis and proactive monitoring, understand that there's a problem, where it is and how to fix it, before your application/web site users are aware. [Use the profiling features][ai-profiler] available in Azure Web Apps to understand the hotpath in your code and use [Visual Studio & Application Insights Snap Debugging][ai-snap] to debug live deployed code!

### Lamna Healthcare Example

Lamna Healthcare has implemented a web-based patient booking system using Virtual Machines and Azure SQL DB across multiple Azure regions. They decide to use the VM Agent and Log Analytics to monitor the performance of the underlying front-end virtual machines.

They use Azure Monitor to understand the performance of their Azure SQL Databases and capture key performance metrics including CPU % and deadlocks.

They have also configured Application Insights to capture availability and telemetry information. They have coded custom events in their application to be sent to application insights when a new booking is made in addition to a number of business-related events.

There are further examples of how [application performance monitoring][application-performance-monitoring] helped identify issue with a hotfix that they had deployed.

<!-- links -->
[ai-snap]:https://docs.microsoft.com/en-us/azure/application-insights/app-insights-snapshot-debugger
[ai-profiler]:https://docs.microsoft.com/en-us/azure/application-insights/app-insights-profiler
[scom-to-la]:https://docs.microsoft.com/en-us/azure/log-analytics/log-analytics-om-agents
[az-mon-vm-guest-metrics]:https://docs.microsoft.com/en-us/azure/virtual-machines/windows/monitor#diagnostics-and-metrics
[az-mon-metrics]:https://docs.microsoft.com/en-us/azure/monitoring-and-diagnostics/insights-how-to-customize-monitoring
[az-mon-webapp-metrics]:https://docs.microsoft.com/en-us/azure/monitoring-and-diagnostics/monitoring-supported-metrics#microsoftwebsites-excluding-functions
[azure-alerts]: https://docs.microsoft.com/en-us/azure/monitoring-and-diagnostics/monitor-quick-audit-notify-action-in-subscription
[azure-dashboards]: https://docs.microsoft.com/en-us/azure/azure-portal/azure-portal-dashboards
[devops-and-microsoft]: 
https://visualstudio.microsoft.com/devops/
[health-endpoint-monitoring-pattern]: https://docs.microsoft.com/en-us/azure/architecture/patterns/health-endpoint-monitoring
[log-analytics]: https://docs.microsoft.com/en-gb/azure/log-analytics/log-analytics-overview
[log-analytics-query-language]: https://docs.loganalytics.io/docs/Learn/Getting-Started/Getting-started-with-the-Analytics-portal
[log-analytics-management-solutions]: https://docs.microsoft.com/en-gb/azure/monitoring/monitoring-solutions?toc=%2fazure%2flog-analytics%2ftoc.json

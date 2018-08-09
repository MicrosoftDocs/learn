# Identify performance bottlenecks in your application

## Motivation

End users are expecting more from their applications. They want to have a great user experience and not be impacted by performance issues. Throughout this unit, we will understand how Lamna Healthcare has defined their requirements utilized DevOps to improve their application performance. We will discuss Azure Monitor, Azure Logic Analytics, and Azure Application Insights and how they can help you provide a great user experience.

## Importance of requirements

Before we talk about performance bottlenecks, it's important to talk about requirements. When we design a solution for a business purpose, there's an expectation for some level of service to be provided. That requirement might be the Service Level Availability (SLA) or the number of expected users (both concurrently and overtime).

Defining these requirements in advance of building your solution is critical. Those requirements enable you to clearly architect the solution to meet certain non-functional requirements, and plan associated monitoring and operations rules.

## DevOps and application performance

DevOps is the union of people, process, and products to enable continuous delivery of value to our end users.

The idea behind DevOps is that we don't have development and infrastructure silos in our organization. Instead, they collectively work together to build great user experiences. To ensure that users enjoy the application, we need to make sure we're building something that matches our requirements. We also need to make sure we have some way of monitoring how we perform against those requirements.

The planning, development, testing, and monitoring is carried out in an iterative approach. Performance and quality of our application become a part of our software development life cycle, rather than an after thought as we deploy into a live environment.

![DevOps Cycle](devops-cycle.png)

This approach aligns with a DevOps concept called "shifting left". In other words, bring your quality control checks earlier into your deployment and release process. This allows you to catch end-user impacting issues earlier in the process. As we operate in a continuous cycle, we limit the amount of manual interaction and automate as much as possible.

* Write unit tests to prove that specific units of code work as expected
* Build integration tests to check that those units of code work together with other units and produce a desired output
* Carry out performance or load tests to validate the application meets those non-functional requirements prior to a deployment into production

We want our application to perform as expected and limit live performance bottlenecks. Though, we may inadvertently add regressions or bug in an iteration of our development.

Wouldn't it  make sense if we could carry out some performance and load tests in an environment that is exactly representative of production? Cloud can benefit in this scenario.  You can automate the creation of a production-like environment, run those tests, and destroy the environment to save cost. This approach to automation can provide reassurance that your application will scale to the needed requirements, as well as any anticipated growth.

Application performance monitoring becomes a core part of this. If we're running performance and load tests on our application, then we want to understand what aspects of our application are struggling. We'll discuss monitoring options further in the next section.

DevOps is a subject that could have its own set of modules in its own right. We've only scratched the surface in the context of performance bottlenecks. You can find out more information about [DevOps][devops-and-microsoft].

## Monitoring options in Azure

Monitoring is the act of collecting and analyzing data to determine the performance, health, and availability of your business application and associated resources.

We want to be kept informed that our application is running smoothly. Proactive notifications can be used to inform about critical issues that arise. There are many layers of monitoring to consider, mainly the infrastructure layer and the application layer.

### Azure Monitor

Azure Monitor enables core monitoring for Azure services by allowing the collection of metrics, activity logs, and diagnostic logs. For example, the activity log tells you when new resources are created or modified. It could be considered our primary single pane of glass for our monitoring needs in Azure. Azure monitor provides us with a range of features including:

* [Azure alerts][azure-alerts] to proactively notify or take action of any breaches to metrics or activities arising
* Use [Azure Dashboards][azure-dashboards] to combine many monitoring sources into one view of our application

Azure Monitor is the place to start for all your [near real-time resource metric insights][az-mon-metrics]. Many Azure resources will start outputting metrics automatically once deployed into your subscription. For example, [Azure Web App instances][az-mon-webapp-metrics] will output compute and application request metrics. Application Insights metrics, including multidimensional metrics, are also collated here in addition to VM host diagnostic metrics. [VM guest diagnostic metrics will also appear once you opt-in.][az-mon-vm-guest-metrics]

### Log Analytics

Consider using Log Analytics for Infrastructure monitoring. [Log Analytics][log-analytics] plays a central role in Azure monitoring by collecting data from various resources, including non-Microsoft tools, into a single repository. There, you can analyze the data by using a [query language][log-analytics-query-language].

You just need to create a workspace to enable collection. You can install agents on virtual machines to include them in the workspace.

![Log Analytics Sources](log-analytics.png)

You can collate a wide range of data sources, Security Logs, Azure Activity Logs, Server, network and Application logs. [You can also push On-premises System Center Operations Manager data to Log Analytics in hybrid deployment scenarios.][scom-to-la] and have [Azure SQLDB][log-analytics-sqldb] send diagnostic information directly into Log Analytics for detailed performance monitoring.

## Application Insights

Application Insights is a service to help with your monitoring needs. Application Insights focuses on application performance Monitoring, rather than infrastructure monitoring. You can use Azure Application Insights to monitor availability, performance, and usage of your web applications across platforms.

You install a small instrumentation package in your application, and set up an Application Insights resource in the Microsoft Azure portal. The instrumentation monitors your app and sends telemetry data to the portal.

Telemetry from the host environments (performance counters, Azure diagnostics, or Docker logs) can be ingested. You can also set up web tests that periodically send synthetic requests to your web service. You could even configure your application to send custom events and metrics that you write yourself in the client or server code. For example, application-specific events such as items sold or games won.

Application Insights stores its data in a common repository and Metrics are shared with Azure Monitor. It can take advantage of shared functionality such as alerts, dashboards, and deep analysis with the Log Analytics query language.

A common pattern used in determining the availability of a web application is the [health endpoint monitoring pattern][health-endpoint-monitoring-pattern]. This pattern is used to monitor web applications and associated back-end services, to ensure they're available and performing correctly.

The pattern is implemented by querying a particular endpoint that has been implemented. The endpoint checks on the status of many components (that is, those backend services that the app depends on) rather than just the availability of the front end itself. This then allows a solution level health check on the solution and returns an indication of its status.

Use Application Insights to gain a deep understanding of your application and correlate activity across your application. Application Insights can help you understand how a specific action works in the client browser, on the server and through to downstream services. The service can help provide insight into trends and notify when there is a problem, help identify where the problem is and how to fix it, before your users are aware. [Use the profiling features][ai-profiler] available in Azure Web Apps to understand the hot path in your code and use [Visual Studio & Application Insights Snap Debugging][ai-snap] to debug live deployed code!

### Lamna Healthcare Example

Lamna Healthcare has implemented a web-based patient booking system using Virtual Machines and Azure SQL DB across two Azure regions. They decide to use the VM Agent and Log Analytics to monitor the performance of the underlying front-end virtual machines.

They use Azure Monitor to understand the performance of their Azure SQL Databases and capture key performance metrics including CPU % and deadlocks.

Application Insights has been configured to capture availability and telemetry information. The team have changed their new booking functionality to send custom event telemetry to Application Insights. The team now have an approach to understand the volume of business-related events taking place.

There are further examples of how [application performance monitoring][application-performance-monitoring] helped identify issue with a hotfix that has been deployed.

## Knowledge Check

Which best describes Application Insights:

* A Single pane of glass for our monitoring needs in Azure
* An implementation of the Health Endpoint Monitoring Pattern
* A workspace to enable collection of logs across infrastructure and application
* A service to monitor availability, performance, and usage of web applications (Correct)

The Log Analytics Monitoring Endpoint Pattern is a recognized cloud design pattern:

* True
* False (Correct - It is actually the Health Endpoint Monitoring Pattern, documented on the Azure Architecture Center)

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
[log-analytics-sqldb]: https://docs.microsoft.com/en-us/azure/sql-database/saas-dbpertenant-log-analytics

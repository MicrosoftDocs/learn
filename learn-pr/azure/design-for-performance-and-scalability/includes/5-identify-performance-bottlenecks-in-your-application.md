End users are expecting more from their applications. They want to have a great user experience and not be impacted by performance issues. How do you integrate performance bottleneck identification into your architecture? What tools does Azure have available to help track down performance issues? In this unit, we will take both process and tools that can help ensure your application performs well, and help you track it down if it doesn't.

## Importance of requirements

Before we talk about performance bottlenecks, it's important to talk about requirements. When we design a solution for a business purpose, there's an expectation for some level of service to be provided. That requirement might be the service level agreement (SLA), committed time to process transactions, or the number of expected users.

Defining these requirements in advance of building your solution is critical. Those requirements enable you to clearly architect the solution to meet certain non-functional requirements, and plan associated monitoring and operations rules.

Discuss requirements with your customers, document them and communicate them broadly to ensure that everyone agrees on what "good performance" means. This helps everyone understand what's being committed, and serves as a level of quality that everyone can work towards.

## DevOps and application performance

DevOps is the union of people, process, and products to enable continuous delivery of value to our end users.

The idea behind DevOps is that we don't have development and infrastructure silos in our organization. Instead, they collectively work together to build great user experiences. To ensure that users enjoy the application, we need to make sure we're building something that matches our requirements. We also need to make sure we have some way of monitoring how we perform against those requirements.

The planning, development, testing, and monitoring is carried out in an iterative approach. Performance and quality of our application become a part of our software development life cycle, rather than an after thought as we deploy into a live environment.

![DevOps Cycle](../media/devops-cycle.png)

This approach aligns with a DevOps concept called "shifting left". In other words, bring your quality control checks earlier into your deployment and release process. This allows you to catch end-user impacting issues earlier in the process. As we operate in a continuous cycle, we limit the amount of manual interaction and automate as much as possible. To ensure performance is considered as part of the DevOps process:

* Write unit tests to prove that specific units of code work as expected
* Build integration tests to check that those units of code work together with other units and produce a desired output
* Carry out performance or load tests to validate the application meets those non-functional requirements prior to a deployment into production

We want our application to perform as expected and limit live performance bottlenecks. Sometimes though, we may inadvertently add regressions or bug in an iteration of our development.

Wouldn't it be great if we could carry out some performance and load tests in an environment that is exactly representative of production? When leveraging the cloud, you fully have this ability. You can automate the creation of a production-like environment, perform testing, then destroy the environment to minimize cost. This approach to automation can provide reassurance that your application will scale to the needed requirements, as well as any anticipated growth.

Application performance monitoring becomes a core part of this. If we're running performance and load tests on our application or want to keep our production performance in check, then we want to understand what aspects of our application may be performing non-optimally. Let's take a look at some ways to do this.

## Performance monitoring options in Azure

Monitoring is the act of collecting and analyzing data to determine the performance, health, and availability of your business application and associated resources.

We want to be kept informed that our application is running smoothly. Proactive notifications can be used to inform about critical issues that arise. There are many layers of monitoring to consider, mainly the infrastructure layer and the application layer.

### Azure Monitor

Azure Monitor enables core monitoring for Azure services by allowing the collection of metrics, activity logs, and diagnostic logs. Azure monitor provides us with a range of features including:

* [Azure alerts][azure-alerts] to proactively notify or take action of any breaches to metrics or activities arising
* Use [Azure Dashboards][azure-dashboards] to combine many monitoring sources into one view of our application

Azure Monitor is the place to start for all your [near real-time resource metric insights][az-mon-metrics]. Many Azure resources will start outputting metrics automatically once deployed into your subscription. For example, [Azure Web App instances][az-mon-webapp-metrics] will output compute and application request metrics. Application Insights metrics, including multidimensional metrics, are also collated here in addition to VM host diagnostic metrics. [VM guest diagnostic metrics will also appear once you opt-in.][az-mon-vm-guest-metrics]

### Log Analytics

Centralized logging can help you uncover hidden issues that may be difficult to track down. Imagine if you could create a dashboard that showed application errors along with performance metrics. This cross-source correlation can help you identify issues or performance problems that may not be evident when looking at logs or metrics individually. 

On Azure, Log Analytics plays the role of this centralized logging service. [Log Analytics][log-analytics] collects and aggregates data from various resources, including non-Microsoft tools, into a single repository. There, you can analyze the data by using a [query language][log-analytics-query-language].

![Log Analytics Sources](../media/log-analytics.png)

You can collate a wide range of data sources, Security Logs, Azure Activity Logs, Server, network and Application logs. [You can also push on-premises System Center Operations Manager data to Log Analytics in hybrid deployment scenarios.][scom-to-la] and have [Azure SQLDB][log-analytics-sqldb] send diagnostic information directly into Log Analytics for detailed performance monitoring.

Centralized logging can be massively beneficial for troubleshooting all types of scenarios, including performance issues. It's a key part of a good monitoring strategy for any architecture.

## Application performance management

Deep application issues are often tricky to track down. This is where integrating telemetry into an application by using an application performance management solution (APM) to track down low-level application performance and behavior can be beneficial. This telemetry can include individual page request times, exceptions within your application, and even custom metrics to track business logic. This telemetry can provide a wealth of insight into what is going on within your application.

On Azure, Application Insights is a service that provides this deep application performance management. You install a small instrumentation package in your application, and set up an Application Insights resource in the Microsoft Azure portal. The instrumentation monitors your app and sends telemetry data to the portal.

Telemetry from the host environments such as performance counters, Azure diagnostics, and Docker logs can be ingested. You can also set up web tests that periodically send synthetic requests to your web service. You could even configure your application to send custom events and metrics that you write yourself in the client or server code. For example, application-specific events such as items sold or games won.

Application Insights stores its data in a common repository and metrics are shared with Azure Monitor. It can take advantage of shared functionality such as alerts, dashboards, and deep analysis with the Log Analytics query language.

A common pattern used in determining the availability of a web application is the [health endpoint monitoring pattern][health-endpoint-monitoring-pattern]. This pattern is used to monitor web applications and associated back-end services, to ensure they're available and performing correctly.

The pattern is implemented by querying a particular endpoint that has been implemented. The endpoint checks on the status of many components, including the back-end services that the app depends on, rather than just the availability of the front end itself. This then allows a solution level health check returns an indication of its overall health.

Use an application performance monitoring solution such as Application Insights to gain a deep understanding of your application and correlate activity across your application. This can help you understand how a specific action works in the client browser, on the server and through to downstream services. It will also provide insight into trends and provide notifications when there is a problem, help identify where the problem is and how to fix it, before your users are aware.

## Performance monitoring at Lamna Healthcare

Lamna Healthcare has implemented a web-based patient booking system using Virtual Machines and Azure SQL DB across two Azure regions. They decide to use the VM Agent and Log Analytics to monitor the performance of the underlying front-end virtual machines.

They use Azure Monitor to understand the performance of their Azure SQL Databases and capture key performance metrics including CPU % and deadlocks.

Application Insights has been configured to capture availability and telemetry information. The team have changed their new booking functionality to send custom event telemetry to Application Insights. The team now has an approach to understand the volume of business-related events taking place, and can get much better insight into what's going on within their application.

## Summary

We've taken a look at some processes, tools, and best practices to help you track down performance issues and ensure your application is performing at it's best. Let's wrap up what we've learned throughout this module.

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

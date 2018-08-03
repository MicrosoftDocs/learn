# Identify performance bottlenecks in your application

## Motivation

End-users are expecting more from their applications. They want to have a great user experience and not experience any performance issues. Monitoring is critical to helping you meet your user expectations, and identify any potential bottlenecks in your application before they reach and impact your end-users.

## Importance of requirements

Before we talk about performance bottlenecks, it is first important to talk about requirements. When we design a solution for a business purpose, there will be an expectation for some level of service to be provided. As some examples, this might be the Service Level Availability (SLA) or the number of expected users (both concurrently and overtime).

Defining these requirements in advance of building your solution is critical. This enables you to clearly architect the solution to meet certain non-functional requirements, and plan associated monitoring and operations rules.

During this unit, we will discuss approaches that you can take to identify performance bottlenecks in your application. It is important that we do this in the context of an application's non-functional requirements, and what the expectation is from the business or our end-users.

## DevOps and application performance

DevOps is the union of people, process, and products to enable continuous delivery of value to our end users.

The idea behind DevOps is that we do not have silos in our organization of infrastructure and development. We are collectively working together to build solutions for our users where they have a great user experience. To ensure they have that great user experience, we need to make sure we're building something that is in line with our requirements.

When adopting a DevOps methodology, it is generally not approached in a waterfall manner. The planning, development, testing and monitoring is carried out in an iterative approach.

![DevOps Cycle](devops-cycle.png)

Performance and quality of our application then become a part of our ongoing software development life cycle, rather than an after thought as we think about deploying into a live environment.

This lines up with a DevOps concept called "shifting left". This means that you want to bring your quality control checks earlier into your deployment and release process, so that you are catching any issues that may impact the end-user experience. As we are operating in a continuous cycle, we limit the amount of manual interaction and automate as much as possible.

* This could be writing unit tests to ensure that specific units of code are working as expected
* This could be integration tests to ensure that those units of code work well together and produce a desired output
* This could be creating performance or load tests to ensure the application meets those non-functional requirements prior to a deployment into production

Ultimately, the aim is that you are taking all opportunities to identify issues as early on (left) in the development cycle as possible and to avoid impacting your end-users experience in a production environment.

Let's think about performance and load testing for a moment. We want to ensure that our application performs as expected and are limiting any performance bottlenecks. As part of each iteration in our development effort, we could be introducing new regressions or bugs. 

Wouldn't it  make sense if we could carry out some performance and load tests in an environment that is exactly representative of production? That is one of the benefits of the cloud. As part of this pipeline, you can automate the creation of such an environment, run those tests, destroy the environment to save on costs and have the reassurance that your application will scale to our requirements (making sure we check for any anticipated growth of the platform as well!)

Application performance monitoring becomes a core part of this mindset. If we are running performance and load tests on our application, then we want to understand what aspects of our application are struggling. We will discuss monitoring options further in the next section. 

Before moving on, it's worth noting that DevOps is a topic that could have its own set of modules in its own right. We have only scratched the surface in the context of performance bottlenecks. You can find out more information about [DevOps and Microsoft][devops-and-microsoft].

## Azure Monitoring options

Monitoring is the act of collecting and analyzing data to determine the performance, health, and availability of your business application and the resources that it depends on.

When we think about monitoring, we are concerned with the ways in which we can be informed that our application is performing as we would expect it to. In particular, that we can be kept notified, even proactively, about critical issues that arise. There are numerous layers of monitoring to consider, primarily the infrastructure layer and the application layer.

### Azure Monitor

Azure Monitor enables core monitoring for Azure services by allowing the collection of metrics, activity logs, and diagnostic logs. For example, the activity log tells you when new resources are created or modified. It could be considered our main pane of glass for our monitoring needs in Azure. Azure monitor provides us with a range of capabilities including:

* [Azure alerts][azure-alerts] to proactively notify or take action of any breaches to metrics or activities arising
* Use [Azure Dashboards][azure-dashboards] to combine multiple monitoring sources into one view for our application

### Log Analytics

From an Infrastructure monitoring perspective, we may want to consider using Log Analytics. [Log Analytics][log-analytics] plays a central role in Azure monitoring by collecting data from a variety of resources (including non-Microsoft tools) into a single repository. There, you can analyze the data by using a [query language][log-analytics-query-language].

You just need to create a workspace to enable collection. You can then install agents on virtual machines to include them in the workspace and enable [management solutions][log-analytics-management-solutions] which include logic to provide additional insights into different applications.

![Log Analytics Sources](log-analytics.png)

## Application Insights

Application Insights is a service to help with your monitoring needs. Application Insights focuses on application performance Monitoring, rather than infrastructure monitoring. You can use Azure Application Insights to monitor availability, performance, and usage of your web applications on multiple platforms.

You install a small instrumentation package in your application, and set up an Application Insights resource in the Microsoft Azure portal. The instrumentation monitors your app and sends telemetry data to the portal.

In addition, you can pull in telemetry from the host environments such as performance counters, Azure diagnostics, or Docker logs. You can also set up web tests that periodically send synthetic requests to your web service. You could even configure your application to send custom events and metrics that you write yourself in the client or server code. This could track business / application specific events such as items sold or games won.

Application Insights stores its data in a common repository. It can take advantage of shared functionality such as alerts, dashboards, and deep analysis with the Log Analytics query language.

A common pattern used in determining the availability of a web application is the [health endpoint monitoring pattern][health-endpoint-monitoring-pattern]. This is a pattern to to monitor web applications and back-end services, to ensure they're available and performing correctly.

The pattern is implemented by querying a particular endpoint that you have implemented. Rather than checking the status of one component, you perform the necessary checks on the numerous components that make up the solution  and return an indication of its status.

### Lamna Healthcare Example

Lamna Healthcare have implemented a web based patient booking system using Virtual Machines and Azure SQL DB across multiple Azure regions. They decide to use the VM Agent and Log Analytics to monitor the performance of the underlying front end virtual machines.

They use Azure Monitor to understand the performance of their Azure SQL Databases and capture key performance metrics including CPU % and deadlocks.

They have also configured Application Insights to capture availability and telemetry information. They have coded custom events in their application to be sent to application insights when a new booking is made in addition to a number of business-related events.

There are further examples of how [application performance monitoring][application-performance-monitoring] helped identify issue with a hotfix that they had deployed.

<!-- links -->
[azure-alerts]: https://docs.microsoft.com/en-us/azure/monitoring-and-diagnostics/monitor-quick-audit-notify-action-in-subscription
[azure-dashboards]: https://docs.microsoft.com/en-us/azure/azure-portal/azure-portal-dashboards
[devops-and-microsoft]: 
https://visualstudio.microsoft.com/devops/
[health-endpoint-monitoring-pattern]: https://docs.microsoft.com/en-us/azure/architecture/patterns/health-endpoint-monitoring
[log-analytics]: https://docs.microsoft.com/en-gb/azure/log-analytics/log-analytics-overview
[log-analytics-query-language]: https://docs.loganalytics.io/docs/Learn/Getting-Started/Getting-started-with-the-Analytics-portal
[log-analytics-management-solutions]: https://docs.microsoft.com/en-gb/azure/monitoring/monitoring-solutions?toc=%2fazure%2flog-analytics%2ftoc.json
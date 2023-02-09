
Application Insights is an extension of Azure Monitor and provides Application Performance Monitoring (also known as “APM”) features.

## Application Insights feature overview

Features include, but not limited to:

| Feature | Description |
|:---|:---|
| Live Metrics | Observe activity from your deployed application in real time with no effect on the host environment. |
| Availability | Probe your applications external endpoint(s) to test the overall availability and responsiveness over time. |
| GitHub or Azure DevOps integration | Create GitHub or Azure DevOps work items in context of Application Insights data. |
| Usage | Reveals which features are popular with users and how users interact and use your application. |
| Smart Detection | Provides automatic failure and anomaly detection through proactive telemetry analysis. |
| Application Map | Allows a high level top-down view of the application architecture and at-a-glance visual references to component health and responsiveness. |
| Distributed Tracing | Search and visualize an end-to-end flow of a given execution or transaction. |

More details on availability and Application Map are discussed later in this module.

## What Application Insights monitors

Application Insights collects Metrics and application Telemetry data, which describe application activities and health, as well as trace logging data.

* **Request rates, response times, and failure rates** - Find out which pages are most popular, at what times of day, and where your users are. See which pages perform best. If your response times and failure rates go high when there are more requests, then perhaps you have a resourcing problem.
* **Dependency rates, response times, and failure rates** - Find out whether external services are slowing you down.
* **Exceptions** - Analyze the aggregated statistics, or pick specific instances and drill into the stack trace and related requests. Both server and browser exceptions are reported.
* **Page views and load performance** - reported by your users' browsers.
* **AJAX calls** from web pages - rates, response times, and failure rates.
* **User and session counts**.
* **Performance counters** from your Windows or Linux server machines, such as CPU, memory, and network usage.
* **Host diagnostics** from Docker or Azure.
* **Diagnostic trace logs** from your app - so that you can correlate trace events with requests.
* **Custom events and metrics** that you write yourself in the client or server code, to track business events such as items sold or games won.

## Getting started with Application Insights

Application Insights is one of the many services hosted within Microsoft Azure, and telemetry is sent there for analysis and presentation. It's free to sign up, and if you choose the basic pricing plan of Application Insights, there's no charge until your application has grown to have substantial usage.

There are several ways to get started monitoring and analyzing app performance: 

* **At run time:** instrument your web app on the server. Ideal for applications already deployed. Avoids any update to the code.
* **At development time:** add Application Insights to your code. Allows you to customize telemetry collection and send more telemetry.
* **Instrument your web pages** for page view, AJAX, and other client-side telemetry.
* **Analyze mobile app usage** by integrating with Visual Studio App Center.
* **Availability tests** - ping your website regularly from our servers.
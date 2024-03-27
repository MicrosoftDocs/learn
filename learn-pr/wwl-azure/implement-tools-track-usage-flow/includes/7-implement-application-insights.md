
## Monitor

Install Application Insights in your app, set up [availability web tests](/azure/application-insights/app-insights-monitor-web-app-availability), and:

 -  Set up a [dashboard](/azure/azure-monitor/app/app-insights-dashboards) for your team room to keep an eye on load, responsiveness, and the performance of your dependencies, page loads, and AJAX calls.
 -  Discover which are the slowest and most-failing requests.
 -  Watch [Live Stream](/azure/application-insights/app-insights-live-stream) when you deploy a new release to know immediately about any degradation.

## Detect, Diagnose

If you receive an alert or discover a problem:

 -  Assess how many users are affected.
 -  Correlate failures with exceptions, dependency calls, and traces.
 -  Examine profiler, snapshots, stack dumps, and trace logs.

## Build, Measure, Learn

[Measure the effectiveness](/azure/application-insights/app-insights-usage-overview) of each new feature that you deploy.

 -  Plan to measure how customers use new UX or business features.
 -  Write custom telemetry into your code.
 -  Base the next development cycle on hard evidence from your telemetry.

## Get started

Application Insights is one of the many services hosted within Microsoft Azure, and telemetry is sent there for analysis and presentation.

So, before you do anything else, you'll need a subscription to [Microsoft Azure](https://azure.com/).

It's free to sign up, and if you choose the basic [pricing plan](https://azure.microsoft.com/pricing/details/application-insights/) of Application Insights, there's no charge until your application has grown to have large usage.

If your organization already has a subscription, they could add your Microsoft account to it.

There are several ways to get started. Begin with whichever works best for you. You can add the others later.

### At run time

Instrument your web app on the server. Avoids any update to the code. You need admin access to your server.

 -  [IIS on-premises or on a VM](/azure/application-insights/app-insights-monitor-performance-live-website-now)
 -  [Azure web app or VM](/azure/azure-monitor/app/azure-vm-vmss-apps)
 -  [J2EE](/azure/application-insights/app-insights-java-live)

### At development time

Add Application Insights to your code. Allows you to write custom telemetry and to instrument back-end and desktop apps.

 -  [Visual Studio](/azure/azure-monitor/app/asp-net) 2013 update two or later.
 -  [Java](/azure/application-insights/app-insights-java-get-started)
 -  Node.js
 -  [Other platforms](/azure/application-insights/app-insights-platforms)
 -  [Instrument your web pages](/azure/application-insights/app-insights-javascript) for page view, and another client-side telemetry.
 -  [Analyze mobile app usage](/azure/application-insights/app-insights-mobile-center-quickstart) by integrating with Visual Studio App Center.
 -  [Availability tests](/azure/application-insights/app-insights-monitor-web-app-availability) \- ping your website regularly from our servers.

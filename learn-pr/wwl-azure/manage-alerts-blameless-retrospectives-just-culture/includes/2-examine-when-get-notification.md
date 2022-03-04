[Application Insights](/azure/application-insights/app-insights-overview) automatically analyzes the performance of your web application and can warn you about potential problems. You might be reading it because you received one of our smart detection notifications.

This feature requires no particular setup other than configuring your app for Application Insights (on [ASP.NET](/azure/azure-monitor/app/asp-net), [Java](/azure/application-insights/app-insights-java-get-started), or Node.js, and [web page code](/azure/application-insights/app-insights-javascript)). It's active when your app generates enough telemetry.

## When would I get a smart detection notification?

Application Insights has detected that the performance of your application has degraded in one of these ways:

 -  Response time degradation - Your app has started responding to requests more slowly than it used to. The change might have been rapid, for example, because there was a regression in your latest deployment. Or it might have been gradual, maybe caused by a memory leak.
 -  Dependency duration degradation - Your app makes calls to a REST API, database, or other dependencies. The dependency is responding more slowly than it used to.
 -  Slow performance pattern - Your app appears to have a performance issue that is affecting only some requests. For example, pages are loading more slowly on one type of browser than others; or requests are being served more slowly from one server. Currently, our algorithms look at page load times, request response times, and dependency response times.

Smart Detection requires at least eight days of telemetry at a workable volume to establish a normal performance baseline. So, after your application has been running for that period, any significant issue will result in a notification.

## Does my app have a problem?

No, a notification doesn't mean that your app has a problem. It's simply a suggestion about something you might want to look at more closely.

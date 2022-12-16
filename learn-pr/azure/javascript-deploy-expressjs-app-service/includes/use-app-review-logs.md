Azure App Service collects the same kinds of monitoring data as other Azure resources. These metrics and logs are provided as part of Azure Monitor, which is integrated with App Service.

:::image type="content" source="../media/azure-monitor-conceptual-overview.png" alt-text="Diagram that displays conceptual Azure Monitor metrics and logging.":::

## Monitoring

Azure Monitor provides several sets of data and functionality you can use to watch your app:

* **Platform metrics and activity log**: These metrics and the log are collected and stored *automatically*. You can route them to other locations by using a diagnostic setting.
* **Resource logs**: These logs *aren't automatically collected* and stored. You must create a diagnostic setting and route them to one or more locations.
* **Alerts**: Alerts proactively notify you when important conditions are found in your monitoring data. You can use them to identify and address issues in your system before your customers notice them.
  
  If you're running an application on App Service via Azure Monitor, Azure Application Insights offers more types of alerts:

    | Alert type | Condition | Examples  |
    |:---|:---|:---|
    | Metric | Average connections| When many connections exceed a set value|
    | Metric | HTTP 404| When HTTP 404 responses exceed a set value|
    | Metric | HTTP server errors| When HTTP 5xx errors exceed a set value|
    | Activity log | Create or update web app | When an app is created or updated|
    | Activity log | Delete web app | When an app is deleted|
    | Activity log | Restart web app| When an app is restarted|
    | Activity log | Stop web app| When an app is stopped|
* **Quotas**: Quotas place limits on the resources that the app can use, such as CPU, memory, bandwidth, and file system storage. When an app exceeds its pricing tier quota, App Service returns 403 errors, stops the app temporarily, or reports other failures.

You can increase or remove quotas from your app by upgrading your App Service plan. To review the status of the various quotas and metrics that affect an app, review your quotas in the Azure portal for your App Service.

## App Service runtime logs

App Service stores log files helpful to resolving runtime issues:

|Log type|Purpose|
|--|--|
| Deployment, installation, and start up| This log ends in `_docker.log`, and it's how you debug your deployment and container startup issues. Every app runs in a container on App Service. When you pick the runtime, a container with that runtime is provided for you.|
|Running web app| This log ends in `_default_docker.log` and includes all the information your running web app provides for logging.|

Your logs can grow beyond the file size limits provided. You can use a process to offload the files to a service with more space. You can also turn off logging at the host.

Some popular npm logging modules allow you to log errors and information. They provide the infrastructure for the logs to use Application Insights or other logging services. In this way, you can use the popular logging packages and have the data automatically managed on Azure.

## Custom Application Insights logging

Application Insights is part of Azure Monitor. It integrates directly with App Service to provide monitoring and metrics.

Application Insights provides the npm package `applicationinsights`. You can integrate it with your Express.js app for more logging. Use the `.traceTrace()` method to log custom tracing.

```javascript
let appInsights = require("applicationinsights");
appInsights.setup("YOUR-INSTRUMENTATION-KEY")
    .setAutoDependencyCorrelation(true)
    .setAutoCollectRequests(true)
    .setAutoCollectPerformance(true, true)
    .setAutoCollectExceptions(true)
    .setAutoCollectDependencies(true)
    .setAutoCollectConsole(true, false)
    .setUseDiskRetryCaching(true)
    .setAutoCollectPreAggregatedMetrics(true)
    .setSendLiveMetrics(false)
    .setAutoCollectHeartbeat(false)
    .setInternalLogging(false, true)
    .setDistributedTracingMode(appInsights.DistributedTracingModes.AI_AND_W3C)
    .start();

let client = appInsights.defaultClient;
client.trackEvent({name: "my custom event", properties: {customProperty: "custom property value"}});
client.trackException({exception: new Error("handled exceptions can be logged with this method")});
client.trackMetric({name: "custom metric", value: 3});
client.trackTrace({message: "trace message"});
client.trackDependency({target:"http://dbname", name:"select customers proc", data:"SELECT * FROM Customers", duration:231, resultCode:0, success: true, dependencyTypeName: "ZSQL"});
client.trackRequest({name:"GET /customers", url:"http://myserver/customers", duration:309, resultCode:200, success:true});
```

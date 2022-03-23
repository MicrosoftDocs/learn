This unit focuses on how you know your app is working correctly. 

## Monitoring

App Service collects the same kinds of monitoring data as other Azure resources. App Service also provides built-in diagnostics to assist with debugging apps. 

* **Platform metrics** and the **Activity log** are collected and stored **automatically**, but can be routed to other locations by using a diagnostic setting. 
* **Resource Logs** are **not automatically collected** and stored until you create a diagnostic setting and route them to one or more locations.
* **Alerts** proactively notify you when important conditions are found in your monitoring data. They allow you to identify and address issues in your system before your customers notice them. 
    * If you're running an application on App Service Azure Monitor, Application Insights offers more types of alerts.

    | Alert type | Condition | Examples  |
    |:---|:---|:---|
    | Metric | Average connections| When number of connections exceed a set value|
    | Metric | HTTP 404| When HTTP 404 responses exceed a set value|
    | Metric | HTTP Server Errors| When HTTP 5xx errors exceed a set value|
    | Activity Log | Create or Update Web App | When app is created or updated|
    | Activity Log | Delete Web App | When app is deleted|
    | Activity Log | Restart Web App| When app is restarted|
    | Activity Log | Stop Web App| When app is stopped|
* **Quotas** are the limits on the resources that the app can use such as CPU, memory, bandwidth, and filesystem storage. When an app exceeds its pricing tier quota, the App Service can return 403 errors, stop the app temporarily, or other failures. You can increase or remove quotas from your app by upgrading your App Service plan. To review the status of the various quotas and metrics that affect an app, review your quotas in the Azure portal, for your App Service. 

## App Service runtime logs

The App Service stores log files helpful to resolving runtime issues:

|Log type|Purpose|
|--|--|
| Deployment, installation, and start up| This log ends in `_docker.log` and is how you debug your deployment and container startup issues. Every app runs in a container on App Service. When you pick the runtime, a container with that runtime is provided for you.|
|Running web app| This log ends in `_default_docker.log` and includes all the information your running web app provides for logging.|

Because your logs can grow beyond the file size limits provided, you can choose to use a process to offload the files to a service with more space or you can turn off logging at the host. 

Some popular npm logging modules allow you to log errors and information and provides the infrastructure for the logs to use Application Insights or other logging services. This allows you to use the popular logging packages and have the data automatically managed on Azure. 
 
## Custom Application Insights logging

Application Insights is part of Azure Monitor and integrates directly with the App Service providing monitoring and metrics. 

Application Insights provides an npm package, `applicationinsights`, which you can integrate with your Express.js app for additional logging. Use the `.traceTrace()` method to log custom tracing. 

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

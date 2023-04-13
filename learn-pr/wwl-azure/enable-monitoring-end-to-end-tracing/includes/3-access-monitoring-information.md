You now can live stream logs to your console. Next, you'll configure Application Insights for your applications.

Application Insights is a feature of Azure Monitor that provides extensible application performance management (APM) and monitoring for live web apps. Developers and DevOps professionals can use Application Insights to:

 -  Automatically detect performance anomalies.
 -  Help diagnose issues by using powerful analytics tools.
 -  See what users actually do with apps.
 -  Help continuously improve app performance and usability.

Application Insights:

 -  Supports a wide variety of platforms, including .NET, Node.js, Java, and Python.
 -  Works for apps hosted on-premises, hybrid, or on any public cloud.
 -  Integrates with DevOps processes.
 -  Has connection points to many development tools.

## How Application Insights works

To use Application Insights, you either install a small instrumentation package (SDK) in your app, or enable Application Insights by using the Application Insights agent.

You can instrument the web app, any background components, and the JavaScript in the web pages themselves. The app and its components don't have to be hosted in Azure.

The instrumentation monitors your app and directs the telemetry data to an Application Insights resource by using a unique instrumentation key. You can pull in telemetry like performance counters, Azure diagnostics, or Docker logs from host environments. All these telemetry streams are integrated into Azure Monitor.

The following diagram shows how Application Insights instrumentation in an app sends telemetry to an Application Insights resource.

:::image type="content" source="../media/application-insights-spring-boot-b571e0f1.png" alt-text="Diagram showing how Application Insights instrumentation in an app sends telemetry.":::


Spring Apps Service uses an in-process Java Agent for Application Insights. When you initially created your service, an Application Insights resource was created for you by default.

You'll need to check whether an Application Insights instance is linked to your Spring Apps Service. If the instance isn't linked, then relink Application Insights.

1.  Run the following command to allow automatic installation of the Azure CLI extension required for this lab.
    
    ```azurecli
    az config set extension.use_dynamic_install=yes_without_prompt
    ```

2.  Use the following command to determine whether Application Insights is linked to your Spring Apps Service.
    
    ```azurecli
    az spring app-insights show \
        -g $RESOURCE_GROUP \
        -n $SPRING_APPS_SERVICE
    ```
    
    You should see output similar to what's displayed below:
    
    ```
    {
    "appInsightsAgentVersions": {
    "java": "3.2.11"
    },
    "appInsightsInstrumentationKey": "InstrumentationKey=xxx-xxx-xxx;IngestionEndpoint=https://westus-0.in.applicationinsights.azure.com/;LiveEndpoint=https://westus.livediagnostics.monitor.azure.com/",
    "appInsightsSamplingRate": 10.0,
    "error": null,
    "provisioningState": "Succeeded",
    "traceEnabled": true
    }
    ```
    
    The output seen above shows that Application Insights is enabled and that your applications are sending monitoring data to Application Insights. If your output differs, and there's no instrumentation key, you'll need to reconfigure Application Insights.
    
    To reconfigure Application Insights, do the following procedure.

3.  To re-enable Application Insights, you'll first need to get hold of the instrumentation key of your Application Insights instance.
    
    ```azurecli
    INSTRUMENTATIONKEY=$(az monitor app-insights component show \
    -g $RESOURCE_GROUP \
    --query [0].connectionString \
    -o tsv)
    ```

4.  You can use the instrumentation key to reconfigure Application Insights for your Spring Apps Service.
    
    ```azurecli
    az spring app-insights update \
    -g $RESOURCE_GROUP \
    -n $SPRING_APPS_SERVICE \
        --sampling-rate 50 \
        --app-insights-key $INSTRUMENTATIONKEY
    ```

5.  You can reissue a *show* for your Application Insights config of the proper output.
    
    ```azurecli
    az spring app-insights show \
    -g $RESOURCE_GROUP \
    -n $SPRING_APPS_SERVICE
    ```

Now that you've successfully deployed your first serverless web function using the Azure Functions Maven Archetype, your company would like you to research how to analyze your application's usage with Azure Application Insights.

In this unit, you'll learn about log streaming as basic troubleshooting tool and the integration between Azure Functions and Application Insights.

## Stream logs in real-time with Azure CLI

Once you have your function app deployed and running. You can use the simple Azure CLI command to get real-time log streaming from the app for basic troubleshooting:

```azcli
az webapp log tail -n <function app name> -g <resource group name>
```

With traffics to your Function app you will see for example:

![Image showing Log Streaming from Azure CLI](../media/8-log-streaming-cli.png)

For more complicate troubleshooting and monitoring scenario, Application Insights will be a better fit.

## What is Application Insights?

Azure Application Insights is an Application Performance Management (APM) service that included with Azure Monitor, and is integrated with Azure Functions. Application Insights helps developers view and analyze live data about their applications as they are being used by customers. Application Insights provides a comprehensive set of tools that can help you analyze and respond to issues that might be affecting your application.

Application Insights supports applications that are developed in Node.js, Java, or .NET, which allows your development team greater flexibility and choice in how they structure and build your company's applications.

Application Insights will provide essential information on failed requests, server response time, server requests, and availability. It can also use telemetry data sent from the application. However, this will require you to include telemetry tracking points in your code. Application Insights is enabled by default for your Azure Functions.

## Adding instrumentation to your Java project

To get the best from Application Insights, you'll need to update your function project. There are two types of changes that you'll need to make:

- The first set of changes is updates to your configuration in order to add Application Insights and logging support:

    - Update your project's *pom.xml* file to add a dependency for the Application Insights library.

    - Update your project's *host.json* file to add parameters that define how the logging and Application Insights will work for your application.

- The second set of changes is modifications to your application's code, which provides you with opportunities to fine-tune your application's reporting:

    - To implement the event tracking in Application Insight, you'll need to add a *tracker* to your code.
    
    - Trackers are added at critical points in your code's execution; for example: when a new page is selected, or when specific data is saved to your application.

## Understanding logging and monitoring options

The recommended method for using Application Insights in your function applications is to fine-tune your application's monitoring and reporting. However, you can also retrieve data about the operation of your applications from the built-in logs that Azure provides you.

For example, **Log streaming** is available from the **Platform features** tab from the top-level page of your functions App Service.

![Image showing where to find Log Streaming](../media/8-log-streaming.png)

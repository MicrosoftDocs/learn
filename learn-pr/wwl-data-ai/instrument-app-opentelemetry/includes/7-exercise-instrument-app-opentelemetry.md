OpenTelemetry is an open-source observability framework that provides a standardized way to collect traces, metrics, and logs from applications. The Azure Monitor OpenTelemetry Distro packages the OpenTelemetry SDK with the Azure Monitor exporter so Python applications can send telemetry to Application Insights with minimal configuration. Custom spans let you trace application-specific operations and add attributes that enrich trace data with business context.

In this exercise, you deploy an Application Insights resource and build a Python Flask web application that demonstrates OpenTelemetry instrumentation for a document processing pipeline. You configure the Azure Monitor OpenTelemetry Distro, create custom parent and child spans for each pipeline stage, add span attributes to capture document metadata, and use Transaction search and log queries in the Azure portal to verify your telemetry and diagnose a simulated latency bottleneck.

Tasks performed in this exercise:

- Download the project starter files
- Create an Application Insights resource
- Add code to the starter files to complete the app
- Run the app and diagnose a performance issue in Application Insights

This exercise takes approximately **25** minutes to complete.

## Before you start

To complete the exercise, you need:

- An Azure subscription. If you don't already have one, you can [sign up for one](https://azure.microsoft.com/).
- [Visual Studio Code](https://code.visualstudio.com/) on one of the [supported platforms](https://code.visualstudio.com/docs/supporting/requirements#_platforms).
- [Python 3.12](https://www.python.org/downloads/) or greater.
- The latest version of the [Azure CLI](/cli/azure/install-azure-cli).

## Get started

Select the **Launch Exercise** button to open the exercise instructions in a new browser window. When you're finished with the exercise, return here to:

> [!div class="checklist"]
> * Complete the module
> * Earn a badge for completing this module

<br/>

<a href="https://go.microsoft.com/fwlink/?linkid=2353616" target="_blank">
    <img src="../media/launch-exercise.png" alt="Button to launch exercise.">
</a>

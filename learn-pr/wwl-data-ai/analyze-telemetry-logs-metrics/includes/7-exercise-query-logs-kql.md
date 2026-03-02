Kusto Query Language (KQL) is the query language used to analyze log data in Application Insights. KQL queries let you filter, aggregate, and join telemetry tables such as requests, dependencies, and exceptions to diagnose application health and performance. The Logs blade in Application Insights provides an interactive query editor with autocomplete, visual results, and time range controls that make it the primary tool for investigating telemetry. Combined with scheduled query alert rules created through the Azure CLI, KQL enables proactive monitoring that notifies your team when failure rates or latency exceed acceptable thresholds.

In this exercise, you deploy an Application Insights resource, run a Python script that generates sample request, dependency, and exception telemetry using OpenTelemetry, then write KQL queries in the Azure portal Logs blade to investigate application health. You query the requests table to identify failures, join exceptions with requests to correlate errors, analyze dependency latency with percentile calculations, and create an action group and log search alert rule using the Azure CLI.

Tasks performed in this exercise:

- Download the project starter files
- Create an Application Insights resource
- Run the telemetry generator to create sample data
- Query telemetry with KQL in the Azure portal
- Create an action group and alert rule with the Azure CLI

This exercise takes approximately **20** minutes to complete.

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

<a href="https://go.microsoft.com/fwlink/?linkid=2353415" target="_blank">
    <img src="../media/launch-exercise.png" alt="Button to launch exercise.">
</a>

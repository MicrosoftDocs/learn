In this unit, we'll look at Logging concepts.

## Introduction

With your sample application setup, there are two ways to see logs: Log Streaming of real-time logs per app instance or Log Analytics for aggregated logs with advanced query capability.

## Streaming logs

In Azure Spring Cloud, Spring developers can enable Log Analytics to view or query logs. The log streaming feature allows developers to get real-time application logs in Azure CLI and know what’s happening with specified application instance running in Azure Spring Cloud.

## Log Analytics introduction

Data collected by Azure Monitor Logs is stored in one or more Log Analytics workspaces. The workspace defines the geographic location of the data, access rights defining which users can access data, and configuration settings such as the pricing tier and data retention.  

You must create at least one workspace to use Azure Monitor Logs. A single workspace may be sufficient for all of your monitoring data, or may choose to create multiple workspaces depending on your requirements. For example, you might have one workspace for your production data and another for testing.

## Log queries

Data is retrieved from a Log Analytics workspace using a log query, which is a read-only request to process data and return results. Log queries are written in **Kusto Query Language (KQL)**, which is the same query language used by Azure Data Explorer. You can write log queries in Log Analytics to interactively analyze their results, use them in alert rules to be proactively notified of issues, or include their results in workbooks or dashboards.

In the next exercise, we'll configure logging for your Sample Spring application.

Application Insights log-based metrics let you analyze the health of your monitored apps, create powerful dashboards, and configure alerts. There are two kinds of metrics:

* **Log-based metrics** behind the scene are translated into [Kusto queries](/azure/kusto/query/) from stored events.
* **Standard metrics** are stored as preaggregated time series.

Since *standard metrics* are preaggregated during collection, they have better performance at query time. Standard metrics are a better choice for dashboarding and in real-time alerting. The *log-based metrics* have more dimensions, which makes them the superior option for data analysis and ad-hoc diagnostics. Use the [namespace selector](/azure/azure-monitor/essentials/metrics-getting-started#create-your-first-metric-chart) to switch between log-based and standard metrics in [metrics explorer](/azure/azure-monitor/essentials/metrics-getting-started).

## Log-based metrics

Developers can use the SDK to send events manually (by writing code that explicitly invokes the SDK) or they can rely on the automatic collection of events from autoinstrumentation. In either case, the Application Insights backend stores all collected events as logs, and the Application Insights blades in the Azure portal act as an analytical and diagnostic tool for visualizing event-based data from logs.

Using logs to retain a complete set of events can bring great analytical and diagnostic value. For example, you can get an exact count of requests to a particular URL with the number of distinct users who made these calls. Or you can get detailed diagnostic traces, including exceptions and dependency calls for any user session. Having this type of information can significantly improve visibility into the application health and usage, allowing to cut down the time necessary to diagnose issues with an app.

At the same time, collecting a complete set of events may be impractical (or even impossible) for applications that generate a large volume of telemetry. For situations when the volume of events is too high, Application Insights implements several telemetry volume reduction techniques, such as sampling and filtering that reduces the number of collected and stored events. Unfortunately, lowering the number of stored events also lowers the accuracy of the metrics that, behind the scenes, must perform query-time aggregations of the events stored in logs.

## Preaggregated metrics

The preaggregated metrics aren't stored as individual events with lots of properties. Instead, they're stored as preaggregated time series, and only with key dimensions. This makes the new metrics superior at query time: retrieving data happens faster and requires less compute power. This enables new scenarios such as near real-time alerting on dimensions of metrics, more responsive dashboards, and more.

> [!IMPORTANT]
> Both, log-based and pre-aggregated metrics coexist in Application Insights. To differentiate the two, in the Application Insights UX the pre-aggregated metrics are now called "Standard metrics (preview)", while the traditional metrics from the events were renamed to "Log-based metrics".

The newer SDKs ([Application Insights 2.7](https://www.nuget.org/packages/Microsoft.ApplicationInsights/2.7.2) SDK or later for .NET) preaggregate metrics during collection. This applies to  [standard metrics sent by default](/azure/azure-monitor/essentials/metrics-supported#microsoftinsightscomponents) so the accuracy isn't affected by sampling or filtering. It also applies to custom metrics sent using [GetMetric](/azure/azure-monitor/app/api-custom-events-metrics#getmetric) resulting in less data ingestion and lower cost.

For the SDKs that don't implement preaggregation the Application Insights backend still populates the new metrics by aggregating the events received by the Application Insights event collection endpoint. While you don't benefit from the reduced volume of data transmitted over the wire, you can still use the preaggregated metrics and experience better performance and support of the near real-time dimensional alerting with SDKs that don't preaggregate metrics during collection.

It's worth mentioning that the collection endpoint preaggregates events before ingestion sampling, which means that [ingestion sampling](/azure/azure-monitor/app/sampling) will never impact the accuracy of preaggregated metrics, regardless of the SDK version you use with your application.

## Azure Stream Analytics solution patterns

Azure Stream Analytics is a key component of the larger IoT solution. Several simple architectural patterns for Azure Stream Analytics can be used to develop more complex solutions in a wide variety of scenarios.

### Create a Stream Analytics job to power real-time dashboarding experience

With Azure Stream Analytics, you can quickly stand up real-time dashboards and alerts. A simple solution ingests events from Event Hubs or IoT Hub, and feeds the Power BI dashboard with a streaming data set. For more information, see the detailed tutorial [Analyze fraudulent call data with Stream Analytics and visualize results in Power BI dashboard](/azure/stream-analytics/stream-analytics-real-time-fraud-detection).

:::image type="content" source="../media/m04-l05-asa-pattern-pbi-dashboard-5efcfd46.png" alt-text="Diagram that illustrates a Stream Analytics job that could be used to power a real-time dashboarding experience.":::


This solution can be built in just a few minutes from Azure portal. There is no extensive coding involved, and SQL language is used to express the business logic.

This solution pattern offers the lowest latency from the event source to the Power BI dashboard in a browser. Azure Stream Analytics is the only Azure service with this built-in capability.

### Incorporate real-time insights into your application with event messaging

The second most popular use of Stream Analytics is to generate real-time alerts. In this solution pattern, business logic in Stream Analytics can be used to detect temporal and spatial patterns or anomalies, then produce alerting signals. However, unlike the dashboard solution where Stream Analytics uses Power BI as a preferred endpoint, various intermediate data sinks can be used. These sinks include Event Hubs, Service Bus, and Azure Functions. You, as the application builder, need to decide which data sink works best for your scenario.

Downstream event consumer logic must be implemented to generate alerts in your existing business workflow. Because you can implement custom logic in Azure Functions, Azure Functions is the fastest way you can perform this integration. A tutorial for using Azure Function as the output for a Stream Analytics job can be found in [Run Azure Functions from Azure Stream Analytics jobs](/azure/stream-analytics/stream-analytics-with-azure-functions). Azure Functions also supports various types of notifications including text and email. Logic App may also be used for such integration, with Event Hubs between Stream Analytics and Logic App.

:::image type="content" source="../media/m04-l05-asa-pattern-event-messaging-app-93858b75.png" alt-text="Diagram that illustrates a Stream Analytics job that could be used to generate real-time alerts.":::


Event Hubs, on the other hand, offers the most flexible integration point. Many other services, like Azure Data Explorer can consume events from Event Hubs. Services can be connected directly to the Event Hubs sink from Azure Stream Analytics to complete the solution. Event Hubs is also the highest throughput messaging broker available on Azure for such integration scenarios.

## How to monitor Azure Stream Analytics jobs

An Azure Stream Analytics job can be run 24/7 to process incoming events continuously in real time. Its uptime guarantee is crucial to the health of the overall application. While Stream Analytics is the only streaming analytics service in the industry that offers a 99.9% availability guarantee, you may still incur some level of down time. Over the years, Stream Analytics has introduced metrics, logs, and job states to reflect the health of the jobs. All of them are surfaced through Azure Monitor service and can be further exported to OMS.

:::image type="content" source="../media/m04-l05-asa-monitoring-diagram-4500b9c2.png" alt-text="Diagram that illustrates how to monitor Azure Stream Analytics.":::


There are two key things to monitor:

 -  Job failed state: First and foremost, you need to make sure the job is running. Without the job in the running state, no new metrics or logs are generated. Jobs can change to a failed state for various reasons, including having a high SU utilization level (for example, running out of resources).
 -  Watermark delay metrics: This metric reflects how far behind your processing pipeline is in wall clock time (seconds). Some of the delay is attributed to the inherent processing logic. As a result, monitoring the increasing trend is much more important than monitoring the absolute value. The steady state delay should be addressed by your application design, not by monitoring or alerts.

Upon failure, activity logs and diagnostics logs are the best places to begin looking for errors.

You can find more information on Azure Stream Analytics solution patterns here: [Azure Stream Analytics solution patterns](/azure/stream-analytics/stream-analytics-solution-patterns)

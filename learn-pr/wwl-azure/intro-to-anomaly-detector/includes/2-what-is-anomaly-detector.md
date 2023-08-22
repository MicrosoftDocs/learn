Anomalies are values that are outside the expected values or range of values.

> [!div class="mx-imgBorder"]
> ![Diagram that shows a line graph with three points that are outside a boundary and identified as anomalies.](../media/batch-anomaly.png)

In the graphic depicting the time series data, there's a light shaded area that indicates the boundary, or sensitivity range. The solid blue line is used to indicate the measured values. When a measured value is outside of the shaded boundary, an orange dot is used to indicate the value is considered an anomaly. The sensitivity boundary is a parameter that you can specify when calling the service. It allows you to adjust that boundary settings to tweak the results.

Anomaly detection is considered the act of identifying events, or observations that differ in a significant way from the rest of the data being evaluated. Accurate anomaly detection leads to prompt troubleshooting, which helps to avoid revenue loss and maintain brand reputation. 

## Azure AI Anomaly Detector 

Azure AI Anomaly Detector is a cloud-based service that enables you to monitor time series data, and to detect anomalies in that data. It doesn't require you to know machine learning. You can use the REST API to integrate Azure AI Anomaly Detector into your applications with relative ease. The service uses the concept of a "one parameter" strategy. The main parameter you need to customize is "sensitivity," which is from 1 to 99 to adjust the outcome to fit the scenario. The service can detect anomalies in historical time series data and also in real-time data such as streaming input from IoT devices, sensors, or other streaming input sources.



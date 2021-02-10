Anomaly detection is considered the act of identifying events, or observations, that differ in a significant way from the rest of the data being evaluated. In other words, unexpected events or rare items. There are two standard ways of performing this evaluation. You can look at historical data or you can evaluate real-time data.

Anomaly Detector is a part of the Decision Services category within Azure Cognitive Services. It is a cloud-based service that enables you to monitor time series data, and to detect anomalies in that data. It does not require you to know machine learning. You can use the REST API to integrate Anomaly Detector into your applications with relative ease. The service uses the concept of a "one parameter" strategy. The main parameter you need to customize is “Sensitivity”, which is from 1 to 99 to adjust the outcome to fit the scenario.

The service can detect anomalies in historical time series data and also in real-time data such as streaming input from IoT devices, sensors, or other streaming input sources.

## What is an anomaly?

Anomalies are values that are outside the expected values or range of values.

:::image type="content" source="../media/batch-anomaly.png" alt-text="Line graph depicting three points that are outside a boundary and identified as anomalies":::

In the graphic depicting the time series data, there is a light shaded area that indicates the boundary, or sensitivity range. The solid blue line is used to indicate the measured values. When a measured value is outside of the shaded boundary, an orange dot is used to indicate the value is considered an anomaly. The sensitivity boundary is the one parameter that you can specify when calling the API. It allows you to adjust that boundary.

## Batch detection

Batch detection involves applying the algorithm to an entire data series at one time. The concept of time series data involves evaluation of a data set as a batch. Use your time series to detect any anomalies that might exist throughout your data. This operation generates a model using your entire time series data, with each point analyzed using the same model.

## Real-time detection

Real-time detection involves streaming data that is evaluated using previous points and the current data point. Detect anomalies in your streaming data by using previously seen data points to determine if your latest one is an anomaly. This operation generates a model using the data points you send, and determines if the target (current) point is an anomaly. By calling the API with each new data point you generate, you can monitor your data as it's created.

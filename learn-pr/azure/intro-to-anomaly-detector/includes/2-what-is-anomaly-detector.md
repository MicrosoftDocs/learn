Anomaly detection is considered the act of identifying events, or observations, that differ in a significant way from the rest of the data being evaluated. There are two standard ways of performing this evaluation. You can look at historical data or you can evaluate real-time data.

Anomaly Detector is a part of the Decision Services category within Azure Cognitive Services. It is a cloud-based service that enables you to monitor time series data, and to detect anomalies in that data, and does not require you to know machine learning. You can use the REST API to integrate Anomaly Detector into your applications with relative ease.

The service provides the ability to detect anomalies in historical time series data and also in real-time data such as streaming input from IoT devices, sensors, or other streaming input sources.

## Batch detection

The concept of time series data involves evaluation of a data set as a batch. Use your time series to detect any anomalies that might exist throughout your data. This operation generates a model using your entire time series data, with each point analyzed using the same model.

:::image type="content" source="../media/batch-anomaly.png" alt-text="Line graph depicting spikes in both positive and negative directions and identified as anomalies":::

In the graphic depicting the batch detection, there are several yellow rectangles highlighting areas of the graph that you might consider anomalies. A key aspect to keep in mind is if the time series data trends up and down without seasonality, some points of change (dips and spikes in the data) may be missed by the model. Similarly, some points of change that are less significant than ones later in the data set may not be counted as significant enough to be incorporated into the model.

## Real-time detection

Detect anomalies in your streaming data by using previously seen data points to determine if your latest one is an anomaly. This operation generates a model using the data points you send, and determines if the target point is an anomaly. By calling the API with each new data point you generate, you can monitor your data as it's created.

:::image type="content" source="../media/real-time.png" alt-text="line graph depicting spikes in both positive and negative but highlighting how real-time analysis misses some potential anomalies":::

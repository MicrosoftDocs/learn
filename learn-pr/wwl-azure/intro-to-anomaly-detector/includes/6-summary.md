Azure AI Anomaly Detector detects anomalies automatically in time series data. It supports two basic detection models. One is for detecting a batch of data with a model trained by the time series sent to the service. The other is used for detecting the last point with the model trained by points before.

Packaging your time series data into a JSON object and passing it to the API, anomalies can be detected in the time series data. Using the returned results can help you identify issues with industrial processes or recorded events. Batch series data is best used to evaluate recorded events that represent seasonal patterns and don't require immediate action. Streaming data points into the API can offer real-time awareness of anomalies that may require immediate action.

The API can be integrated into your applications by using REST calls or by incorporating the appropriate SDK into your code. Using Azure AI Anomaly Detector does not require you to devise, or to be knowledgeable in, machine learning algorithms.

## Learn more

To learn more about Azure AI Anomaly Detector, see the [service documentation](/azure/ai-services/anomaly-detector/overview?azure-portal=true).

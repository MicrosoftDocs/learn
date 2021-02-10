The Anomaly Detector API supports batch processing of time series data or last-point anomaly detection for real-time data. Also included in batch processing, is the ability to find trend change points. All three options are available via a REST API or SDKs targeting .NET, Python, Node.js, and Go.

When using the batch detection mode, Anomaly Detector creates a single statistical model based on the entire data set that you pass to the service.  From this model, each data point in the data set is evaluated and anomalies are identified. Batch detection is best used when your data has the following characteristics:

- Seasonal time series with occasional anomalies
- Flat trend time series with occasional spikes or dips

Seasonality is considered to be a pattern in your data, that occurs at regular intervals. Examples would be hourly, daily, or monthly patterns. Using seasonal data, and specifying a period for that pattern, can help to reduce the latency in detection.

## How anomalies are identified

The Anomaly Detector API identifies anomalies that exist outside the scope of a boundary. The boundary is set using a sensitivity value. By default, the upper and lower boundaries for anomaly detection are calculated using concepts known as **expectedValue**, **upperMargin**, and **lowerMargin**. The upper and lower boundaries are calculated using these three values. If a value exceeds either boundary, it will be identified as an anomaly. You can adjust the boundaries by applying a **marginScale** to the upper and lower margins as demonstrated by the following formula.

*upperBoundary = expectedValue + (100 - marginScale) * upperMargin*

## Data format

The Anomaly Detector API accepts data in JSON format. You can use any numerical data that you have recorded over time. The key aspects of the data being sent includes the granularity, a timestamp, and a value that was recorded for that timestamp. An example of a JSON object that you might send to the API is shown in this code sample. The granularity is set as hourly and is used to represent temperatures in degrees Celsius that were recorded at the timestamps indicated.

```json
{
    "granularity": "hourly",
    "series": [
      {
        "timestamp": "2021-03-01T01:00:00Z",
        "value": -10.56
      },
      {
        "timestamp": "2021-03-02T02:00:00Z",
        "value": -8.30
      },
      {
        "timestamp": "2021-03-02T03:00:00Z",
        "value": -10.30
      },
      {
        "timestamp": "2021-03-02T04:00:00Z",
        "value": 5.95
      },
    ]
}
```

The API will support a maximum of 8640 data points however, sending this many data points in the same JSON object, can result in latency for the response. You can improve the response by breaking your data points into smaller chunks (windows) and sending these in a sequence.

The same JSON object format is used in a streaming scenario. The main difference is that you will send a single value in each request. The streaming detection method will compare the current value being sent and the previous value sent.

## Data consistency recommendations

If your data may have missing values in the sequence, consider the following recommendations.

- Sampling occurs every few minutes and has less than 10% of the expected number of points missing. In this case, the impact should be negligible on the detection results.
- If you have more than 10% missing, there are options to help "fill" the data set. Consider using a linear interpolation method to fill in the missing values and complete the data set. This will fill gaps with evenly distributed values.

The Anomaly Detector API will provide the best results if your time series data is evenly distributed. If the data is more randomly distributed, you can use an aggregation method to create a more even distribution data set.
Azure AI Anomaly Detector identifies anomalies that exist outside the scope of a boundary. The boundary is set using a sensitivity value. By default, the upper and lower boundaries for anomaly detection are calculated using concepts known as **expectedValue**, **upperMargin**, and **lowerMargin**. The upper and lower boundaries are calculated using these three values. If a value exceeds either boundary, it will be identified as an anomaly. You can adjust the boundaries by applying a **marginScale** to the upper and lower margins as demonstrated by the following formula.

*upperBoundary = expectedValue + (100 - marginScale) \* upperMargin*

## Data format

Azure AI Anomaly Detector accepts data in JSON format. You can use any numerical data that you have recorded over time. The key aspects of the data being sent includes the granularity, a timestamp, and a value that was recorded for that timestamp. An example of a JSON object that you might send to the API is shown in this code sample. The granularity is set as hourly and is used to represent temperatures in degrees celsius that were recorded at the timestamps indicated.

```
{
    "granularity": "hourly",
    "series": [
      {
        "timestamp": "2021-03-02T01:00:00Z",
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

The service will support a maximum of 8640 data points however, sending this many data points in the same JSON object, can result in latency for the response. You can improve the response by breaking your data points into smaller chunks (windows) and sending these in a sequence.

The same JSON object format is used in a streaming scenario. The main difference is that you will send a single value in each request. The streaming detection method will compare the current value being sent and the previous value sent.

## Data consistency recommendations

If your data may have missing values in the sequence, consider the following recommendations.

- Sampling occurs every few minutes and has less than 10% of the expected number of points missing. In this case, the impact should be negligible on the detection results.
- If you have more than 10% missing, there are options to help "fill" the data set. Consider using a linear interpolation method to fill in the missing values and complete the data set. This will fill gaps with evenly distributed values.

Azure AI Anomaly Detector will provide the best results if your time series data is evenly distributed. If the data is more randomly distributed, you can use an aggregation method to create a more even distribution data set.

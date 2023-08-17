Azure AI Anomaly Detector supports batch processing of time series data and last-point anomaly detection for real-time data.

## Batch detection

Batch detection involves applying the algorithm to an entire data series at one time. The concept of time series data involves evaluation of a data set as a batch. Use your time series to detect any anomalies that might exist throughout your data. This operation generates a model using your entire time series data, with each point analyzed using the same model.

Batch detection is best used when your data contains:

- Flat trend time series data with occasional spikes or dips
- Seasonal time series data with occasional anomalies
    - Seasonality is considered to be a pattern in your data, that occurs at regular intervals. Examples would be hourly, daily, or monthly patterns. Using seasonal data, and specifying a period for that pattern, can help to reduce the latency in detection.

When using the batch detection mode, Azure AI Anomaly Detector creates a single statistical model based on the entire data set that you pass to the service. From this model, each data point in the data set is evaluated and anomalies are identified. 

#### Batch detection example 

Consider a pharmaceutical company that stores medications in storage facilities where the temperature in the facilities needs to remain within a specific range. To evaluate whether the medication remained stored in a safe temperature range in the past three months we need to know:

- the maximum allowable temperature
- the minimum allowable temperature
- the acceptable duration of time for temperatures to be outside the safe range

If you are interested in evaluating compliance over historical readings, you can extract the required time series data, package it into a JSON object, and send it to Azure AI Anomaly Detector for evaluation. You will then have a historical view of the temperature readings over time. 

## Real-time detection

Real-time detection uses streaming data by comparing previously seen data points to the last data point to determine if your latest one is an anomaly. This operation generates a model using the data points you send, and determines if the target (current) point is an anomaly. By calling the service with each new data point you generate, you can monitor your data as it's created.

#### Real-time detection example 

Consider a scenario in the carbonated beverage industry where real-time anomaly detection may be useful. The carbon dioxide added to soft drinks during the bottling or canning process needs to stay in a specific temperature range.

Bottling systems use a device known as a carbo-cooler to achieve the refrigeration of the product for this process. If the temperature goes too low, the product will freeze in the carbo-cooler. If the temperature is too warm, the carbon dioxide will not adhere properly. Either situation results in a product batch that cannot be sold to customers.

This carbonated beverage scenario is an example of where you could use streaming detection for real-time decision making. It could be tied into an application that controls the bottling line equipment. You may use it to feed displays that depict the system temperatures for the quality control station. A service technician may also use it to identify equipment failure potential and servicing needs.

You can use Azure AI Anomaly Detector to create a monitoring application configured with the above criteria to perform real-time temperature monitoring. You can perform anomaly detection using both streaming and batch detection techniques. Streaming detection is most useful for monitoring critical storage requirements that must be acted on immediately. Sensors will monitor the temperature inside the compartment and send these readings to your application or an event hub on Azure. Azure AI Anomaly Detector will evaluate the streaming data points and determine if a point is an anomaly.





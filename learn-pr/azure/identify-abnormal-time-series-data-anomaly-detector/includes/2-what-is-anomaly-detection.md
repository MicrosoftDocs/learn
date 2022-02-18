The Azure Anomaly Detector service offers different APIs to enable developers or businesses to detect data deviations faster.  This helps decision-making quicker across various industries.  It also helps identifying problems before they occur.  Developers can integrate the services in their applications without needing to be an expert in machine learning.  But first, let's understand what anomaly detection is.

## What is Azure Anomaly Detection?

The Anomaly Detection is a machine learning technique that monitors and detects abnormalities in time-series data. It is used in many instances to identify unusual behavior patterns, events, outliers, errors, or rare changes in data. This is useful in finding root causes; preventing problems before they happen; removing bad data during data cleansing; or triggering a corrective action. For example, fraud detection, manufacturing glitches, health monitoring systems, financial trends, or customer/product behavior.  A change in data is not always a negative event, it depends on the use case rules.

![Diagram displaying data sources, anomaly detector, and business use cases ](..\media\2-what-is-anomaly-detection-1.png)


## Common challenges of training an anomaly detection model

One of the challenges of identifying anomalies with machine learning is that there are different algorithms for various data patterns. This can be difficult when data trends change frequently. What may be a normal behavior now, may not be normal in a couple of months. For example, seasonal weather changes can impact the air conditioning and heater usage causing a high energy use during the extreme temperatures in the summer and winter time. The downside is a developer or business will need to train multiple models each time the data changes, which are not efficient. Finally having only one variable is not always enough to drill down issues to pinpoint the root cause. You need a combination of multiple variables.  

![Diagram displaying difference data patterns.](..\media\2-what-is-anomaly-detection-2.png)

### Data

Azure Anomaly Detector can use streams of data from sources such as devices, sensors, websites, social media, logs, and other applications. The input has to be time-series data.  Meaning, the input data that is sent to the Anomaly Detector API needs be sequential data that contains both a timestamp and one or more numeric values.  The Anomaly Detector API service offers two types of service modes for you to use depending on the number of metrics are in the time series data: univariate and multivariate.

### What is Univariate Anomaly Detector API?

The univariate Anomaly Detector API service is used when the time-series data only has one metric and a timestamp. The univariate API algorithms automatically adapt by choosing and applying the best-fitting pre-trained model to your data pattern. This is because there are many types of time-series data patterns, but not a single algorithm that fits all. It can be used on historical or real-time continuous data streams to spot irregular data points.  

![Diagram displaying data input, analysis and output of univariate.](..\media\2-what-is-anomaly-detection-3.png)

### What is Multivariate Anomaly Detector API?

The Multivariate Anomaly Detector APIs use time-series data with two or more metrics to identify anomalies.  It makes it possible to see how an outlier detected in one metric relates to other metrics in the dataset.  The service shines when it comes to providing a holistic view of abnormalities from more than one variable. It helps to pinpoint contributors when a problem is found.  The different APIs that the service provides are to train, export, and delete a model using your unique dataset.  Lastly, it provides APIs for model inference and reviewing the JSON results.

![Diagram displaying data input, analysis and output of multivariate.](..\media\2-what-is-anomaly-detection-4.png)

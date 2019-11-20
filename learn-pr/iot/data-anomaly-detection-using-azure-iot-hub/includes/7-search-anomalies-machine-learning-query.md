## Create a second messaging route, to analyze telemetry in real-time

The second message route we need to create uses an Azure Event Hub to handle the, potentially, large volume of data. This route is added to the Azure Stream Analytics job.

The job we created a few units back needs to be updated to handle two inputs and two outputs, and a more complex query.

### Make a call to a machine learning algorithm

The machine learning function we are going to call is built into Azure Stream Analytics. The function is `AnomalyDetection_SpikeAndDip`. 

At its simplest use, the `AnomalyDetection_SpikeAndDip` function takes a _sliding window_ of data, and examines it for anomalies. The sliding window could be, say, the most recent two minutes of telemetry data. This sliding window keeps up with the flow of telemetry in close to real-time (there is some latency). If the size of the sliding window is increased, generally the accuracy of anomaly detection will increase too.

As the flow of data continues, the algorithm establishes a _normal_ range of values, then compares new values against those norms. The result is a score for each value, a percentage that determines the confidence level that the given value is anomalous. Low confidence levels are ignored, the question is what percentage confidence value is acceptable. In our query, we are going to set this at 95%.

There are always complications, like when there are gaps in the data (the conveyor belt stops for a while, perhaps!).

Spikes and dips in telemetry data are temporary anomalies. However, as we are dealing with sine waves for vibration, we can expect that a short period of "normal" values will be returned after a high or low value that triggers an anomaly alert. The operator, man or machine, is looking for a bunch of anomalies occurring in a short time span. This would indicate something is wrong.

There are other built in machine learning functions in Azure, such as detecting trends. We don't include these as part of this module, but the student is encouraged to investigate further.

### Visualize data using Power BI

Visualizing numerical data, especially volumes of it, is a challenge in itself. How can we alert a human operator of the sequence of anomalies that infer something is wrong?

The solution we use in this module is to use some built-in functionality of Power BI. And the ability of Azure Stream Analytics to send data in a real-time format that Power BI can ingest.

We use the dashboard feature of Power BI to create a number of _tiles_. One tile contains the actual vibration measurement. Another tile is a gauge, showing from 0.0 to 1.0 the confidence level that the value is an anomaly. A third tile indicates if the 95% confidence level is reached. The main tile though shows the number of anomalies detected over the past hour. This makes it really clear if a bunch of anomalies were detected in short succession.

The fourth tile includes time as the x-axis. This allows you to compare the anomalies with the red text in the telemetry console window. Are there a bunch of anomalies being detected when forced, or increasing, or both, vibrations are in effect?

To answer this all important question, let's create the second route, update the SQL query, create a Power BI dashboard, and let it all run!

Suppose you work for an electricity company that installs smart meters in residential homes and monitors energy consumption. Most of the company’s customer service calls are complaints about high electricity bills. The company has no way to drill down to find contributors of the high bill. The company wants to build an automated system that collects meter readings of electricity usage in real-time to detect unusual data behavior.  For instance, unusual behavior can be events such as spikes in usage caused from a leaky refrigerator or sudden dips caused by a blown fuse. This will improve customer satisfaction by helping residents reduce their electricity bill and receive prompt maintenance support.

![Diagram displaying ingesting sensor data to iot hub; storing in blog storage and using anomaly detector to analyze.](..\media\1-introduction.png)

Your task to build a solution that monitors energy consumption, identify odd data patterns quickly and pinpoint root-causes.  However, you don’t know how to send the data streams from smart meter devices to the cloud, store the data and detect anomalies.

## Learning objectives
By the end of this module, you'll be able to: 
- Understand what anomaly detection is
- Understand how the Azure Anomaly Detector APIs work and when to use for your scenario
- Build a solution to use a prebuilt Azure Anomaly Detector model on real-time IoT data streams
- Train and evaluate your own model with Azure Anomaly Detector using your unique time-series data
- Find the root cause of an anomaly when you've more than one metric/variable in your data

## Prerequisites
- Basic Python knowledge
- Basic knowledge on how to use Jupyter Notebooks
- Install Anaconda, ONLY if Jupyter Notebook & Python not already installed on your computer. See https://docs.anaconda.com/anaconda/install/index.html
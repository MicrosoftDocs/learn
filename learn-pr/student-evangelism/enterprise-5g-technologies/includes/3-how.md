In our scenario about monitoring patients with dementia, the key elements include:

- Assistive technology: providing verbal or auditory reminders
- Memory problems and daily activities: for example, managing pill dispensers
  - Keeping safe: detecting motion, walking, gait; using locator devices (ex: for keys)
  - Socializing: remote monitoring by carers 

Video analytics is especially beneficial for monitoring and tracking patients with degenerative mental conditions like Alzheimer’s disease and dementia. Patients are often prone to walking away and endangering themselves. In such cases, rapid response is essential. Also, video analytics can be used as a diagnostic and preventative tool. 

Here, we describe how 5G and Azure private multi-access edge compute (MEC) components combine to address the challenges of caring for patients with dementia and Alzheimer’s. 

In this case, the 5G-enabled internet protocol (IP) cameras capture real-time video of the patients in care homes. Then, the on-premises IoT Edge devices analyze the video data in real-time to detect the conditions listed above, such as walking, gait, socialization, and medication routines. Based on the analytics running on edge devices, the system sends an alert to the carer. If an anomaly (such as a deviation from a regular pattern or an emergency) is detected, the carer undertakes an action. Also, over time, the video clips collected are analyzed for trend data in the cloud. 

The steps are:

1. Video is captured in real-time by 5G-enabled IP cameras and sent to a 5G Radio Access Network (RAN) device.
2. From there, the 5G radios in the care homes send the data to the 5G packet core running on the Azure Stack Edge IoT Edge server.
3. The packet core authenticates the devices, applies Quality of Service (QoS) policies, and routes the video traffic to the Azure video analyzer.
4. Azure Video Analyzer also runs on the edge server and provides low latency capabilities for processing and analyzing the video on the edge device necessary for transporting and processing the video feeds.
5. Further processing is performed by the spatial analysis module if needed to detect walk and gait.
6. Based on this analysis, event notifications are sent to the Azure IoT Hub module in the cloud.
7. The IoT Hub records the event notifications in a web app and alerts the carers if any concerns are detected.
8. Finally, the video and events are stored in Azure Media Services Storage account stores for long-term trend analysis and resource planning.


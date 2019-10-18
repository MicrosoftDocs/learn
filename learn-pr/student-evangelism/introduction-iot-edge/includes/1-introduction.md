
For IoT customers, the cloud has made storage and compute costs affordable. Enterprise and industrial customers are connecting IoT devices to the cloud and persisting IoT data in the cloud. However, it is not possible to always manage all IoT data in the cloud due to the need for rapid response times especially for mission-critical applications. If all data were stored in the cloud, then the round trip to the cloud and back would cause high latency, leading to high response times.

Azure IoT Edge brings compute capability closer to the source of the data, that is, to edge devices. IoT Edge provides the ability to move workloads from the cloud to the edge. In doing so, IoT Edge overcomes the problems of latency and response times.

The ability to move computing workloads to edge devices provides other advantages such as deploying artificial intelligence applications on edge devices. Machine learning models can be trained in the cloud and then deployed on edge devices. IoT Edge also provides the ability to run in offline mode and provides the underlying security for reliable operations.  

Suppose the user of the system is a doctor who specializes in diabetic treatment. She wants to monitor the patient's blood glucose level and warn the patient when the glucose level changes are of concern to their health. In this case, the IoT Edge device monitors the glucose level of the patient and stores the data on the device itself. The device pushes summarized data from the edge to the cloud. Algorithms, which run on the device, help to monitor the changes in the level, which could cause concern. The doctor receives an alert from the algorithm running on the IoT Edge device. The alarm is generated rapidly in response to the changing glucose levels because the algorithm is running on the edge device. This notification enables the doctor to respond to the patient immediately. The device also caters for situations where connectivity is poor. The data is stored securely on the device.

![](../media/iot-edge.png)


## Learning objectives

In this module, you will:  

- Evaluate situations where IoT Edge can help in deploying IoT applications to the cloud
- Describe the components of IoT Edge  
- List the capabilities of the IoT Edge for the IoT solutions in the cloud  

## Prerequisites

- Basic programming knowledge in languages such as C, Python, Node.js  
- Basic knowledge of running Azure CLI
- Basic knowledge of IoT applications and IoT Hub


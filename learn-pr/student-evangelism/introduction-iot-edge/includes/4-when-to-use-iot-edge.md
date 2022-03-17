In this section, we discuss how you can decide if IoT Edge is the right solution for you. We'll approach the choice from the perspective of a large enterprise planning an IoT deployment.

##  Decision criteria

|  | Description |
|:---:|---|
| **Near real-time response to local changes** | Does your application need to react quickly to local changes in near real time? IoT Edge can run modules locally on IoT Edge devices to enable faster response to local changes. |
| **Deploy and manage using Containers to IoT Edge devices** | Does your application need to be deployed in docker compatible containers to IoT Edge devices? IoT Edge enables you to use containers to run your logic at the IoT Edge. Containers help to manage software dependencies such as runtimes and libraries, ensuring that the application runs consistently wherever it's deployed. |
| **Security for IoT Edge deployments** | The lack of security for IoT devices is a significant barrier to entry for many enterprises. IoT Edge provides security in several ways. These include integrating with Microsoft Defender for Cloud and by making use of any hardware security modules to provide strong authenticated connections for confidential computing. |
| **Offline or intermittent mode operation** | Does your application need to operate with intermittent of offline connectivity? IoT Edge devices automatically synchronize the latest state of your devices once they've reconnected to the cloud to ensure seamless operations. |
| **AI and analytics workloads to the IoT Edge** | Do you need to run machine learning algorithms on IoT Edge devices? IoT Edge enables you to deploy models built and trained in the cloud and run them on IoT Edge devices. |
| **Optimize data costs** | Management of costs in the deployment of Cloud resources is essential. You can design your system in such a way that data sent to the cloud is reduced by pre-processing on the IoT Edge devices. |
| **Privacy for IoT Edge deployments** | Do you need to ensure compliance for Privacy regulations? IoT Edge can protect personally identifiable data and keep data on-premises in that way improving compliance. |

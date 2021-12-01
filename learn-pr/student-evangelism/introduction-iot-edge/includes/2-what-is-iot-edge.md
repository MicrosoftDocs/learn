Azure IoT Edge is a combination of a cloud service running in the cloud and a runtime that runs on the device. The runtime starts and manages workflows on the device. The workflow comprises a set of containers that you link together in a specific order to create an end-to-end scenario. IoT Edge is managed by the IoT Hub. The Azure IoT Edge enables you to run workloads on the edge device, which are developed using cloud services.  The workload is a module deployed using docker compatible containers. The modules could be artificial intelligence applications, Azure and third-party services, or your business logic.

IoT Edge enables you to:

**React in near real time to local changes:** Because you can implement some functionality at the edge, the device spends less time communicating with the cloud. Hence, the device can react quickly to local changes by processing the data on the device and reducing latency. Also, when modules run locally, they can avail of the option to use specialized hardware such as a field-programmable gate array.

**Manage edge devices:** IoT Edge provides a cloud interface and a runtime module, which enables you to manage remotely and deploy workloads to edge devices through the IoT Hub.

**Deploy using Containers:** IoT Edge allows you to use Docker-compatible containers to run your business logic at the edge.

**Deploy using secure and certified hardware:** IoT Edge enables access to certified IoT Edge hardware on Linux or Windows devices that support container engines.

**Distribute AI and analytics workloads to the edge:** IoT Edge allows you to deploy models built and trained in the cloud and run them on edge devices. IoT Edge uses the model to process data locally and respond to the event rapidly.

**Use existing developer skillsets and code:** IoT Edge code supports languages such as C, C#, Java, Node.js, and Python.  

**Manage data to reduce costs:** IoT Edge devices capture a large amount of data, but typically you only need a small portion of that data for further analysis. If you send all the data to the cloud, the user will incur transportation and storage costs. IoT Edge reduces costs by allowing you only to send a segment of the data as needed. You could also send aggregated data to the cloud. Sending aggregated data to the cloud reduces overall costs of managing data and transporting data through reduced bandwidth and storage costs.   

**Reliably operate in offline or intermittent mode:** Often, IoT devices need to work in intermittent or offline connectivity to the cloud. IoT Edge device management functionality automatically synchronizes the latest state of your devices once they've reconnected to the cloud to ensure seamless operations.  

**Provide security for edge deployments:** IoT Edge provides security in several ways. Working with the IoT Hub, we can ensure that only the right devices can communicate with each other and that they have the right software installed. IoT Edge can provide added security by integrating with Microsoft Defender for Cloud. Also, by IoT Edge can make use of any hardware security modules if available to provide strong authenticated connections for confidential computing.

**Ensure privacy for IoT deployments:** IoT Edge can protect person-related data. Person-related data can be cleansed before it's sent to the cloud, in that way providing better privacy protection. By storing data on-premises, you can comply better with security, confidentiality, and privacy regulations. 

**Act as a gateway:** IoT Edge can function as a protocol gateway and thus provide connectivity and edge analytics to IoT devices that would otherwise not have these capabilities. 

**Availability of third-party modules:** You can use third-party modules from the  Azure marketplace to reduce time to market and enhance the robustness of software solution at the edge.

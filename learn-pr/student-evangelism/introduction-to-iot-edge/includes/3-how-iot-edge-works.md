
Azure IoT Edge comprises three components:

**IoT Edge modules** are units of execution implemented as Docker compatible containers. IoT Edge modules can run business logic at the edge. IoT Edge modules can run Azure services, third-party services, or your own code. Modules are deployed to IoT Edge devices and execute locally on those devices. You can configure modules to communicate with each other to create a pipeline for data processing. Modules can run offline if needed.   

**IoT Edge runtime** runs on each IoT Edge device and manages the runtime and communication for the modules deployed to each device. IoT Edge runtime ensures that the modules are always running and report module health to the cloud. The runtime performs several functions such as installing and updating workloads; maintaining IoT Edge security standards; managing communication between downstream leaf devices and the IoT Edge device; managing communication between modules on an IoT Edge device and managing communications between an IoT Edge device and the cloud.  

IoT Edge runtime may be installed in several possible configurations. Typically, the runtime is deployed at a gateway device, but other options are possible.  Physically, IoT Edge runtime can run on a variety if IoT devices – both Linux and Windows.  

**IoT Edge cloud interface** enables you to remotely monitor and manage IoT Edge devices. To run a diverse set of devices at scale, it is necessary to create and configure a workload to be run on a specific type of device. You then need to deploy the workload to a set of devices of that type. Once the devices are running, you need to monitor workloads centrally. IoT Edge cloud interface allows you to manage this overall lifecycle at scale for a diverse set of devices which are geographically scattered. 

It's challenging to manage the software lifecycle for millions of IoT devices that are often different makes and models or geographically scattered. Workloads are created and configured for a particular type of device, deployed to all of your devices, and monitored to catch any misbehaving devices. These activities can’t be done on a per device basis and must be done at scale.

Consider the case of deploying complex event processing or machine learning on edge devices. If you want to implement machine learning on edge devices, you must first train the model in the cloud. After training the model, you need to deploy the trained model to a diverse range of edge devices across geography. Once deployed, these models will run often offline on the device. You would also need to update the model periodically. By encapsulating the models in docker compatible containers, IoT edge can manage the end-to-end cycle of deployment for machine learning on iot. IoT edge runtime and the cloud interface can monitor the status of the machine learning modules.

In the absence of the IoT edge, the developer would need to create the added functionality of maintaining the module.
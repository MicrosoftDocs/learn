Previously, we introduced the NVIDIA DeepStream SDK, which enables developers to create optimized Intelligent Video Applications (IVA) able to ingest multiple video-input sources, apply cascading inference on processed frames, and produce telemetry that can be published to cloud services like Microsoft Azure.  

We looked at developing applications with the NVIDIA DeepStream SDK using a configuration-file driven approach.  While this method is a highly enabling strategy for IVA development, the NVIDIA Graph Composer takes this approach further by allowing you to generate DeepStream compatible IVA pipelines using a visual editor with drag and drop components.  This mechanism allows you to further simplify development while also allowing you to view how components relate to each other in an interactive graph.

![NVIDIA DeepStream Graph Composer Application](../media/composer-test1.png)

The available components may seem familiar to the Configuration Groups that we used earlier. This is because these components and those Configuration Groups are derived from functions provided in the DeepStream SDK C libraries. These components are made available to the Composer application using a local registry that pulls and stores extensions provided by NVIDIA.  The Composer application also allows for importing custom extensions to support components. 

Once a graph is ready for production, an included `container-builder` tool allows developers to package their Composer Graphs into container workloads capable of running on X86 or ARM64 devices.  This feature enables you to use the Graph Composer to build containerized IVA pipelines that can be deployed to server class or edge capable devices.

The full process for this workflow is depicted below:

![NVIDIA DeepStream Graph Composer Workflow](../media/composer-workflow.png)


### Integrating containerized Graph Composer workloads with Azure IoT Services

The ability to package DeepStream Graph Composer workloads into containers enables the ability to run IVA applications in edge-to-cloud scenarios with various capabilities including device-to-cloud messaging, cloud-to-device messaging, device monitoring, remote updates, and scalable deployment through integration with Azure IoT Edge.

This service offering allows us to instrument a capable device with a runtime that provides orchestration of containerized workloads and secure connectivity into an ingestion point known as an IoT Hub.  

The IoT Edge runtime runs on the physical device where containerized workloads are referred to as "modules".  These modules can communicate between each other using message routing.  For example, one module could produce telemetry and another module would aggregate messages from the first messages using Stream Analytics at the Edge.  Messages from this module could then be published directly to the cloud through a connection to an IoT Hub.


![Azure IoT Runtime](../media/runtime.png)

With devices registered and managed securely from an Azure IoT Hub, it becomes possible to seamlessly deploy updated workloads to devices and also monitor the connectivity status of an entire fleet.  As a result, we can put our DeepStream Graph Composer applications into production with support for all stages of the software development lifecycle. These ares include plugin support for Azure DevOps, ability to modify running workloads using "Module twins", and targeted deployments based on device metadata.


![Azure IoT Hub Cloud Interface](../media/cloud-interface.png)

In this module, we'll explore how to develop applications using the DeepStream Graph Composer, package that output into a containerized workload, then prepare that container for production by publishing it to an Azure Container Registry.  In the follow-up module, we'll look at how to pull that workload from a secure Azure Container Registry and deploy it to an NVIDIA powered embedded device running Azure IoT Edge.

### Try this

Imagine that you have been tasked to develop an IVA application to count people entering into a restaurant establishment.  Now imagine that the CEO loves your proof of concept and wishes to deploy this application to 1,000 locations around the world!  How might you design a strategy to facilitate this deployment and what tools could you use to speed up the development / test cycle?
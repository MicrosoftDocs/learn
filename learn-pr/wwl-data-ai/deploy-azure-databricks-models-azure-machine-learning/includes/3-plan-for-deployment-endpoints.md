After you have trained your machine learning model and evaluated it to the point where you are ready to use it outside your own development or test environment, you need to deploy it somewhere. Azure Machine Learning service simplifies this process. You can use the service components and tools to register your model and deploy it to one of the **available compute targets** so it can be made available as a web service in the Azure cloud, or on an IoT Edge device.

## Available compute targets

You can use the following compute targets to host your web service deployment:

| Compute target                                                    | Usage                     | Description                                                                                |
| ----------------------------------------------------------------- | ------------------------- | ------------------------------------------------------------------------------------------ |
| Local web service                           | Testing/debug             | Good for limited testing and troubleshooting.                                              |
| Azure Kubernetes Service (AKS) | Real-time inference       | Good for high-scale production deployments. Provides autoscaling, and fast response times. |
| Azure Container Instances (ACI) | Testing                   | Good for low scale, CPU-based workloads.                                                   |
| Azure Machine Learning Compute Clusters | Batch inference | Run batch scoring on serverless compute. Supports normal and low-priority VMs.             |
| Azure IoT Edge                               | (Preview) IoT module      | Deploy & serve ML models on IoT devices.                                                   |

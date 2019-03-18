Let's consider the key components of the Azure Machine Learning service. Below is a more detailed diagram of the data science process within the Azure Machine Learning service.

![Screenshot of Azure Machine Learning Service Workspace Key Components](../media/4-key-components-ml-workspace.png)

The process usually is under the umbrella of one workspace. You use Python to request compute targets and query experiment during training phase.

After model registration, an image will be created for deployment. You use Python to run deployed model in Web service or IoT module.

## Glossary for AMLS Architecture

### Workspace

The workspace is the top-level resource for the Azure Machine Learning service. It serves as a hub for building and deploying our models. You can create a workspace in the Azure portal or create and access it using Python on IDE of your choice.

All models need to be registered in the workspace's model registry for future usage. Together with the scoring scripts, you create an image for deployment.

The workspace stores experiment objects which are required for each model you create. In addition, it saves your compute targets. You can track training runs, and retrieve logs, metrics, output, and scripts with ease. This information is important for model evaluation and selection.

### Image

Recall the example in unit one, there are three key components in an image:

- A model and scoring script or application
- An environment file that declares dependencies that are needed by the model, scoring script or application.
- A configuration file that describes required resources.

### Web Service

When deploying your model as a web service, you have the choices of Azure Container Instances, Azure Kubernetes Service, or FPGAs. With your model, script, and associated files all set in the image, you can create a web service.

### IoT Module

The IoT module is a Docker container. As with a web service, you will need your model, associated script, or application, and any additional dependencies. See Azure IoT Edge (https://docs.microsoft.com/azure/iot-edge/) to learn more about the service. It enables you to monitor the hosting device.

### Datastore

A datastore is a storage abstraction over an Azure storage account.

### Pipeline

Machine learning pipeline is a tool to create and manage workflows during a data science process, which typically includes data manipulation, model training and testing, and deployment phases. Each step of the process can run unattended in different compute targets which makes it easier to allocate resources.

### Compute Target

A compute target is the compute resource to run training script or host service deployment. It is attached to a workspace. Compute targets, other than the local machine, are shared by users of the workspace.

### Log to the Experimentation Service

You can log information during the pipeline execution. 
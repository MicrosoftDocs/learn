## Overview

In this module, your objective is to train a machine learning model and deploy the trained model into an Azure Machine Learning container. The components required for training the model and deploying the container are in the [AI Toolkit for Azure IoT Edge Git repo](https://github.com/Azure/ai-toolkit-iot-edge/tree/master/IoT Edge anomaly detection tutorial). You'll run the notebook in the exercise below.  

Firstly, you **set up the parameters** for the IoT Hub and Azure ML workspace. These include the resource group, the Azure region, your Azure IoT Hub name, IoT Edge device ID, Azure subscription ID, your Azure ML service workspace name. You should also specify the module name that is "machinelearningmodule". In this case, **we're using the decision tree classifier as an anomaly detector**. You'll **build, evaluate, and test** the model. You'll also **store the model to disk** and then **register the model**  

You'll next use the registered model to **create a docker image**. You can then **test the performance of your model** by deploying the container to Azure container instance (ACI).  Call the web service with some dummy input data to **get a prediction**.

Finally, you'll **deploy the container to Azure IoT Edge device**. You create a **deployment.json file** that contains the modules you want to deploy to the device and the routes. Then you **push this file to the IoT Hub**, which will then **send it to the IoT Edge device**. The IoT Edge agent will then pull the Docker images and run them. In the sections below, we describe these steps in greater detail.   

## Azure model management

Building the machine learning is only the first step towards deploying it in production on edge devices. The workflow for deploying models production is:  

1.	Register the model.

2.	Prepare to deploy. (Specify assets, usage, compute target.)

3.	Deploy the model to the compute target.

4.	Test the deployed model as a web service.

Firstly, after building the model, you must register it. A registered model is a logical grouping for one or more files that make up your model. The model is then packaged into a Docker image.  Ultimately, you deploy the model as a web service in the cloud or locally. Some additional steps may be needed during deployment. These include profiling to determine the ideal CPU and memory settings or model conversion to optimize performance.  

### Preparing to deploy the model  

You can use the following compute targets/compute resources to host your web service deployment.  

Local web service

Azure Machine Learning compute instance web service

Azure Kubernetes Service (AKS)

Azure Container Instances

Azure Machine Learning compute clusters

Azure Functions

Azure IoT Edge

Azure Data Box Edge.  

In this instance, you'll use **Azure Container Instance** as a compute target.  After the model is created in a container, you can deploy the model as a container as a web service to IoT Edge devices.

To deploy the model, you need the following items:

- **An entry script**. This script accepts requests, scores the requests by using the model and returns the results. The entry script is specific to your model.  
- **Dependencies**, like helper scripts or Python/Conda packages required to run the entry script or model.
- **The deployment configuration** for the compute target that hosts the deployed model. This configuration describes things like memory and CPU requirements needed to run the model.

These items are encapsulated into an *inference configuration* and a *deployment configuration*. The inference configuration references the entry script and other dependencies. You define these configurations programmatically when you use the SDK to perform the deployment. You define them in JSON files when you use the CLI.

The entry script receives data submitted to a deployed web service and passes it to the model. It then takes the response returned by the model and returns that to the client. 

The script contains two functions that load and run the model:

- init(): Typically, this function loads the model into a global object. This function is run only once when the Docker container for your web service is started.
- run(input_data): This function uses the model to predict a value based on the input data. Inputs and outputs of the run typically use JSON for serialization and deserialization. You can also work with raw binary data. You can transform the data before sending it to the model or before returning it to the client.

### Create Docker Image

Deployed models are packaged as a docker image. The image contains the dependencies needed to run the model all along with the logic to score new data. For Azure Container Instance, the azureml.core.image.ContainerImage class is used to create an image configuration. The image configuration is then used to create a new Docker image.

Once you have an image registered, you need to build the image using the ContainerImage  

### Deploy the image in your compute target

To deploy the image you created, you first need to specify the target you want to use. In our case, that is the Azure container instance (ACI). You then use the AciWebservice class to configure and deploy from an image. 

### Deploy container to Azure IoT Edge device

You create a deployment.json file that contains the modules you want to deploy to the device and the routes. You should then push this file to the IoT Hub, which will then send it to the IoT Edge device. The IoT Edge agent will then pull the Docker images and run them. At this point, you should be able to monitor messages from your edge device to your IoT Hub. 
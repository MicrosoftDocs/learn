To understand Azure Machine learning service, let's consider how it fits into the data science process shown below.

![Screenshot of Azure Machine Learning Service](../media/3-ml-service-framework.png)

## Environment Setup

You start by creating a workspace, a place for your machine learning work to be stored in Azure. The workspace can be created in the Azure portal or from within Python code. An experiment object is created within the workspace to store information about runs for the models you train and test. You can have multiple experiment objects in a workspace.

Azure Machine Learning Service allows you to interact with the workspace using your preferred IDE such as a local Jupyter Notebook, PyCharm, or an Azure Notebook (a cloud version of Jupyter Notebook). It's easy to configure the environment as you will see later in this module.

## Data Preparation

Before you can train a model, you need to explore and analyze the source data to determine its quality and select data for model features. Typically, this involves statistical analysis and use of visualizations. Then, in the data wrangling step, you clean up the data and apply transformations to prepare it for use in model training.

You can use whatever Python modules you like for data preparation including pandas or the Azure Machine Learning Data Preparation SDK called azureml.dataprep.

## Experimentation

Experimentation is the iterative process of model training and testing. Open-source packages like Scikit-learn, Tensorflow, and others are all supported.

After building the model, you can train it locally or on a remote machine.

A key feature of the Azure Machine Learning service is the ability to run model training and evaluation in Azure containers. It's easy to monitor the remote model execution and retrieve output using the azureml package. You also need to create and configure a compute target object used to provision computing resource.

Once you have the model you want to use in production, you register the model to the model registry in the workspace.

Step Review: Build Model -> Train and Test Model (Locally or Remotely) -> Configure Compute target -> Register Model.

## Deployment

Once you make sure the model runs correctly in the local environment and is performing at the accuracy level you want, you can deploy the model.

You will create a docker image and then deploy it to Azure Container Instances (ACI). Note: Other target environments available are Azure Kubernetes Service (AKS), Azure IoT Edge, and a field-programmable gate array. For the deployment, you need the following files.

1. Score scripts file to decide how to run the model;
2. Environment file to specify package dependencies, which are important when using open-source packages;
3. Configuration file to request appropriate amount of resource for the container

Steps Review: Review Model -> Build an Image -> Deploy to Web Service.
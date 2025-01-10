In this module, you learn how to use AutoML to train a labeled dataset and develop a production object detection model. AutoML is the process of automating the time-consuming and iterative tasks of machine learning model development. It allows data scientists, analysts, and developers to build Machine Learning models with high scale, efficiency, and productivity all while sustaining model quality. AutoML in Azure Machine Learning is based on a breakthrough from our [Microsoft Research division](https://www.microsoft.com/research/project/automl/).

Traditional machine learning model development is resource-intensive, requiring significant domain knowledge and time to produce and compare dozens of models. With AutoML, you accelerate the time it takes to get production-ready Machine Learning models with great ease and efficiency.

### Prerequisites

- [Azure Free Trial Account](https://azure.microsoft.com/pricing/purchase-options/azure-account?icid=azurefreeaccount)

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=eddb2bd4-407e-470d-8fe9-6e60585b9910]

## Scenario: Use AutoML to train a labeled dataset and develop a production model

You're a data scientist who's been assigned the task of improving automation in a manufacturing facility using computer vision. Your team completed the process of gathering and labeling sample image data. This process is in preparation for training an object detection model that'll be used at the site of manufacture. You would like to investigate the performance of this model on various edge and server devices.  

With Azure Machine Learning, you can use AutoML to build a model using Azure Machine Learning Python SDK and convert it to the [ONNX, or Open Neural Network Exchange](https://onnx.ai/), format. Once the model is in the ONNX format, it can be run on various platforms and devices. You'll develop the model using a Jupyter notebook running on a compute instance that was previously deployed in your Azure Machine Learning studio environment. This allows the team to easily retrain a new model when new sample data is provided in the associated datastore to support continuous deployment using [MLOps](/azure/machine-learning/concept-model-management-and-deployment) best practices.

## What will you learn?

After you finish this module, you'll be able to:

- Author AutoML models for vision tasks via the Azure Machine Learning Python SDK.
- Seamlessly integrate with the Azure Machine Learning data labeling capability.
- Optimize model performance by specifying the model algorithm and tuning the hyperparameters.
- Operationalize at scale, using Azure Machine Learning MLOps capabilities.
- Download the resulting model for use in a production deployment.

## What is the main goal?

This module shows you how to use AutoML to train a labeled dataset and develop a production object detection model.

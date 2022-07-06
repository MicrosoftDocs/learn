In this module, you'll learn how to use AutoML to train a labeled dataset and develop a production object detection model. Automated machine learning, also referred to as automated ML or AutoML, is the process of automating the time-consuming, iterative tasks of machine learning model development. It allows data scientists, analysts, and developers to build ML models with high scale, efficiency, and productivity all while sustaining model quality. Automated ML in Azure Machine Learning is based on a breakthrough from our [Microsoft Research division](https://www.microsoft.com/research/project/automl/). 

Traditional machine learning model development is resource-intensive, requiring significant domain knowledge and time to produce and compare dozens of models. With automated machine learning, you'll accelerate the time it takes to get production-ready ML models with great ease and efficiency.

### Prerequisites

- [Azure Free Trial Account](https://azure.microsoft.com/free/)

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE2Xc9t]

## Scenario: Use AutoML to train a labeled dataset and develop a production model

You're a data scientist who has been assigned the task of improving automation in a manufacturing facility using computer vision. Your team has completed the process of gathering and labeling sample image data in preparation for training an object detection model that will be used at the site of manufacture.  You would like to investigate the performance of this model on various edge and server devices.  With Azure Machine Learning, you can use automated ML to build a model using Azure ML Python SDK and have it converted to the [ONNX](https://onnx.ai/) format. Once the model is in the ONNX format, it can be run on various platforms and devices.  You'll develop the model using a Jupyter notebook running on a compute instance that was previously deployed in your Azure Machine Learning studio environment.  This will allow the team to easily retrain a new model when new sample data is provided in the associated datastore to support continuous deployment using [MLOps](https://docs.microsoft.com/azure/machine-learning/concept-model-management-and-deployment) best practices.

## What will you learn?

After you finish this module, you'll be able to:

- Author AutoML models for vision tasks via the Azure ML Python SDK
- Seamlessly integrate with the Azure Machine Learning data labeling capability
- Optimize model performance by specifying the model algorithm and tuning the hyperparameters
- Operationalize at scale, leveraging Azure Machine Learning MLOps capabilities
- Download the resulting model for use in a production deployment

## What is the main goal?

This module will show you how to use AutoML to train a labeled dataset and develop a production object detection model. 
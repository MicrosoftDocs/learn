After training, you want to deploy a machine learning model in order to integrate the model with an application. In Azure Machine Learning, you can easily deploy a model to a batch or online endpoint when you register the model with **MLflow**. 

Imagine you're a data scientist, working for a company that creates an application for health care practitioners to help diagnose diabetes in patients. The practitioners enter a patient's medical information and expect a response from the application, indicating whether a patient is likely to have diabetes or not.

You expect to regularly retrain the model that predicts diabetes. Whenever you have more training data, you want to retrain the model to produce a better performing model. Every time the model is retrained, you want to update the model that is deployed to the endpoint and integrated with the application. By doing so, you're providing the practitioners with the latest version of the model anytime they use the application.

You'll learn how to register a model with MLflow in Azure Machine Learning to prepare the model for deployment. 

## Learning objectives 

In this module, you'll learn how to:

- Log models with MLflow.
- Understand the MLmodel format.
- Register an MLflow model in Azure Machine Learning.


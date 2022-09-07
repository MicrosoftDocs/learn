You can use the Azure Machine Learning CLI (v2) to deploy trained machine learning models automatically as part of machine learning operations (MLOps).

The data science team you work with has trained a classification model that is able to predict whether someone has diabetes, based on some medical information. Your work as a machine learning engineer, is to establish a process that can automatically deploy the trained model to production.

Using the Azure Machine Learning CLI (v2), you want to set up an automated workflow that will be triggered when a new model is registered. Once the workflow is triggered, the new registered model will be deployed to the production environment. 

## Learning objectives

In this module, you'll learn how to:

- Deploy a model to a managed endpoint.
- Trigger model deployment with GitHub Actions.
- Test the deployed model.
You can manually deploy a model with the Azure Machine Learning workspace. To automatically deploy a model, you can use the Azure Machine Learning CLI (v2) and GitHub Actions. To automatically deploy a model with GitHub Actions, you'll have to:

- Package and register the model.
- Create an endpoint and deploy the model.
- Test the deployed model.

## Package and register the model

Whenever you want to deploy a model with the Azure Machine Learning workspace, you'll need to save the model's output and **register** the model in the workspace. When you register the model, you specify whether you have an MLflow or custom model. 

When you create and log a model with MLflow, you can use no-code deployment. 

> [!Tip]
> Learn more about [how to deploy MLflow models.](/azure/machine-learning/how-to-deploy-mlflow-models?tabs=fromjob%2Cmir%2Cendpoint)

To log your model with MLflow, enable autologging in your training script by using `mlflow.autolog()`.

When you log a model during model training, the model is stored in the job output. Alternatively, you can store the model in an Azure Machine Learning datastore. 

To register the model, you can point to either a job's output, or to a location in an Azure Machine Learning datastore. 

## Create an endpoint and deploy the model

To deploy the model to an endpoint, you first create an endpoint and then deploy the model. An endpoint is an HTTPS endpoint that the web app can send data to and get a prediction from. You want the endpoint to remain the same, even after you deploy an updated model to the same endpoint. When the endpoint remains the same, the web app won't need to be updated every time the model is retrained.

> [!Tip]
> Learn more about [how to deploy a model with the Azure Machine Learning CLI (v2).](/learn/modules/deploy-azure-machine-learning-model-managed-endpoint-cli-v2/)

## Test the model

Finally, you'll want to test the deployed model before integrating the endpoint with the web app. Or before converting all traffic of an endpoint to the updated model. You can manually test an online endpoint or you can automate testing the endpoint with GitHub Actions. 

> [!Note]
> You can add a test task to the same workflow as the model deployment task. However, model deployment may take a while to complete. You therefore need to ensure that the testing only happens when the model deployment is completed successfully. 
The easiest way to deploy a model to an online endpoint is to use an **MLflow** model and deploy it to a *managed* online endpoint. Azure Machine Learning will automatically generate the scoring script and environment for MLflow models.

To deploy an MLflow model, you need to have created an endpoint. Then you can deploy the model to the endpoint.

## Deploy an MLflow model to an endpoint

When you deploy an MLflow model to a managed online endpoint, you don´t need to have the scoring script and environment. 

To deploy an MLflow model, you must have model files stored on a local path or with a registered model. You can log model files when training a model by using MLflow tracking. 

In this example, we're taking the model files from a local path. The files are all stored in a local folder called `model`. The folder must include the `MLmodel` file, which describes how the model can be loaded and used.

> [!Tip]
> Learn more about [the MLmodel format](/azure/machine-learning/concept-mlflow-models#the-mlmodel-format?azure-portal=true).

Next to the model, you also need to specify the compute configuration for the deployment:

- `instance_type`: Virtual machine (VM) size to use. [Review the list of supported sizes](/azure/machine-learning/reference-managed-online-endpoints-vm-sku-list?azure-portal=true).
- `instance_count`: Number of instances to use.

To deploy (and automatically register) the model, run the following command:

```python
from azure.ai.ml.entities import Model, ManagedOnlineDeployment
from azure.ai.ml.constants import AssetTypes

# create a blue deployment
model = Model(
    path="./model",
    type=AssetTypes.MLFLOW_MODEL,
    description="my sample mlflow model",
)

blue_deployment = ManagedOnlineDeployment(
    name="blue",
    endpoint_name="endpoint-example",
    model=model,
    instance_type="Standard_F4s_v2",
    instance_count=1,
)

ml_client.online_deployments.begin_create_or_update(blue_deployment).result()
```

> [!Tip]
> Explore the reference documentation to [create a managed online deployment with the Python SDK v2](/python/api/azure-ai-ml/azure.ai.ml.entities.managedonlinedeployment?azure-portal=true).

Since only one model is deployed to the endpoint, you want this model to take 100% of the traffic. When you deploy multiple models to the same endpoint, you can distribute the traffic among the deployed models.

To route traffic to a specific deployment, use the following code:

```python
# blue deployment takes 100 traffic
endpoint.traffic = {"blue": 100}
ml_client.begin_create_or_update(endpoint).result()
```

To delete the endpoint and all associated deployments, run the command:

```python
ml_client.online_endpoints.begin_delete(name="endpoint-example")
```

> [!Tip]
> Learn more about [deploying MLflow models](/azure/machine-learning/how-to-deploy-mlflow-models?azure-portal=true)
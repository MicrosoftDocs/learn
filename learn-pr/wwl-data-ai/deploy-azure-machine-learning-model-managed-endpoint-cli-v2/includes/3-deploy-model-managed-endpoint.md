When you want to get real-time predictions from your model, you can deploy to an online endpoint. The benefit of using a managed online endpoint is that you don't have to manage the underlying infrastructure. You do need to create the endpoint and deploy a model to the endpoint.

Here you'll learn how to create a managed online endpoint and how to deploy a model to the endpoint.

## Create an endpoint

Create an endpoint:

Include the following parameters in the YAML configuration to create a managed online endpoint:

- `name`: Name of the endpoint. Must be unique in the Azure region.
- `traffic`: (Optional) Percentage of traffic from the endpoint to divert to each deployment. Sum of traffic values must be 100.
- `auth_mode`: Use `key` for key-based authentication. Use `aml_token` for Azure Machine Learning token-based authentication.

For example, to create a key-based authenticated endpoint, use this YAML configuration:

```yml
$schema: https://azuremlschemas.azureedge.net/latest/managedOnlineEndpoint.schema.json
name: mlflow-endpoint
auth_mode: key
```

To actually create the endpoint, use the following command:

```azurecli
az ml online-endpoint create --name diabetes-mlflow -f ./mslearn-aml-cli/Allfiles/Labs/05/mlflow-endpoint/create-endpoint.yml
```

> [!Tip]
> Learn more about [managing online endpoint with the CLI (v2)](/cli/azure/ml/online-endpoint).

## Deploy a model to an endpoint

To deploy a model, you must have:

- Model files stored on local path or registered model
- Scoring script
- Environment
- Instance type and scaling capacity
    - `instance_type`: VM SKU that will host your deployment instance.
    - `instance_count`: Number of instances in the deployment.

When you deploy a MLflow model to a managed online endpoint, you don´t need to have the scoring script and environment. 

To define the deployment for a MLflow model, use a YAML configuration like this:

```yml
$schema: https://azuremlschemas.azureedge.net/latest/managedOnlineDeployment.schema.json
name: mlflow-deployment
endpoint_name: churn-endpoint
model:
  name: mlflow-sklearn-model
  version: 1
  local_path: model
  model_format: mlflow
instance_type: Standard_F2s_v2
instance_count: 1
```

In this example, we're taking the model files from a local path. The files are all stored in a local folder called `model`. When this YAML is submitted to deploy the model to the endpoint `churn-endpoint`, the model will be registered in the Azure Machine Learning workspace as `mlflow-sklearn-model`, version 1.

To deploy (and automatically register) the model, run the following command:

```azurecli
az ml online-deployment create --name mlflow-deployment --endpoint diabetes-mlflow -f ./mslearn-aml-cli/Allfiles/Labs/05/mlflow-endpoint/mlflow-deployment.yaml --all-traffic
```

> [!Tip]
> Learn more about how to [manage online deployments with the CLI (v2)](/cli/azure/ml/online-deployment).

Here, all traffic to the endpoint will be routed to this one deployment because we use `--all-traffic`. If you want to deploy multiple models to the endpoint, you can reconfigure traffic to route incoming requests to the different deployments.

For example, if after testing you want to reroute all traffic to the green deployment, which uses the newest version of the model, use the following command:

```azurecli
az ml online-endpoint update --name churn-endpoint --traffic "blue=0 green=100"
```

To delete the endpoint and all associated deployments, run the command:

```azurecli
az ml online-endpoint delete --name churn-endpoint --yes --no-wait
```

> [!Tip]
> Learn more about [deploying a MLflow model to a managed online endpoint](/azure/machine-learning/how-to-deploy-mlflow-models-online-endpoints?tabs=endpoint%2Cstudio)
To make a machine learning model available for other applications, you can deploy the model to a managed online endpoint.

You'll learn how to use managed online endpoints for real-time predictions.

## Real-time predictions

To get real-time predictions, you can deploy a model to an endpoint. An **endpoint** is an HTTPS endpoint to which you can send data, and which will return a response (almost) immediately.

Any data you send to the endpoint will serve as the input for the scoring script hosted on the endpoint. The scoring script loads the trained model to predict the label for the new input data, which is also called **inferencing**. The label is then part of the output that's returned.

## Managed online endpoint

Within Azure Machine Learning, there are two types of online endpoints:

- **Managed online endpoints**: Azure Machine Learning manages all the underlying infrastructure.
- **Kubernetes online endpoints**: Users manage the Kubernetes cluster which provides the necessary infrastructure.

As a data scientist, you may prefer to work with managed online endpoints to test whether your model works as expected when deployed. If a Kubernetes online endpoint is required for control and scalability, it'll likely be managed by other teams.

If you're using a managed online endpoint, you only need to specify the virtual machine (VM) type and scaling settings. Everything else, such as provisioning compute power and updating the host operating system (OS) is done for you automatically.

## Deploy your model

After you create an endpoint in the Azure Machine Learning workspace, you can deploy a model to that endpoint. To deploy your model to a managed online endpoint, you need to specify four things:

- **Model assets** like the model pickle file, or a **registered model** in the Azure Machine Learning workspace.
- **Scoring script** that loads the model.
- **Environment** which lists all necessary packages that need to be installed on the compute of the endpoint.
- **Compute configuration** including the needed **compute size** and **scale settings** to ensure you can handle the amount of requests the endpoint will receive.

> [!Important]
> When you deploy MLFlow models to an online endpoint, you don't need to provide a scoring script and environment, as both are automatically generated.

All of these elements are defined in the deployment. The deployment is essentially a set of resources needed to host the model that performs the actual inferencing.

## Blue/green deployment

One endpoint can have multiple deployments. One approach is the **blue/green deployment**.

Let's take the example of the restaurant recommender model. After experimentation, you select the best performing model. You use the blue deployment for this first version of the model. As new data is collected, the model can be retrained, and a new version is registered in the Azure Machine Learning workspace. To test the new model, you can use the green deployment for the second version of the model.

Both versions of the model are deployed to the same endpoint, which is integrated with the application. Within the application, a user selects a restaurant, sending a request to the endpoint to get new real-time recommendations of other restaurants the user may like. 

When a request is sent to the endpoint, 90% of the traffic can go to the blue deployment*, and 10% of the traffic can go to the *green deployment*. With two versions of the model deployed on the same endpoint, you can easily test the model. 

After testing, you can also seamlessly transition to the new version of the model by redirecting 90% of the traffic to the green deployment. If it turns out that the new version doesn't perform better, you can easily roll back to the first version of the model by redirecting most of the traffic back to the blue deployment.

Blue/green deployment allows for multiple models to be deployed to an endpoint. You can decide how much traffic to forward to each deployed model. This way, you can switch to a new version of the model without interrupting service to the consumer.

> [!Tip]
> Learn more about [safe rollout for online endpoints](/azure/machine-learning/how-to-safely-rollout-online-endpoints?azure-portal=true)

## Create an endpoint

To create an online endpoint, you'll use the `ManagedOnlineEndpoint` class, which requires the following parameters:

- `name`: Name of the endpoint. Must be unique in the Azure region.
- `auth_mode`: Use `key` for key-based authentication. Use `aml_token` for Azure Machine Learning token-based authentication.

To create an endpoint, use the following command:

```python
from azure.ai.ml.entities import ManagedOnlineEndpoint

# create an online endpoint
endpoint = ManagedOnlineEndpoint(
    name="endpoint-example",
    description="Online endpoint",
    auth_mode="key",
)

ml_client.begin_create_or_update(endpoint).result()
```

> [!Tip]
> Explore the reference documentation to [create a managed online endpoint with the Python SDK v2](/python/api/azure-ai-ml/azure.ai.ml.entities.managedonlineendpoint?azure-portal=true).
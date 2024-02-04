To get a model to generate batch predictions, you can deploy the model to a batch endpoint. 

You'll learn how to use batch endpoints for asynchronous batch scoring.

## Batch predictions

To get batch predictions, you can deploy a model to an endpoint. An **endpoint** is an HTTPS endpoint that you can call to trigger a batch scoring job. The advantage of such an endpoint is that you can trigger the batch scoring job from another service, such as Azure Synapse Analytics or Azure Databricks. A batch endpoint allows you to integrate the batch scoring with an existing data ingestion and transformation pipeline.

Whenever the endpoint is invoked, a batch scoring job is submitted to the Azure Machine Learning workspace. The job typically uses a **compute cluster** to score multiple inputs. The results can be stored in a datastore, connected to the Azure Machine Learning workspace.

## Create a batch endpoint

To deploy a model to a batch endpoint, you'll first have to create the batch endpoint. 

To create a batch endpoint, you'll use the `BatchEndpoint` class. Batch endpoint names need to be unique within an Azure region.

To create an endpoint, use the following command:

```python
# create a batch endpoint
endpoint = BatchEndpoint(
    name="endpoint-example",
    description="A batch endpoint",
)

ml_client.batch_endpoints.begin_create_or_update(endpoint)
```

> [!Tip]
> Explore the reference documentation to [create a batch endpoint with the Python SDK v2](/python/api/azure-ai-ml/azure.ai.ml.entities.batchendpoint?azure-portal=true).

## Deploy a model to a batch endpoint

You can deploy multiple models to a batch endpoint. Whenever you call the batch endpoint, which triggers a batch scoring job, the **default deployment** will be used unless specified otherwise.

:::image type="content" source="../media/batch-details.png" alt-text="Screenshot of details page of a batch endpoint, showing the default deployment.":::

## Use compute clusters for batch deployments

The ideal compute to use for batch deployments is the Azure Machine Learning compute cluster. If you want the batch scoring job to process the new data in parallel batches, you need to provision a compute cluster with more than one maximum instances.

To create a compute cluster, you can use the `AMLCompute` class. 

```python
from azure.ai.ml.entities import AmlCompute

cpu_cluster = AmlCompute(
    name="aml-cluster",
    type="amlcompute",
    size="STANDARD_DS11_V2",
    min_instances=0,
    max_instances=4,
    idle_time_before_scale_down=120,
    tier="Dedicated",
)

cpu_cluster = ml_client.compute.begin_create_or_update(cpu_cluster)
```


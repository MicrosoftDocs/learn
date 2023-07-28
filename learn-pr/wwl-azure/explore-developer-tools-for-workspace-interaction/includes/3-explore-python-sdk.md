

> [!Important]
> Currently, there are two versions of the Python SDK: version 1 (v1) and version 2 (v2). For any new projects, you should use v2 and therefore, **the content in this unit only covers v2**. Learn more about [deciding between v1 and v2](/azure/machine-learning/how-to-migrate-from-v1?azure-portal=true).

Data scientists can use Azure Machine Learning to train, track, and manage machine learning models. As a data scientist, you'll mostly work with the assets within the Azure Machine Learning workspace for your machine learning workloads. 

As most data scientists are familiar with Python, Azure Machine Learning offers a software development kit (SDK) so that you can interact with the workspace using Python.

The Python SDK for Azure Machine Learning is an ideal tool for data scientists that can be used in any Python environment. Whether you normally work with Jupyter notebooks, Visual Studio Code, you can install the Python SDK and connect to the workspace.

## Install the Python SDK

To install the Python SDK within your Python environment, you need Python 3.7 or later. You can install the package with `pip`:

```
pip install azure-ai-ml
```

> [!Note]
> When working with notebooks within the Azure Machine Learning studio, the new Python SDK is already installed when using Python 3.10 or later. You can use the Python SDK v2 with earlier versions of Python, but you'll have to install it first.

## Connect to the workspace

After the Python SDK is installed, you'll need to connect to the workspace. By connecting, you're authenticating your environment to interact with the workspace to create and manage assets and resources.

To authenticate, you need the values to three necessary parameters:

- `subscription_id`: Your subscription ID.
- `resource_group`: The name of your resource group.
- `workspace_name`: The name of your workspace.

Next, you can define the authentication by using the following code:

```python
from azure.ai.ml import MLClient
from azure.identity import DefaultAzureCredential

ml_client = MLClient(
    DefaultAzureCredential(), subscription_id, resource_group, workspace
)
```

After defining the authentication, you need to call `MLClient` for the environment to connect to the workspace. You'll call `MLClient` anytime you want to create or update an asset or resource in the workspace. 

For example, you'll connect to the workspace when you create a new job to train a model:

```python
from azure.ai.ml import command

# configure job
job = command(
    code="./src",
    command="python train.py",
    environment="AzureML-sklearn-0.24-ubuntu18.04-py37-cpu@latest",
    compute="aml-cluster",
    experiment_name="train-model"
)

# connect to workspace and submit job
returned_job = ml_client.create_or_update(job)
``` 

## Use the reference documentation

To efficiently work with the Python SDK, you'll need to use the reference documentation. In the reference documentation, you'll find all possible classes, methods, and parameters available within the Python SDK.

[The reference documentation on the `MLClient` class](/python/api/azure-ai-ml/azure.ai.ml.mlclient?azure-portal=true) includes the methods you can use to connect and interact with the workspace. Moreover, it also links to the possible operations for the various entities like how to list the existing datastores in your workspace.
 
[The reference documentation also includes a list of the classes for all entities](/python/api/azure-ai-ml/azure.ai.ml.entities?azure-portal=true) you can interact with. For example, separate classes exist when you want to create a datastore that links to an Azure Blob Storage, or to an Azure Data Lake Gen 2. 

By selecting a specific class like `AmlCompute` from the list of entities, you can find [a more detailed page on how to use the class and what parameters it accepts](/python/api/azure-ai-ml/azure.ai.ml.entities.amlcompute?azure-portal=true). 

Within the Azure Machine Learning, it's common to work with assets such as compute resources, environments, and datasets to train machine learning models. With the Azure CLI, you can easily create and manage those assets.

You want to train the machine learning model to predict customer churn in the workspace you created. To run the notebook that trains the model, you need to create a compute resource and environment in the Azure Machine Learning workspace. The notebook uses a CSV dataset, and to refer to that data, you'll also create a dataset in the workspace.

You'll learn how to use the Azure CLI (v2) to create compute resources, an environment, and a dataset in the Azure Machine Learning workspace.

## Compute resources

To run a Python notebook or script in the Azure Machine Learning workspace, you need a compute resource. There are two types of compute resources that you most commonly use to train a model:

- **Compute instance**: A compute instance is a cloud-based workspace you can use as a developing environment. You can use tools like Jupyter and VS Code with a compute instance to collaborate on notebooks and scripts. You can choose the VM size of the compute instance and start and stop it manually or automatically based on a schedule.
- **Compute cluster**: A compute cluster is a managed-compute infrastructure that scales up automatically when a job is submitted. You can create a single or multi-node compute cluster based on the VM size of your choosing. A compute cluster is more commonly used to run scheduled jobs and pipelines.

### Create a compute instance

The data science team told you they want to use Azure Machine Learning to collaborate on machine learning projects more effectively. Most of the data scientists were working with Jupyter on their own computer. The easiest way to migrate the customer churn project to Azure Machine Learning is by taking the data and the notebook, and run the notebook on a compute instance.

To create a compute instance with the CLI (v2), you can use the `az ml compute create` command. You'll need to decide on these parameters:

- `--resource-group`: Name of resource group. If you configured a default group with `az configure --defaults group=<name>`, you don't need to use this parameter.
- `--workspace-name`: Name of the Azure Machine Learning workspace. If you configured a default workspace with `az configure --defaults workspace=<name>`, you don't need to use this parameter.
- `--name`: Name of compute target. The name should be fewer than 24 characters and unique within an Azure region.
- `--size`: VM size to use for the compute instance. Learn more about [supported VM series and sizes](/azure/machine-learning/concept-compute-target).
- `--type`: Type of compute target. To create a compute instance, use `ComputeInstance`.

> [!Note]
> All code examples assume there is a default resource group and Azure Machine Learning workspace configured.

To create a compute instance to train the customer churn model, you use this command:

```azurecli
az ml compute create --name "testdev-vm" --size STANDARD_DS11_V2 --type ComputeInstance
```

For more information to create compute resources with the CLI (v2), see [az ml compute create](/cli/azure/ml/compute).

### Create a compute cluster

You plan to first train the customer churn model by running the notebook with the compute instance. When you're successful, you want to train the model with a compute cluster. Training the model with a compute cluster means you can schedule a job to retrain the model whenever it's needed.

To create a compute cluster with the CLI (v2), you use the `az ml compute create` command. There are some additional settings you can include when creating a compute cluster:

- `--type`: To create a compute cluster, use `AmlCompute`.
- `--min-instances`: The minimum number of nodes used on the cluster. The default is 0 nodes.
- `--max-instances`: The maximum number of nodes. The default is 4.

```azurecli
az ml compute create --name "aml-cluster" --size STANDARD_DS11_V2 --max-instances 2 --type AmlCompute
```

To learn more on how to create and manage a compute cluster, see the [how-to guide on creating an Azure Machine Learning compute cluster](/azure/machine-learning/how-to-create-attach-compute-cluster?tabs=python).

## Create an environment

You expect to use a compute cluster in the future to retrain the model whenever needed. To train the model on either a compute instance or compute cluster, all necessary packages need to be installed on the compute to run the code. Instead of manually installing these packages every time you use a new compute, you can list them in an **environment**.

Every Azure Machine Learning workspace will by default have a list of curated environments when you create the workspace. Curated environments include common machine learning packages to train a model.

If you need to create your own environment because none of the curated environments meet your needs, you can do so with the `az ml environment create` command:

```azurecli
az ml environment create --file basic-env.yml
```

To create an environment within your workspace that you can reuse at any time, you need to refer to a YAML file. In that file you can specify:

- The name of the environment as it will be known in the workspace.
- The version of the environment.
- The base Docker image.
- The local path to Conda environment file listing the packages and libraries you want to use.

The Conda environment file can be another YAML like this:

```yml
name: basic-env-ml
channels:
  - conda-forge
dependencies:
  - python=3.8
  - pip
  - pip:
    - numpy
    - pandas
    - scikit-learn
    - matplotlib
    - azureml-mlflow
```

The YAML file to create the environment, which will refer to the Conda environment file, will then look like this:

```yml
$schema: https://azuremlschemas.azureedge.net/latest/environment.schema.json
name: basic-env-scikit
version: 1
image: mcr.microsoft.com/azureml/openmpi3.1.2-ubuntu18.04
conda_file: file:conda-envs/basic-env-ml.yml
```

Make sure both YAML files are stored locally on the same computer from which you'll run the command to create the environment. For an example environment created with the CLI (v2), go to the [Azure Machine Learning examples repository](https://github.com/Azure/azureml-examples/tree/main/cli/assets/environment).

To get a list of all environments in your workspace, you use the `az ml environment list` command. Both curated and custom environments will show in this list. All environments can also be found in the [Azure Machine Learning Studio](https://ml.azure.com), in the Environments tab.

Learn more about the commands to [manage Azure ML environments](/cli/azure/ml/environment).

All registered environments will persist in the Azure Machine Learning workspace and can be used whenever you want to train a model or run a job.

## Create a dataset asset

The data scientist gives you the Python notebook and a CSV dataset. You want to run the notebook on the compute instance you created, to test training the model in the Azure Machine Learning workspace. You could upload the CSV dataset to the compute instance, but after testing, you want to train the model with a compute cluster. To make it more future-proof, you want to upload the CSV to a datastore connected to the workspace and create a dataset that refers to the CSV to use when training the model.

You have the CSV as a local file on your computer. Using the CLI (v2), you create a **dataset asset** in the workspace. Azure Machine Learning will then automatically upload the CSV to the workspace's default datastore. The default datastore is the storage account that was created together with the workspace, unless you change it.

To create a dataset asset from a local file, you'll need to:

- Create a YAML specification file referring to the local file.
- Run the `az ml dataset create` command.

In the YAML file you'll include:

- The name of the dataset asset as it will show in the workspace.
- The version of the dataset asset.
- The local path to the data file.
- Optionally, you can add a description.

Store the YAML file and the CSV dataset somewhere on your computer:

```yml
$schema: https://azuremlschemas.azureedge.net/latest/asset.schema.json
name: customer-churn-data
version: 1
local_path: customer-churn.csv
description: Dataset pointing to customer churn CSV on local computer. Data will be uploaded to default datastore.
```

From the shell prompt, navigate to the folder that contains the YAML file and CSV. Then, you run the command to create the dataset in the workspace:

```azurecli
az ml dataset create --file data-local-path.yml
```

As the data is uploaded to the default datastore, the progress of uploading the data is shown in the prompt. Once it's completed, the dataset will show up in the Datasets tab of your workspace when opening the [Azure ML Studio](https://ml.azure.com). Or you can list all datasets within the workspace using the list command:

```azurecli
az ml dataset list
```

Learn more about the commands to [manage Azure ML dataset assets](/cli/azure/ml(v1)/dataset?view=azure-cli-latest).

The dataset is now available for anyone with access to the workspace. When you train a model by running a job, you can refer to the dataset to use it as input for the job.

> [!Important]
> You can use YAML files to define the configuration when you create assets such as compute, environments and datasets with the CLI (v2). Find more examples of the YAML files used to create assets in the [Azure Machine Learning examples repository for the CLI (v2)](https://github.com/Azure/azureml-examples/tree/main/cli).

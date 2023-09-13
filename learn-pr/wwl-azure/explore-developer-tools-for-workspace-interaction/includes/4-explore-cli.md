

> [!Important]
> **The content in this unit only covers version 2 of the CLI**. Learn more about [deciding between version 1 and 2](/azure/machine-learning/how-to-migrate-from-v1?azure-portal=true).

Another code-based approach to interact with the Azure Machine Learning workspace is the command-line interface (CLI). As a data scientist, you may not work with the CLI as much as you do with Python. The Azure CLI is commonly used by administrators and engineers to automate tasks in Azure. 

There are many advantages to using the Azure CLI with Azure Machine Learning. The Azure CLI allows you to:

- Automate the creation and configuration of assets and resources to make it **repeatable**.
- Ensure **consistency** for assets and resources that must be replicated in multiple environments (for example, development, test, and production).
- Incorporate machine learning asset configuration into developer operations (**DevOps**) **workflows**, such as **continuous integration** and **continuous deployment** (**CI/CD**) pipelines.

To interact with the Azure Machine Learning workspace using the Azure CLI, you'll need to install the Azure CLI and the Azure Machine Learning extension. 

## Install the Azure CLI

You can install the Azure CLI on a Linux, Mac, or Windows computer. With the Azure CLI, you run commands or scripts to manage Azure resources. You can also use the Azure CLI from a browser through the Azure Cloud Shell. No matter which platform you choose, you can execute the same tasks. But, the installation of the Azure CLI, the commands, and scripts are different across platforms.

> [!IMPORTANT]
> To install the Azure CLI on your computer you can use a package manager. Here are the instructions to [install the Azure CLI](/cli/azure/install-azure-cli?azure-portal=true), based on the platform you choose. You don't need to install the Azure CLI if you use the Azure Cloud Shell. Learn more about how to use [the Azure Cloud Shell in this overview](/azure/cloud-shell/overview?azure-portal=true).

## Install the Azure Machine Learning extension 

After you've installed the Azure CLI, or set up the Azure Cloud Shell, you need to install the Azure Machine Learning extension to manage Azure Machine Learning resources using the Azure CLI.

You can install the Azure Machine Learning extension `ml` with the following command:

```azurecli
az extension add -n ml -y
```

You can then run the help command `-h` to check that the extension is installed and to get a list of commands available with this extension. The list gives an overview of the tasks you can execute with the Azure CLI extension for Azure Machine Learning:

```azurecli
az ml -h
```

## Work with the Azure CLI

To use the Azure CLI to interact with the Azure Machine Learning workspace, you'll use **commands**. Each command is prefixed with `az ml`. You can find the [list of commands in the reference documentation of the CLI](/cli/azure/ml?azure-portal=true).

For example, to create a compute target, you can use the following command:

```azurecli
az ml compute create --name aml-cluster --size STANDARD_DS3_v2 --min-instances 0 --max-instances 5 --type AmlCompute --resource-group my-resource-group --workspace-name my-workspace
```

To explore all possible parameters that you can use with a command, you can [review the reference documentation for the specific command](/cli/azure/ml/compute?azure-portal=true).

As you define the parameters for an asset or resource you want to create, you may prefer using YAML files to define the configuration instead. When you store all parameter values in a YAML file, it becomes easier to organize and automate tasks. 

For example, you can also create the same compute target by first defining the configuration in a YAML file:

```yml
$schema: https://azuremlschemas.azureedge.net/latest/amlCompute.schema.json 
name: aml-cluster
type: amlcompute
size: STANDARD_DS3_v2
min_instances: 0
max_instances: 5
```

All possible parameters that you can include in the YAML file can be found in [the reference documentation for the specific asset or resource you want to create like a compute cluster](/azure/machine-learning/reference-yaml-compute-aml?azure-portal=true).

When you saved the YAML file as `compute.yml`, you can create the compute target with the following command:

```azurecli
az ml compute create --file compute.yml --resource-group my-resource-group --workspace-name my-workspace
```

You can find [an overview of all the YAML schemas in the reference documentation](/azure/machine-learning/reference-yaml-overview?azure-portal=true). 

> [!Tip]
> Learn more about [how to use the CLI (v2) with Azure Machine Learning to train models](/training/paths/train-models-azure-machine-learning-cli-v2/?azure-portal=true). 


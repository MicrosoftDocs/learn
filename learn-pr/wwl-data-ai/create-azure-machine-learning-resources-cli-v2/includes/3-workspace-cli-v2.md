Organizations often use multiple Azure Machine Learning workspaces for different teams or projects. To easily create multiple Azure Machine Learning workspaces, you can use the Azure CLI (v2).

The data science team you're working with wants to use Azure Machine Learning for all machine learning projects. Your work on this first project on predicting customer churn will be an example for any machine learning project they'll do in the future. You want to make sure that you can replicate your steps of creating an Azure Machine Learning workspace.

Here, you'll learn how to organize workspace management within Azure Machine Learning. After that, you'll learn how to use the Azure CLI (v2) to create and manage your Azure Machine Learning workspace.

## Organize Azure Machine Learning workspaces

To know how to organize your workspaces, you need to decide how you want to manage your team and projects.

The company you work for has one data science team. Several data scientists are currently experimenting with machine learning models that may help other departments with doing their work more efficiently. Currently, each data scientist gets a small dataset, and trains a model on their computer.

Together with the data science team, you decide all machine learning workloads will use Azure Machine Learning to help data scientists collaborate on projects. And more importantly, with Azure Machine Learning it will be easy to deploy a model, so that the relevant department can consume the model's insights.

### Team structure

In general, there are three common ways to organize Azure Machine Learning workspaces:

- **Workspace per team**: Choose to use one workspace for each team when all members of a team need the same level of access to data and experimentation assets.
- **Workspace per project**: Choose to use one workspace for each project if you need segregation of data and experimentation assets by project, or have cost reporting and budgeting requirements at a project level.
- **Single workspace**: Choose to use one workspace for non-team or non-project related work, or when costs can't be directly associated to a specific unit of billing, for example with R&D. A single workspace reduces your Azure footprint.

The data science team works on projects for different internal departments that sometimes also need access to the data or model. Together, you decide to create one workspace per project. You already have your first project: the customer churn model for the marketing department. After you create a workspace for this project as an example, the team will do the same for any new projects in the future.

> [!Tip]
> Learn more about [best practices and common decision points to organize Azure Machine Learning workspaces](/azure/cloud-adoption-framework/ready/azure-best-practices/ai-machine-learning-resource-organization).

## Create a workspace with the CLI (v2)

The first time you create an Azure Machine Learning workspace, you'll work with the CLI interactively on your computer (cmd.exe on Windows, Bash on Linux or macOS). Before you can use the Azure CLI to create a workspace, make sure you did these steps:

- The Azure CLI is installed on your computer.
- The Azure Machine Learning extension is installed.
- You authenticated to your Azure subscription from the CLI. Remember if you have multiple subscriptions linked to your account, you can set the default subscription.

### Create a resource group and set as default

To create a workspace, you need a resource group. You can use any existing resource group or create a new one with the `az group create` command:

```azurecli
az group create --name "churn-dev-rg" --location "eastus"
```

For more information on working with resource groups, see [az group](/cli/azure/group).

After you created a resource group, you can set a default resource group. You'll need to include the resource group as a parameter for many commands when managing an Azure Machine Learning workspace. If a resource group is set as a default, you won't have to include it as a parameter every time.

```azurecli
az configure --defaults group="churn-dev-rg"
```

### Create an Azure Machine Learning workspace

Now that you have set a default resource group, you can create a workspace without adding the resource group name as a parameter:

```azurecli
az ml workspace create --name "aml-churn-dev"
```

The `az ml workspace create` command will take a couple of minutes to create all necessary resources. In your shell prompt, you can see what is being created and how long it takes per resource. The output will look something like this:

```json
{
  "application_insights": "/subscriptions/<subscription-GUID>/resourcegroups/churn-dev-rg/providers/microsoft.insights/components/amlchurninsightsGUID",
  "description": "aml-churn-dev",
  "discovery_url": "https://eastus.api.azureml.ms/discovery",
  "friendly_name": "aml-churn-dev",
  "hbi_workspace": false,
  "key_vault": "/subscriptions/<subscription-GUID>/resourcegroups/churn-dev-rg/providers/microsoft.keyvault/vaults/amlchurnkeyvaultGUID",
  "location": "eastus",
  "mlflow_tracking_uri": "azureml://eastus.api.azureml.ms/mlflow/v1.0/subscriptions/<subscription-GUID>/resourceGroups/churn-dev-rg/providers/Microsoft.MachineLearningServices/workspaces/aml-churn-dev",
  "name": "aml-churn-dev",
  "storage_account": "/subscriptions/<subscription-GUID>/resourcegroups/churn-dev-rg/providers/microsoft.storage/storageaccounts/amlchurnstorageGUID",
  "tags": {}
}
```

You can use the output to find your resources, for example if you want to find them in the Azure portal. If you navigate to your resource group in the Azure portal, you can see four resources:

- Machine Learning workspace
- Application Insights
- Key vault
- Storage account

Finally, if you're going to manage your workspace with the CLI, you can set the workspace as the default. Setting a workspace as default means you don't have to include it as a parameter each time you want to run a command.

Set the default workspace with the following command:

```azurecli
az configure --defaults workspace="aml-churn-dev"
```

While the Azure portal is an easy method to create a workspace, another technique is to create it in your Python code using the Azure Machine Learning SDK as demonstrated below.


## Create an Azure ML service workspace with Python

To create an Azure Machine Learning service workspace with Python, you will need your Azure _subscription id_. You can find your subscriptions in the Azure portal through the **Subscriptions** item in the left sidebar, or by typing "Subscriptions" into the global search box.

![Screenshot showing search bar in Azure portal searching for "subscriptions"](../media/3-subscriptions.png)

Locate the subscription you want to use and replace the `{azure-subscription-id}` value below with the subscription id value. The SDK will ask you to sign into your Azure account if you are not already signed in.

> [!IMPORTANT]
> If you didn't create an AMLS workspace in a prior module, you won't have a resource group named **rgAMLSLearnworkspace**. In that case, make sure to change the value of the `create_resource_group` parameter in the following code to `True` so the SDK creates the resource group for you.

```python
from azureml.core import Workspace

ws = Workspace.create(
            name='learn-workspace-py',
            subscription_id='{azure-subscription-id}', 
            resource_group='rgAMLSLearnworkspace',
            create_resource_group=False,
            location='eastus2'
)
print('Done')

```

> [!IMPORTANT]
> The `Workspace.create` function returns the created `Workspace` object which we will use as we go along. Make sure to keep the Python window open. We are storing it here in the variable `ws`.

This command will display progress for all the created Azure resources as it creates the workspace.

```output
Deploying ContainerRegistry with name learnworacrsvaiolwq.
Deployed ContainerRegistry with name learnworacrsvaiolwq.
Deploying AppInsights with name learnworinsightszhbzswxg.
Deployed AppInsights with name learnworinsightszhbzswxg.
Deploying KeyVault with name learnworkeyvaultqltiyela.
Deploying StorageAccount with name learnworstorageboxtinpk.
Deployed KeyVault with name learnworkeyvaultqltiyela.
Deployed StorageAccount with name learnworstorageboxtinpk.
Deploying Workspace with name learn-workspace-py.
Deployed Workspace with name learn-workspace-py.
```

As with the portal approach, it takes a few minutes to set up the workspace. After the workspace is provisioned, you can view the workspace details, such as the associated Azure Blob Storage account, Docker container registry account, and key vault through the returned `ws` object - try executing the `get_details()` function on it.

```python
ws.get_details()
```
This returns a JSON block with all the created details. It will look something like:

```output
{  
   'id':'/subscriptions/{subscription-id}/resourceGroups/mslearn-amls/providers/Microsoft.MachineLearningServices/workspaces/learn-workspace-py',
   'name':'learn-workspace-py',
   'location':'eastus',
   'type':'Microsoft.MachineLearningServices/workspaces',
   'workspaceid':'3dd46201-f0b2-44d3-90c7-2309fd641615',
   'description':'',
   'friendlyName':'learn-workspace-py',
   'creationTime':'2019-04-09T01:21:33.0508952+00:00',
   'containerRegistry':'/subscriptions/{subscription-id}/resourcegroups/mslearn-amls/providers/microsoft.containerregistry/registries/learnworacrsvaiolwq',
   'keyVault':'/subscriptions/{subscription-id}/resourcegroups/mslearn-amls/providers/microsoft.keyvault/vaults/learnworkeyvaultqltiyela',
   'applicationInsights':'/subscriptions/{subscription-id}/resourcegroups/mslearn-amls/providers/microsoft.insights/components/learnworinsightszhbzswxg',
   'identityPrincipalId':'xyz',
   'identityTenantId':'xyz',
   'identityType':'SystemAssigned',
   'storageAccount':'/subscriptions/{subscription-id}/resourcegroups/mslearn-amls/providers/microsoft.storage/storageaccounts/learnworstorageboxtinpk'
}
```
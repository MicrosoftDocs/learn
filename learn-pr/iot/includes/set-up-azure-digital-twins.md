---
author: baanders
ms.author: baanders
ms.date: 11/10/2023
ms.topic: include
ms.service: digital-twins
---

## Set up hands-on session

For a hands-on experience with Azure Digital Twins, this unit provides Azure CLI commands that you can run with an Azure subscription. If you don't have an Azure subscription already, [create one for free now](https://azure.microsoft.com/free).

In another browser window, navigate to the [Azure Cloud Shell](https://ms.portal.azure.com/#cloudshell/). The commands in this module are written for the Cloud Shell's bash environment, which may be selected already by default.

Run the following commands in the Cloud Shell to set up your session and create a resource group to use for this unit. This also creates environment variables to store your subscription ID, resource group, and location in your Cloud Shell session, for reuse in future commands throughout the module.  By default, your resource group will be named *azure-digital-twins-training* and it will be created in the *westus2* region. There is one placeholder for you to fill in your Azure subscription ID value.

```azurecli
AZURE_SUBSCRIPTION="<your-Azure-subscription-ID>"
RESOURCE_GROUP="azure-digital-twins-training"
REGION="westus2"
az account set --subscription $AZURE_SUBSCRIPTION
az group create --name $RESOURCE_GROUP --location $REGION
echo "Your resource group is $RESOURCE_GROUP and your location is $REGION."
```

Next, create an Azure Digital Twins instance. Run the following commands in the Cloud Shell to generate a random name for the instance and then create a new instance with that name. If you're prompted to install the `azure-iot` extension as part of this command, install it.

```azurecli
INSTANCE_NAME="Digital-Twins-$RANDOM"
az dt create --dt-name $INSTANCE_NAME --resource-group $RESOURCE_GROUP --location $REGION
echo "Your Azure Digital Twins instance name is $INSTANCE_NAME."
```

Finally, run the following command to grant yourself the *Azure Digital Twins Data Owner* role on the instance, which is required to edit its data.

>[!IMPORTANT]
> This command can only be run by someone with subscription-level permission to manage access to Azure resources. For instance, if you've created your own subscription and are the **Owner**, you'll be able to run it. If you only have the **Contributor** role in the subscription, this command will return an error.
>
> If you're unable to run this command and you want to follow along with the hands-on exercises in this unit, have someone with elevated permissions (such as an Owner, Account Admin, or User Access Administrator + Contributor) run this command on your behalf. Instead of assigning the role to the current signed-in user account, they can enter the email associated with your Azure account for the `assignee` parameter.

```azurecli
AZURE_USER=$(az ad signed-in-user show --query id -o tsv)
az dt role-assignment create --dt-name $INSTANCE_NAME --assignee $AZURE_USER --role "Azure Digital Twins Data Owner"
```

Now you have an Azure Digital Twins instance to use in this module, and permission to manage its data.
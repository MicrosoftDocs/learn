---
author: baanders
ms.author: baanders
ms.date: 11/10/2023
ms.topic: include
ms.service: digital-twins
---

## Set up hands-on session

For a hands-on experience with Azure Digital Twins, this unit provides Azure CLI commands that you can run with an Azure subscription. If you don't have an Azure subscription already, [create one for free now](https://azure.microsoft.com/free).

In another browser tab, navigate to the [Azure Cloud Shell](https://ms.portal.azure.com/#cloudshell/).

Run the following commands in the Cloud Shell to set up your session and create a resource group to use for this unit. There is one placeholder for your Azure subscription ID value.

```azurecli
az account set --subscription "<your-Azure-subscription-ID>"
az group create --name azure-digital-twins-training --location westus2
```

Next, create an Azure Digital Twins instance. Run the following commands in the Cloud Shell to generate a random name for the instance and then create a new instance with that name.

```azurecli
INSTANCE_NAME="Digital-Twins-$RANDOM"
echo "Your Azure Digital Twins instance name will be: $INSTANCE_NAME"
az dt create --dt-name $INSTANCE_NAME --resource-group azure-digital-twins-training --location westus2
```

Finally, run the following command to grant yourself the *Azure Digital Twins Data Owner* role on the instance, which is required to edit its data.

>[!IMPORTANT]
> This command can only be run by someone with subscription-level permission to manage access to Azure resources. For instance, if you've created your own subscription and are the **Owner**, you'll be able to run it. If you only have the **Contributor** role in the subscription, this command will return an error.
>
> If you find you're unable to run this command and you want to follow along with the hands-on exercises in this unit, have someone with elevated permissions (such as an Owner, Account Admin, or User Access Administrator + Contributor) run this command on your behalf. Instead of assigning the role to the current signed-in user account, they can enter the email associated with your Azure account for the `assignee` parameter.

```azurecli
AZURE_USER=$(az ad signed-in-user show --query id -o tsv)
az dt role-assignment create --dt-name $INSTANCE_NAME --assignee $AZURE_USER --role "Azure Digital Twins Data Owner"
```

During the build process, Packer creates temporary Azure resources for the base VM. To capture that base VM for use as an image, you must define a resource group. An Azure resource group is a logical container where Azure resources are deployed and managed.

First, create a resource group in Azure Cloud Shell by using [az group create](/cli/azure/group#az_group_create). The following example creates a resource group named *myResourceGroup* in the *eastus* location:

```azurecli
az group create -n myResourceGroup -l eastus
```

Packer authenticates with Azure by using a service principal. An Azure service principal is a security identity that you can use with apps, services, and automation tools like Packer. You control and define the permissions that determine what operations the service principal can perform in Azure.

Create a service principal in Azure Cloud Shell by using [az ad sp create-for-rbac](/cli/azure/ad/sp#create-for-rbac) and provide the credentials that Packer needs:

```azurecli
az ad sp create-for-rbac --query "{ client_id: appId, client_secret: password, tenant_id: tenant }"
```

An example of the output from the preceding commands is as follows:

```azurecli
{
    "client_id": "f5b6a5cf-fbdf-4a9f-b3b8-3c2cd00225a4",
    "client_secret": "0e760437-bf34-4aad-9f8d-870be799c55d",
    "tenant_id": "72f988bf-86f1-41af-91ab-2d7cd011db47"
}
```

> [!NOTE]
> Remember the values that you get for *client_id*, *client_secret*, and *tenant_id* when you run the preceding command. You will use them in the next step. 

To authenticate to Azure, you also need to obtain your Azure subscription ID by using [az account show](/cli/azure/account#az_account_show):

```azurecli
az account show --query '{ "subscription_id": "id" }'
```

An example of the output from the preceding command is as follows:

```azurecli
{
  "subscription_id": "1695b3e3-fdd4-49ec-8dfd-d684c8c91517"
}
```

> [!NOTE]
> You will use the output from these two commands in the next step, so don't forget to copy the output of each when you run them. 
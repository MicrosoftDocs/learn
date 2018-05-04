During the build process, Packer creates temporary Azure resources for the base VM. To capture that base VM for use as an image, you must define a resource group. An Azure resource group is a logical container into which Azure resources are deployed and managed.

First, create a resource group in the Azure Cloud Shell with [az group create](/cli/azure/group#az_group_create). The following example creates a resource group named *myResourceGroup* in the *eastus* location:

```azurecli
az group create -n myResourceGroup -l eastus
```

Packer authenticates with Azure using a service principal. An Azure service principal is a security identity that you can use with apps, services, and automation tools like Packer. You control and define the permissions as to what operations the service principal can perform in Azure.

Create a service principal in the Azure Cloud Shell with [az ad sp create-for-rbac](/cli/azure/ad/sp#create-for-rbac) and output the credentials that Packer needs:

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

Copy your own output for use in the next step.

To authenticate to Azure, you also need to obtain your Azure subscription ID with [az account show](/cli/azure/account#az_account_show):

```azurecli
az account show --query '{ "subscription_id": "id" }'
```

You use the output from these two commands in the next step.
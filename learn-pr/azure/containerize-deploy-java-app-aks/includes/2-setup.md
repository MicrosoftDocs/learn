In this unit, you use the Azure CLI to create the Azure resources needed in later units. Before you start entering commands, make sure Docker Desktop is installed and running.

## Use the Azure CLI

> [!NOTE]
> In an effort to preserve time, you instruct Azure to provision the resources first and move on to the next unit. Azure Kubernetes Service (AKS) cluster creation can take up to 10 minutes. This can, optionally, run in the background while you proceed through the next units.

### Authenticate with Azure Resource Manager

Use the following command in your CLI to sign in:

```azurecli
   az login
```

### Select an Azure subscription

Azure subscriptions are logical containers used to provision resources in Azure. Locate the subscription ID, `SubscriptionId`, that you plan to use in this module. Use this command to list your Azure subscriptions:

```azurecli
   az account list --output table
```

Use the following command to ensure you're using an Azure subscription that allows you to create resources for the purposes of this module, substituting your `SubscriptionId` of choice for the placeholder:

```azurecli
   az account set --subscription "<YOUR_SUBSCRIPTION_ID>"
```

### Define local variables

To simplify the commands that we execute later, set up the following environment variables:

> [!NOTE]
> Replace `<YOUR_AZURE_REGION>` with your region of choice; for example, `eastus`.
>
> Replace `<YOUR_CONTAINER_REGISTRY>` with a unique value, because this is used to generate a unique FQDN (fully qualified domain name) for your Azure container registry when it is created, for example, `someuniquevaluejavacontainerregistry`.
>
> Replace `<YOUR_UNIQUE_DNS_PREFIX_TO_ACCESS_YOUR_AKS_CLUSTER>` with a unique value, because it's used to generate a unique FQDN (fully qualified domain name) for your AKS cluster when it is created; for example: `someuniquevaluejavacontainerizationdemoaks`.

```azurecli
   AZ_RESOURCE_GROUP=javacontainerizationdemorg
   AZ_CONTAINER_REGISTRY=<YOUR_CONTAINER_REGISTRY>
   AZ_KUBERNETES_CLUSTER=javacontainerizationdemoaks
   AZ_LOCATION=<YOUR_AZURE_REGION>
   AZ_KUBERNETES_CLUSTER_DNS_PREFIX=<YOUR_UNIQUE_DNS_PREFIX_TO_ACCESS_YOUR_AKS_CLUSTER>
```

### Create an Azure resource group

Azure resource groups are Azure containers in Azure subscriptions for holding related resources for an Azure solution. Create a resource group by using the following command in your CLI:

```azurecli
   az group create \
       --name $AZ_RESOURCE_GROUP \
       --location $AZ_LOCATION \
   | jq
```

> [!NOTE]
> This module uses the `jq` tool, which is installed by default on [Azure Cloud Shell](https://shell.azure.com/) to display JSON data and make it more readable.
>
> If you don't want to use the `jq` tool, you can safely remove the `| jq` part of all commands in this module.

### Create an Azure container registry

Azure Container Registry allows you to build, store, and manage container images, including a container image for this Java app. Create a container registry by using the following command:

```azurecli
   az acr create \
       --resource-group $AZ_RESOURCE_GROUP \
       --name $AZ_CONTAINER_REGISTRY \
       --sku Basic \
   | jq
```

Configure Azure CLI to use this newly created Azure container registry:

```azurecli
   az configure \
       --defaults acr=$AZ_CONTAINER_REGISTRY
```

Authenticate to the newly created Azure container registry:

```azurecli
   az acr login -n $AZ_CONTAINER_REGISTRY
```

> [!NOTE]
> Before executing the `az acr login` command, please ensure that Docker Desktop is running on your local environment. If it isn't running, you receive an error message like the following:
>
>```azurecli
>   Cannot connect to the Docker daemon at unix:///$HOME_DIR/.docker/run/docker.sock. Is the docker daemon running?`
>```

### Create an Azure Kubernetes Service cluster

You need an AKS cluster to deploy the Java app container image. Create an AKS cluster by using the following command:

```azurecli
   az aks create \
       --resource-group $AZ_RESOURCE_GROUP \
       --name $AZ_KUBERNETES_CLUSTER \
       --attach-acr $AZ_CONTAINER_REGISTRY \
       --dns-name-prefix=$AZ_KUBERNETES_CLUSTER_DNS_PREFIX \
       --generate-ssh-keys \
   | jq
```

> [!NOTE]
> Creating an AKS cluster can take up to 10 minutes. Once you run the previous command, you can let it continue in your Azure CLI tab and move on to the next unit.

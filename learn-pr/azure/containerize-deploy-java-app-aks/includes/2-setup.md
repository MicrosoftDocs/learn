In this unit, you'll use the Azure CLI to create the Azure resources that will be needed in later units. Before you start entering commands, make sure Docker Desktop is installed and running.

## Using the Azure CLI, perform the following steps

> [!NOTE]
> In an effort to preserve time, you'll instruct Azure to provision the resources first and move on to the next unit. Azure Kubernetes Cluster creation can take up to 10 minutes. This can, optionally, run in the background while you proceed through the next units.

### Authenticate with Azure Resource Manager

Use the following command in your CLI to sign in:

```bash
az login
```

### Select an Azure subscription

Azure subscriptions are logical containers used to provision resources in Azure. You'll need to locate the subscription ID (SubscriptionId) that you plan to use in this module. Use this command to list your Azure subscriptions:

```bash
az account list --output table
```

Use the following command to ensure you're using an Azure subscription that allows you to create resources for the purposes of this module, substituting your subscription ID (SubscriptionId) of choice:

```bash
az account set --subscription "<YOUR_SUBSCRIPTION_ID>"
```

### Define local variables

To simplify the commands that we'll execute later, set up the following environment variables:

> [!NOTE]
> You'll want to replace <YOUR_AZURE_REGION> with your region of choice; for example: *eastus*.  
>
> You'll want to replace <YOUR_CONTAINER_REGISTRY> with a unique value, because this is used to generate a unique FQDN (fully qualified domain name) for your Azure Container Registry when it is created; for example: `someuniquevaluejavacontainerregistry`.
>
> You'll want to replace <YOUR_UNIQUE_DNS_PREFIX_TO_ACCESS_YOUR_AKS_CLUSTER> with a unique value, because it's used to generate a unique FQDN (fully qualified domain name) for your Azure Kubernetes Cluster when it is created; for example: `someuniquevaluejavacontainerizationdemoaks`.

```bash
AZ_RESOURCE_GROUP=javacontainerizationdemorg
AZ_CONTAINER_REGISTRY=<YOUR_CONTAINER_REGISTRY>
AZ_KUBERNETES_CLUSTER=javacontainerizationdemoaks
AZ_LOCATION=<YOUR_AZURE_REGION>
AZ_KUBERNETES_CLUSTER_DNS_PREFIX=<YOUR_UNIQUE_DNS_PREFIX_TO_ACCESS_YOUR_AKS_CLUSTER>
```

### Create an Azure Resource Group

Azure resource groups are Azure containers in Azure subscriptions for holding related resources for an Azure solution. Create a Resource group by using the following command in your CLI:

```bash
az group create \
    --name $AZ_RESOURCE_GROUP \
    --location $AZ_LOCATION \
    | jq
```

> [!NOTE]
> This module uses the `jq` tool, which is installed by default on [Azure Cloud Shell](https://shell.azure.com/) to display JSON data and make it more readable.
>
> If you don't want to use the `jq` tool, you can safely remove the `| jq` part of all commands in this module.

### Create an Azure Container Registry

Azure Container Registry allows you to build, store, and manage container images, which are ultimately where the container image for the Java app will be stored. Create a Container registry by using the following command:

```bash
az acr create \
    --resource-group $AZ_RESOURCE_GROUP \
    --name $AZ_CONTAINER_REGISTRY \
    --sku Basic \
    | jq
```

Configure Azure CLI to use this newly created Azure Container Registry:

```bash
az configure \
    --defaults acr=$AZ_CONTAINER_REGISTRY
```

Authenticate to the newly created Azure Container Registry:

```bash
az acr login -n $AZ_CONTAINER_REGISTRY
```

### Create an Azure Kubernetes Cluster

You'll need an Azure Kubernetes Cluster to deploy the Java app (container image) to. Create an AKS Cluster:

```bash
az aks create \
    --resource-group $AZ_RESOURCE_GROUP \
    --name $AZ_KUBERNETES_CLUSTER \
    --attach-acr $AZ_CONTAINER_REGISTRY \
    --dns-name-prefix=$AZ_KUBERNETES_CLUSTER_DNS_PREFIX \
    --generate-ssh-keys \
    | jq
```

> [!NOTE]
> Creating an Azure Kubernetes Cluster can take up to 10 minutes. Once you run the command above, you can let it continue in your Azure CLI tab and move on to the next unit.

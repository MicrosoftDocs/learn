In this unit, you'll use the Azure CLI to create the Azure resources that will be needed in later units. 

> [!NOTE]
> In an effort to preserve time, you'll instruct Azure to create the resources first and move on to the next unit. Azure Kubernetes Cluster creation can take approximately 10 minutes. This can, optionally, run in your background while you proceed through the next units.

## Using the Azure CLI, perform the following steps

Authenticate with Azure:

```bash
az login
```

Azure subscriptions are logical containers used to provision resources in Azure. You'll need to locate the subscription id (SubscriptionId) that you plan to use in this module. List your Azure subscriptions:

```bash
az account list --output table
```

Ensure your using an Azure subscription that allows you to create resources for the purposes of this module, substituting your subscription id (SubscriptionId) of choice:

```bash
az account set --subscription "<YOUR_SUBSCRIPTION_ID>"
```

To simplify the commands that will be executed further down, set up the following environment variables:

> [!NOTE]
> You'll want to replace <YOUR_AZURE_REGION> with your region of choice, for example: eastus  
>
> You'll want to replace <YOUR_UNIQUE_DNS_PREFIX_TO_ACCESS_YOUR_AKS_CLUSTER> with a unique value as this is used to generate a unique FQDN (fully qualified domain name) for your cluster when it is created, for example: somerandomvaluejavacontainerizationdemoaks

```bash
AZ_RESOURCE_GROUP=javacontainerizationdemorg
AZ_CONTAINER_REGISTRY=javacontainerizationdemoacr
AZ_KUBERNETES_CLUSTER=javacontainerizationdemoaks
AZ_LOCATION=<YOUR_AZURE_REGION>
AZ_KUBERNETES_CLUSTER_DNS_PREFIX=<YOUR_UNIQUE_DNS_PREFIX_TO_ACCESS_YOUR_AKS_CLUSTER>
```

Azure resource groups are Azure containers, located within Azure subscriptions, for holding related resources for an Azure solution. Create a Resource group:

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

Azure Container Registry allows you to build, store, and manage container images, which is ultimately where Docker image for the Java application will be stored. tCreate a Container registry:

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
    --defaults acr=$AZ_CONTAINER_REGISTRY \
    | jq
```

Authenticate to the newly created Azure Container Registry:

```bash
az acr login -n $AZ_CONTAINER_REGISTRY
```

You'll need an Azure Kubernetes Cluster to deploy the Java application (Docker image) to. Create an AKS Cluster:

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
> Azure Kubernetes Cluster creation can take approximately 10 minutes, once you run the command above, you can optionally let it continue in that Azure CLI tab and move on to the next unit.

In this unit, you use the Azure CLI to create the Azure resources needed in later units. Before you start entering commands, make sure Docker Desktop is installed and running.

To save time, you can instruct Azure to provision the resources first and then move on to the next unit. Azure Kubernetes Service (AKS) cluster creation can take up to 10 minutes. This process can run in the background while you proceed through subsequent units.

## Authenticate with Azure Resource Manager

Use the following command to sign in:

```azurecli
az login
```

## Select an Azure subscription

Azure subscriptions are logical containers used to provision resources in Azure. Use the following command to list your Azure subscriptions, then locate the subscription ID - the `SubscriptionId` value - that you plan to use in this module.

```azurecli
az account list --output table
```

Use the following command to ensure you're using an Azure subscription that enables you to create resources for the purposes of this module, substituting your preferred `SubscriptionId` value for the placeholder:

```azurecli
az account set --subscription "<your-subscription-ID>"
```

## Define local variables

To simplify the commands that you use later, set up the following environment variables. Be sure to replace the following placeholders with your own values:

- Replace `<your-Azure-region>` with your region of choice - for example, `eastus`.
- Replace `<your-container-registry>` with a unique value. This value is used to generate a unique fully qualified domain name (FQDN) for your Azure container registry when it's created.
- Replace `<your-unique-DNS-prefix-to-access-your-AKS-cluster>` with a unique value. This value is used to generate a unique FQDN for your AKS cluster when it's created.

```azurecli
export AZ_RESOURCE_GROUP=java-containerization-demo-rg
export AZ_CONTAINER_REGISTRY=<your-container-registry>
export AZ_KUBERNETES_CLUSTER=java-containerization-demo-aks
export AZ_LOCATION=<your-Azure-region>
export AZ_KUBERNETES_CLUSTER_DNS_PREFIX=<your-unique-DNS-prefix-to-access-your-AKS-cluster>
```

## Create an Azure resource group

Azure resource groups are Azure containers in Azure subscriptions for holding related resources for an Azure solution. Create a resource group by using the following command:

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

## Create an Azure container registry

Azure Container Registry enables you to build, store, and manage container images, including a container image for this Java app. Create a container registry by using the following command:

```azurecli
az acr create \
    --resource-group $AZ_RESOURCE_GROUP \
    --name $AZ_CONTAINER_REGISTRY \
    --sku Basic \
| jq
```

Use the following command to configure the Azure CLI to use this newly created Azure container registry:

```azurecli
az configure --defaults acr=$AZ_CONTAINER_REGISTRY
```

Use the following command to authenticate to the newly created Azure container registry:

> [!NOTE]
> Before you run the `az acr login` command, ensure that Docker Desktop is running on your local environment. If it isn't running, you receive an error message similar to `Cannot connect to the Docker daemon at unix:///$HOME_DIR/.docker/run/docker.sock. Is the docker daemon running?`

```azurecli
az acr login --name $AZ_CONTAINER_REGISTRY
```

## Create an Azure Kubernetes Service cluster

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
> Creating an AKS cluster can take up to 10 minutes. After you run the previous command, you can let it continue in your Azure CLI tab and move on to the next unit.

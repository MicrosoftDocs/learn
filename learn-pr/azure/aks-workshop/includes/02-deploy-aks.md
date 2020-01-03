Azure has a managed Kubernetes service, Azure Kubernetes Service (AKS). You'll use this to easily deploy a Kubernetes cluster.

[!include[](../../../includes/azure-exercise-subscription-prerequisite.md)]
[!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

## Create a new resource group

1. Sign into the [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true) with your Azure account.

1. Create a new resource group with the name **aksworkshop** so that it will be easier to clean up these resources when you are finished with the module. If you choose a different resource group name, remember it for the rest of the exercises in this module. You also need to choose a region in which you want to create the resource group, for example **East US**.

    ```azurecli
    az group create \
        --name aksworkshop \
        --location eastus
    ```

## Create the Azure Kubernetes Service (AKS) cluster

1. Get the latest, non-preview, Kubernetes version in your selected region, and store it in a Bash variable named `VERSION`.

    ```azurecli
    VERSION=$(az aks get-versions \
        --location eastus \
        --query 'orchestrators[?!isPreview] | [-1].orchestratorVersion' \
        --output tsv)
    ```

1. Your AKS cluster name must be unique. For learning purposes, run this command from Cloud Shell to create a Bash variable that holds a unique name.

    ```azurecli
    AKS_CLUSTER_NAME=aksworkshop-$RANDOM
    ```

1. Run the following `az aks create` command to create the Azure Kubernetes Service (AKS) cluster using the latest version. This should take a few minutes.

    ```azurecli
    az aks create --resource-group aksworkshop \
      --name $AKS_CLUSTER_NAME \
      --location eastus \
      --kubernetes-version $VERSION \
      --generate-ssh-keys
    ```

    `$AKS_CLUSTER_NAME` specifies your AKS cluster name, `$VERSION` is the latest Kubernetes version retrieved before.

## Ensure you can connect to the cluster using `kubectl`

1. When the `az aks create` command completes, retrieve the cluster credentials.

    ```azurecli
    az aks get-credentials \
        --resource-group aksworkshop \
        --name $AKS_CLUSTER_NAME
    ```

1. Let's take a look at what has been deployed by listing all the nodes in your cluster. To do this, you'll use the `kubectl` command. This is the main command-line tool you will use for working with Kubernetes. It is already installed in the Cloud Shell.

    ```bash
    kubectl get nodes
    ```

    You should see a list of your cluster's nodes. Here's an example.

    ```output
    NAME                       STATUS   ROLES   AGE  VERSION
    aks-nodepool1-24503160-0   Ready    agent   1m   v1.15.5
    aks-nodepool1-24503160-1   Ready    agent   1m   v1.15.5
    aks-nodepool1-24503160-2   Ready    agent   1m   v1.15.5
    ````

## Create a Kubernetes namespace for the application

Kubernetes provides features that let you logically isolate teams and workloads in the same cluster. The goal should be to provide the least number of privileges, scoped to the resources each team needs. A namespace in Kubernetes creates a logical isolation boundary. Names of resources need to be unique within a namespace, but not across namespaces.

If you don't specify the namespace when working with Kubernetes resources, the **default** namespace is implied. Let's create a namespace for the application we will deploy to our cluster.

1. List the current namespaces in the cluster.

    ```bash
    kubectl get namespace
    ```

    You should get a list of namespaces, similar to the following:

    ```output
    NAME              STATUS   AGE
    default           Active   1h
    kube-node-lease   Active   1h
    kube-public       Active   1h
    kube-system       Active   1h
    ```

1. You'll be using `kubectl create namespace` command to create a namespace for the application called **ratingsapp**.

    ```bash
    kubectl create namespace ratingsapp
    ```

    You will get a confirmation that the namespace was created.

    ```output
    namespace/ratingsapp created
    ```

Next, we'll create and configure Azure Container Registry to use with our AKS cluster.

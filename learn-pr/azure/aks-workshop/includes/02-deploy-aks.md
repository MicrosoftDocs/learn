Azure has a managed Kubernetes service, Azure Kubernetes Service (AKS), you'll use this to easily deploy a Kubernetes cluster.

[!include[](../../../includes/azure-exercise-subscription-prerequisite.md)]
[!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

## Create a new resource group

1. Sign into the [Azure portal](https://portal.azure.com/?azure-portal=true) with your Azure subscription.

1. Open the Azure Cloud Shell from the Azure portal using the Cloud Shell icon.

    ![Image showing Cloud Shell icon in the Azure portal](../media/2-portal-cloudshell-access.png)

1. Create a new resource group with the name **aksworkshop** so that it will be easier to clean up these resources when you are finished with the module. If you choose a different resource group name, remember it for the rest of the exercises in this module. You also need to choose a region in which you want to create the resource group, for example **East US**.

    ```azurecli
    az group create --name aksworkshop --location eastus
    ```

## Create the Azure Kubernetes Service (AKS) cluster

1. Get the latest, non-preview, Kubernetes version in your selected region, and store it in a Bash variable named `VERSION`.

    ```azurecli
    VERSION=$(az aks get-versions -l eastus --query 'orchestrators[?!isPreview] | [-1].orchestratorVersion' -o tsv)
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
      --kubernetes-version $VERSION
      --generate-ssh-keys
    ```

    `$AKS_CLUSTER_NAME` specifies your AKS cluster name, `$VERSION` is the latest Kubernetes version retrieved before.

## Ensure you can connect to the cluster using `kubectl`

1. When the `az aks create` command completes, retrieve the cluster credentials.

    ```azurecli
    az aks get-credentials --resource-group aksworkshop --name $AKS_CLUSTER_NAME
    ```

1. Perform a sanity check by listing all the nodes in your cluster.

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

    > [!TIP]
    > `kubectl` is the main command line tool you will using for working with Kubernetes. It is already installed in the  Cloud Shell.

## Summary

Here, you created an Azure Kubernetes Service (AKS) cluster. You also downloaded the credentials to access the cluster onto the Cloud Shell and verified that the cluster nodes are up.

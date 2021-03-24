In this exercise, you'll create an Azure Kubernetes Service (AKS) cluster to deploy a sample component for your video rendering service. You'll create an AKS cluster that uses several nodes to meet the demand of many customers using the service. You decide to use the *single control plane and multiple nodes* architecture because it provides the best way to create and manage workload resources.

## Create a new cluster

You start the AKS cluster deployment by provisioning the cluster within Azure. Provisioning an AKS cluster in Azure can be done in the Azure portal or through the Azure CLI.

[!INCLUDE [azure-exercise-subscription-prerequisite](../../../includes/azure-exercise-subscription-prerequisite.md)]

1. Sign in to Azure Cloud Shell with the account you want to deploy resources into.

    > [!div class="nextstepaction"]
    > [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true)

    > [!IMPORTANT]
    > We'll run all the scripts with Bash, so if you haven't created a Cloud Shell yet, select "Bash" as the running shell.

1. Create variables for the configuration values you'll reuse throughout the exercises.

    ```bash
    RESOURCE_GROUP=rg-contoso-video
    CLUSTER_NAME=aks-contoso-video
    ```

1. Run the `az group create` command to create a resource group. You'll deploy all resources into this new resources group.

    ```azurecli
    az group create --name $RESOURCE_GROUP --location eastus
    ```

1. Run the `az aks create` command to create an AKS cluster.

    ```azurecli
    az aks create \
        --resource-group $RESOURCE_GROUP \
        --name $CLUSTER_NAME \
        --node-count 2 \
        --enable-addons http_application_routing \
        --enable-managed-identity \
        --generate-ssh-keys \
        --node-vm-size Standard_B2s
    ```

    The previous command creates a new AKS cluster named `aks-contoso-video` within the `rg-contoso-video` resource group. The cluster will have two nodes defined by the `--node-count` parameter. We're using only two nodes here for cost considerations in this exercise. The `--node-vm-size` parameter configures the cluster nodes as `Standard_B2s`-sized VMs. The HTTP application routing add-on is enabled via the `--enable-addons` flag.

> [!CAUTION]
> The HTTP application routing add-on is not recommended for production use. For production-ready ingress deployments that include multiple replicas and TLS support, see the **AKS HTTPS ingress controller docs** link at the end of this module.

## Link with kubectl

1. Link your Kubernetes cluster with `kubectl` by using the following command in Cloud Shell.

    ```azurecli
    az aks get-credentials --name $CLUSTER_NAME --resource-group $RESOURCE_GROUP
    ```

    This command will add an entry to your `~/.kube/config` file, which holds all the information to access your clusters. Kubectl allows you to manage multiple clusters from a single command-line interface.

1. Execute the `kubectl get nodes` command to check that you can connect to your cluster and confirm its configuration.

    ```bash
    kubectl get nodes
    ```

    You should receive a list of two available nodes.

    ```output
    NAME                                STATUS   ROLES   AGE    VERSION
    aks-nodepool1-14167704-vmss000000   Ready    agent   105s   v1.16.10
    aks-nodepool1-14167704-vmss000001   Ready    agent   105s   v1.16.10
    ```

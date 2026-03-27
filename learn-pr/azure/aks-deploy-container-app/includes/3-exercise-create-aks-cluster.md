In this exercise, create an Azure Kubernetes Service (AKS) cluster that uses several nodes to meet the demand of many customers using the service. AKS supports both Linux and Windows node pools via Azure portal or Azure CLI. Select an OS based on which type of node pools you want to add.

[!INCLUDE [azure-exercise-subscription-prerequisite](../../../includes/azure-exercise-subscription-prerequisite.md)]

1. Sign in to Azure Cloud Shell for the subscription you want to deploy resources into.

    > [!div class="nextstepaction"]
    > [Azure Cloud Shell](https://shell.azure.com/bash)

    We run the commands in Bash, so select _Bash_ as the shell.

1. Create variables for the configuration values you reuse throughout the exercises.

    ```bash
    export RESOURCE_GROUP=rg-contoso-video
    export CLUSTER_NAME=aks-contoso-video
    export LOCATION=eastus
    ```

    Update the `LOCATION` variable with the region closest to you. This example uses: `eastus`.

1. Run the `az group create` command to create a resource group. Deploy all resources into this new resource group.

    ```azurecli
    az group create --name $RESOURCE_GROUP --location $LOCATION
    ```

1. Run the `az aks create` command to create an AKS cluster.

    ```azurecli
    az aks create \
      --resource-group $RESOURCE_GROUP \
      --name $CLUSTER_NAME \
      --node-count 2 \
      --generate-ssh-keys \
      --node-vm-size Standard_B2s \
      --network-plugin azure
    ```

    The command creates a new AKS cluster named `aks-contoso-video` within the `rg-contoso-video` resource group. The cluster has two nodes defined by the `--node-count` parameter. We're using only two nodes in this exercise for cost considerations in this exercise. The `--node-vm-size` parameter configures the cluster nodes as Standard_B2s-sized virtual machines. These nodes are part of **System mode**.

    When the AKS cluster is created, a second resource group is also created with a name that starts with `MC_`. This resource group contains all the resources that are needed to run the cluster, such as virtual machines, virtual machine scale sets, and virtual networks.

    > [!IMPORTANT]
    > Standard B2s virtual machines are required to create node pools but not available in Free-Tier subscriptions. If you're receiving notifications about limits, you need to upgrade to a Standard Upgrade.

1. Run the `az aks nodepool add` command to add another node pool that uses the default Linux operating system.

    ```azurecli
    az aks nodepool add \
      --resource-group $RESOURCE_GROUP \
      --cluster-name $CLUSTER_NAME \
      --name userpool \
      --node-count 2 \
      --node-vm-size Standard_B2s
    ```

    The command adds a new node pool (**User mode**) to the AKS cluster that was created in the previous command. This **User** node pool is used to host applications and workloads, unlike the **System** node pool.

## Connect with kubectl

1. Connect to your cluster with `kubectl` by running the following command in Cloud Shell.

    ```azurecli
    az aks get-credentials --name $CLUSTER_NAME --resource-group $RESOURCE_GROUP
    ```

    This command adds an entry to your `~/.kube/config` file, which holds all the information to access your clusters. Kubectl enables you to manage multiple clusters from a single command-line interface.

1. Run the `kubectl get nodes` command to check that you can connect to your cluster, and confirm its configuration.

    ```bash
    kubectl get nodes
    ```

    The output should list four available nodes for two node pools.


    ```output
    NAME                                STATUS   ROLES    AGE    VERSION
    aks-nodepool1-12345678-vmss000000   Ready    <none>   6m7s   v1.33.7
    aks-nodepool1-12345678-vmss000001   Ready    <none>   6m8s   v1.33.7
    aks-userpool-98765432-vmss000000    Ready    <none>   79s    v1.33.7
    aks-userpool-98765432-vmss000001    Ready    <none>   87s    v1.33.7
    ```

    The `nodepool` nodes are the System node pool, and the `userpool` nodes are the User node pool. The System node pool is used to run critical cluster services, while the User node pool is used to run your applications and workloads.

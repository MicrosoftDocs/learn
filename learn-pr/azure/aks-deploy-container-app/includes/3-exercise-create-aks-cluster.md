In this exercise, create an AKS cluster that uses several nodes to meet the demand of many customers using the service. You decide to use the *single control plane and multiple nodes* architecture because it provides the best way to create and manage workload resources.

AKS supports both Linux and Windows node pools via the Portal or Azure CLI, however, if you're going to use Windows node pools, the cluster must be created with extra **prerequisites** and commands. Select an OS based on which type of node pools you want to add.

[!INCLUDE [azure-exercise-subscription-prerequisite](../../../includes/azure-exercise-subscription-prerequisite.md)]

#### [Linux](#tab/linux)

1. Sign in to Azure Cloud Shell with the account you want to deploy resources into.

    > [!div class="nextstepaction"]
    > [Azure Cloud Shell](https://shell.azure.com/bash?azure-portal=true)

    > [!IMPORTANT]
    > We'll run all the scripts with Bash, so if you haven't created a Cloud Shell yet, select *Bash* as the running shell.

1. Create variables for the configuration values you reuse throughout the exercises.

    ```bash
    export RESOURCE_GROUP=rg-contoso-video
    export CLUSTER_NAME=aks-contoso-video
    export LOCATION=eastus
    ```

    Update the LOCATION variable with the region closest to you. This example uses: `eastus`.

1. Run the `az group create` command to create a resource group. Deploy all resources into this new resource group.

    ```azurecli
    az group create --name=$RESOURCE_GROUP --location=$LOCATION
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

    The command creates a new AKS cluster named `aks-contoso-video` within the `rg-contoso-video` resource group. The cluster has two nodes defined by the `--node-count` parameter. We're using only two nodes in this exercise for cost considerations in this exercise. The `--node-vm-size` parameter configures the cluster nodes as Standard_B2s-sized VMs. These nodes are part of **System mode**.

    > [!IMPORTANT]
    > Standard B2s VMs are required to create node pools but not available in Free-Tier subscriptions. If you are recieving limits you need to upgrade to a Standard Upgrades.

1. Run the `az aks nodepool add` command to add another node pool that uses the default Linux operating system.

    ```azurecli
    az aks nodepool add \
        --resource-group $RESOURCE_GROUP \
        --cluster-name $CLUSTER_NAME \
        --name userpool \
        --node-count 2 \
        --node-vm-size Standard_B2s
    ```

    The command adds a new node pool (**User mode**) to the existing AKS cluster (created in the previous command). This new node pool is used to host applications and workloads, unlike the **System** node pool.

#### [Windows](#tab/windows)

1. Sign in to Azure Cloud Shell with the account you want to deploy resources into.

    > [!div class="nextstepaction"]
    > [Azure Cloud Shell](https://shell.azure.com/bash?azure-portal=true)

    > [!IMPORTANT]
    > We'll run all the scripts with Bash, so if you haven't created a Cloud Shell yet, select *Bash* as the running shell.

1. Create variables for the configuration values you reuse throughout the exercises.

    ```bash
    export RESOURCE_GROUP=rg-contoso-video
    export CLUSTER_NAME=aks-contoso-video
    export LOCATION=eastus
    ```

    Update the LOCATION variable with the region closest to you. This example uses: `eastus`.
1. Run the `az group create` command to create a resource group. Deploy all resources into this new resource group.

    ```azurecli
    az group create --name=$RESOURCE_GROUP --location=$LOCATION
    ```

1. Run the `az aks create` command to create an AKS cluster.

    ```azurecli
    az aks create \
        --resource-group $RESOURCE_GROUP \
        --name $CLUSTER_NAME \
        --node-count 2 \
        --generate-ssh-keys \
        --node-vm-size Standard_B2s \
        --network-plugin azure \
        --windows-admin-username localadmin
    ```

    The command creates a new AKS cluster named `aks-contoso-video` within the `rg-contoso-video` resource group. The cluster has two nodes defined by the `--node-count` parameter. We're using only two nodes in this exercise for cost considerations in this exercise. The `--node-vm-size` parameter configures the cluster nodes as Standard_B2s-sized VMs. These nodes are part of **System mode**.

    > [!IMPORTANT]
    > Standard B2s VMs are required to create node pools but not available in Free-Tier subscriptions. If you are recieving limits you need to upgrade to a Standard Upgrades.

    The `--windows-admin-username` parameter is used to set up administrator credentials for Windows containers, and prompts the user to set a password at the command line. The password has to meet [**Windows Server password requirements**](/windows/security/threat-protection/security-policy-settings/password-must-meet-complexity-requirements#reference).

1. Run the `az aks nodepool add` command to add another node pool that uses the Windows operating system.

    ```azurecli
    az aks nodepool add \
        --resource-group $RESOURCE_GROUP \
        --cluster-name $CLUSTER_NAME \
        --name uspool \
        --node-count 2 \
        --node-vm-size Standard_B2s \
        --os-type Windows
    ```

    The command adds a new node pool (**User mode**) to the existing AKS cluster (created in the previous command). This new node pool is used to host applications and workloads, unlike the **System** node pool.

    The `--os-type` parameter is used to specify operating system of the node pool. If not specified, the command uses Linux as operating system for the nodes.

---

## Link with kubectl

1. Link your Kubernetes cluster with `kubectl` by running the following command in Cloud Shell.

    ```azurecli
    az aks get-credentials --name $CLUSTER_NAME --resource-group $RESOURCE_GROUP
    ```

    This command adds an entry to your `~/.kube/config` file, which holds all the information to access your clusters. Kubectl enables you to manage multiple clusters from a single command-line interface.

1. Run the `kubectl get nodes` command to check that you can connect to your cluster, and confirm its configuration.

    ```bash
    kubectl get nodes
    ```

   The output should list four available nodes for two node pools.

#### [Linux](#tab/linux)

   ```output
   NAME                                STATUS   ROLES   AGE    VERSION
   aks-nodepool1-21895026-vmss000000   Ready    agent   245s   v1.23.12
   aks-nodepool1-21895026-vmss000001   Ready    agent   245s   v1.23.12
   aks-userpool-21895026-vmss000000    Ready    agent   105s   v1.23.12
   aks-userpool-21895026-vmss000001    Ready    agent   105s   v1.23.12
   ```

#### [Windows](#tab/windows)

   ```output
   NAME                                STATUS   ROLES   AGE    VERSION
   aks-nodepool1-40010859-vmss000000   Ready    agent   245s   v1.23.12
   aks-nodepool1-40010859-vmss000001   Ready    agent   245s   v1.23.12
   aksuspool000000                     Ready    agent   105s   v1.23.12
   aksuspool000001                     Ready    agent   105s   v1.23.12
   ```

---
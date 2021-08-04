In this exercise, you'll create an AKS cluster that uses several nodes to meet the demand of many customers using the service. You decide to use the *single control plane and multiple nodes* architecture because it provides the best way to create and manage workload resources.

AKS supports both Linux and Windows node pools via the Portal or Azure CLI, however, if you're going to use windows node pools, the cluster must be created with additional **pre-requisites** and commands. Please make a selection below, based on which type of node pools you want to add.

#### [Linux](#tab/linux)

## Activate the Azure sandbox

1. Start by **activating the Azure sandbox above.**
1. Once it's activated, sign into the [Azure portal for sandbox](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true). Make sure to use the same account you activated the sandbox with.

1. Create variables for the configuration values you'll reuse throughout the exercises.

    ```bash
    export RESOURCE_GROUP=<rgn>[sandbox resource group name]</rgn>
    export CLUSTER_NAME=aks-contoso-video
    ```

1. Run the `az aks create` command to create an AKS cluster.

    ```azurecli
    az aks create \
        --resource-group $RESOURCE_GROUP \
        --name $CLUSTER_NAME \
        --node-count 2 \
        --enable-addons http_application_routing \
        --generate-ssh-keys \
        --node-vm-size Standard_B2s \
        --network-plugin azure
    ```

    The above command creates a new AKS cluster named `aks-contoso-video` within the `rg-contoso-video` resource group. The cluster will have two nodes defined by the `--node-count` parameter. We're using only two nodes here for cost considerations in this exercise. The `--node-vm-size` parameter configures the cluster nodes as Standard_B2s-sized VMs. The HTTP application routing add-on is enabled via the `--enable-addons` flag. These nodes will be part of **System** mode.

1. Run the `az aks nodepool add` command to add additional node pool of linux operating system.

    ```azurecli
    az aks nodepool add \
        --resource-group $RESOURCE_GROUP \
        --cluster-name $CLUSTER_NAME \
        --name userpool \
        --node-count 2 \
        --node-vm-size Standard_B2s
    ```

    The above command adds a new node pool (**User mode**) to an existing AKS cluster (created in previous command). This new node pool can be used to host applications and workloads, instead of using **System** node pool, which gets created during previous command `az aks create`.

#### [Windows](#tab/windows)

> [!CAUTION]
> If you're using **Windows nodes** then the Azure Sandbox is **not supported**. Please use your own Azure subscription to continue.
>
> You can still use this page to follow the tutorial, however, you **will not be able to create AKS clusters using the provided cloud shell.**

[!INCLUDE [azure-exercise-subscription-prerequisite](../../../includes/azure-exercise-subscription-prerequisite.md)]

1. Sign in to Azure Cloud Shell with the account you want to deploy resources into.

    > [!div class="nextstepaction"]
    > [Azure Cloud Shell](https://shell.azure.com/?azure-portal=true)

    > [!IMPORTANT]
    > We'll run all the scripts with Bash, so if you haven't created a Cloud Shell yet, select *Bash* as the running shell.

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
        --generate-ssh-keys \
        --node-vm-size Standard_B2s \
        --network-plugin azure \
        --windows-admin-username localadmin
    ```

   The above command creates a new AKS cluster named `aks-contoso-video` within the `rg-contoso-video` resource group. The cluster will have two nodes defined by the `--node-count` parameter. We're using only two nodes here for cost considerations in this exercise. The `--node-vm-size` parameter configures the cluster nodes as Standard_B2s-sized VMs. The HTTP application routing add-on is enabled via the `--enable-addons` flag. These nodes will be part of **System** mode.

    The `--windows-admin-username` parameter is used to setup administrator credentials for Windows containers. The above command will prompt to set a password at the command line. The password has to meet [**Windows Server password requirements**](/windows/security/threat-protection/security-policy-settings/password-must-meet-complexity-requirements#reference).

1. Run the `az aks nodepool add` command to add additional node pool of Windows operating system.

    ```azurecli
    az aks nodepool add \
        --resource-group $RESOURCE_GROUP \
        --cluster-name $CLUSTER_NAME \
        --name userpool \
        --node-count 2 \
        --node-vm-size Standard_B2s \
        --os-type Windows
    ```

    The above command adds a new node pool (**User mode**) to an existing AKS cluster (created in previous command). This new node pool can be used to host applications and workloads, instead of using **System** node pool, which gets created during previous command `az aks create`.

    The `--os-type` parameter is used to specify operating system of the node pool. If not specified, it will use Linux as operating system for the nodes.

---

## Link with kubectl

1. Link your Kubernetes cluster with `kubectl` by running the following command in Cloud Shell.

    ```azurecli
    az aks get-credentials --name $CLUSTER_NAME --resource-group $RESOURCE_GROUP
    ```

    This command will add an entry to your `~/.kube/config` file, which holds all the information to access your clusters. Kubectl enables you to manage multiple clusters from a single command-line interface.

1. Run the `kubectl get nodes` command to check that you can connect to your cluster, and confirm its configuration.

    ```bash
    kubectl get nodes
    ```

   You should receive a list of four available nodes for two node pools.

#### [Linux](#tab/linux)

   ```output
   NAME                                STATUS   ROLES   AGE    VERSION
   aks-nodepool1-21895026-vmss000000   Ready    agent   245s   v1.19.9
   aks-nodepool1-21895026-vmss000001   Ready    agent   245s   v1.19.9
   aks-userpool-21895026-vmss000000    Ready    agent   105s   v1.19.9
   aks-userpool-21895026-vmss000001    Ready    agent   105s   v1.19.9
   ```

#### [Windows](#tab/windows)

   ```output
   NAME                                STATUS   ROLES   AGE    VERSION
   aks-nodepool1-40010859-vmss000000   Ready    agent   245s   v1.19.9
   aks-nodepool1-40010859-vmss000001   Ready    agent   245s   v1.19.9
   aksuserpool000000                   Ready    agent   105s   v1.19.9
   aksuserpool000001                   Ready    agent   105s   v1.19.9
   ```

---

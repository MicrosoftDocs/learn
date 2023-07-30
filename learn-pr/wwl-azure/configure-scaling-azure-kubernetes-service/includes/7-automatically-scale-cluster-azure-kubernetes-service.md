
The cluster autoscaler component can watch for pods in your cluster that can't be scheduled because of resource constraints. When issues are detected, the number of nodes in a node pool increases to meet the application demand. Nodes are also regularly checked for a lack of running pods, with the number of nodes then decreased as needed. This ability to automatically scale up or down the number of nodes in your AKS cluster lets you run an efficient, cost-effective cluster.

### Enable the cluster autoscaler on a new cluster

The cluster autoscaler is a Kubernetes component. Although the AKS cluster uses a virtual machine scale set for the nodes, don't manually enable or edit settings for scale set autoscale in the Azure portal or using the Azure CLI. Let the Kubernetes cluster autoscaler manage the required scale settings.

1.  Create a resource group using the [`az group create`](https://github.com/MicrosoftDocs/azure-docs/blob/main/cli/azure/group#az_group_create) command.
    
    ```azurecli
    az group create --name myResourceGroup --location eastus
    ```

2.  Create an AKS cluster using the [az aks create](https://github.com/MicrosoftDocs/azure-docs/blob/main/cli/azure/aks#az-aks-create) command and enable and configure the cluster autoscaler on the node pool for the cluster using the --enable-cluster-autoscaler parameter and specifying a node --min-count and --max-count. The following example command creates a cluster with a single node backed by a virtual machine scale set, enables the cluster autoscaler, sets a minimum of one and maximum of three nodes:
    
    ```azurecli
    az aks create \
        --resource-group myResourceGroup \
        --name myAKSCluster \
        --node-count 1 \
        --vm-set-type VirtualMachineScaleSets \
        --load-balancer-sku standard \
        --enable-cluster-autoscaler \
        --min-count 1 \
        --max-count 3
    ```

> [!NOTE]
> It takes a few minutes to create the cluster and configure the cluster autoscaler settings.<br>

### Enable the cluster autoscaler on an existing cluster

Update an existing cluster using the [`az aks update`](https://github.com/Azure/azure-cli-extensions/tree/master/src/aks-preview) command and enable and configure the cluster autoscaler on the node pool using the `--enable-cluster-autoscaler` parameter and specifying a node `--min-count` and`--max-count`. The following example command updates an existing AKS cluster to enable the cluster autoscaler on the node pool for the cluster and sets a minimum of one and maximum of three nodes:<br>

```azurecli
az aks update \
    --resource-group myResourceGroup \
    --name myAKSCluster \
    --enable-cluster-autoscaler \
    --min-count 1 \
    --max-count 3
```

> [!NOTE]
> It takes a few minutes to update the cluster and configure the cluster autoscaler settings.

### Disable the cluster autoscaler on a cluster

Disable the cluster autoscaler using the **az aks update** command and the `--disable-cluster-autoscaler` parameter.

```azurecli
az aks update \
    --resource-group myResourceGroup \
    --name myAKSCluster \
    --disable-cluster-autoscaler
```

> [!NOTE]
> Nodes aren't removed when the cluster autoscaler is disabled.

You can manually scale your cluster after disabling the cluster autoscaler using the [`az aks scale`](https://github.com/MicrosoftDocs/azure-docs/blob/main/cli/azure/aks#az-aks-scale) command.<br>

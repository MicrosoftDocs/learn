The cluster autoscaler watches for pods in your cluster that can't be scheduled because the pods' requested resources don't fit on the available nodes. When it detects unschedulable pods that could run if the node pool had more capacity, it increases the number of nodes. It also evaluates underutilized nodes and, after pods can be safely moved, decreases the node count when capacity is no longer needed. This ability to automatically scale up or down the number of nodes in your AKS cluster lets you run an efficient, cost-effective cluster.

The cluster autoscaler responds to Kubernetes scheduling decisions, not directly to CPU or memory pressure on running nodes. Define appropriate resource requests on workloads so the scheduler and the autoscaler can determine when more node capacity is required. When the horizontal pod autoscaler (HPA) creates more replicas, those new pods remain `Pending` if they can't fit on existing nodes. The cluster autoscaler can then add nodes, up to the node pool's `--max-count`, so the scheduler can place the pods.

Choose one of the following sections that matches your scenario. Don't run both procedures against the same cluster.

### Enable the cluster autoscaler on a new cluster

The following procedure creates a new AKS cluster with a single (default) node pool that has the cluster autoscaler enabled. For multi-node-pool clusters, configure each node pool individually with `az aks nodepool` commands.

The cluster autoscaler is a Kubernetes component. Although the AKS cluster uses a virtual machine scale set for the nodes, don't manually enable or edit settings for scale set autoscale in the Azure portal or using the Azure CLI. Let the cluster autoscaler manage the required scale settings.

1. Create a resource group using the `az group create` command.

    ```azurecli
    az group create --name myResourceGroup --location eastus
    ```

1. Create an AKS cluster using the `az aks create` command and enable and configure the cluster autoscaler on the node pool for the cluster using the `--enable-cluster-autoscaler` parameter and specifying `--min-count` and `--max-count` for the node pool. The default node pool is a system node pool. The Azure CLI accepts a `--min-count` of `1` for system node pools, but Microsoft recommends at least two nodes (and at least three nodes for a production cluster with a single system node pool) so that critical system pods remain healthy. The following example follows that recommendation by setting an initial node count and minimum of two nodes:

    ```azurecli
    az aks create \
        --resource-group myResourceGroup \
        --name myAKSCluster \
        --node-count 2 \
        --enable-cluster-autoscaler \
        --min-count 2 \
        --max-count 3 \
        --generate-ssh-keys
    ```

> [!NOTE]
> It takes a few minutes to create the cluster and configure the cluster autoscaler settings.

### Enable the cluster autoscaler on an existing cluster

For a cluster with a single node pool, update the cluster with the `az aks update` command and enable the cluster autoscaler on the default node pool by using `--enable-cluster-autoscaler` and specifying `--min-count` and `--max-count`. For multi-node-pool clusters, use `az aks nodepool update --update-cluster-autoscaler --min-count --max-count` against each target node pool instead. The following example updates a single-node-pool AKS cluster to enable the cluster autoscaler on the default node pool with a minimum of two and maximum of three nodes:

```azurecli
az aks update \
    --resource-group myResourceGroup \
    --name myAKSCluster \
    --enable-cluster-autoscaler \
    --min-count 2 \
    --max-count 3
```

> [!NOTE]
> It takes a few minutes to update the cluster and configure the cluster autoscaler settings.

### Update the cluster autoscaler settings

After enabling the cluster autoscaler on a single-node-pool cluster, you can change the node `--min-count` and `--max-count` values at any time by using the `az aks update` command with the `--update-cluster-autoscaler` parameter. For multi-node-pool clusters, use `az aks nodepool update --update-cluster-autoscaler --min-count --max-count` against the target node pool. The following example updates a single-node-pool cluster so that the autoscaler keeps a minimum of two and a maximum of five nodes:

```azurecli
az aks update \
    --resource-group myResourceGroup \
    --name myAKSCluster \
    --update-cluster-autoscaler \
    --min-count 2 \
    --max-count 5
```

> [!NOTE]
> The cluster autoscaler enforces the minimum count if the actual node count drops below the minimum because of external factors, such as a spot eviction.

> [!TIP]
> In clusters with multiple node pools, enable or update the cluster autoscaler on each target node pool by using `az aks nodepool update` with `--update-cluster-autoscaler`, `--min-count`, and `--max-count`. Each autoscaled node pool has its own minimum and maximum bounds. For more information, see [Scale node pools in AKS](/azure/aks/scale-node-pools).

### Disable the cluster autoscaler on a cluster

For a single-node-pool cluster, disable the cluster autoscaler using the `az aks update` command and the `--disable-cluster-autoscaler` parameter. For multi-node-pool clusters, use `az aks nodepool update --disable-cluster-autoscaler` against the target node pool.

```azurecli
az aks update \
    --resource-group myResourceGroup \
    --name myAKSCluster \
    --disable-cluster-autoscaler
```

> [!NOTE]
> Nodes aren't removed when the cluster autoscaler is disabled.

After you disable the cluster autoscaler, you can manually set fixed counts for either the workload or the node pool. To set a fixed replica count for a workload, use `kubectl scale deployment <deployment-name> --replicas <replica-count>`. To set a fixed node count for a single-node-pool cluster, use `az aks scale --resource-group myResourceGroup --name myAKSCluster --node-count <count>`. For a specific node pool or for a multi-node-pool cluster, use `az aks nodepool scale --resource-group myResourceGroup --cluster-name myAKSCluster --name <nodepool-name> --node-count <count>`. If the horizontal pod autoscaler is still configured, it continues to adjust pod replicas, but additional replicas might remain pending if the node pool doesn't have enough capacity.

### Beyond the cluster autoscaler: node auto-provisioning

The cluster autoscaler scales an existing node pool of a fixed VM SKU between a minimum and maximum count. For workloads where the right VM SKU is hard to predict, AKS also offers [node auto-provisioning (NAP)](/azure/aks/node-auto-provisioning), which uses the open-source Karpenter project to dynamically choose the optimal VM SKU and provision nodes based on pending pod resource requirements. NAP is an alternative node-scaling approach; choose either NAP or the cluster autoscaler for a cluster because NAP can't be enabled on clusters that already have the cluster autoscaler enabled.

For more information about cluster autoscaler commands and settings, see [Use the cluster autoscaler in AKS](/azure/aks/cluster-autoscaler).

> [!TIP]
> If you created a resource group only to try this procedure, delete it with `az group delete --name myResourceGroup --yes --no-wait` to avoid unintended cost.

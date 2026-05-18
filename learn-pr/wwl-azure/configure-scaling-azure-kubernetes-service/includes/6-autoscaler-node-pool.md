In this exercise, you use the Azure portal to enable the cluster autoscaler on a node pool of an existing AKS cluster. Enabling the cluster autoscaler lets the node pool automatically add or remove nodes in response to pod scheduling demand.

You can scale the number of nodes in your cluster to increase the total number of cores and memory available for your container applications.

AKS lets you manually set a fixed node count or enable the cluster autoscaler so the node pool grows and shrinks automatically within minimum and maximum limits. The cluster autoscaler scales up when pods can't be scheduled because the node pool doesn't have enough resources, and scales down when nodes are no longer needed and their pods can move elsewhere. When a node is removed, AKS cordons and drains the node to minimize disruption to running applications. When AKS adds nodes, it waits until nodes are marked **Ready** by the Kubernetes cluster before pods are scheduled on them. In this exercise, you enable the cluster autoscaler from the Azure portal.

> [!NOTE]
> To complete this exercise, you need:
>
> - An [Azure subscription](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn).
> - An existing AKS cluster with at least one node pool. To create one, see [Quickstart: Deploy an Azure Kubernetes Service (AKS) cluster by using the Azure portal](/azure/aks/learn/quick-kubernetes-deploy-portal).
> - A minimum and maximum node count that fits your workload, node pool mode, subscription vCPU quotas, and subnet IP capacity. The cluster autoscaler can't scale past the maximum count, and scale-up can fail if Azure quota or network capacity is exhausted. For more information, see [Scale node pools in Azure Kubernetes Service (AKS)](/azure/aks/scale-node-pools) and [Common issues and mitigation recommendations for cluster autoscaling in AKS](/azure/aks/cluster-autoscaler-overview#common-issues-and-mitigation-recommendations).

1. Sign in to the [Azure portal](https://portal.azure.com) and navigate to your AKS cluster resource.
1. In the service menu, under **Settings**, select **Node pools**.

    :::image type="content" source="../media/node-pools-adjust-scale-541110db.png" alt-text="Screenshot showing the AKS resource menu with Settings then Node pools selected and the node pools table visible in the Azure portal.":::

1. Select the node pool name to open its details.

    :::image type="content" source="../media/select-node-pool-a501c4e5.png" alt-text="Screenshot showing the Node pools page with the target node pool row selected in the Azure portal.":::

1. Select **Scale node pool**.

    :::image type="content" source="../media/scale-node-pool-ed62dd62.png" alt-text="Screenshot showing the node pool command bar with the Scale node pool action highlighted for an AKS node pool.":::

1. Select **Autoscale** and set the minimum and maximum node count.

    The autoscaler can change the node count only within these bounds. System node pools host critical system pods and can't scale to `0`. Use at least two nodes for system node pools; for a production AKS cluster with a single system node pool, use at least three nodes. User node pools can use a minimum of `0` if workloads can tolerate the time required to add nodes again. For more information, see [System and user node pools](/azure/aks/use-system-pools#system-and-user-node-pools).

    :::image type="content" source="../media/set-node-count-save-ac104d86.png" alt-text="Screenshot showing the Scale node pool pane with Autoscale selected, minimum and maximum node counts entered, and the Apply button available.":::

1. Select **Apply** to enable node scaling.

After autoscale is enabled, the cluster autoscaler manages the node count for that node pool automatically, and manual scaling for the pool is disabled. To change the bounds later, update the minimum and maximum node count for the node pool instead of setting a fixed node count. The equivalent Azure CLI operation is `az aks nodepool update` with `--update-cluster-autoscaler`, `--min-count`, and `--max-count`. To return to a fixed node count, disable the cluster autoscaler on the node pool and then scale the node pool manually with `az aks nodepool scale --node-count`. Don't manually configure Virtual Machine Scale Set autoscaling for AKS nodes.

### Clean up

If you only enabled autoscale to try the procedure, return the node pool to its previous configuration to avoid unintended cost. To revert, repeat the previous steps and either restore the previous fixed node count by selecting **Manual** and entering the original node count, or update the minimum and maximum values to match your standard configuration. Equivalent Azure CLI operations are `az aks nodepool update --disable-cluster-autoscaler` followed by `az aks nodepool scale --node-count <count>`.

For more information about how the cluster autoscaler works and recommended best practices, see [Cluster autoscaling in AKS overview](/azure/aks/cluster-autoscaler-overview).

Azure provides Azure Virtual Machine instances that offer scalability while reducing costs, and are ideal for workloads that can be interrupted. However, these virtual machines (VMs) access unused Azure compute capacity at lower prices but still support high-performance computing scenarios.

Your company's drone-tracking solution is deployed on Azure Kubernetes Service (AKS) as many containerized applications and services. One of these services is a batch-processing service that schedules drone flight paths. With a sudden growth in your customer base, the batch-processing service gets inundated with requests and builds up a backlog of deliveries. This situation is causing delays and frustrating customers.

Automatically scaling the number of batch-processing service replicas provides for the timely processing of orders. However, it also requires you to deploy more nodes to keep up with computing resource needs. Analyzing usage trends in Azure Monitor, you notice that these nodes are used only at specific times and not in a cost-effective way. The batch-processing service is stateless and doesn't save any client-session data. You realize that you can save money by:

- Using lower-cost node instances.
- Automatically scaling the node count in the node pool that's configured for batch processing.

Let's look at the infrastructure that underlies this cost-saving solution in AKS.

## What is a spot virtual machine (spot VM) in Azure?

A *spot virtual machine* is a VM that gives you access to unused Azure compute capacity at deep discounts. Spot VMs replace the existing, low-priority VMs in Azure. You can use spot VMs to run workloads that include:

- High-performance computing scenarios, batch processing, or visual-rendering applications.

- Large-scale, stateless applications.

- Developer/test environments, including continuous integration (CI) and continuous delivery (CD) workloads.

### Spot VM availability

Spot VM availability depends on factors such as capacity, size, region, and time of day. Azure allocates VMs only if capacity is available. As a result, there's no service-level agreement (SLA) for these types of VMs and they offer no high-availability guarantees.

### Spot VM eviction policy

The default eviction policy for spot VMs is **Deallocate**. Azure will evict spot VMs with 30 seconds of notice when capacity in a region becomes limited. A VM that's set with the **Deallocate** policy moves to the stopped-deallocated state when evicted. You can redeploy an evicted VM when spot capacity becomes available again. A deallocated VM is still counted toward your spot virtual CPU (vCPU) quota, and charges for the underlying allocated disks still apply.

## What is a spot virtual machine scale set?

A spot virtual machine scale set is a virtual machine scale set that supports Azure spot VMs. These VMs behave the same way as normal spot VMs, but with one difference: when you use virtual machine scale set support for spot VMs in Azure, you choose between two eviction policies:

- **Deallocate**: The Deallocate policy functions exactly as described earlier.

- **Delete**:  The Delete policy allows you to avoid the cost of disks and hitting quota limits. With the Delete eviction policy, evicted VMs are deleted together with their underlying disks. The scale set's autoscaling feature can now automatically try to compensate for the eviction of VMs by creating new VMs. Although the creation of VMs isn't guaranteed, the evicted VMs don't count toward your vCPU quota or incur costs for underlying disks.  

    A best practice is to use the autoscale feature only when you set the eviction policy to **Delete** on the scale set.

## What is a spot node pool in Azure Kubernetes Service (AKS)?

A *spot node pool* is a user node pool that uses a spot virtual machine scale set. AKS supports spot VMs when you:

- Need to create user node pools.
- Want the cost benefits offered by virtual machine scale set support for Azure spot VMs.

Use spot node pools to:

- Take advantage of unused capacity in Azure.
- Use scale set features with the Delete eviction policy.
- Define the maximum price you want to pay per hour.
- Enable the recommended AKS Kubernetes cluster autoscaler when using spot node pools.

For example, to support the batch-processing service of the drone-tracking application, you can create a spot user node pool and enable the cluster autoscaler. You then configure the horizontal pod scaler to deploy additional batch-processing services to match resource demands.

As the demand for nodes increases, the cluster autoscaler can scale the number of nodes up and down in the spot node pool. If node evictions happen, the cluster autoscaler keeps trying to scale up the node count if additional nodes are still needed.

## Spot node pool limitations

Before you decide to add a spot user node pool to your AKS cluster, consider the following limitations:

- The underlying spot scale set is deployed only to a single fault domain and offers no high-availability guarantees.
- The AKS cluster needs multiple node-pool support to be enabled.
- You can use spot node pools only as user node pools.
- Spot node pools can't be upgraded.
- The creation of spot VMs isn't guaranteed. The creation of spot nodes depends on capacity and quota availability in the cluster's deployed Azure region.

Remember that spot node pools should be used only for workloads that can be interrupted.

## Create a spot node pool

Spot node pools are in preview at the time this module is being written. To complete configuration of the spot node pool, you need to enable the preview feature on the **Microsoft.ContainerService** resource provider and install the aks-preview CLI extension.

>[!IMPORTANT]
>
>In some subscriptions, such as sponsorship subscriptions, the ability to create spot VMs and spot node pools is limited. You might not be able to create a spot node pool for your cluster.

## Enable preview features on your subscription

To use spot node pools, you must enable the **spotpoolpreview** feature on your subscription and provide the latest set of service enhancements when configuring a cluster.

>[!CAUTION]
>
>After you enable some preview features in Azure, defaults might be used for all AKS clusters created in the subscription. Test any preview features in non-production subscriptions to avoid unforeseen side effects in production deployments.

To register the **spotpoolpreview** feature:

1. Use the `az feature register` command to register the **spotpoolpreview** feature. This command takes two parameters: *namespace* identifies the resource provider you're registering the feature with, and *name* identifies the feature.

    You register the **spotpoolpreview** feature with the **Microsoft Container Service** resource provider.

    The **Microsoft Container Service** resource provider enables actions that impact an AKS cluster's management. Examples of actions include creating, updating, and deleting container services, or reading details about them.

    Here's an example of the `az feature register` command to register the **spotpoolpreview** feature:

    ```azurecli
    az feature register --namespace "Microsoft.ContainerService" --name "spotpoolpreview"
    ```

1. The registration of the resource provider requires a refresh when the feature is registered. To check the status of the registration, query the resource provider's feature list. The `az feature list` query returns the value **Registered** when it's complete. Here's an example of the query command:

    ```azurecli
    az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/spotpoolpreview')].{Name:name,State:properties.state}"
    ```

1. When the feature is registered, the last step is to propagate the new registration. Run the `az provider register` command with the `--namespace` parameter, specifying the same resource provider as before. Here's an example of the `az provider register` command.

    ```azurecli
    az provider register --namespace Microsoft.ContainerService
    ```

## Install the aks-preview CLI extension

The AKS spot node pool command parameters are available only in the aks-preview CLI extension. Without the extension installed, you can't use the preview features.

You can run the following commands to install the extension or, if it's already installed, to check its version and update it.

If the extension isn't already installed, run this command to install it:

```azurecli
az extension add --name aks-preview
```

You must install the aks-preview CLI extension version 0.4.53 or later to create an AKS cluster that uses spot node pools. Check the installed version of the extension if you've already installed the preview version. To query the extension version, run the `az extension show` command:

```azurecli
az extension show --name aks-preview --query [version]
```

If you've previously installed the extension and need to update it to a newer version, run the `az extension update` command:

```azurecli
az extension update --name aks-preview
```

## Add a spot node pool to an AKS cluster

A spot node pool can't be a system node pool for an AKS cluster. You'll first create your cluster and then use the `az aks nodepool add` command to add a new user node pool.

You set several parameters for a new node pool to configure it as a spot node pool.

### Priority

The `--priority` parameter is set to `Regular` by default for a new node pool. Set the value to `Spot` to indicate that the new pool you're creating is a spot node pool. This value can't be changed after creation.

### Eviction policy

A spot node pool must use a virtual machine scale set. Recall from earlier discussion that the spot node pool uses a spot scale set. Set `--eviction-policy` to `Delete` to allow the scale set to remove both the node and the underlying, allocated disk used by the node. This value can't be changed after creation.

You can set the eviction policy to `Deallocate`. However, when these nodes are evicted, they'll count against your compute quota and impact later scaling or upgrading of the cluster.

### Maximum price for spot node

Spot node pools enable you to optimize costs by setting the maximum amount that you're willing to pay per spot node per hour. To set your safe amount, use the `--spot-max-price` parameter. Newly created spot nodes are evicted when this value is reached.

You can set this value to any positive amount up to five decimal places, or set it to -1. Setting the `--spot-max-price` value to -1 affects your node pool in the following ways:

- Nodes won't be evicted based on the node's price.
- The cost for new nodes will be the current price for spot nodes or the price for a standard node, whichever is lower.

For example, if you set the value to 0.98765, the maximum price for a node will be USD0.98765 per hour. When the node's consumption exceeds this amount, it's evicted.

### Enable the cluster autoscaler

We recommend that you enable the cluster autoscaler by using the `--enable-cluster-autoscaler` parameter. If you don't use the cluster autoscaler, you risk the node count dropping to zero in the node pool as nodes are evicted because of Azure capacity constraints.

### Minimum node count

Set the minimum node count to a value between 1 and 100 by using the `--min-count` parameter. A minimum node count is required when you enable the cluster autoscaler.

### Maximum node count

Set the maximum node count to a value between 1 and 100 by using the `--max-count` parameter. A maximum node count is required when you enable the cluster autoscaler.

Here's an example `az aks nodepool add` command that adds a spot node pool. Notice the use of the additional parameters to enable the spot node features.

```azurecli
az aks nodepool add \
    --resource-group resourceGroup \
    --cluster-name aksCluster \
    --name spotpool01 \
    --enable-cluster-autoscaler \
    --max-count 3 \
    --min-count 1 \
    --priority Spot \
    --eviction-policy Delete \
    --spot-max-price -1 \
    --no-wait
```

## Deploy pods to spot node pools

When deploying workloads in Kubernetes, you can provide information to the scheduler to specify which nodes the workloads can or can't run. You control workload scheduling by configuring *taints*, *toleration*, or *node affinity*. Spot nodes are configured with a specific label and taint.

### What is a taint?

A taint is applied to a node to indicate that only specific pods can be scheduled on it. Spot nodes are configured with a label set to `kubernetes.azure.com/scalesetpriority:spot`.

### What is toleration?

Toleration is a specification applied to a pod to allow it to tolerate a node's taint. Spot nodes are configured with a node taint set to `kubernetes.azure.com/scalesetpriority=spot:NoSchedule`.

### What is node affinity?

You use node affinity to describe which pods are scheduled on a node. Affinity is specified by using labels defined on the node. For example, in AKS, system pods are configured with anti-affinity towards spot nodes to prevent the pods from being scheduled on these nodes.

## Define toleration in a pod manifest file

You specify node taint toleration by creating a `tolerations` dictionary entry in your workload manifest file. In this dictionary, you set the following properties for each node taint the workload has to tolerate in this section:

| Property | Description |
| --- | --- |
| `key` | Identifies a node taint key-value pair specified on the node. For example, on a spot node pool, the key-value pair is `kubernetes.azure.com/scalesetpriority:spot`. The key is `kubernetes.azure.com/scalesetpriority`. |
| `operator` | Allows the toleration to match a taint. The default operator is `Equal`. You can also specify `Exists` to match toleration. However, when you use `Exists`, you don't specify the following property (`value`). |
| `value` | Represents the value part of the node taint key-value pair that is specified on the node. For example, on a spot node pool with a key-value pair of `kubernetes.azure.com/scalesetpriority:spot`, the value is `spot`. |
| `effect` | Indicates how the scheduling of a pod is handled in the system. There are three options: `NoSchedule`, `PreferNoSchedule`, and `NoExecute`. `NoSchedule` ensures that the system won't schedule the pod. `PreferNoSchedule` allows the system to try not to schedule the pod. `NoExecute` either evicts pods that are already running on the tainted node or doesn't schedule the pod at all. |

Here's an example of a workload that has toleration added for spot node pools.

```yml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    env: test
spec:
  containers:
  - name: nginx
    image: nginx
    imagePullPolicy: IfNotPresent
  tolerations:
  - key: "kubernetes.azure.com/scalesetpriority"
    operator: "Equal"
    value: "spot"
    effect: "NoSchedule"
```

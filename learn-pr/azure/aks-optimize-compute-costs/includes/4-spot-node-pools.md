Your company's drone tracking solution is deployed on Azure Kubernetes Service (AKS) as many containerized applications and services. One of these services is a batch processing service that schedules drone flight paths. With a sudden growth in your customer base, you see the batch processing service gets inundated with requests and builds up a backlog of deliveries, causing delays and frustrates customers.

Automatically scaling the number of batch processing service replicas allows for the timeous processing of orders and requires you to deploy more nodes to keep up with computing resource needs. Analyzing usage trends in Azure Monitor, you realize these nodes are only used at specific times during the day and not cost-effectively. The batch processing service is stateless and doesn't save and client session data. You realize you can save money, by using lower-cost node instances and automatically scale the node count in the node pool configured for batch processing.

Azure provides Azure Virtual Machine instances that you can use to access unused Azure compute capacity at deep discounts. These VMs are ideal for workloads that can be interrupted, providing scalability while reducing costs.

Let's look at the underlying infrastructure that allows for this cost-saving solution in AKS.

## What is an Azure Spot Virtual Machine (Spot VM)?

A Spot Virtual Machine is a VM that allows you access to unused Azure compute capacity at deep discounts. Spot VMs replace the existing low-priority VMs in Azure. You can use Spot VMs to run workloads that include:

- High-performance computing scenarios, batch processing, or visual rendering applications

- Large-scale stateless applications

- Developer/test environments, including continuous integration (CI) and continuous delivery (CD) workloads

### Spot VM availability

Spot VM availability depends on factors such as capacity size, region, and time of day. Azure will allocate VMs only if there's capacity available. As a result, no SLA is available for these types of VMs and they offer no high availability guarantees.

### Spot VM eviction policy

The default Spot VM eviction policy is **Deallocate**. Azure will evict Spot VMs with a 30 seconds notice once capacity in a region becomes limited. A VM set with the *Deallocate* policy, moves to the stopped-deallocated state when evicted. You may redeploy an evicted VM when Spot capacity becomes available again. A deallocated VM keeps counting to your Spot vCPU quota, and charges for the underlying allocated disks still apply.

## What is a Spot Virtual machine scale set

A Spot Virtual machine scale set is Virtual machine scale sets that support Azure Spot VMs. These VMs have the same behavior as normal Spot VMs, but with one difference. You choose between two eviction policies when you use virtual machine scale set support for Azure Spot VMs. These policies are:

- **Deallocate**

    The *Deallocate* policy functions exactly as described earlier.

- **Delete**

    The **Delete** policy allows you to avoid the cost of disks and hitting quota limits. With the *Delete* eviction policy, evicted VMs are deleted together with their underlying disks. The scale set's autoscaling feature can now automatically try to compensate for the eviction of VMs and create new VMs. Though the creation of VMs isn't guaranteed, the evicted VMs don't count towards your vCPU quota, and underlying disks cost.  

    Best practice advice is to only use the autoscale feature when you set the eviction policy to delete on the scale set.

## What is a Spot node pool in Azure Kubernetes Service (AKS)?

A spot node pool is a user node pool that uses a spot virtual machine scale set. AKS supports *Spot VMs* when you need to create user node pools and want to use the cost benefits that *Virtual machine scale set support for Azure Spot VMs* offer.

 These node pools allow you to:

- Take advantage of unutilized capacity in Azure
- Use scale set features with the *Delete* eviction policy
- Define the maximum price you want to pay per hour
- Enable the recommended AKS Kubernetes cluster autoscaler when using spot node pools

For example, to support the drone tracking application's batch processing service, you can create a spot node pool and enable the **cluster autoscaler**. You then configure the **horizontal pod scaler** to deploy additional batching processing services to match resource demands.

As the demand for nodes increase, the **cluster autoscaler** can scale the number of nodes up and down in the spot node pool. Should node evictions happen, the **cluster autoscaler** will continue to try to scale the node count up if additional nodes are still needed.

## Spot node pool limitations

Before you decide to add a spot node pool to your AKS cluster, consider the following limitations.

- The underlying spot scale set is only deployed to a single fault domain and offers no high availability guarantees.
- The AKS cluster needs multiple node pool support enabled.
- You can only use spot node pools as secondary pools.
- Spot node pool can't be upgraded.
- The creation of Spot VMs isn't guaranteed. The creation of spot nodes depends on capacity and quota availability in the cluster's deployed Azure region.

It's important to keep in mind that spot node pools should only be used for workloads that can be interrupted.

## How to create a spot node pool

Spot node pools are, at the time of creating this content, in preview. To complete the spot node pool configuration, you need to enable the preview feature on the *Microsoft.ContainerService* resource provider and installing the aks-preview CLI extension.

>[!IMPORTANT]
>
>In some subscriptions, such as sponsorship subscriptions, the ability to create Spot VMs and Spot node pools are limited. You may not be able to create a spot node pool for your cluster.

## Enable preview features on your subscription

To use spot node pools, you must enable the **spotpoolpreview** feature on your subscription and provide the latest set of service enhancements when configuring a cluster.

>[!CAUTION]
>
>Once you enable some preview features in Azure, defaults may be used for all AKS clusters created in the subscription. Test preview features in non-production subscriptions to avoid unforeseen side effects in production deployments.

There are a couple of steps to registering the **spotpoolpreview** feature.

1. You first register the **spotpoolpreview** feature using the `az feature register` command. This command takes two parameters. The *namespace* identifies the resource provider you're registering the feature, and the name of the *feature*.

    You register the **spotpoolpreview** feature with the **Microsoft Container Service** resource provider.

    The **Microsoft Container Service** resource provider allows for actions that impact an AKS cluster's management. For example, reading details about creating or updating, and deleting container services, and so on.

    Here is an example of the `az feature register` command to register the *spotpoolpreview* feature.

    ```azurecli
    az feature register --namespace "Microsoft.ContainerService" --name "spotpoolpreview"
    ```

1. The registration of the resource provider requires a refresh when then feature is registered. To check the status of the registration, you query the resource providers' feature list. The `az feature list` query returns the value **Registered** once complete. Here is an example of the query command.

    ```azurecli
    az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/spotpoolpreview')].{Name:name,State:properties.state}"
    ```

1. Once registered, the last step is to propagate the new feature registration. You run the `az provider register` command with the `--namespace` parameter using the same resource provider from earlier. Here is an example of the `az provider register` command.

    ```azurecli
    az provider register --namespace Microsoft.ContainerService
    ```

## Install aks-preview CLI extension

The AKS spot node pool command parameters are only available in the aks-preview CLI extension. Without the extension installed, you can't use the preview features.

You can run the following two commands to install or update the extension if already installed.

```azurecli
az extension add --name aks-preview
```

You need to install the aks-preview CLI extension version 0.4.53 or higher to create an AKS cluster that uses spot node pools. Check the installed version of the extension if you've already installed the preview version. Run the `az extension show` command to query the extension version.

```azurecli
az extension show --name aks-preview --query [version]
```

You update the extension by running the `az extension update` command if you've previously installed the extension and need to update it to a newer version.

```azurecli
az extension update --name aks-preview
```

## Add a spot node pool to an AKS cluster

A spot node pool can't be a primary node pool for an AKS cluster. You'll first create your cluster and then use the `az aks nodepool add` command to add a new user node pool.

You set several parameters for a new node pool to configure it as a spot node pool.

#### Priority

The `--priority` parameter is set to `Regular` by default for a new node pool. You have set the value to `Spot` to indicate that the new pool you're creating is a spot node pool. This value can't be changed after creation.

#### Eviction policy

A spot node pool must use a Virtual Machine Scale Set. Recall from earlier that the spot node pool is using a spot scale set. Set `--eviction-policy` to `Delete` to allow the scale set to remove the node and the underlying allocated disk used by the node. This value can't be changed after creation.

You may set the eviction policy to `Deallocate`. However, when evicted, these nodes will count against your compute quota and impact later cluster scaling or upgrading.

#### Spot max price

Spot node pools allow you to optimize costs by setting the maximum amount you're willing to pay per spot node per hour. To set your safe amount, you use the `spot-max-price` parameter. Newly created spot nodes are evicted once this value is reached.

You can set this value to any positive amount up to five decimals, or set it to -1. Setting the `spot-max-price` value to -1 effects your node pool in the following ways:

- nodes won't be evicted based on the node's price
- cost for new nodes will be the current price for Spot nodes or the price for a standard node, whichever is less

For example, assume you set the value to 0.98765, then the max price for a node will be 0.98765 USD per hour. When the node's consumption exceeds this amount, it's evicted.

#### Enable cluster autoscaler

It's recommended to enable the cluster autoscaler. If you don't use the cluster autoscaler, you run the risk of the node count dropping to zero in the node pool as nodes are evicted because of Azure capacity constraints.

#### Min count

Set the minimum node count to a value between 1 and 100 by using the `--min-count`. Minimum node count is required when enabling the cluster autoscaler.

#### Max count

Set the maximum node count to a value between 1 and 100 by using the `--max-count`. Maximum node count is required when enabling the cluster autoscaler.

Here is an example `az aks nodepool add` command that adds a spot node pool. Notice the use of the additional parameters to enable the spot node features.

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

## How to deploy pods to spot node pools

When deploying workloads in Kubernetes, you can provide information to the scheduler to specify which nodes the workloads may or may not run. You control workload scheduling by configuring taints, toleration, or node affinity. Spot nodes are configured with a specific label and taint.

## What is a taint?

A taint is applied to a node to indicate that only specific pods can be scheduled on them. Spot nodes are configured with a label set to `kubernetes.azure.com/scalesetpriority:spot`.

## What is toleration?

Toleration is a specification applied to a pod to allow it to tolerate a node's taint. Spot nodes are configured with a node taint set to `kubernetes.azure.com/scalesetpriority=spot:NoSchedule`.

## What is node affinity?

Node affinity allows you to describe which Pods are scheduled on a node. Affinity is specified using labels defined on the node. For example, in AKS,  system pods are configured with anti-affinity towards spot nodes to prevent them from being scheduled on these nodes.

## How to define toleration in a pod manifest file

Node taint toleration is specified by creating a `tolerations` dictionary entry in your workload manifest file. In this dictionary, you set the following properties for each node taint the workload has to tolerate in this section.

| Property | Description |
| --- | --- |
| `key` | The key identifies a node taint key-value pair specified on the node. For example, on a spot node pool, the key-value pair is `kubernetes.azure.com/scalesetpriority:spot`. The key is `kubernetes.azure.com/scalesetpriority`. |
| `operator` | The operator allows the toleration to match a taint. The default operator is `Equal`. You may also specify `Exists` to match toleration. However, when using `Exists`, the following property, `value`, isn't specified. |
| `value` | This item is the value part of the node taint key-value pair specified on the node. For example, on a spot node pool with a key-value pair of `kubernetes.azure.com/scalesetpriority:spot`. The value is `spot`. |
| `effect` | This value indicates how the scheduling of a pod is handled in the system. There are three options to choose from, `NoSchedule`, `PreferNoSchedule`, and `NoExecute`. `NoSchedule` ensures the system won't schedule the pod, `PreferNoSchedule` allows the system to try and not schedule the pod, and `NoExecute` will either evict pods already running on the tainted node or not schedule the pod at all. |

Here is an example of a workload that has toleration added for spot node pools.

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

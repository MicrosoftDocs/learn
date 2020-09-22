Azure Kubernetes Service allows you to create different node pools to match specific workloads to the nodes running in each node pool.

Recall from the drone tracking example. Your team developed a new predictive-modeling service that processes flight-path information in extreme weather conditions and creates optimal flight routes. This service requires GPU-based virtual-machine (VM) support and runs only on specific days during the week. The team wants to make sure no VMS are used when the service doesn't run.

Here, you'll create an Azure Kubernetes Service (AKS)-managed Kubernetes cluster. You'll configure the cluster to support multiple node pools and make sure the cluster allows you to scale the nodes in the node pools. Then you'll add a second node pool to support user workloads. Finally, you'll scale the node count in the second node pool to zero to reduce the cost of the node used in your AKS cluster.

## Create a new resource group

1. Sign in to Azure Cloud Shell by using your Azure account. Select the Bash version of Cloud Shell.

    >[!div class="nextstepaction"]
    >[Azure Cloud Shell](https://shell.azure.com/?azure-portal=true)

1. You'll reuse some values throughout the exercises in this module. For example, you need to choose a region where you want to create a resource group. Some features that you'll add in later exercises might not be available in the region you select. For this reason, we recommend that you select **East US**. If you choose a different value, remember to note that value for use with exercises throughout the module.

    Run the following commands to register your variables:

    ```azurecli
    REGION_NAME=eastus
    RESOURCE_GROUP=rg-akscostsaving
    AKS_CLUSTER_NAME=akscostsaving-$RANDOM
    ```

    [!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

    You can check each value by using the `echo` command, for example, `echo $REGION_NAME`.

1. Make a note of your new cluster's name. You'll use this value later when you clean up resources, and in configuration settings for the cluster.

    ```bash
    echo $AKS_CLUSTER_NAME
    ```

1. Create a new resource group named **rg-akscostsaving**. Deploy all resources created in these exercises in this resource group. A single resource group makes it easier to clean up the resources after you finish the module.

    ```azurecli
    az group create \
        --name $RESOURCE_GROUP \
        --location $REGION_NAME
    ```

## Create the AKS cluster

With the resource group in place, you can now create the AKS cluster. Your first step is to get the version of the latest, non-preview version of Kubernetes in your selected region. You'll use this version in configuring the cluster.

1. To get the latest, non-preview Kubernetes version, use the `az aks get-versions` command. Store the value that the command returns in a Bash variable named `VERSION`. To retrieve and store the version number, run the following command:

    ```azurecli
    VERSION=$(az aks get-versions \
        --location $REGION_NAME \
        --query 'orchestrators[?!isPreview] | [-1].orchestratorVersion' \
        --output tsv)
    ```

1. Run the `az aks create` command shown later in this step to create the AKS cluster. The cluster will run the latest Kubernetes version with two nodes in the system node pool. This command can take a few minutes to finish.

    The `az aks create` command has several parameters that enable precise configuration of your Kubernetes cluster. There are two important parameters in configuring the correct support in your cluster for scaling and multiple node pools:

    | Parameter and value | Description |
    | --- | --- |
    | `--load-balancer-sku standard` | The default load-balancer support in AKS is `basic`.  The `basic` load balancer isn't supported when you use multiple node pools. Set the value to `standard`. |
    | `--vm-set-type VirtualMachineScaleSets` | To use the scale features in AKS, virtual machine scale sets are required. This parameter enables support for scale sets.

    ```azurecli
    az aks create \
        --resource-group $RESOURCE_GROUP \
        --name $AKS_CLUSTER_NAME \
        --location $REGION_NAME \
        --kubernetes-version $VERSION \
        --node-count 2 \
        --load-balancer-sku standard \
        --vm-set-type VirtualMachineScaleSets \
        --generate-ssh-keys
    ```

    Notice that two nodes are configured in the default node pool by using the `--node-count 2` parameter. Recall from earlier discussion that essential system services run across this system node pool. It's important that production clusters use at least `--node-count 3` for reliability in cluster operation. We're using only two nodes here for cost considerations in this exercise.

1. Run the `az aks nodepool list` command to list the node pools in your new cluster:

    ```azurecli
    az aks nodepool list --resource-group $RESOURCE_GROUP --cluster-name $AKS_CLUSTER_NAME
    ```

    Here's an example of the output from the command:

    ```output
    [
      {
        "agentPoolType": "VirtualMachineScaleSets",
        "availabilityZones": null,
        "count": 2,
        "enableAutoScaling": null,
        "enableNodePublicIp": false,
        "id": "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourcegroups/rg-akscostsaving/providers/Microsoft.ContainerService/managedClusters/akscostsaving-17835/agentPools/nodepool1",
        "mode": "System",
        "name": "nodepool1",
        ...
        "type": "Microsoft.ContainerService/managedClusters/agentPools",
        "upgradeSettings": null,
        "vmSize": "Standard_DS2_v2",
        "vnetSubnetId": null
      }
    ]
    ```

    Notice that the `mode` of the node pool is set to `System` and that the `name` is automatically assigned.

## Add a node pool

1. Your cluster has a single node pool. Add a second node pool by using the `az aks nodepool add` command. Use the command in this step to create a user node pool with three nodes and the name `batchprocpl`. Keep in mind that node-pool names must start with a lowercase letter and contain only alphanumeric characters. Node-pool names are limited to 12 characters for Linux node pools and six characters for Windows node pools.

    Run the following command:

    ```azurecli
    az aks nodepool add \
        --resource-group $RESOURCE_GROUP \
        --cluster-name $AKS_CLUSTER_NAME \
        --name batchprocpl \
        --node-count 2
    ```

1. Run the `az aks nodepool list` command to list the new node pool in your new cluster:

    ```azurecli
    az aks nodepool list --resource-group $RESOURCE_GROUP --cluster-name $AKS_CLUSTER_NAME
    ```

    Here's an example of the output from the command:

    ```output
    [
      {
        "agentPoolType": "VirtualMachineScaleSets",
        "availabilityZones": null,
        "count": 2,
        "enableAutoScaling": null,
        "enableNodePublicIp": false,
        "id": "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourcegroups/rg-akscostsaving/providers/Microsoft.ContainerService/managedClusters/akscostsaving-17835/agentPools/batchprocpl",
        "mode": "User",
        "name": "batchprocpl",
        ...
        "type": "Microsoft.ContainerService/managedClusters/agentPools",
        "upgradeSettings": {
          "maxSurge": null
        },
        "vmSize": "Standard_DS2_v2",
        "vnetSubnetId": null
      },
      {
        "agentPoolType": "VirtualMachineScaleSets",
        "availabilityZones": null,
        "count": 2,
        "enableAutoScaling": null,
        "enableNodePublicIp": false,
        "id": "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourcegroups/rg-akscostsaving/providers/Microsoft.ContainerService/managedClusters/akscostsaving-17835/agentPools/nodepool1",
        "mode": "System",
        "name": "nodepool1",
        ...
        "type": "Microsoft.ContainerService/managedClusters/agentPools",
        "upgradeSettings": null,
        "vmSize": "Standard_DS2_v2",
        "vnetSubnetId": null
      }
    ]
    ```

    Notice that the `mode` of the new node pool is set to `User` and that the `name` is `batchprocpl`.

## Scale the node-pool node count to zero

You use the `az aks nodepool scale` command to scale nodes in a node pool manually.

Run the `az aks nodepool scale` command and use the `--node-count` parameter to set the node-count value to 0.

Here's an example of the command:

```azurecli
az aks nodepool scale \
    --resource-group $RESOURCE_GROUP \
    --cluster-name $AKS_CLUSTER_NAME \
    --name batchprocpl \
    --node-count 0
```

Here's an example of the output from the command:

```output
{
  "agentPoolType": "VirtualMachineScaleSets",
  "availabilityZones": null,
  "count": 0,
  "enableAutoScaling": null,
  "enableNodePublicIp": false,
  "id": "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourcegroups/rg-akscostsaving/providers/Microsoft.ContainerService/managedClusters/akscostsaving-17835/agentPools/batchprocpl",
  "maxCount": null,
  "maxPods": 110,
  "minCount": null,
  "mode": "User",
  "name": "batchprocpl",
  "nodeImageVersion": "AKSUbuntu-1604-2020.06.10",
  "nodeLabels": null,
  "nodeTaints": null,
  "orchestratorVersion": "1.17.9",
  "osDiskSizeGb": 128,
  "osType": "Linux",
  "provisioningState": "Succeeded",
  "proximityPlacementGroupId": null,
  "resourceGroup": "rg-akscostsaving",
  "scaleSetEvictionPolicy": null,
  "scaleSetPriority": null,
  "spotMaxPrice": null,
  "tags": null,
  "type": "Microsoft.ContainerService/managedClusters/agentPools",
  "upgradeSettings": {
    "maxSurge": null
  },
  "vmSize": "Standard_DS2_v2",
  "vnetSubnetId": null
}
```

Notice that the node pool `count` parameter value is 0 and that the `enableAutoScaling` value is set to `null` in the returned result. You'll have to increase the node count for this node pool manually when you need to schedule workloads here, because node creation won't happen automatically.

## Configure the Kubernetes context

In the output from the previous command, the node pool count is set to 0. You can confirm the available nodes in the cluster by running the `kubectl get nodes` command.

1. You use `kubectl` to interact with your cluster's API server. You have to configure a Kubernetes cluster context to allow `kubectl` to connect. The context contains the cluster's address, a user, and a namespace. Use the `az aks get-credentials` command to configure the Kubernetes context in Cloud Shell.

    Retrieve the cluster credentials by running this command:

    ```azurecli
    az aks get-credentials \
        --resource-group $RESOURCE_GROUP \
        --name $AKS_CLUSTER_NAME
    ```

    Here's an example of the output from the command.

    ```output
    Merged "akscostsaving-17835" as current context in /home/user/.kube/config
    ```

1. Run `kubectl get nodes` to list the nodes in your node pools.

    Here's an example of the command output:

    ```output
    NAME                                STATUS   ROLES   AGE   VERSION
    aks-nodepool1-37990379-vmss000000   Ready    agent   32m   v1.17.9
    aks-nodepool1-37990379-vmss000001   Ready    agent   32m   v1.17.9
    ```

    Notice that, even though the `az aks nodepool list` command lists two node pools, there are only two nodes available in the cluster, and both are from `nodepool1`.

To optimize costs on AKS when you manage workload demands directly, a good strategy is to:

- Manually scale the node count in node pools.
- Scale expensive, NV-based user node pools to zero.

Let's look at a strategy where you need to scale nodes, but don't control demand directly.

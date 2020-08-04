In this exercise, you'll create an Azure Kubernetes Service Kubernetes cluster. You'll configure the cluster to support multiple node pools and make sure the cluster allows you to scale the nodes in the node pools. Then you'll add a second node pool to support user workloads. Finally, you'll scale the node count in the second node pool to zero to reduce the cost of the node used in your AKS cluster.

## Create a new resource group

1. Sign in to Azure Cloud Shell with your Azure Account. Select the Bash version of Cloud Shell.

    >[!div class="nextstepaction"]
    >[Azure Cloud Shell](https://shell.azure.com/?azure-portal=true)

1. You'll reuse some values throughout the exercises in this module. For example, you need to choose a region where you want to create a resource group. Some features, that you'll add in later exercises, may not be available in the region you select. For this reason, we advise you to use **East US**. If you choose a different value, remember to note the value for use with exercises throughout the module.

    Run the following commands to register your variables.

    ```azurecli
    REGION_NAME=eastus
    RESOURCE_GROUP=aks-costsaving-grp
    AKS_CLUSTER_NAME=akscostsaving-$RANDOM
    ```

    [!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

    You can check each value using the `echo` command, for example, `echo $REGION_NAME`.

1. Make a note of your new cluster's name. You'll use this value later when you cleanup resources, and configuration settings for the cluster.

    ```bash
    echo $AKS_CLUSTER_NAME
    ```

1. Create a new resource group with the name **akscostsavinggrp**. Deploy all resources created in these exercises in this resource group. A single resource group makes it easier to clean up the resources after you finish the module.

    ```azurecli
    az group create \
        --name $RESOURCE_GROUP \
        --location $REGION_NAME
    ```

## Create the AKS cluster

With the resource group in place, you can now create the AKS cluster. Your first step is to get the version of the latest, non-preview, Kubernetes version in your selected region. You'll use the version in configuring the cluster.

1. To get the latest, non-preview, Kubernetes version, you use the `az aks get-versions` command. Store the value that returns from the command in a Bash variable named `VERSION`. Run the command below the retrieve and store the version number.

    ```azurecli
    VERSION=$(az aks get-versions \
        --location $REGION_NAME \
        --query 'orchestrators[?!isPreview] | [-1].orchestratorVersion' \
        --output tsv)
    ```

1. Run the following `az aks create` command to create the AKS cluster running the latest Kubernetes version with **two** nodes in the primary node pool. This command can take a few minutes to complete.

    The `az aks create` command has several parameters that allow precise configuration of your Kubernetes cluster.  There are two important parameters in configuring the correct support in your cluster for scaling and multiple node pools.

    | Parameter and value | Description |
    | --- | --- |
    | `--load-balancer-sku standard` | The default load balancer support in AKS is *Basic*.  The *Basic* load balancer isn't supported when using multiple node pools. Set the value to *Standard*. |
    | `--vm-set-type VirtualMachineScaleSets` | Virtual Machine Scale Sets are required to use the scale features in AKS. This parameter enables this support.

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
    Notice the configuration of two nodes in the default node pool using the `--node-count 2` parameter. Recall from earlier that essential system services run across this node pool, and additional nodes allow for cluster operation reliability.

1. Run the `az aks nodepool list` command to list the node pools in your new cluster.

    ```azurecli
    az aks nodepool list --resource-group $RESOURCE_GROUP --cluster-name $AKS_CLUSTER_NAME
    ```

    Here is an example of the output from the command.

    ```output
    [
      {
        "agentPoolType": "VirtualMachineScaleSets",
        "availabilityZones": null,
        "count": 2,
        "enableAutoScaling": null,
        "enableNodePublicIp": false,
        "id": "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourcegroups/akscostsavinggrp/providers/Microsoft.ContainerService/managedClusters/akscostsaving-17835/agentPools/nodepool1",
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

    Notice that the *mode* of the node pool is set to `System`, and the name is automatically assigned.

## Add a node pool

1. Your cluster has a single node pool. Add a second node pool using the `az aks nodepool add` command. Use the following command to create a node pool with three nodes and the name `batchprocpl`. Keep in mind that node pool names must start with a lowercase letter and only contain alphanumeric characters. Node pool names are limited to 12 characters for Linux node pools and six characters for Windows node pools.

    Run the following command:

    ```azurecli
    az aks nodepool add \
        --resource-group $RESOURCE_GROUP \
        --cluster-name $AKS_CLUSTER_NAME \
        --name batchprocpl \
        --node-count 3
    ```

1. Run the `az aks nodepool list` command to list the new node pool in your new cluster.

    ```azurecli
    az aks nodepool list --resource-group $RESOURCE_GROUP --cluster-name $AKS_CLUSTER_NAME
    ```

    Here is an example of the output from the command.

    ```output
    [
      {
        "agentPoolType": "VirtualMachineScaleSets",
        "availabilityZones": null,
        "count": 3,
        "enableAutoScaling": null,
        "enableNodePublicIp": false,
        "id": "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourcegroups/akscostsavinggrp/providers/Microsoft.ContainerService/managedClusters/akscostsaving-17835/agentPools/batchprocpl",
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
        "id": "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourcegroups/akscostsavinggrp/providers/Microsoft.ContainerService/managedClusters/akscostsaving-17835/agentPools/nodepool1",
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

    Notice that the *mode* of the new node pool is set to `User` and the name is `batchprocpl`.

## Scale the node pool node count to zero

You use the `az aks nodepool scale` command to scale nodes in a node pool manually.

1. Run the `az aks nodepool scale` command and use the `--node-count` parameter to set the node count value to 0.

    Here is an example of the command

    ```azurecli
    az aks nodepool scale \
        --resource-group $RESOURCE_GROUP \
        --cluster-name $AKS_CLUSTER_NAME \
        --name batchprocpl \
        --node-count 0
    ```

    Here is an example of the output from the command. 

    ```output
    {
      "agentPoolType": "VirtualMachineScaleSets",
      "availabilityZones": null,
      "count": 0,
      "enableAutoScaling": null,
      "enableNodePublicIp": false,
      "id": "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourcegroups/akscostsavinggrp/providers/Microsoft.ContainerService/managedClusters/akscostsaving-17835/agentPools/batchprocpl",
      "maxCount": null,
      "maxPods": 110,
      "minCount": null,
      "mode": "User",
      "name": "batchprocpl",
      "nodeImageVersion": "AKSUbuntu-1604-2020.06.10",
      "nodeLabels": null,
      "nodeTaints": null,
      "orchestratorVersion": "1.16.9",
      "osDiskSizeGb": 128,
      "osType": "Linux",
      "provisioningState": "Succeeded",
      "proximityPlacementGroupId": null,
      "resourceGroup": "akscostsavinggrp",
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
Notice that the node pool `count` parameter value is `0`, and the `enableAutoScaling` value is set to `null` in the return result. You'll have to manually increase the node count for this node pool when you need to schedule workloads here, as node creation won't happen automatically.

## Configure the Kubernetes context

In the previous command's output result, the node pool count is set to 0. You can confirm the available nodes in the cluster by running the `kubectl get nodes` command.

1. You use *kubectl* to interact with your cluster's API server and have to configure a Kubernetes cluster context to allow *kubectl* to connect. The context contains the cluster's address, a user, and a namespace. Use the `az aks get-credentials` command to configure the Cloud Shell Kubernetes context.

    Retrieve the cluster credentials by running the command below.

    ```azurecli
    az aks get-credentials \
        --resource-group $RESOURCE_GROUP \
        --name $AKS_CLUSTER_NAME
    ```

    Here is an example of the output from the command.

    ```output
    Merged "akscostsaving-17835" as current context in /home/christiaan/.kube/config
    ```

1. Run `kubectl get nodes` to list the nodes in your node pools.

    Here is an example of the command output:

    ```output
    NAME                                STATUS   ROLES   AGE   VERSION
    aks-nodepool1-37990379-vmss000000   Ready    agent   32m   v1.16.9
    aks-nodepool1-37990379-vmss000001   Ready    agent   32m   v1.16.9
    ```

    Notice that even though the `az aks nodepool list` command lists two node pools, there are only two nodes available in the cluster, and both are from `nodepool1`.

    Manually scaling the node count in node pools and the ability to scale expensive MV-based node pools to zero is a good strategy to optimize costs on AKS when you manage workload demands directly. Let's look at a strategy where you need to scale nodes, but don't control demand directly.

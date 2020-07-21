You created a standard user node pool with cluster autoscaler to manage the creation of nodes in the previous exercise and scaled the node count manually. Here, you'll add a spot node pool with automatic scaling to reduce your cluster's operational costs where usage isn't as predictive, but still varies. You'll also deploy a workload with node affinity enabled so that the pod is scheduled on nodes in the spot node pool.

## Enable preview features on your subscription

1. Sign in to Azure Cloud Shell with your Azure Account. Select the Bash version of Cloud Shell.

    >[!div class="nextstepaction"]
    >[Azure Cloud Shell](https://shell.azure.com/?azure-portal=true)

    >[!CAUTION]
    >
    >This exercise makes use of preview features. Once you enable some preview features in Azure, defaults may be used for all AKS clusters created in the subscription. Test preview features in non-production subscriptions to avoid unforeseen side effects in production deployments.

1. Register the *spotpoolpreview* flag using the `az feature register` command. This command takes two parameters. The namespace identifying the resource provider you're registering the feature to the name of the feature.

    ```azurecli
    az feature register --namespace "Microsoft.ContainerService" --name "spotpoolpreview"
    ```

1. Check that the registration is successful by querying the feature list table using the `az feature list` command. The feature's registration can take several minutes to complete, and you'll have to check the result periodically.

    ```azurecli
    az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/spotpoolpreview')].{Name:name,State:properties.state}"
    ```

1. When the feature registration is complete, run the `az provider register` command with the `--namespace` parameter to update the registration.

    ```azurecli
    az provider register --namespace Microsoft.ContainerService
    ```

## Install the Azure CLI preview extensions

1. To work with this preview, you have to use the `aks-preview` Azure CLI preview extension for AKS. Install version 0.4.0 of the Azure CLI preview extension by running the `az extension add` command:

    ```azurecli
    az extension add --name aks-preview
    ```

    You can check the installed version of the extension if you've already installed the preview version. Run the `az extension show` command to query the extension version.

    ```azurecli
    az extension show --name aks-preview --query [version]
    ```

    You can update the extension by running the `az extension update` command if you've previously installed it and need to update it to a newer version.

    ```azurecli
    az extension update --name aks-preview
    ```

## Create a spot node pool

You want to create a separate node pool that supports the batch processing service. This node pool is a spot node pool that makes use of *Delete* eviction policy and a spot maximum price of -1;

1. Run the same `az aks nodepool add` as in the previous exercise to add a new spot node pool to your cluster. You'll need to change the node pool name and add a few additional parameters to identify this node pool as a spot node pool.

    Use the following values and set the node pool's:

    - Name to `batchprocpl2`
    - Priority to `Spot`
    - Eviction policy to `Delete`
    - Spot maximum price to `-1`

    Run the following command:

    ```azurecli
    az aks nodepool add \
        --resource-group $RESOURCE_GROUP \
        --cluster-name $AKS_CLUSTER_NAME \
        --name batchprocpl2 \
        --enable-cluster-autoscaler \
        --max-count 3 \
        --min-count 1 \
        --priority Spot \
        --eviction-policy Delete \
        --spot-max-price -1 \
        --node-vm-size Standard_DS2_v2 \
        --no-wait
    ```

    Keep in mind that this request may fail because of capacity restrictions in the location that you've selected.

1. Run the `az aks nodepool show` command to show the new batch processing spot node pool's details.

    ```azurecli
    az aks nodepool show \
        --resource-group $RESOURCE_GROUP \
        --cluster-name $AKS_CLUSTER_NAME \
        --name batchprocpl2
    ```

    Here is an example of the output from the command.

    ```output
    {
    "agentPoolType": "VirtualMachineScaleSets",
    "availabilityZones": null,
    "count": 3,
    "enableAutoScaling": true,
    "enableNodePublicIp": false,
    "id": "/subscriptions/b04925ae-8450-4684-9d3c-fbbf71ebc383/resourcegroups/akscostsavinggrp/providers/Microsoft.ContainerService/managedClusters/costsaving-4398/agentPools/batchprocpl2",
    "maxCount": 3,
    "maxPods": 110,
    "minCount": 1,
    "mode": "User",
    "name": "batchprocpl2",
    "nodeImageVersion": "AKSUbuntu-1604-2020.06.10",
    "nodeLabels": {
        "kubernetes.azure.com/scalesetpriority": "spot"
    },
    "nodeTaints": [
        "kubernetes.azure.com/scalesetpriority=spot:NoSchedule"
    ],
    "orchestratorVersion": "1.16.9",
    "osDiskSizeGb": 128,
    "osType": "Linux",
    "provisioningState": "Creating",
    "proximityPlacementGroupId": null,
    "resourceGroup": "akscostsavinggrp",
    "scaleSetEvictionPolicy": "Delete",
    "scaleSetPriority": "Spot",
    "spotMaxPrice": -1.0,
    "tags": null,
    "type": "Microsoft.ContainerService/managedClusters/agentPools",
    "upgradeSettings": {
        "maxSurge": null
    },
    "vmSize": "Standard_DS2_v2",
    "vnetSubnetId": null
    }
    ```

    There are a few values in this result that is distinctly different than what you've seen in previous node pools. Let's review these items.

    1. Notice the `enableAutoScaling` property value is set to `true`.

    1. Both the `maxCount` and `minCount` values are set.

    1. The `scaleSetEvictionPolicy` property is set to `Delete`.

    1. The `scaleSetPriority` property is set to `Spot`

    1. The `spotMaxPrice` property is set to `-1`

    1. Notice the `nodeLabels` and `nodeTaints` applied to the node pool. You use these values to schedule workloads on the nodes in this node pool.

## Configure a namespace

1. Use the `kubectl create namespace` command to create a namespace for the application called **cost savings**. You'll use this namespace to make it easier to select your workloads.

    ```bash
    kubectl create namespace costsavings
    ```

    You'll see a confirmation that the namespace was created.

    ```output
    namespace/costsavings created
    ```


## Schedule a pod with spot pool node affinity

You can schedule a pod to run on a spot node by adding toleration to the pod's deployment manifest file. When the toleration corresponds with the taint applied to your spot nodes, then pod will be scheduled on these nodes.

The nodes in a spot node pool are assigned a taint that equals `kubernetes.azure.com/scalesetpriority=spot:NoSchedule`. You use the information in this key value pair in the `tolerations` section of your workloads YAML manifest file. With the second batch processing pool configured as a spot node pool, you can now create a deployment file to schedule workloads to run on it.

1. Create a manifest file for the Kubernetes deployment called `spot-node-deployment.yaml` by using the integrated editor.

    ```bash
    code spot-node-deployment.yaml
    ```

    > [!TIP]
    > Azure Cloud Shell includes an [integrated file editor](https://docs.microsoft.com/azure/cloud-shell/using-cloud-shell-editor). The Cloud Shell editor supports features such as language highlighting, the command palette, and a file explorer. For simple file creation and editing, launch the editor by running `code .` in the Cloud Shell terminal. This action opens the editor with your active working directory set in the terminal. To directly open a file for quick editing, run `code spot-node-deployment.yaml` to open the editor without the file explorer.

1. Paste the following text in the file.

    ```yaml
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

1. To save the file, select <kbd>Ctrl+S</kbd>. To close the editor, select <kbd>Ctrl+Q</kbd>.

1. Apply the configuration by using the `kubectl apply` command and deploy the application in the `costsavings` namespace.

    ```bash
    kubectl apply \
    --namespace costsavings \
    -f spot-node-deployment.yaml
    ```

    You'll see output like this example.

    ```output
    pod/nginx created
    ```

1. You can fetch more information on the running pod using the `-o wide` flag with the `kubectl get pods` command. In this case you want to see on which node the pod is scheduled. Make sure to query for pods in the `costsavings` namespace.

    ```bash
    kubectl get pods --namespace costsavings -o wide
    ```

    You'll see output like this example.

    ```output
    NAME    READY   STATUS    RESTARTS   AGE   IP           NODE                                   NOMINATED NODE   READINESS GATES
    nginx   1/1     Running   0          43s   10.244.3.3   aks-batchprocpl2-25254417-vmss000000   <none>           <none>
    ```

    Notice the name of the node, `aks-batchprocpl2-25254417-vmss000000`. This node is part of the `batchprocpl2` spot node pool you created earlier.

Spot user node pools allow you to access unused Azure compute capacity at lower prices with support for high-performance computing scenarios.

In the previous exercise, you created a standard user node pool, used the cluster autoscaler to manage node creation, and scaled the node count manually.

The next step is for you to add a spot user node pool with automatic scaling to reduce your cluster's operational costs. Cluster usage varies based on resources needed and isn't predictable, so you set up rules to capture the spikes and dips. The workload is deployed with node affinity enabled so that the pod is scheduled on nodes in the spot node pool.

## Create a spot node pool

You need to create a separate node pool that supports the batch-processing service. This node pool is a spot node pool that uses the Delete eviction policy and a spot maximum price of -1.

1. Run the same `az aks nodepool add` command as in the previous exercise to add a new spot node pool to your cluster. You need to change the node pool name and add a few more parameters to identify this node pool as a spot node pool.

    Enter the following values to set the node pool's parameters:

    - Name: `batchprocpl2`
    - Priority: `Spot`
    - Eviction policy: `Delete`
    - Spot maximum price: `-1`

    Run the following command to create the spot node pool:

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

    Keep in mind that this request might fail because of capacity restrictions in the location that you've selected.

1. Run the `az aks nodepool show` command to show the details of the new spot node pool for the batch-processing service:

    ```azurecli
    az aks nodepool show \
        --resource-group $RESOURCE_GROUP \
        --cluster-name $AKS_CLUSTER_NAME \
        --name batchprocpl2
    ```

    Here's an example of the output from the command.

    ```output
    {
    "agentPoolType": "VirtualMachineScaleSets",
    "availabilityZones": null,
    "count": 3,
    "enableAutoScaling": true,
    "enableNodePublicIp": false,
    "id": "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourcegroups/rg-akscostsaving/providers/Microsoft.ContainerService/managedClusters/akscostsaving-17835/agentPools/batchprocpl2",
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
    "orchestratorVersion": "1.17.9",
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

    A few values in this result are distinctly different from what you've seen in previous node pools. Let's review these items:

    - The `enableAutoScaling` property value is set to `true`.

    - Both the `maxCount` and `minCount` values are set.

    - The `scaleSetEvictionPolicy` property is set to `Delete`.

    - The `scaleSetPriority` property is set to `Spot`.

    - The `spotMaxPrice` property is set to `-1`.

    - The `nodeLabels` and `nodeTaints` are applied to this node pool. You use these values to schedule workloads on the nodes in the node pool.

## Configure a namespace

1. Run the `kubectl create namespace` command to create a namespace called `costsavings` for the application. You'll use this namespace to make it easier to select your workloads.

    ```bash
    kubectl create namespace costsavings
    ```

    Here's the output from the preceding command:

    ```output
    namespace/costsavings created
    ```

## Schedule a pod with spot node affinity

You can schedule a pod to run on a spot node by adding a toleration and an affinity to the pod's deployment manifest file. When the toleration and node affinity correspond with the taint and label applied to your spot nodes, the pod is scheduled on these nodes.

The nodes in a spot node pool are assigned a taint that equals `kubernetes.azure.com/scalesetpriority=spot:NoSchedule` and a label that equals `kubernetes.azure.com/scalesetpriority=spot`. Use the information in this key-value pair in the `tolerations` and `affinity` section of your workloads YAML manifest file. With the second batch-processing pool configured as a spot node pool, you can now create a deployment file to schedule workloads to run on it.

1. Create a manifest file for the Kubernetes deployment called `spot-node-deployment.yaml` by using the integrated editor:

    ```bash
    code spot-node-deployment.yaml
    ```

    > [!TIP]
    > Cloud Shell includes an [integrated file editor](/azure/cloud-shell/using-cloud-shell-editor). The Cloud Shell editor supports features such as language highlighting, the command palette, and a file explorer. For simple file creation and editing, start the editor by running `code .` in the Cloud Shell terminal. This action opens the editor with your active working directory set in the terminal. To open your manifest file directly for quick editing, run `code spot-node-deployment.yaml`. This command opens the editor without the file explorer.

1. Paste the following text into the file:

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
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: "kubernetes.azure.com/scalesetpriority"
                operator: In
                values:
                - "spot"
    ```

1. Press <kbd>Ctrl+S</kbd> to save the file, then press <kbd>Ctrl+Q</kbd> to close the editor.

1. Run the `kubectl apply` command to apply the configuration and deploy the application in the `costsavings` namespace:

    ```bash
    kubectl apply \
    --namespace costsavings \
    -f spot-node-deployment.yaml
    ```

      Here's the output from the preceding command:

    ```output
    pod/nginx created
    ```

1. You can fetch more information about the running pod by using the `-o wide` flag when running `kubectl get pods` command. In this case, you want to see which node the pod is scheduled on. Make sure to query for pods in the `costsavings` namespace.

    ```bash
    kubectl get pods --namespace costsavings -o wide
    ```

    The output should resemble the following:

    ```output
    NAME    READY   STATUS    RESTARTS   AGE   IP           NODE                                   NOMINATED NODE   READINESS GATES
    nginx   1/1     Running   0          43s   10.244.3.3   aks-batchprocpl2-25254417-vmss000000   <none>           <none>
    ```

    Notice the name of the node, `aks-batchprocpl2-25254417-vmss000000`. This node is part of the `batchprocpl2` spot node pool that you created earlier.

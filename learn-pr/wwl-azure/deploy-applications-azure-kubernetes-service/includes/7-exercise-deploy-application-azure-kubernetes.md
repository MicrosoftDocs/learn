In this exercise, you walk through the process of creating and updating a Deployment in an Azure Kubernetes Service (AKS) cluster. You use the cluster you provisioned in the first exercise of this module.

> [!NOTE]
> To complete this exercise, you need an [Azure Subscription](https://azure.microsoft.com/pricing/purchase-options/azure-account?cid=msft_learn).<br>

### Prepare for creating a Deployment in an Azure Kubernetes Service cluster

In this task, you prepare to create a Deployment in an AKS cluster by creating a namespace using Azure Cloud Shell.

1.  From the Azure portal, open a Bash session in the Azure Cloud Shell. To make sure that the AKS cluster name and credentials are available in the current session (Cloud Shell variables don't persist between sessions), run the following commands:

    ```azurecli
    AKSRG='aks-01-RG'
    AKSNAME='aks-01'
    az aks get-credentials --resource-group $AKSRG --name $AKSNAME --overwrite-existing
    ```

2.  To create a namespace and list the existing namespaces, run the following commands:

    ```bash
    kubectl create namespace demo-deployment
    kubectl get namespaces
    ```

3.  Run the following commands to review the node pool name and scale the node pool to two nodes. Because the cluster currently has one node, this scales the node pool by adding one node. The `--node-count` value is the absolute target node count, not an increment.

    ```azurecli
    az aks show --resource-group $AKSRG --name $AKSNAME --query "agentPoolProfiles[].{Name:name,Count:count}" -o table
    NODEPOOL=$(az aks show --resource-group $AKSRG --name $AKSNAME --query "agentPoolProfiles[0].name" -o tsv)
    az aks scale --resource-group $AKSRG --name $AKSNAME --node-count 2 --nodepool-name $NODEPOOL
    ```

4.  To wait until the extra node is fully provisioned and confirm both nodes appear as **Ready**, run the following commands:

    ```bash
    kubectl wait --for=condition=Ready nodes --all --timeout=300s
    kubectl get nodes
    ```

### Create a Deployment

In this task, you create a Deployment in the target AKS cluster.

1.  In the Azure portal, in the Bash session of Azure Cloud Shell, use the built-in editor to create a file named *nginx-deployment.yaml* and copy into it the following YAML manifest:

    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: nginx-deployment
    spec:
      replicas: 3
      selector:
        matchLabels:
          app: nginx
      template:
        metadata:
          labels:
            app: nginx
        spec:
          containers:
          - name: nginx
            image: mcr.microsoft.com/azurelinux/base/nginx:1.25
            ports:
            - containerPort: 80
            resources:
              requests:
                cpu: 250m
                memory: 64Mi
              limits:
                cpu: 500m
                memory: 256Mi
    ```

2.  Save the changes to the file and close it to return to the Bash prompt.
3.  To create the Deployment, from the Bash session in the Azure Cloud Shell, run the following command:

    ```bash
    kubectl apply -f nginx-deployment.yaml --namespace demo-deployment
    ```

4.  To validate the Deployment rollout and enumerate Deployments, pods, and ReplicaSets, run the following commands:

    ```bash
    kubectl rollout status deployment/nginx-deployment --namespace demo-deployment
    kubectl get deployments --namespace demo-deployment
    kubectl get pods --namespace demo-deployment
    kubectl get rs --namespace demo-deployment
    ```

### Update the Deployment

In this task, you update the Deployment by replacing the image used by its pods.

1.  To replace the image used by the Deployment, from the Bash session in the Azure Cloud Shell, run the following command:

    ```bash
    kubectl set image deployment/nginx-deployment nginx=mcr.microsoft.com/azurelinux/base/nginx:1.28 --namespace demo-deployment
    ```

2.  To validate the Deployment rollout and enumerate Deployments, pods, and ReplicaSets, run the following commands:

    ```bash
    kubectl rollout status deployment/nginx-deployment --namespace demo-deployment
    kubectl get deployments --namespace demo-deployment
    kubectl get pods --namespace demo-deployment
    kubectl get rs --namespace demo-deployment
    ```

### Delete the resources provisioned in the module

In this task, you delete the resource group that contains the AKS cluster and related resources.

1.  Since this is the last exercise in the module, from the Bash session in the Azure Cloud Shell, run the following commands. The `AKSRG` variable is reset in case it isn't defined in the current Cloud Shell session:

    ```azurecli
    AKSRG='aks-01-RG'
    az group delete --name $AKSRG --yes --no-wait
    ```

In this exercise, you walk through the process of creating and updating a deployment in an Azure Kubernetes Service cluster. You use the cluster you provisioned in the first exercise of this module.

> [!NOTE]
> To complete this exercise, you need an [Azure Subscription](https://azure.microsoft.com/free/).<br>

### Prepare for creating a deployment to an Azure Kubernetes Service cluster

In this task, you prepare for a deployment to an AKS cluster by creating a namespace using Azure Cloud Shell.

1.  From the Azure portal, open a Bash session in the Azure Cloud Shell and run the following commands.
    
    ```azurecli
    kubectl create namespace demo-deployment
    kubectl get namespaces
    ```

2.  Run the following command to add a node to the AKS cluster.
    
    ```azurecli
    az aks show --resource-group $AKSRG --name $AKSNAME --query agentPoolProfiles
    az aks scale --resource-group $AKSRG --name $AKSNAME --node-count 2 --nodepool-name nodepool1
    ```
    
    > [!NOTE]
    > Wait until the extra node is fully provisioned before you proceed to the next task.<br>

### Create a deployment

In this task, you create a deployment in the target AKS cluster.

1.  In the Azure portal, in the Bash session of Azure Cloud Shell, use the built-in editor to create a file named *nginx-deployment.yaml* and copy to the following YAML manifest:
    
    ```azurecli
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
            image: mcr.microsoft.com/oss/nginx/nginx:1.15.2-alpine
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
3.  To create the deployment, from the Bash session in the Azure Cloud Shell, run the following command:
    
    ```azurecli
    kubectl apply -f nginx-deployment.yaml --namespace demo-deployment
    ```

4.  To validate the deployment, enumerate deployments, pods, and replica sets by running the following commands:
    
    ```azurecli
    kubectl get deployments --namespace demo-deployment
    kubectl get pods --namespace demo-deployment
    kubectl get rs --namespace demo-deployment
    ```

### Update the deployment

In this task, you update the deployment by replacing the image used by its pods.

1.  To replace the image used by our deployment, from the Bash session in the Azure Cloud Shell, run the following command:
    
    ```azurecli
    kubectl set image deployment/nginx-deployment nginx=nginx:1.16.1 --namespace demo-deployment
    ```

2.  To validate the deployment, enumerate deployments, pods, and replica sets by running the following commands:
    
    ```azurecli
    kubectl get deployments --namespace demo-deployment
    kubectl get pods --namespace demo-deployment
    kubectl get rs --namespace demo-deployment
    ```

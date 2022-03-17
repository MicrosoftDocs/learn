This walkthrough shows how to deploy an AKS cluster using the Azure CLI.

A multi-container application that includes a web front end and a Redis Cache instance is run in the cluster.

You then see how to monitor the health of the cluster and pods that run your application.

## Prerequisites

 -  Use the Cloud Shell.
 -  You require an Azure subscription to do these steps. If you don't have one, you can create it by following the steps outlined on the [Create your Azure free account today](https://azure.microsoft.com/free) page.

## Steps

1.  Open Azure Cloud Shell by going to https://shell.azure.com or using the Azure portal and selecting **Bash** as the environment option.
    
    :::image type="content" source="../media/walkthrough-java-appservice-163e413e.png" alt-text="Open Cloud Shell icon in Bash Environment selected, and highlighted.":::
    

2.  Create an Azure resource group by running the following command:
    
    ```CLI
    az group create --name myResourceGroup --location < datacenter nearest you >
    
    ```

3.  Create an AKS cluster by running the following command:
    
    ```Bash
    az aks create \
        --resource-group myResourceGroup \
        --name myAKSCluster \
        --node-count 1 \
        --enable-addons monitoring \
        --generate-ssh-keys
    
    ```
    
    After a few minutes, the command completes and returns JSON-formatted information about the cluster.

4.  To manage a Kubernetes cluster, you use `kubectl`, the Kubernetes command-line client. If you use Azure Cloud Shell, `kubectl` is already installed. To install `kubectl` locally, use the following command:
    
    ```Bash
    az aks install-cli
    
    ```

5.  To configure `kubectl` to connect to your Kubernetes cluster, use the `az aks get-credentials` command. This command downloads credentials and configures the Kubernetes CLI to use them:
    
    ```Bash
    az aks get-credentials --resource-group myResourceGroup --name myAKSCluster
    
    ```

6.  Verify the connection to your cluster by running the following command. Make sure that the status of the node is Ready:
    
    ```Bash
    kubectl get nodes
    
    ```

7.  Create a file named **azure-vote.yaml**, and then copy it into the following `YAML` definition. If you use the Azure Cloud Shell, you can create this file-using **vi** or **nano** as if working on a virtual or physical system:

    ```YAML
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: azure-vote-back
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: azure-vote-back
      template:
        metadata:
          labels:
            app: azure-vote-back
        spec:
          nodeSelector:
            "beta.kubernetes.io/os": linux
          containers:
          - name: azure-vote-back
            image: mcr.microsoft.com/oss/bitnami/redis:6.0.8
            env:
            - name: ALLOW_EMPTY_PASSWORD
              value: "yes"
            ports:
            - containerPort: 6379
              name: redis
    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: azure-vote-back
    spec:
      ports:
      - port: 6379
      selector:
        app: azure-vote-back
    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: azure-vote-front
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: azure-vote-front
      strategy:
        rollingUpdate:
          maxSurge: 1
          maxUnavailable: 1
      minReadySeconds: 5 
      template:
        metadata:
          labels:
            app: azure-vote-front
        spec:
          nodeSelector:
            "beta.kubernetes.io/os": linux
          containers:
          - name: azure-vote-front
            image: mcr.microsoft.com/azuredocs/azure-vote-front:v1
            ports:
            - containerPort: 80
            resources:
              requests:
                cpu: 250m
              limits:
                cpu: 500m
            env:
            - name: REDIS
              value: "azure-vote-back"
    ---
    apiVersion: v1
    kind: Service
    metadata:
      name: azure-vote-front
    spec:
      type: LoadBalancer
      ports:
      - port: 80
      selector:
        app: azure-vote-front
    ```

8.  Deploy the application by running the following command:
    
    ```Bash
    kubectl apply -f azure-vote.yaml
    
    ```
    
    You should receive output showing that the Deployments and Services were created successfully after it runs.
    
    ```Bash
    deployment "azure-vote-back" created
    service "azure-vote-back" created
    deployment "azure-vote-front" created
    service "azure-vote-front" created
    
    ```

9.  When the application runs, a Kubernetes service exposes the application front end to the internet. This process can take a few minutes to complete. To monitor progress, run the command.
    
    ```Bash
    kubectl get service azure-vote-front --watch
    
    ```

10. Initially, the **EXTERNAL-IP** for the azure-vote-front service is shown as pending.
    
    ```Bash
    NAME              TYPE          CLUSTER-IP  EXTERNAL-IP  PORT(S)        AGE
    azure-vote-front  LoadBalancer  10.0.37.27  < pending >    80:30572/TCP  6s
    
    ```

11. When the **EXTERNAL-IP** address changes from pending to an actual public IP address, use **CTRL-C** to stop the `kubectl` watch process. The following example output shows a valid public IP address assigned to the service:
    
    ```Bash
    azure-vote-front  LoadBalancer  10.0.37.27  52.179.23.131  80:30572/TCP  2m
    
    ```

12. To see the Azure Vote app in action, open a web browser to the external IP address of your service.
    
    :::image type="content" source="../media/walkthrough-deploy-aks-a73b975f.png" alt-text="A web browser displaying the Azure Voting app.":::
    

Monitor health and logs. When the AKS cluster was created, Azure Monitor for containers captured health metrics for both the cluster nodes and pods.

These health metrics are available in the Azure portal.

To see current status, uptime, and resource usage for the Azure Vote pods, complete the following steps in the Azure portal:

1.  Open a web browser to the Azure portal [https://portal.azure.com](https://portal.azure.com/).
2.  Select your resource group, such as myResourceGroup, then select your AKS cluster, such as myAKSCluster.
3.  Under Monitoring on the left-hand side, choose Insights.
4.  Across the top, choose to + Add Filter.
5.  Select Namespace as the property, then choose &lt; All but kube-system &gt;
6.  Choose to view the Containers. The azure-vote-back and azure-vote-front containers are displayed.
7.  To see logs for the azure-vote-front pod, select the View container logs to link on the right-hand side of the containers list. These logs include the stdout and stderr streams from the container.

> [!NOTE]
> If you continue using the Azure resources, remember to delete them to avoid incurring costs.

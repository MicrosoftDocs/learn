In this exercise, you create an Azure Kubernetes Service (AKS) cluster and deploy an image to the Azure Container Registry (ACR). Afterwards, you can access your app through an external IP address.

## Create an Azure Container Registry (ACR)

In this task, you create an Azure Container Registry. An Azure Container Registry (ACR) is a secure, managed registry that stores container images, making it easy to deploy those images to Azure services like AKS.

1. Open the Visual Studio Code project from the previous exercise

1. In the terminal, log in to Azure using `az login`

    Follow the prompts to authenticate.

1. In the terminal, create the ACR with the following command:

    ```
    az acr create --resource-group myResourceGroup --name myACRName --sku Basic
    ```

    Be sure to replace `myResourceGroup` and `myACRName` with the desired names of your resources. You can use an existing resource group, or create a new one using the command:

    ```
    az group create --name myResourceGroup --location eastus
    ```

1. Log in to your ACR resource with the following command:

    ```
    az acr login --name myACRName
    ```

    Be sure to replace `myACRName` with the name of your registry. Next, you need to tag your local Docker image with your ACR login server address.

## Create an AKS cluster

Before you can create an AKS cluster, you must make sure the Microsoft.Compute resource provider is registered for your subscription. Afterwards, you can create your cluster and deploy your image.

1. Navigate to **portal.azure.com** and select your subscription

1. In the left hand menu, select **Resource providers** under **Settings**

1. In the name filter, enter "Microsoft.Compute"

1. If the status is "NotRegistered", select the provider and select **Register**

    Now you're ready to create your AKS cluster

1. Open the Visual Studio Code project you worked on in the previous exercise.

1. In the terminal, install the Kubernetes CLI with the following command:

    ```bash
    az aks install-cli
    ```

    You use the Kubernetes CLI, `kubectl`, to create and connect to your Kubernetes cluster.

1. Create your AKS cluster by entering the following command in the terminal:

    ```
    az aks create \
        --resource-group myResourceGroup \
        --name myAKSClusterName \
        --node-count 2 \
        --generate-ssh-keys \
        --attach-acr myACRName 
    ```

    Be sure to replace the values of the resource group, cluster name, and Azure Resource Container (ACR). Use the name of the ACR that you created in the previous steps.

    > [!NOTE]
    > If you run into issues creating resources in a particular region, you can change the region by using the `location` parameter. For example, `--location westus3`

    If you run into issues with the available Virtual Machine (VM) sizes, you can specify the VM size using the `node-vm-size` parameter. For example, `--node-vm-size standard_d15_v2`

## Deploy an image to the cluster

1. Once the cluster is created, connect to the cluster using the following command:
   
    ```
    az aks get-credentials --resource-group myResourceGroup --name myAKSClusterName
    ```

    This command retrieves the cluster credentials and configures kubectl to communicate with your AKS cluster. You should see some output similar to `Merged "vector-search-aks" as current context in C:\Users\user\.kube\config`

1. Verify your cluster's connectivity and status using the following command:

    ```
    kubectl get nodes
    ```

    You should see some details similar to the following output:
    ```
    NAME                                STATUS   ROLES    AGE   VERSION
    aks-nodepool1-30047545-vmss000000   Ready    <none>   32m   v1.29.9
    aks-nodepool1-30047545-vmss000001   Ready    <none>   32m   v1.29.9
    ```

1. Create an image of your app with the following command:
   
    `az acr build --image vector-search-app:1.0.0 --registry vectorsearchcontainer --file Dockerfile .`

    This command builds a Docker image named `vector-search-app` with the tag `1.0.0` from the specified Dockerfile in the current directory and then pushes the image to the ACR.

1. Create a file `deployment.yaml` with the following content:

    ```
    apiVersion: apps/v1
    kind: Deployment
    metadata:
    name: vector-search-app
    spec:
    replicas: 2
    selector:
        matchLabels:
        app: vector-search-app
    template:
        metadata:
        labels:
            app: vector-search-app
        spec:
        containers:
            - name: vector-search-app
            image: vectorsearchcontainer.azurecr.io/vector-search-app:1.0.0
            ports:
                - containerPort: 3000

    ---
    apiVersion: v1
    kind: Service
    metadata:
    name: vector-search-app
    spec:
    type: LoadBalancer
    selector:
        app: vector-search-app
    ports:
        - protocol: TCP
        port: 80
        targetPort: 3000
    ```

    `Deployment.yaml` is a configuration file used in Kubernetes to define and manage an application’s deployment. It specifies details like the number of application instances (replicas), container image, and environment settings. This file helps Kubernetes automate the creation, scaling, and management of containerized applications.

1. Apply the yaml file using `kubectl apply -f deployment.yaml`

    This command creates a deployment resource in the cluster.

1. Verify the image is running with the command `kubectl get pods`

    You should see some output similar to:

    ```
    NAME                                READY    STATUS              RESTARTS   AGE
    vector-search-app-5d5f446499-vlmtx   1/1     Running             0          6s
    ```

1. To get the external IP of your app, enter `kubectl get svc vector-search-app`

    You should see some output similar to:

    ```
    NAME                TYPE           CLUSTER-IP     EXTERNAL-IP    PORT(S)        AGE
    vector-search-app   LoadBalancer   10.0.0.0       11.0.0.0       80:30235/TCP   29s
    ```

1. In a browser, enter the external IP address and you should see the Contoso Bike Shop webpage with the Virtual Assistant chatbox.

Great work! You created an AKS cluster, deployed your Docker image to it, exposed the application through a LoadBalancer service, and accessed the application using the external IP address. You successfully deployed a containerized application to Azure Kubernetes Service!
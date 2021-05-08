In this exercise, you will set up an Azure Kubernetes Service (AKS) cluster, which is an approved Kubernetes distribution for App Service on Azure Arc. The exercise consists of the following tasks:

1. Deploy an AKS cluster
1. Connect to the AKS cluster

> [!NOTE]
> App Service on Azure Arc doesn't support Windows node pools in AKS clusters.

> [!NOTE]
> The choice of AKS as the hosting platform for this module is not meant to represent the intended primary use case of App Service on Azure Arc. App Service on Azure Arc is designed to run on any compliant Arc-enabled Kubernetes cluster.

This is the second exercise in the sequence of exercises of this module that takes you through the process of implementing Azure App Service web apps on Kubernetes with Azure Arc. The sequence consists of the following exercises:

1. Prepare the lab environment
1. Set up a Kubernetes cluster
1. Connect the Kubernetes cluster to Azure Arc
1. Implement App Service on the Azure Arc enabled Kubernetes cluster
1. Deploy an App Service web app to the Azure Arc enabled Kubernetes cluster
1. Clean up the lab environment

:::image type="content" source="../media/u3-exercise2.png" alt-text="The image depicts the sequence of exercises with the default view of the second of them." border="false":::


## Task 1: Deploy an AKS cluster

In order to support the App Service on Azure Arc, an AKS cluster must satisfy the following requirements:

- Run Kubernetes version 1.18.14 or newer
- Feature a load balancer as its front-end service
- Be Azure Active Directory (Azure AD) enabled
- Constitute an approved App Service on Azure Arc distribution 

Use the following steps to deploy an AKS cluster that supports App Service on Azure Arc:

1. Within the web browser window displaying the Bash session in the Azure Cloud Shell pane, run the following commands to set values of the variables that will be used to assign names to, respectively, the resource group that will contain the AKS cluster, the AKS cluster, its public IP address, and its Azure region:

    ```azurecli-interactive
    K8S_CLUSTER_RG_NAME=k8sAKS-RG
    K8S_CLUSTER_NAME=k8sAKS-cluster
    K8S_PIP_NAME=k8sAKS-cluster-pip
    LOCATION=eastus
    ```

    > [!IMPORTANT]
    > During the preview, the only supported Azure region is **East US**.

1. Run the following commands to create the resource group that will contain the AKS cluster and then provision the AKS cluster:

    ```azurecli-interactive
    az group create -l $LOCATION -n $K8S_CLUSTER_RG_NAME
    az aks create -g $K8S_CLUSTER_RG_NAME -n $K8S_CLUSTER_NAME --enable-aad --generate-ssh-keys --node-count 1
    ```

    > [!NOTE]
    > Wait for the cluster provisioning to complete. This should take about 5 minutes.

    > [!NOTE]
    > The cluster contains a single worker node. While this is not recommended for production environments, it is sufficient for the evaluation purposes.

1. Run the following commands to identify the resource group hosting the cluster infrastructure resources and create a public IP address resource in that group:

    ```azurecli-interactive
    K8S_INFRA_RG_NAME=$(az aks show -g $K8S_CLUSTER_RG_NAME -n $K8S_CLUSTER_NAME --query nodeResourceGroup -o tsv)
    az network public-ip create -g $K8S_INFRA_RG_NAME -n $K8S_PIP_NAME --sku STANDARD
    ```

    > [!IMPORTANT]
    > You **must** create the public IP address resource in the cluster's infrastructure resource group in order for it to bind to the cluster's load balancer.


## Task 2: Connect to the AKS cluster

Since the AKS cluster you deployed is Azure AD-enabled, you have the option of using a device code-based login to authenticate. However, for the sake of simplicity, you will retrieve the admin credentials from the cluster by relying on having the Azure Kubernetes Service Cluster Admin built-in role:

> [!NOTE]
> For more information regarding AKS integration with Azure AD, refer to [AKS-managed Azure Active Directory integration](https://docs.microsoft.com/azure/aks/managed-aad).

1. Run the following command to retrieve the admin credentials from the cluster and merge them into your local kubeconfig file:

    ```azurecli-interactive
    az aks get-credentials -g $K8S_CLUSTER_RG_NAME -n $K8S_CLUSTER_NAME --admin
    ```

1. Run the following command to determine whether you have successfully connected to the cluster:

    ```azurecli-interactive
    kubectl get ns
    ```

1. Examine the output and verify that it lists the namespaces on the target AKS cluster.

Congratulations! You completed the second exercise of this module. In its exercise, you deployed an AKS cluster and connected to it.
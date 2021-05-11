In this exercise, you will connect the AKS cluster you deployed in the previous exercise to Azure Arc and prepare it for implementing the Azure App Service extension in the next exercise of this module. The exercise consists of the following tasks:

1. Prepare for connecting the AKS cluster to Azure Arc
1. Connect the AKS cluster to Azure Arc

In order to provide support for the Azure App Service workloads, you must enroll the Kubernetes cluster onto Azure Arc. This allows you to install and manage Azure App Service extensions, just like any other Azure Arc extension. 

> [!NOTE]
> While this is a general requirement applicable to Kubernetes clusters, its applicability to AKS clusters is subject to change in the future releases of the Azure App Service extension.

This is the third exercise in the sequence of exercises of this module that takes you through the process of implementing Azure App Service web apps on Kubernetes with Azure Arc. The sequence consists of the following exercises:

1. Prepare the lab environment
1. Set up a Kubernetes cluster
1. Connect the Kubernetes cluster to Azure Arc
1. Implement App Service on the Azure Arc enabled Kubernetes cluster
1. Deploy an App Service web app to the Azure Arc enabled Kubernetes cluster
1. Clean up the lab environment

:::image type="content" source="../media/u4-exercise3.png" alt-text="The image depicts the sequence of exercises with the default view of the third of them." border="false":::


## Task 1: Prepare for connecting the AKS cluster to Azure Arc

Before you connect the AKS cluster to Azure Arc, take care of the relevant prerequisites, including creating a resource group that will host Azure Arc resources and verifying registration of the relevant resource providers.

Use the following steps to implement these prerequsites:

1. Within the web browser window displaying the Bash session in the Azure Cloud Shell pane, run the following commands to set values of the variables that will be used to assign names to, respectively, the resource group that will contain the Arc resources and the name of the Azure Arc connected cluster resource:

    ```azurecli-interactive
    K8S_ARC_PREFIX=k8sArc
    ARC_RG_NAME="${K8S_ARC_PREFIX}-RG"
    ARC_CLUSTER_NAME="${K8S_ARC_PREFIX}-cluster" 
    ```

1. Run the following command to create the resource group that will house the Azure Arc connected cluster resources:

    ```azurecli-interactive
    az group create -n $ARC_RG_NAME -l "East US"
    ```

    > [!IMPORTANT]
    > During the preview, the only supported Azure region is **East US**.

1. Run the following command to verify the registration of the resource providers necessary to implement a connected cluster resource in the region hosting the resource group:

    ```azurecli-interactive
    az provider show -n Microsoft.Kubernetes --query "[registrationState,resourceTypes[?resourceType=='connectedClusters'].locations]"
    ```

## Task 2: Connect the AKS cluster to Azure Arc

Now you are ready to connect your AKS cluster to Azure Arc. The connected cluster resource represents an Azure-hosted projection of the your Kubernetes infrastructure.

Use the following steps to connect the AKS cluster to Azure Arc.

1. Within the web browser window displaying the Bash session in the Azure Cloud Shell pane, run the following commands to ensure that the kubectl context within the Azure CLI session is set to the target AKS cluster:

    ```azurecli-interactive
    K8S_CLUSTER_RG_NAME=k8sAKS-RG
    K8S_CLUSTER_NAME=k8sAKS-cluster
    kubectl config use-context $K8S_CLUSTER_NAME
    ```

1. Run the following command to connect the cluster to Azure Arc:

    ```azurecli-interactive
    az connectedk8s connect -g $ARC_RG_NAME -n $ARC_CLUSTER_NAME
    ```

    > [!NOTE]
    > Wait for the command to complete. This should take about 2 minutes.

    > [!NOTE]
    > Review the output of the command and verify that the value of the **provisioningState** property is **Succeeded**.


1. Run the following command to list the Azure Arc pods created on your cluster:

    ```azurecli-interactive
    kubectl get pods -n azure-arc
    ```

1. To validate the deployment, in the web browser displaying the Azure Cloud Shell, open another tab, navigate to [the Azure portal](https://portal.azure.com), use the **Search resources, services, and docs** text box to search for the Azure Arc resource representing your AKS cluster, and navigate to its **Overview** blade. 

:::image type="content" source="../media/u4-arc-cluster-overview.png" alt-text="The screenshot depicts the Overview blade of the Kubernetes - Azure Arc cluster." border="false":::

Congratulations! You completed the third exercise of this module. In its exercise, you connected the AKS cluster you deployed in the previous exercise to Azure Arc, preparing it for installation of the App Service extension in the next exercise.
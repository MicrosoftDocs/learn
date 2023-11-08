In this exercise, you'll set up an Azure Kubernetes Service (AKS) cluster. An AKS cluster is an approved Kubernetes distribution for Azure App Service on Kubernetes with Azure Arc. However, this capability is not limited to AKS cluster only. This can be any CNCF certified, Arc tested Kubernetes cluster deployed in any public cloud provider, on-premises or at the edge. This unit's exercise consists of the following tasks: 

1. Deploy an AKS cluster.
1. Connect to the AKS cluster.

> [!NOTE]
> Azure App Service on Kubernetes with Azure Arc doesn't support Windows node pools in AKS clusters.

> [!NOTE]
> Choosing AKS as this module's hosting platform doesn't represent the intended primary use case of Azure App Service on Kubernetes with Azure Arc. Azure App Service on Kubernetes with Azure Arc is designed to run on any compliant Azure Arc enabled Kubernetes cluster.

This is the second in this module's sequence of exercises. These exercises guide you through implementing Azure App Service web apps on Kubernetes with Azure Arc. The sequence consists of the following exercises:

1. Prepare the lab environment.
1. Set up a Kubernetes cluster.
1. Connect the Kubernetes cluster to Azure Arc.
1. Implement App Service on the Azure Arc enabled Kubernetes cluster.
1. Deploy an App Service web app to the Azure Arc enabled Kubernetes cluster.
1. Clean up the lab environment.

:::image type="content" source="../media/3-exercise-2.png" alt-text="Depiction of this module's exercise sequence with additional sub-steps illustrated for the second exercise (Set up a Kubernetes cluster)." border="false":::

## Task 1: Deploy an AKS cluster

To support the Azure App Service on Kubernetes with Azure Arc, deploy a supported AKS cluster with the following requirements:

- Run a supported Kubernetes version 1.20.x or newer.
- Kubectl version 1.20.x or newer.
- Feature a load balancer as its front-end service.
- Have Microsoft Entra ID enabled.
- Constitute an approved Azure App Service on Kubernetes with Azure Arc distribution.

Use the following steps to deploy an AKS cluster that supports Azure App Service on Kubernetes with Azure Arc:

1. In the browser window that displays the Bash session in the **Azure Cloud Shell** pane, run the following commands. These commands set values for variables that assign names to the resource group that contains the AKS cluster, the AKS cluster, and its Azure region (replace the `<azure_region>` placeholder with the name of any AKS-supported region):

    ```azurecli-interactive
    K8S_CLUSTER_RG_NAME=k8sAKS-RG
    K8S_CLUSTER_NAME=k8sAKS-c$RANDOM
    LOCATION=<azure_region>
    ```

1. Run the following commands to create the resource group that will contain the AKS cluster, and then provision the AKS cluster:

    ```azurecli-interactive
    az group create -l $LOCATION -n $K8S_CLUSTER_RG_NAME
    az aks create -g $K8S_CLUSTER_RG_NAME -n $K8S_CLUSTER_NAME -l $LOCATION --enable-aad --generate-ssh-keys
    ```

    > [!NOTE]
    > Wait for the cluster provisioning to complete. This should take about 5 minutes.


## Task 2: Connect to the AKS cluster

The AKS cluster you deployed is Microsoft Entra ID enabled. Therefore, you've got the option to use a device code-based login to authenticate. However, to keep it simple, you'll instead retrieve the cluster's admin credentials by using the Azure Kubernetes Service Cluster Admin built-in role:

> [!NOTE]
> For more information about AKS integration with Microsoft Entra ID, refer to [AKS-managed Microsoft Entra integration](/azure/aks/managed-aad).

1. Run the following command to retrieve the admin credentials from the cluster and merge them into your local kubeconfig file:

    ```azurecli-interactive
    az aks get-credentials -g $K8S_CLUSTER_RG_NAME -n $K8S_CLUSTER_NAME --admin
    ```

1. Run the following command to determine whether you've successfully connected to the cluster:

    ```azurecli-interactive
    kubectl get ns
    ```
    > [!NOTE]
    > The output should include the listing of the default and system namespaces.

1. Examine the output and verify that it lists the namespaces on the target AKS cluster.

Congratulations! You've completed the second exercise of this module. You've deployed an AKS cluster and connected to it.

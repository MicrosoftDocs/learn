In this exercise, you'll connect to Azure Arc the AKS cluster you deployed in the previous exercise. You'll then prepare it for implementing the Application services extension in this module's next exercise. The exercise consists of the following tasks:

1. Prepare for connecting the AKS cluster to Azure Arc.
1. Connect the AKS cluster to Azure Arc.

To support Azure App Service workloads, you must enroll the Kubernetes cluster in Azure Arc. This enables you to install and manage Application services extensions, just like any other Azure Arc extension.

> [!NOTE]
> Azure Arc onboarding is a general requirement applicable to Kubernetes clusters. It's yet to be determined whether it applies to AKS clusters in future application services extension releases.

This is the third in this module's sequence of exercises. These exercises guide you through implementing Azure App Service on Kubernetes with Azure Arc. The sequence consists of the following exercises:

1. Prepare the lab environment.
1. Set up a Kubernetes cluster.
1. Connect the Kubernetes cluster to Azure Arc.
1. Implement App Service on the Azure Arc enabled Kubernetes cluster.
1. Deploy an App Service web app to the Azure Arc enabled Kubernetes cluster.
1. Clean up the lab environment.

:::image type="content" source="../media/4-exercise-3.png" alt-text="Depiction of this module's exercise sequence with additional sub-steps illustrated for the third exercise (Connect the Kubernetes cluster to Azure Arc)." border="false":::

## Task 1: Prepare for connecting the AKS cluster to Azure Arc

Before you connect the AKS cluster to Azure Arc, ensure relevant prerequisites are met. Prerequisites you must address include creating a resource group that will host Azure Arc resources and verifying registration of the necessary resource providers.

Use the following steps to implement these prerequisites:

1. In the browser window that displays the Bash session in the **Azure Cloud Shell** pane, run the following commands. These commands set values for variables that assign names to the resource group that will contain the Azure Arc resources and the Azure Arc-connected cluster resource:

    ```azurecli-interactive
    K8S_ARC_PREFIX=k8sArc
    ARC_RG_NAME="${K8S_ARC_PREFIX}-RG"
    ARC_CLUSTER_NAME="${K8S_ARC_PREFIX}-cluster" 
    ```

1. Run the following command to create the resource group that will house the Azure Arc-connected cluster resources (replace the `<azure_region>` placeholder with the name of the Azure region where you want to create the resource group that will host Azure Arc resources):

    ```azurecli-interactive
    az group create -n $ARC_RG_NAME -l "<azure_region>"
    ```

    > [!IMPORTANT]
    > During the preview, the only supported Azure regions are **East US** and **West Europe**.

    > [!NOTE]
    > You can choose a different region from the one hosting the AKS cluster.

1. Run the following command to verify registration of resource providers necessary to implement a connected cluster resource in the region hosting the resource group:

    ```azurecli-interactive
    az provider show -n Microsoft.Kubernetes --query "[registrationState,resourceTypes[?resourceType=='connectedClusters'].locations]"
    ```

## Task 2: Connect the AKS cluster to Azure Arc

Now you're ready to connect your AKS cluster to Azure Arc. The connected cluster resource represents an Azure-hosted projection of your Kubernetes infrastructure.

Use the following steps to connect the AKS cluster to Azure Arc:

1. In the browser window that displays the Bash session in the **Azure Cloud Shell** pane, run the following command to connect the cluster to Azure Arc:

    ```azurecli-interactive
    az connectedk8s connect -g $ARC_RG_NAME -n $ARC_CLUSTER_NAME -l eastus
    ```

    > [!NOTE]
    > Wait for the command to complete. This should take about 2 minutes.

    > [!NOTE]
    > Examine the output and verify that the value of the **provisioningState** property is **Succeeded**.


1. Run the following command to list the Azure Arc pods created on your cluster:

    ```azurecli-interactive
    kubectl get pods -n azure-arc
    ```

    > [!NOTE]
    > Verify that the output includes clusterconnect-agent pods

1. To validate the deployment, in the web browser that displays the Azure Cloud Shell, open another tab, navigate to [the Azure portal](https://portal.azure.com), use the **Search resources, services, and docs** text box to search for the Azure Arc resource representing your AKS cluster, and then navigate to its **Overview** blade.

:::image type="content" source="../media/4-arc-cluster-overview.png" alt-text="Screenshot that depicts the **Overview** blade of the Kubernetes-Azure Arc cluster." border="false":::

Congratulations! You've completed the third exercise of this module. You've connected the AKS cluster that you previously deployed to Azure Arc and prepared it for installation of the Application services extension in the next exercise.

In this exercise, you will implement the Azure App Service extension on your Azure Arc enabled Kubernetes cluster, preparing it for a deployment of an App Service web app in the next exercise. Your implementation will integrate with an Azure Log Analytics workspace that you will create as part of this exercise. The exercise consists of the following tasks:

1. Prepare for implementing the Azure App Service on the Azure Arc enabled Kubernetes cluster
1. Create an Azure Log Analytics workspace
1. Install the Azure App Service extension on your Azure Arc enabled Kubernetes cluster
1. Create a custom location for the Azure Arc enabled Kubernetes cluster
1. Register an App Service Kubernetes environment into the custom location

This is the fourth exercise in the sequence of exercises of this module that takes you through the process of implementing Azure App Service web apps on Kubernetes with Azure Arc. The sequence consists of the following exercises:

1. Prepare the lab environment
1. Set up a Kubernetes cluster
1. Connect the Kubernetes cluster to Azure Arc
1. Implement App Service on the Azure Arc enabled Kubernetes cluster
1. Deploy an App Service web app to the Azure Arc enabled Kubernetes cluster
1. Clean up the lab environment

:::image type="content" source="../media/u5-exercise4.png" alt-text="The image depicts the sequence of exercises with the default view of the fourth of them." border="false":::


## Task 1: Prepare for implementing the Azure App Service on the Azure Arc enabled Kubernetes cluster

Before you start your implementation of the Azure App Service extension on your Azure Arc enabled Kubernetes cluster, collect the information required to perform each of the implementation steps, including installing the App Service extension, creating a custom location, and setting up a Kubernetes environment

Use the following steps to collect the required information.

1. Within the web browser window displaying the Bash session in the Azure Cloud Shell pane, run the following commands to set values of the variables designating the names of, respectively, the resource group hosting the AKS cluster, the AKS cluster, the resource group that contains the Arc resources, and the Azure Arc connected cluster resource: 

    ```azurecli-interactive
    K8S_CLUSTER_RG_NAME=k8sAKS-RG
    K8S_CLUSTER_NAME=k8sAKS-cluster
    K8S_ARC_PREFIX=k8sArc
    ARC_RG_NAME="${K8S_ARC_PREFIX}-RG"
    ARC_CLUSTER_NAME="${K8S_ARC_PREFIX}-cluster" 
    ```

1. Run the following commands to set value of the variable designating the public IP address associated with the the load balancer service of the AKS cluster:

    ```azurecli-interactive
    K8S_PIP_NAME=k8sAKS-cluster-pip
    K8S_INFRA_RG=$(az aks show -g $K8S_CLUSTER_RG_NAME -n $K8S_CLUSTER_NAME --query nodeResourceGroup -o tsv)
    K8S_PIP=$(az network public-ip show -g $K8S_INFRA_RG -n $K8S_PIP_NAME --query ipAddress -o tsv)
    ```

1. Run the following commands to set the value of the variable designating the identifier of the Azure subscription hosting the resources you are provisioning in this module:

    ```azurecli-interactive
    SUBSCRIPTION_ID=$(az account show --query id -o tsv)
    ```

1. Run the following commands to set the value of the variable designating the name of the custom location that will host resources you deployed to the Azure Arc-connected Kubernetes cluster:

    ```azurecli-interactive
    CUSTOM_LOCATION_NAME="${K8S_ARC_PREFIX}-location"
    ```

1. Run the following commands to set the values of the variables designating, respectively, the name of the extension to be installed in the Azure Arc-connected cluster and the name of the corresponding Kubernetes environment:

    ```azurecli-interactive
    EXTENSION_NAME="${K8S_ARC_PREFIX}-kube"
    KUBE_ENV_NAME=$EXTENSION_NAME
    ```

    > [!IMPORTANT]
    > Currently, the names of the extension and kube environment must match.


1. Run the following commands to set the values of the variables designating the name of the Kubernetes namespace hosting the App Service resources:

    ```azurecli-interactive
    APP_SERVICE_NAMESPACE_NAME=appservice-ns
    ```

## Task 2: Create an Azure Log Analytics workspace

You can leverage Log Analytics to store and analyze application logs for App Service on your cluster. This is optional, but recommended.

> [!NOTE]
> This task is applicable only if you intend to use Log Analytics to store and analyze application logs for App Service resources hosted on your Kubernetes cluster.

Use the following steps to create an Azure Log Analytics workspace:

1. Run the following commands to set values of the variables representing the names of, respectively, the resource group that contains the AKS cluster infrastructure resources and the Azure Log Analytics workspace:

    ```azurecli-interactive
    K8S_INFRA_RG_NAME=$(az aks show -g $K8S_CLUSTER_RG_NAME -n $K8S_CLUSTER_NAME --query nodeResourceGroup -o tsv)
    LA_WORKSPACE_NAME=k8sAKS-workspace
    ```

1. Run the following commands to create an Azure Log Analytics workspace:

    ```azurecli-interactive
    az monitor log-analytics workspace create -g $K8S_INFRA_RG_NAME -n $LA_WORKSPACE_NAME
    ```

    > [!NOTE]
    > Wait for the workspace provisioning to complete. This should take about 2 minutes.

1. Run the following commands to set the values of the variables designating, respectively, the name of the Log Analytics workspace and its shared key:

    ```azurecli-interactive
    LA_WORKSPACE_NAME=k8sAKS-workspace
    LA_WORKSPACE_ID=$(az monitor log-analytics workspace show --resource-group $K8S_INFRA_RG_NAME --workspace-name $LA_WORKSPACE_NAME --query "customerId" -o tsv)
    LA_WORKSPACE_ID_ENC=$(printf %s $LA_WORKSPACE_ID | base64)
    LA_WORKSPACE_KEY=$(az monitor log-analytics workspace get-shared-keys --resource-group $K8S_INFRA_RG_NAME --workspace-name $LA_WORKSPACE_NAME --query "secondarySharedKey" -o tsv)
    LA_WORKSPACE_KEY_ENC_WITH_SPACE=$(printf %s $LA_WORKSPACE_KEY | base64)
    LA_WORKSPACE_KEY_ENC=$(echo -n "${LA_WORKSPACE_KEY_ENC_WITH_SPACE//[[:space:]]/}")
    ```


## Task 3: Install the App Service extension on your Azure Arc enabled Kubernetes cluster

Now you are ready to proceed with installing the App Service extension. Cluster extensions provide an Azure Resource Manager-based functionality for installation and lifecycle management of Azure resources on Azure Arc enabled Kubernetes clusters. A cluster extension instance is an extension of the Azure Resource Manager resource (Microsoft.KubernetesConfiguration/extensions) on top of the Azure Arc connected Kubernetes resource (represented by Microsoft.Kubernetes/connectedClusters). 

Use the following steps to install the App Service extension on your Azure Arc enabled Kubernetes cluster

1. Within the web browser window displaying the Bash session in the Azure Cloud Shell pane, run the following commands to verify the registration state of the Microsoft.KubernetesConfiguration resource provider, which will allow you to create the App Service extension in the region you selected for the resource group hosting the Azure Arc enabled services:

    ```azurecli-interactive
    az provider show -n Microsoft.KubernetesConfiguration --query "[registrationState,resourceTypes[?resourceType=='extensions'].locations]"
    ```

1. Run the following command to install the extension, including support for Log Analytics:

    > [!IMPORTANT]
    > If you intend to use Log Analytics for storing logs of App Service web apps hosted on an Azure Arc enabled Kubernetes cluster, you must reference the workspace when installing the App Service cluster extension. At present, there is no support for implementing this functionality after App Service cluster extension has been installed.

    ```azurecli-interactive
    az k8s-extension create -g $ARC_RG_NAME --name $EXTENSION_NAME --cluster-type connectedClusters -c $ARC_CLUSTER_NAME --extension-type 'Microsoft.Web.Appservice' --version "0.7.0" --auto-upgrade-minor-version false --scope cluster --release-namespace $APP_SERVICE_NAMESPACE_NAME --configuration-settings "Microsoft.CustomLocation.ServiceAccount=default" --configuration-settings "appsNamespace=${APP_SERVICE_NAMESPACE_NAME}" --configuration-settings "clusterName=${KUBE_ENV_NAME}" --configuration-settings "loadBalancerIp=${K8S_PIP}" --configuration-settings "buildService.storageClassName=default" --configuration-settings "buildService.storageAccessMode=ReadWriteOnce" --configuration-settings "envoy.annotations.service.beta.kubernetes.io/azure-load-balancer-resource-group=${K8S_CLUSTER_RG_NAME}" --configuration-settings "customConfigMap=${APP_SERVICE_NAMESPACE_NAME}/kube-environment-config" --configuration-settings "logProcessor.appLogs.destination=log-analytics" --configuration-settings "logProcessor.appLogs.logAnalyticsConfig.customerId=${LA_WORKSPACE_ID_ENC}" --configuration-settings "logProcessor.appLogs.logAnalyticsConfig.sharedKey=${LA_WORKSPACE_KEY_ENC}"
    ```

    > [!NOTE]
    > To install the extension without support for Log Analytics, use the following command:

    > ```azurecli-interactive
    > az k8s-extension create -g $ARC_RG_NAME --name $EXTENSION_NAME --cluster-type connectedClusters -c $ARC_CLUSTER_NAME --extension-type 'Microsoft.Web.Appservice' --version "0.7.0" --auto-upgrade-minor-version false --scope cluster --release-namespace $APP_SERVICE_NAMESPACE_NAME --configuration-settings "Microsoft.CustomLocation.ServiceAccount=default" --configuration-settings "appsNamespace=${APP_SERVICE_NAMESPACE_NAME}" --configuration-settings "clusterName=${KUBE_ENV_NAME}" --configuration-settings "loadBalancerIp=${K8S_PIP}" --configuration-settings "buildService.storageClassName=default" --configuration-settings "buildService.storageAccessMode=ReadWriteOnce" --configuration-settings "envoy.annotations.service.beta.kubernetes.io/azure-load-balancer-resource-group=${K8S_CLUSTER_RG_NAME}" --configuration-settings "customConfigMap=${APP_SERVICE_NAMESPACE_NAME}/kube-environment-config"
    > ```

1. Run the following command to validate the status of the installed extension:

    ```azurecli-interactive
    az k8s-extension show --cluster-type connectedClusters -c $ARC_CLUSTER_NAME -g $ARC_RG_NAME --name $EXTENSION_NAME
    ```

    > [!NOTE]
    > Re-run the command until the value of the value of the **installState** property changes to **Installed**. This should take about 5 minutes.

1. Run the following command to store the value of the **id** property of the extension in a variable:

    ```azurecli-interactive
    EXTENSION_ID=$(az k8s-extension show --cluster-type connectedClusters -c $ARC_CLUSTER_NAME -g $ARC_RG_NAME --name $EXTENSION_NAME --query id -o tsv)
    ```

    > [!NOTE]
    > You will use need this value in the next task of this exercise.


## Task 4: Create a custom location for the Azure Arc enabled Kubernetes cluster

Azure Resource Manager provides the location extension, which allows you to designate Azure Arc enabled Kubernetes clusters as target locations for deploying instances of Azure Arc enabled services, such as App Services web apps, function apps, or logic apps. A custom location maps extensions to a Kubernetes namespace hosting pods that implement the functionality of the corresponding resources.

Use the following steps to create a custom location.

1. Within the web browser window displaying the Bash session in the Azure Cloud Shell pane, run the following commands to verify the registration state of the Microsoft.ExtendedLocation resource provider, which will allow you to create a custom location in the region you selected for the resource group hosting the Azure Arc enabled services:

    ```azurecli-interactive
    az provider show -n Microsoft.ExtendedLocation --query "[registrationState,resourceTypes[?resourceType=='customLocations'].locations]"
    ```

1. Run the following command to store the value of the **id** property of the connected cluster in a variable: 

    ```azurecli-interactive
    CONNECTED_CLUSTER_ID=$(az connectedk8s show -n $ARC_CLUSTER_NAME -g $ARC_RG_NAME --query id -o tsv)
    ```

1. Run the following commands to identify object ID values of the service principals corresponding to the Custom Locations and App Service resource providers:

    ```azurecli-interactive
    AZURE_WEBSITES_OID=$(az ad sp show --id 'abfa0a7c-a6b6-4736-8310-5855508787cd' --query objectId -o tsv)
    CUSTOM_LOCATIONS_RP_OID=$(az ad sp show --id 'bc313c14-388c-4e7d-a58e-70017303ee3b' --query objectId -o tsv)
    ```

1. Run the following command to configure the Azure Role Based Access Control (RBAC) assignment allowing the App Service resource provider to manage the connected cluster resources in the target resource group you created in the previous exercise:

    ```azurecli-interactive
    az role assignment create --assignee-object-id $AZURE_WEBSITES_OID --role Owner --scope "/subscriptions/${SUBSCRIPTION_ID}/resourceGroups/${ARC_RG_NAME}" --output none
    ```

    > [!IMPORTANT]
    > Note that this command grants the App Service Resource Provider the Owner role privileges to the resource group.

1. Run the following commands to configure ClusterRoleBindings in order to allow the Custom Locations and App Service resource providers to interact with the Arc-enabled AKS cluster:

    ```azurecli-interactive
    echo "
    kind: ClusterRoleBinding
    apiVersion: rbac.authorization.k8s.io/v1beta1
    metadata:
        name: cluster-admin-firstparty-app
    roleRef:
        apiGroup: rbac.authorization.k8s.io
        kind: ClusterRole
        name: cluster-admin
    subjects:
        - kind: User
          name: $AZURE_WEBSITES_OID
        - kind: User
          name: $CUSTOM_LOCATIONS_RP_OID
    " > ./clusterrolebinding.yaml

    kubectl apply -f ./clusterrolebinding.yaml

    rm ./clusterrolebinding.yaml
    ```

    > [!NOTE]
    > The first of these commands creates the **clusterrolebinding.yaml** file in the working directory of the Azure Cloud Shell. The third one removes it.

1. Run the following command to create a custom location:

    ```azurecli-interactive
    az customlocation create -g $ARC_RG_NAME -n $CUSTOM_LOCATION_NAME -hr $CONNECTED_CLUSTER_ID -ns $APP_SERVICE_NAMESPACE_NAME -c $EXTENSION_ID
    ```

    > [!NOTE]
    > Wait for the provisioning process to complete. This should take about 1 minute. 

    > [!NOTE]
    > Review the output of the command and verify that the value of the "provisioningState" property is "Succeeded".

1. Run the following command to store the value of the "id" property of the custom location in a variable:

    ```azurecli-interactive
    CUSTOM_LOCATION_ID=$(az customlocation show -g $ARC_RG_NAME -n $CUSTOM_LOCATION_NAME --query id -o tsv)
    ```

    > [!NOTE]
    > You will use need this value in the next task of this exercise.


## Task 5: Register an App Service Kubernetes environment into the custom location

Once you create a custom location, you can proceed to register an App Service Kubernetes environment into that location. An App Service Kubernetes Environment enables configuration common across apps, but not related directly to cluster operations, such as providing the default DNS suffix.

> [!NOTE]
> You can create only one Kubernetes environment resource per custom location.

Use the following steps to create an App Service Kubernetes environment.

1. Within the web browser window displaying the Bash session in the Azure Cloud Shell pane, run the following commands to verify the registration state of the Microsoft.Web resource provider, which will allow you to create a kubeEnvironment resource in **Central US EUAP**:

    ```azurecli-interactive
    az provider show -n Microsoft.Web --query "[registrationState,resourceTypes[?resourceType=='kubeEnvironments'].locations]"
    ```

1. Run the following commands to create the App Service Kubernetes environment:

    ```azurecli-interactive
    az appservice kube create -g $ARC_RG_NAME -n $KUBE_ENV_NAME --custom-location $CUSTOM_LOCATION_ID --static-ip $K8S_PIP --location centraluseuap
    ```

1. Run the following command to validate the status of the Kubernetes environment:

    ```azurecli-interactive
    az appservice kube show -g $ARC_RG_NAME -n $KUBE_ENV_NAME
    ```

    > [!NOTE]
    > Re-run the command until the value of the "provisioningState" property changes to "InfrastructureSetupComplete". This should take about 3 minutes.

Congratulations! You completed the fourth exercise of this module. In its exercise, you implemented the Azure App Service extension on your Azure Arc enabled Kubernetes cluster, preparing it for a deployment of an App Service web app in the next exercise. 
This unit combines the last two exercises as you evaluate Azure App Service on Azure Arc. In these two exercises, you'll perform the following tasks:

1. Create a web app in an App Service Kubernetes environment.
1. Deploy a Node.js-based application by using a zip-file deployment.
1. Delete the Azure Arc resource group.
1. Delete the AKS resource group.

> [!NOTE]
> The sample application you'll deploy is intentionally very simplistic. This exercise's primary purpose is to demonstrate deployment methodology. However, you can use the same approach when deploying more complex apps (the file size limit is 2048 megabytes (MB). For more information, refer to the Microsoft Docs article [Deploy your app to Azure App Service with a ZIP or WAR file](https://docs.microsoft.com/en-us/azure/app-service/deploy-zip).

> [!NOTE]
> This exercise illustrates a code-based deployment. App Service Kubernetes environment also supports container-based deployments.

These are the two final exercises in the module's sequence of exercises. These exercises have guided you through implementing Azure App Service web apps on Kubernetes with Azure Arc. The sequence consists of the following exercises:

1. Prepare the lab environment.
1. Set up a Kubernetes cluster.
1. Connect the Kubernetes cluster to Azure Arc.
1. Implement App Service on the Azure Arc-enabled Kubernetes cluster.
1. Deploy an App Service web app to the Azure Arc-enabled Kubernetes cluster.
1. Clean up the lab environment.

:::image type="content" source="../media/u6-exercise5.png" alt-text="Depiction of this module's exercise sequence with additional sub-steps illustrated for the fifth exercise (Deploy an App Service web app to the Azure Arc-enable Kubernetes cluster)." border="false":::

:::image type="content" source="../media/u6-exercise6.png" alt-text="Depiction of this module's exercise sequence with additional sub-steps illustrated for the sixth exercise (Clean up the lab environment)." border="false":::


## Task 1: Create a web app in an App Service Kubernetes environment

To create a web app in an App Service Kubernetes environment, you need an App Service plan within that environment. However, you don't have to create one explicitly. If a plan doesn't exist, the platform will automatically provision it. For the sake of completeness, this process includes steps that illustrate creation of an App Service plan.

Use the following step to create an App Service plan and a Linux code-based web app:

1. In the browser window that displays the Bash session in the **Azure Cloud Shell** pane, run the following commands. These commands set values of the variables that designate the names of the resource group that contains the Arc resources and the Azure Arc-connected cluster resource:

    ```azurecli-interactive
    K8S_ARC_PREFIX=k8sArc
    ARC_RG_NAME="${K8S_ARC_PREFIX}-RG"
    ARC_CLUSTER_NAME="${K8S_ARC_PREFIX}-cluster" 
    ```

1. Run the following commands to set the values of the variables that designate the extension's name that's being installed in the Azure Arc-connected cluster and the name of the corresponding Kubernetes environment:

    ```azurecli-interactive
    EXTENSION_NAME="${K8S_ARC_PREFIX}-kube"
    KUBE_ENV_NAME=$EXTENSION_NAME
    ```

    > [!IMPORTANT]
    > Currently, the names of the extension and kube environment must match.

1. Run the following commands to set the value of the variable that designate the name of the custom location that will host resources you deployed to the Azure Arc-connected Kubernetes cluster:

    ```azurecli-interactive
    CUSTOM_LOCATION_NAME="${K8S_ARC_PREFIX}-location"
    ```

1. Run the following command to store the **id** property value of the custom location in a variable:

    ```azurecli-interactive
    CUSTOM_LOCATION_ID=$(az customlocation show -g $ARC_RG_NAME -n $CUSTOM_LOCATION_NAME --query id -o tsv)
    ```

1. Run the following commands to set values of the variables that designate the names of the service plan and the web app:

    ```azurecli-interactive
    WEBAPP_SP_NAME=k8sArc-sp
    WEBAPP_NAME=k8sarcwebapp$RANDOM$RANDOM
    ```

    > [!NOTE]
    > A known issue requires that you choose a globally unique name for your web app. Don't use a cluster-unique app name. Otherwise, you might observe a **ResourceNotFound** exception error when you preform the web-app deployment later in this exercise.

1. Run the following command to create an App Service plan in the custom location:

    ```azurecli-interactive
    az appservice plan create -g $ARC_RG_NAME -n $WEBAPP_SP_NAME --custom-location $CUSTOM_LOCATION_ID --is-linux --per-site-scaling
    ```

1. Run the following command to deploy a web app using the newly created App Service plan:

    ```azurecli-interactive
    az webapp create -g $ARC_RG_NAME -p $WEBAPP_SP_NAME -n $WEBAPP_NAME --runtime "NODE|12-lts"
    ```

    > [!TIP]
    > To list valid runtimes, run the following command:
    >
    > ```azurecli-interactive
    > az webapp list-runtimes --linux
    > ```


## Task 2: Deploy a Node.js-based application by using the zip-file deployment

Now, you'll download the code containing a sample Node.js application, install its dependencies, create a zip archive that contains all application files, and deploy it to the web app you previously created.

Use the following steps to deploy a Node.js-based application by using the ZIP file deployment to a web app in an App Service Kubernetes environment:

1. In the browser window that displays the Bash session in the **Azure Cloud Shell** pane, run the following command to download the content of the https://github.com/Azure-Samples/nodejs-docs-hello-world GitHub repository that contains the sample application:

    ```azurecli-interactive
    git clone https://github.com/Azure-Samples/nodejs-docs-hello-world.git
    ```

1. Run the following command to change the working directory to the one that contains the application code:

    ```azurecli-interactive
    cd nodejs-docs-hello-world
    ```

1. Run the following command to install the application dependencies:

    ```azurecli-interactive
    npm install
    ```

1. Run the following command to create a zip archive that contains all of the application files:

    ```azurecli-interactive
    zip -r nodejs-docs-hello-world.zip .
    ```

1. Run the following command to deploy the zip archive that contains all of the application files to the target web app:

    ```azurecli-interactive
    az webapp deployment source config-zip -g $ARC_RG_NAME -n $WEBAPP_NAME --src nodejs-docs-hello-world.zip
    ```

    > [!NOTE]
    > From the deployment standpoint, this process is the same as the one used to deploy an application to Azure App Service. The difference is that your web app is running on the Azure Arc-enabled Kubernetes cluster. It's not being hosted by Azure App Service.

    > [!NOTE]
    > Don't use `az webapp up` to deploy code. It isn't supported in the current preview. There also isn't support for File Transfer Protocol (FTP) publishing.

1. Run the following command to list pods in the appservice-ns namespace on the target Azure Arc-enabled Kubernetes cluster:

    ```azurecli-interactive
    kubectl get pods -n appservice-ns
    ```

    > [!NOTE]
    > The list should include a pod with a name for which the prefix matches the web app's name. <!-- ID/SME: Can we put an example name here, for clarity. -->

1. To validate the deployment from a functional standpoint, in the web browser that displays the Azure Cloud Shell, open another tab, navigate to [the Azure portal](https://portal.azure.com), use the **Search resources, services, and docs** text box to search for the App Service web app you deployed. Navigate to its **Overview** blade, identify its **URL**, and then open another tab in the same browser window to display the corresponding webpage.

    > [!NOTE]
    > The webpage should display **Hello World!**


## Task 3: Delete the Azure Arc resource group

To return your Azure subscription to its original state, remove the Azure Arc resources that you'll no longer use.

Use the following step to delete all Azure Arc resources you provisioned throughout this course's exercises:

1. Switch to the browser window that displays the Bash session in the **Azure Cloud Shell** pane, and then run the following commands. These commands set the variable value for the name of the resource group that contains the Arc resources:

    ```azurecli-interactive
    K8S_ARC_PREFIX=k8sArc
    ARC_RG_NAME="${K8S_ARC_PREFIX}-RG"
    ```

1. Run the following command to delete the resource group:

    ```azurecli-interactive
    az group delete --name $ARC_RG_NAME --yes
    ```


## Task 4: Delete the AKS resource group

To minimize Azure-related charges that are associated with running these exercises, remember to delete the Azure resources that you'll no longer use.

Use the following step to delete the remaining Azure resources you provisioned throughout this course's exercises:

1. In the web browser window that displays the Bash session in the **Azure Cloud Shell** pane, run the following command. These commands set the value of the variable that designates the resource group's name that contains the AKS cluster. This will automatically delete all resources in the corresponding infrastructure resource group:

    ```azurecli-interactive
    K8S_CLUSTER_RG_NAME=k8sAKS-RG
    ```

1. Run the following command to delete the resource group:

    ```azurecli-interactive
    az group delete --name $K8S_CLUSTER_RG_NAME --no-wait --yes
    ```

    >**Note**: The command executes asynchronously (as determined by the **--nowait** parameter). While you'll be able to run another Azure CLI command in the same shell immediately after running this command, it'll take a few minutes before the resource groups are actually removed.

Congratulations! You've completed the last two exercises of this module. You've created an App Service plan and a web app in the App Service Kubernetes environment hosted on your Azure Arc-enabled Kubernetes cluster. You've also deployed a Node.js-based application into the web app by using the zip-file deployment method, validated the deployment, and removed any Azure resources that you'll no longer use.

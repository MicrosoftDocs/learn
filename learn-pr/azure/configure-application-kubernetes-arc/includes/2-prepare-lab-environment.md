In this exercise, you will prepare your lab environment for implementation of Azure App Service on Azure Arc enabled Kubernetes clusters. The exercise consists of the following tasks:

1. Install prerequisite software tools
1. Enable required preview features in the Azure subscription
1. Install required Azure CLI extensions

This is the first exercise in the sequence of exercises in this module that takes you through the process of implementing Azure App Service web apps on Kubernetes with Azure Arc. The sequence consists of the following exercises:

1. Prepare the lab environment
1. Set up a Kubernetes cluster
1. Connect the Kubernetes cluster to Azure Arc
1. Implement App Service on the Azure Arc enabled Kubernetes cluster
1. Deploy an App Service web app to the Azure Arc enabled Kubernetes cluster
1. Clean up the lab environment

:::image type="content" source="../media/u2-exercise1.png" alt-text="The image depicts the sequence of exercises with the default view of the first of them." border="false":::

## Task 1: Install prerequisite software tools

The implementation process relies on Azure CLI, kubectl, and Helm. An Azure portal-based implementation process is not yet available.

> [!IMPORTANT]
> Skip this task when using [Azure Cloud Shell](https://shell.azure.com). Azure Cloud Shell provides a convenient lab environment, since it has the prerequisite software tools already installed, and it simplifies the process of authenticating to your Azure subscription. Azure Cloud Shell is available on the latest versions of Microsoft Edge, Google Chrome, Mozilla Firefox, and Apple Safari. Safari in private mode is not supported.

> [!NOTE]
> The exercises in this module will use Azure Cloud Shell to implement Azure App Service on Kubernetes with Azure Arc. 

- Azure CLI (version 2.19.1 or later). For installation instructions, refer to [the Install the Azure CLI page on Microsoft Docs](https://docs.microsoft.com/cli/azure/install-azure-cli)
- kubectl (version 1.13.2 or later). Once you install Azure CLI, you can use it to install kubectl by running `az aks install-cli`.
- Helm (version 3.4.0 or later). For information regarding Helm and installation, refer to [the Install existing applications with Helm in Azure Kubernetes Service (AKS) page on Microsoft Docs](https://docs.microsoft.com/azure/aks/kubernetes-helm)


## Task 2: Enable required preview features in the Azure subscription

Azure App Service on Kubernetes with Azure Arc is available on the preview basis. You have to explicitly opt-in if you intend to use this functionality in your Azure subscription. Once the opt-in process is completed, use the following steps to enable the relevant functionality within your Azure subscription.

1. Start any Azure Cloud Shell-compatible web browser, navigate to [Azure Cloud Shell](https://shell.azure.com), and, if prompted, authenticate with a Microsoft account or an Azure Active Directory (Azure AD) account that has an Owner role in the Azure subscription.
1. If prompted to select either **Bash** or **PowerShell**, select **Bash**. 

    > [!NOTE]
    > If this is the first time you are starting Azure Cloud Shell and you are presented with the **You have no storage mounted** message, select the subscription you are using in this lab, and select **Create storage**. 

1. From the Bash session in the Azure Cloud Shell pane, run the following commands to enable all required resource providers and their respective preview features for all of the resources and locations that you will use in this module:

    ```azurecli-interactive
    az feature register --namespace Microsoft.Resources --name EUAPParticipation
    az provider register -n Microsoft.Resources --wait

    az feature register --namespace Microsoft.Kubernetes --name previewAccess
    az provider register --namespace Microsoft.Kubernetes --wait

    az feature register --namespace Microsoft.KubernetesConfiguration --name extensions
    az provider register --namespace Microsoft.KubernetesConfiguration --wait

    az feature register --namespace Microsoft.ExtendedLocation --name CustomLocations-ppauto
    az provider register --namespace Microsoft.ExtendedLocation --wait

    az provider register --namespace Microsoft.Web --wait
    ```

    > [!NOTE]
    > Wait for the commands to complete. This should take about 2 minutes.

1. Run the following command to determine whether you can create Kubernetes Environments:

    ```azurecli-interactive
    az provider show -n Microsoft.Web --query "resourceTypes[?resourceType=='kubeEnvironments'].locations"
    ```

    > [!NOTE]
    > Verify that the output includes the entry representing the **Central US EUAP** location before you proceed further. If that's not the case, wait a few more minutes and repeat this step.


## Task 3: Install required Azure CLI extensions

Some of the implementation tasks in this module depend on Azure CLI extensions. Extensions are Python components referred to as *wheels* and take the form of files with the **.whl** extension. Extensions implement Azure CLI commands that deliver experimental and pre-release features. You can download them from the GitHub repository dedicated to development of these features.

When using Azure Cloud Shell, you can leverage its file upload functionality if you downloaded the **.whl** files to your local computer. Alternatively, you can download them directly to your Azure Cloud Shell home directory.

    > [!NOTE]
    > When installing a newer version of an already installed extension, first uninstall the older one by running `az extension remove --name <extensionName>`.

Use the following steps to install the Azure CLI extensions required to implement Azure App Service on Kubernetes with Azure Arc.

1. From the Bash session in the Azure Cloud Shell pane, run the following command to make sure you have the latest version of the CLI and all of the currently installed extensions:

    ```azurecli-interactive
    az upgrade
    ```

1. Run the following commands to install the **connectedk8s**, **k8s-extension**, and **customlocation** Azure CLI extensions. 

    ```azurecli-interactive
    az extension add --upgrade --yes -n connectedk8s
    az extension add --upgrade --yes -n k8s-extension
    az extension add --upgrade --yes -n customlocation
    ```

    > [!NOTE]
    > Wait for the installation to complete. This should take about 1 minute.

1. From your computer, download the latest **appservice-kube** CLI extension from [the Releases page of the Azure App Service on Azure Arc repository](https://github.com/microsoft/Azure-App-Service-on-Azure-Arc/releases).
1. Within the web browser window displaying the Azure Cloud Shell pane, in the pane's toolbar, select the fourth icon displaying a page with a pair of vertical arrows pointing in the opposite directions (the fourth icon from the right) and, in the drop-down menu, select **Upload**.
1. In the **Open** dialog box, navigate to the location of the **.whl** file, select it, and click **Open**.
1. From the Bash session in the Azure Cloud Shell pane, run the following command to install the **appservice-kube** Azure CLI extension (if needed, replace `appservice_kube-0.1.16-py2.py3-none-any.whl` with the name of the **.whl** file you uploaded in the previous step):

    ```azurecli-interactive
    az extension add --yes --source ./appservice_kube-0.1.16-py2.py3-none-any.whl
    ```

    > [!NOTE]
    > To verify that the installation completed successfully, run the `az -v` command and examine its output. The output should include the **Extensions** section in the following format:
    >
    >```json
    >Extensions:
    >customlocation                     0.1.0
    >connectedk8s                       0.3.5
    >k8s-extension                      0.1.0
    >appservice-kube                    0.1.16
    >ai-examples                        0.2.5
    >ssh                                0.1.5
    >```

Congratulations! You completed the first exercise of this module. In its exercise, you prepared your lab environment for implementation of Azure App Service on Azure Arc enabled Kubernetes clusters.

Imagine that you want to create an Azure Kubernetes Service (AKS) cluster for a new video game your team is working on. You would like to try out using Azure Policies to govern this cluster. Based on your research, you decide to start with the following policies:

- Allow images only from trusted registries into the cluster
- Kubernetes cluster pod security restricted standards for Linux-based workloads initiative

The first step would be to create an AKS cluster that has Azure policies enabled.

[!INCLUDE [azure-optional-exercise-subscription-note](../../../includes/azure-optional-exercise-subscription-note.md)]

## Create an AKS cluster with Azure Policy and Azure Monitor add-on

Before you install the Azure Policy add-on or enable any of the service features, your subscription must enable the **Microsoft.PolicyInsights** resource provider.

1. You need the Azure CLI version 2.12.0 or later installed and configured. To find the version, Run `az --version`. If you need to install or upgrade, see [Install the Azure CLI](/cli/azure/install-azure-cli).
1. Register the resource providers and preview features.

In this exercise, we use the Azure Cloud Shell to run the commands. Feel free to use a terminal of your choice for this exercise. To begin, sign in to your **Azure portal**

### Setting up the environment

1. Go to the Azure portal.

    > [!div class="nextstepaction"]
    > [Azure portal](https://portal.azure.com?azure-portal=true)

1. Select the **Cloud Shell** icon at the top of the screen to the right of the search bar

   :::image type="content" source="../media/3-create-cloud-shell-instance.png" alt-text="screenshot of Azure portal on the cloud shell creation screen." lightbox="../media/3-create-cloud-shell-instance.png":::

1. Select the appropriate Subscription and then select **Create storage**.

1. In the top-left corner of the resulting Cloud Shell, select **PowerShell** and change it to **Bash**. If it's showing Bash already, you can skip this step

1. Register the resource providers and preview features by entering the following command in Cloud Shell.

     ```azurecli-interactive
    # Log in first with az login if you're not using Cloud Shell
    # Provider register: Register the Azure Policy provider
    az provider register --namespace Microsoft.PolicyInsights
    ```

1. Once these prerequisite steps are completed, use the instructions in the previous note to install the Azure Policy add-on in the AKS cluster that you want to manage. In the next section, we create a new cluster and enable the Azure Policy add-on.

### Create AKS cluster and enable Azure Policy add-on

Now that we have the provider registered we can create a new resource group and create an AKS cluster within that group.

1. Create a resource group

   ```azurecli-interactive
   az group create --location eastus --name videogamerg
   ```

1. Create AKS cluster using the default settings
    > [!NOTE]
    > For production workloads, you would want to further customize the creation of your cluster to ensure it meets your security and governance requirements. We are going with a simple cluster purely for training purposes.
    
    ```azurecli-interactive
    az aks create --name videogamecluster --resource-group videogamerg 
    ```
    
1. Enable Azure Policies for the cluster

    ```azurecli-interactive
    az aks enable-addons --addons azure-policy --name videogamecluster --resource-group videogamerg
    ```


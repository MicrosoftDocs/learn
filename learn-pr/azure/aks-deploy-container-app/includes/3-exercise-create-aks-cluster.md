## Create a new resource

The first action you need to take in order to create your cluster is to povision it within Azure. Provisioning an AKS cluster in Azure can be done in the Azure portal or through the Azure CLI.

[!INCLUDE [azure-exercise-subscription-prerequisite](../../../includes/azure-exercise-subscription-prerequisite.md)]

:::zone pivot="portal"

1. Log in to the [Azure portal](https://portal.azure.com?azure-portal=true) with the account you want to deploy your AKS cluster in.

1. Select the search box at the top of the portal and search for **kubernetes**, then select **Kubernetes Services** in the search results.

    :::image type="content" source="../media/3-option-search-box.png" alt-text="Searching for Azure Kubernetes Service in the Azure portal":::

## Basic cluster information

In this screen, you'll notice there are several tabs at the top. Each one of them provides a different setting you may want to set up. Let's start with the **Basics** tab. Fill this information.

|Parameter  |Value  |
|---------|---------|
|**Resource Group**     | Select **Create new**, enter **contoso-aks**, then select **OK**       |
|**Kubernetes Cluster Name**     |  Enter a name for your cluster, such as **contoso-kubernetes-cluster**       |
|**Region**     | **East US**        |
|**Kubernetes Version**     |  Leave the **(default)** version selected |
| **Node size** | Select **Change size**, then select **B2s** |
| **Node count** | 3 |

    :::image type="content" source="../media/3-node-size.png" alt-text="Change node size via Portal":::

The final configuration will be similar to this:

:::image type="content" source="../media/3-final-basic-config.png" alt-text="Final basic configuration":::

When finished, select **Next: Node pools** to configure the next settings:

## Configure Node Pools

In this next screen you'll be presented with the configuration of the Node Pools, which were explained in the conceptual part of this exercise. But, as a reminder, _Node Pools_ are a way to have multiple node types within the same cluster.

Select the **Next: Authentication** button to continue:

## Define authentication settings

The **Authentication** tab is where you set up everything related to user credentials and the Kubernetes integration with Azure services via Service Principal, which is basically a service account that you can give different scopes, think of service principals as passes, that allow your cluster to communicate to Azure services.

For now, leave all settings as they are.

Select the **Next: Networking** button to go on to the next step

## Creating a network

The **Networking** tab is the place where you'll configure how your cluster will behave to the world and how it will manager the internal traffic from its pods and workloads.

1. Configure basic network information

    The Network tab has two different types of configuration:

    - The _basic_ configuration, in which all IP addresses and subnets are automatically configured, and
    - The _advanced_ mode, where you need to set up all the address ranges and subnets. For now, let's keep on the basic.

    Next up, you can choose a **DNS name**, this is what is going to identify your cluster's ingress rules and external DNS records.

    Leave the **private cluster** and **network policy** configuration as it is.

1. Configure application routing

    Lastly you'll enable the `HTTP Application Routing` configuration, explained in the conceptual part of this exercise. Read more about it in the official docs.

    :::image type="content" source="../media/3-network-settings.png" alt-text="Network tab":::

## Finish

Once all is done, select the **Review + Create** button and wait a few seconds while Azure validates your deployment, once the **Create** blue button appears, select it, then wait a few minutes for the deployment to finish.

When it finishes, you should see a notification with a button named **Go to Resource**. Select it and Azure will take you to the newly created cluster.

:::image type="content" source="../media/3-finished.png" alt-text="Finished creation":::

:::zone-end

:::zone pivot="bash"

1. Before creating an AKS cluster, it's necessary to create an Azure Resource Group, this group will hold all of the created resources:

    ```bash
    az group create --name contoso-aks --location eastus
    ```

    If the group has been created successfully, you will receive the following response:

    ```json
    {
      "id": "/subscriptions/<guid>/resourceGroups/contoso-aks",
      "location": "eastus",
      "managedBy": null,
      "name": "contoso-aks",
      "properties": {
        "provisioningState": "Succeeded"
      },
      "tags": null
    }
    ```

    Then it's time to create the cluster.

2. Creating an AKS using bash resumes in issuing a single command using Azure CLI. Open your preferred terminal (or use CloudShell) and issue the following command:

    ```bash
    az aks create --resource-group contoso-aks --name contoso-kubernetes-cluster --node-count 3 --enable-addons http_application_routing --generate-ssh-keys --dns-name-prefix contoso-kubernetes --node-vm-size Standard_B2s
    ```

:::zone-end

:::zone pivot="powershell"

1. Before creating an AKS cluster, it's necessary to create an Azure Resource Group, this group will hold all of the created resources:

    ```powershell
    az group create --name contoso-aks --location eastus
    ```

    If the group has been created successfully, you will receive the following response:

    ```json
    {
      "id": "/subscriptions/<guid>/resourceGroups/contoso-aks",
      "location": "eastus",
      "managedBy": null,
      "name": "contoso-aks",
      "properties": {
        "provisioningState": "Succeeded"
      },
      "tags": null
    }
    ```

    Then it's time to create the cluster.

2. Creating an AKS using powershell resumes in issuing a single command using Azure CLI. Open your preferred terminal (or use CloudShell) and issue the following command:

    ```powershell
    az aks create --resource-group contoso-aks --name contoso-kubernetes-cluster --node-count 3 --enable-addons http_application_routing --generate-ssh-keys --dns-name-prefix contoso-kubernetes --node-vm-size Standard_B2s
    ```

:::zone-end

## Linking with Kubectl

1. To access the cluster it's necessary to have `kubectl` installed. Kubectl is the default CLI tool to access Kubernetes' API and issue commands to it. To do it, we need Azure CLI, and it already has built-in commands for it!

    ```bash
    az aks install-cli
    ```

    Issuing this command, Azure CLI will install `kubectl` in your OS.

2. Run the following command to check if it has been installed successfully:

    ```bash
    kubectl version
    ```

3. Link your kubernetes cluster with `kubectl` with the following command

    ```bash
    az aks get-credentials --name contoso-kubernetes-cluster --resource-group contoso-aks
    ```

## Testing the installation

1. Let's check if the cluster has been installed correctly by issuing the command:

    ```bash
    kubectl get nodes
    ```

    If the cluster is correct you should receive a list of three available nodes.

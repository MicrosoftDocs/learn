
[//]: # (1. There are some things to consider with the structure of the exercise. It would help if you started with how what the learner is going to do here applies to the overall scenario instead of starting with the first H2 step. In this case, we want to deploy workloads, which means the creation of the cluster is one of those subtasks we need to complete to complete the main task. "How to deploy workloads declaratively?" Explore one of the architectural decisions you discussed in the previous unit.)

[//]: # (2. Create the cluster using the portal and drop the Azure CLI steps and the Powershell steps [You're repeating the Azure CLI info in the Powershell scripts instead of using New-AzAks]. In hindsight, we do not need the pivot.)

[//]: # (3. Keep the Linking with kubectl section as is, however, explain why we're doing this. Mention how this step configures the user's Kubernetes context. Make sure to call out the environment in which these steps execute. Avoid an instruction like this  one, "Open your preferred terminal [or use CloudShell]." Not all terminals are configured the same. Focus on cloud shell usage since all executables are already configured. Some students may prefer the macOS terminal, but may not have azure CLI install.)

[//]: # (4. Use the "azurecli" script tag when using CLI commands.)

[//]: # (5. General thoughts about using headers. In this unit, the user has two tasks. One, create a new AKS cluster and two, configure the user environment Kubernetes context. Create a header for these two main tasks you want the user to perform. Underneath each add H3 headers to describe the subtasks the user will perform. For example, create a resource group. Avoid titles with "-ing" words. Rewrite the titles that start with an -ing word. For example,  "Creating a network" -> "Create a network" )

[//]: # (5. Do not use the "Finish" heading.)

[//]:# (Make sure the red box has the proper size border, i.e., brush width 3px. https://review.docs.microsoft.com/en-us/help/contribute/contribute-how-to-create-screenshot?branch=master)

## Create a new resource

[//]:# (Consider the create a resource steps as used in this module - https://docs.microsoft.com/en-us/learn/modules/intro-to-azure-virtual-machines/3-create-a-vm)

The first action you need to take in order to create your cluster is to provision it within Azure. Provisioning an AKS cluster in Azure can be done in the Azure portal or through the Azure CLI.

[!INCLUDE [azure-exercise-subscription-prerequisite](../../../includes/azure-exercise-subscription-prerequisite.md)]

:::zone pivot="portal"

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true) with the account you'll use to deploy your AKS cluster.

1. Use the search bar at the top of the portal to find **kubernetes**.  In the list of search results options, select **Kubernetes Services**.

    :::image type="content" source="../media/3-option-search-box.png" alt-text="Searching for Azure Kubernetes Service in the Azure portal":::

1. You're presented with the Create Kubernetes cluster page.

## Basic cluster information

The create Kubernetes cluster page has several tabs at the top that guides you through the different setting you may want to configure for your cluster. Complete the **Basics** tab with the following information.

[//]:# (Consider describing why the user will use the info below.)

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

1.  Select **Next: Node pools**

## Configure Node Pools

[//]:# (Rather use "Recall from earlier that you need to configure node pools to group the same types of nodes. In this tab ...". Instead of refering back to a previous unit, use the opportunity to reinforce the learning concept for the user. The user isn't going to page back to reread they concept. They want to complete the task.)

In this next screen you'll be presented with the configuration of the Node Pools, which were explained in the conceptual part of this exercise. But, as a reminder, _Node Pools_ are a way to have multiple node types within the same cluster.

1. Select **Next: Authentication**

## Define authentication settings

The **Authentication** tab is where you set up everything related to user credentials and the Kubernetes integration with Azure services via Service Principal. The Service Principal is a service account that you can give different scopes, think of service principals as passes, that allow your cluster to communicate to Azure services.

[//]:# (Consider exploring the service principle topic further vs. the System-assigned managed identity. At this point, it's the first time the users see these two options, and authentication is discussed in the module. What should they consider here? Same goes for RBAC options.)

For now, leave all settings as they are.

Select the **Next: Networking** button to go on to the next step

## Create a network

The **Networking** tab is the place where you'll configure how your cluster will behave to the world and how it will manager the internal traffic from its pods and workloads.

1. Configure basic network information

    The Network tab has two different types of configuration:

    - The _basic_ configuration, in which all IP addresses and subnets are automatically configured, and
    - The _advanced_ mode, where you need to set up all the address ranges and subnets. For now, let's keep on the basic.

    Next up, choose a **DNS name**. The DNS name identifies your cluster's ingress rules and external DNS records.

    Leave the **private cluster** and **network policy** configuration as it is.

1. Configure application routing

    Enable the `HTTP Application Routing` configuration, explained in the conceptual part of this exercise. Read more about it in the official docs.

    :::image type="content" source="../media/3-network-settings.png" alt-text="Network tab":::

## Finish

Finally, select the **Review + Create** button and wait a few seconds while Azure validates your deployment, once the **Create** blue button appears, select it, then wait a few minutes for the deployment to finish.

When deployment completes, select the **Go to Resource** notification button to take you to the newly created cluster.

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

3. Link your Kubernetes cluster with `kubectl` with the following command

    ```bash
    az aks get-credentials --name contoso-kubernetes-cluster --resource-group contoso-aks
    ```

## Testing the installation

1. Let's check if the cluster has been installed correctly by issuing the command:

    ```bash
    kubectl get nodes
    ```

    If the cluster is correct you should receive a list of three available nodes.

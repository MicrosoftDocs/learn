## Create a new resource

The first action you need to take in order to create your cluster is to provide it within Azure. Providing an AKS cluster in Azure is simple and intuitive and can be done in one of two ways: Either by the Azure portal via Browser, or via Azure CLI.

> [!CAUTION]
> For this unit you're going to use your own subscription, but, by the end of this module, we'll give your instructions to delete all the created resources.

:::zone pivot="portal"

1. First of all access the [Azure portal](https://portal.azure.com).

    In the Portal, you'll create your new AKS cluster.

1. Press `G+/` or click the top search box and search for `kubernetes`, then click "Kubernetes Services" right in the search results.

    :::image type="content" source="../media/3-option-search-box.png" alt-text="Azure portal: AKS on search bar":::

## Basic cluster information

In this screen, you'll notice there are several tabs at the top. Each one of them provides a different setting you may want to set up. Let's start with the `Basics` tab. Fill this information.

1. Fill in the __Resource Group__: Create a new resource group with any name you want, for instance: `contoso-aks`.
1. Fill in the __Kubernetes Cluster Name__: This setting represents the name of your cluster, let's use `contoso-kubernetes-cluster`.
1. Fill in the __Region__: Select `East US`.
1. Fill in the __Kubernetes Version__: In the previous unit, we talked about Kubernetes versions and how there are some differences between those versions. Some of the newest have breaking changes that will alter the way you create your workloads when managing your cluster. Let's leave it at the `(default)` value.

1. Fill in Node Pool information

    As we mentioned before, node pools define different node types. After the basic information about the cluster itself, we need to change the __Node Pool__ information, we'll not change the __Node Count__ value, only the __Node Size__.

    Nodes are Azure VMs, this means you can change their size to match your usage pattern. For this module, you'll start with a `B2s` VM since the company only requires a low usage. You can update it by clicking on the __Change Size__ link.

    :::image type="content" source="../media/3-node-size.png" alt-text="Change node size via Portal":::

The final configuration will be similar to this:

:::image type="content" source="../media/3-final-basic-config.png" alt-text="Final basic configuration":::

When finished, click the __Next: Node pools__ button to configure the next settings:

## Configure Node Pools

In this next screen you'll be presented with the configuration of the Node Pools, which were explained in the conceptual part of this exercise. But, as a reminder, _Node Pools_ are a way to have multiple node types within the same cluster.

Click the __Next: Authentication__ button to continue:

## Define authentication settings

The __Authentication__ tab is where you set up everything related to user credentials and the Kubernetes integration with Azure services via Service Principal, which is basically a service account that you can give different scopes, think of service principals as passes, that allow your cluster to communicate to Azure services.

For now, leave all settings as they are.

Click the __Next: Networking__ button to go on to the next step

## Creating a network

The __Networking__ tab is the place where you'll configure how your cluster will behave to the world and how it will manager the internal traffic from its pods and workloads.

1. Configure basic network information

    The Network tab has two different types of configuration:

    - The _basic_ configuration, in which all IP addresses and subnets are automatically configured, and
    - The _advanced_ mode, where you need to set up all the address ranges and subnets. For now, let's keep on the basic.

    Next up, you can choose a __DNS name__, this is what is going to identify your cluster's ingress rules and external DNS records.

    Leave the __private cluster__ and __network policy__ configuration as it is.

1. Configure application routing

    Lastly you'll enable the `HTTP Application Routing` configuration, explained in the conceptual part of this exercise. Read more about it in the official docs.

    :::image type="content" source="../media/3-network-settings.png" alt-text="Network tab":::

## Finish

Once all is done, click the __Review + Create__ button and wait a few seconds while Azure validates your deployment, once the __Create__ blue button appears, click it, then wait a few minutes for the deployment to finish.

When it finishes, you should see a notification with a button named __Go to Resource__. Click it and Azure will take you to the newly created cluster.

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

## Creating an AKS Cluster

The first action you need to take in order to create your cluster is to provide it within Azure. Providing an AKS cluster in Azure is simple and intuitive and can be done in one of two ways: Either by the Azure Portal via Browser, or via Azure CLI.

#### [Browser](#tab/browser/)

1. First of all access the [Azure Portal](https://portal.azure.com):

:::image type="content" source="../media/3-access-azure-portal.png" alt-text="Azure Portal":::

Once in the portal you'll have three options to create a new AKS cluster:

__Option 1:__ AKS already in home screen

If your Azure Portal already shows "Kubernetes Services" in the home screen, under "Azure Services", just click it.

:::image type="content" source="../media/3-option-azure-services.png" alt-text="Azure Portal: AKS on Home Screen":::

__Option 2:__ Search box

You can also press `G+/` or click the top search box and search for `kubernetes`, then click "Kubernetes Services" right in the search results.

:::image type="content" source="../media/3-option-search-box.png" alt-text="Azure Portal: AKS on search bar":::

__Option 3:__ "Create a resource" button

You can also click the "Create a resource" button in the home screen to be taken to the product selection screen.

:::image type="content" source="../media/3-option-add-new.png" alt-text="Azure Portal: AKS on Add New":::

Then you can search or, if it's present, click the "Kubernetes Service" button right at the bottom right of your screen

:::image type="content" source="../media/3-search-aks.png" alt-text="Azure Portal: AKS on search bar":::

2. Fill the creation form

Despite there are different ways to access the Kubernetes Service, all of those options should bring you to the AKS Creation Form below:

:::image type="content" source="../media/3-aks-creation-screen.png" alt-text="Azure Portal: AKS on add New":::

In this screen you'll notice there are several tabs at the top. Each one of them provides a different setting you may want to set up. Let's start with the `Basics` tab. Here you can set all the primary required information for your cluster, each field play an important role when creating the cluster, below there's a simple explanation of each one:

**Resource Group:** Resources in Azure are grouped into _[Resource Groups](https://docs.microsoft.com/azure/azure-resource-manager/management/manage-resource-groups-portal?WT.mc_id=learndeploycontainerappsaks-learn-ludossan#what-is-a-resource-group)_, which alow to group similar resources into one place. In order to create an AKS cluster, it's necessary to create its resource group or select an existing one.

You can create a resource group by clicking the link `Create new`, just below the `Resource Group` select:

:::image type="content" source="../media/3-create-resource-group.png" alt-text="Create a resource group":::

**Kubernetes Cluster Name:** This is the main name for your Kubernetes cluster. It's important to define it well, you won't be able to change it later and this will be the name which all of your resources will use to refer to this cluster in the future:

**Region:** Azure is a global infrastructure provider, which means it has several [regions](https://azure.microsoft.com/global-infrastructure/regions/?WT.mc_id=learndeploycontainerappsaks-learn-ludossan) to offer the services. When choosing a region, be aware of the cost changes and also the physical location. Generally, for production clusters you'd have all the resources set up in the nearest region from you.

**Kubernetes Version:** Since Kubernetes is an Open-Source Project, it's constantly evolving. Therefore, it's versions bear differences between each other, the best practice is to use the `default` version for most of the common scenarios.

**Node Size:** Nodes are [Azure VMs](https://azure.microsoft.com/services/virtual-machines/?WT.mc_id=learndeploycontainerappsaks-learn-ludossan), this means you can change their size to match your usage pattern. For this module you'll start with a `B2s` VM since the company only requires a low usage.

:::image type="content" source="../media/3-node-size.png" alt-text="Change node size via Portal":::

**Node count:** Kubernetes is a cluster composed of a `master` node and several `worker` nodes. The `Node Count` is the amount of worker nodes your cluster will have. For production clusters the best practice is to set this property to an odd number to avoid distribution issues.

You can change this later in the cluster's configuration panel. It's also a best practice to keep this number as low as possible to avoid unnecessary costs and unused compute power.

The final configuration will be like this:

:::image type="content" source="../media/3-final-basic-config.png" alt-text="Final basic configuration":::

3. Configure Node Pools

When finished, click the `Next: Node pools >` button to configure the next settings:

:::image type="content" source="../media/3-next-node-pools.png" alt-text="Finish basic configuration":::

In this next screen you'll be presented with the configuration of the Node Pools, which were explained in the conceptual part of this exercise. But, as a reminder, _Node Pools_ are a way to have multiple node types within the same cluster.

For this module, you'll leave the setting as it is:

:::image type="content" source="../media/3-step-node-pools.png" alt-text="Setting up node pools":::

4. Define authentication settings

Click the `Next: Authentication >` button to proceed:

:::image type="content" source="../media/3-authentication-button.png" alt-text="Proceed to next step":::

The `Authentication` tab is where you set up everything related to user credentials and the Kubernetes integration with Azure services via [Service Principal](https://docs.microsoft.com/cli/azure/create-an-azure-service-principal-azure-cli?WT.mc_id=learndeploycontainerappsaks-learn-ludossan#create-a-service-principal). Leave all settings as they are.

5. Creating a network

Click the `Next: Networking >` button to go on to the next step:

:::image type="content" source="../media/3-step-auth.png" alt-text="Authentication configuration":::

The __Networking__ tab is the place where you'll configure how your cluster will behave to the world and how it'll manager the internal traffic from its pods and workloads.

The Network tab has two different types of configuration, the _basic_ configuration, in which all IP addresses and subnets are automatically configured, and the _advanced_ mode, where you'll have to configure all the address ranges and subnets. For now let's keep on the basic.

Next up, you can choose a __DNS name__, this is what is going to identify your cluster's ingress rules and external DNS records.

__Private clusters__ allow you to keep your Kubernetes API internal only. This means no one outside your cluster will be able to access it, learn more [in the docs](https://docs.microsoft.com/azure/aks/private-clusters?WT.mc_id=learndeploycontainerappsaks-learn-ludossan).

__Network Policies__ allow you to customize how your cluster's data will flow between all the workloads. By default, all internal communications are allowed. However, it's possible to define the cluster to use _Calico_ resource policy when using the _basic_ configurations, while the _Azure_ network policy needs you to switch to an _advanced_ configuration.

> [!TIP]
> Read more about __network policies__ [in the docs](https://docs.microsoft.com/azure/aks/use-network-policies?WT.mc_id=learndeploycontainerappsaks-learn-ludossan) or in [The Azure Friday Series, in Channel 9](https://azure.microsoft.com/resources/videos/azure-friday-secure-traffic-between-pods-using-network-policies-in-azure-kubernetes-service-aks/?WT.mc_id=learndeploycontainerappsaks-learn-ludossan)

Lastly you'll enable the `HTTP Application Routing` configuration, explained in the conceptual part of this exercise. Read more about it [in the docs](https://docs.microsoft.com/azure/aks/http-application-routing?WT.mc_id=learndeploycontainerappsaks-learn-ludossan)

:::image type="content" source="../media/3-network-settings.png" alt-text="Network tab":::

Once all is done, click the `Review + Create` button:

:::image type="content" source="../media/3-network-finish.png" alt-text="Finish network settings":::

#### [Bash](#tab/bash/)

shell content

---

Linking with powershell/bash/zsh through AZCLI

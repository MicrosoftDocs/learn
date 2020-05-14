## Create a new resource

The first action you need to take in order to create your cluster is to provide it within Azure. Providing an AKS cluster in Azure is simple and intuitive and can be done in one of two ways: Either by the Azure Portal via Browser, or via Azure CLI.

:::zone pivot="portal"

First of all access the [Azure Portal](https://portal.azure.com):

Once in the portal you'll be able to create your new AKS cluster:

Press `G+/` or click the top search box and search for `kubernetes`, then click "Kubernetes Services" right in the search results.

:::image type="content" source="../media/3-option-search-box.png" alt-text="Azure Portal: AKS on search bar":::

## Fill in the basic information

1. Fill in cluster information

    In this screen you'll notice there are several tabs at the top. Each one of them provides a different setting you may want to set up. Let's start with the `Basics` tab. You should fill this information:

    - __Resource Group__: Create a new resource group with any name you want, for instance: `contoso-aks`
    - __Kubernetes Cluster Name__: This represents the name of your cluster, let's use `contoso-kubernetes-cluster`
    - __Region__: Select `East US`
    - __Kubernetes Version__: Leave it at the `(default)` value

1. Fill in Node Pool information

    After the basic information about the cluster itself, we need to change the __Node Pool__ information, we'll not change the __Node Count__ value, only the __Node Size__.

    Nodes are [Azure VMs](https://azure.microsoft.com/services/virtual-machines/?WT.mc_id=learndeploycontainerappsaks-learn-ludossan), this means you can change their size to match your usage pattern. For this module you'll start with a `B2s` VM since the company only requires a low usage. You can update it by clicking on the __Change Size__ link.

    :::image type="content" source="../media/3-node-size.png" alt-text="Change node size via Portal":::

The final configuration will be similar to this:

:::image type="content" source="../media/3-final-basic-config.png" alt-text="Final basic configuration":::

When finished, click the __Next: Node pools__ button to configure the next settings:

## Configure Node Pools

In this next screen you'll be presented with the configuration of the Node Pools, which were explained in the conceptual part of this exercise. But, as a reminder, _Node Pools_ are a way to have multiple node types within the same cluster.

Click the __Next: Authentication__ button to proceed:

## Define authentication settings

The __Authentication__ tab is where you set up everything related to user credentials and the Kubernetes integration with Azure services via [Service Principal](https://docs.microsoft.com/cli/azure/create-an-azure-service-principal-azure-cli?WT.mc_id=learndeploycontainerappsaks-learn-ludossan#create-a-service-principal). Leave all settings as they are.

Click the __Next: Networking__ button to go on to the next step

## Creating a network

The __Networking__ tab is the place where you'll configure how your cluster will behave to the world and how it'll manager the internal traffic from its pods and workloads.

1. Configure basic network information

    The Network tab has two different types of configuration, the _basic_ configuration, in which all IP addresses and subnets are automatically configured, and the _advanced_ mode, where you'll have to configure all the address ranges and subnets. For now let's keep on the basic.

    Next up, you can choose a __DNS name__, this is what is going to identify your cluster's ingress rules and external DNS records.

    Leave the __private cluster__ and __network policy__ configuration as it is.

1. Configure application routing

    Lastly you'll enable the `HTTP Application Routing` configuration, explained in the conceptual part of this exercise. Read more about it [in the docs](https://docs.microsoft.com/azure/aks/http-application-routing?WT.mc_id=learndeploycontainerappsaks-learn-ludossan)

    :::image type="content" source="../media/3-network-settings.png" alt-text="Network tab":::

### Finish

Once all is done, click the __Review + Create__ button and wait a few seconds while Azure validates your deployment, once the __Create__ blue button appears, click it, then wait a few minutes for the deployment to finish.

When it finishes, you should see a notification with a button named __Go to Resource__. Click it and Azure will take you to the newly-created cluster.

:::image type="content" source="../media/3-finished.png" alt-text="Finished creation":::

:::zone-end

:::zone pivot="bash"
    shell content
:::zone-end

:::zone pivot="powershell"
    powershell content
:::zone-end

Linking with powershell/bash/zsh through AZCLI

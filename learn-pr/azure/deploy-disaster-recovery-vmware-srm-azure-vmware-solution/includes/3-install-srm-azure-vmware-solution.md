Now that you know what VMware SRM is and what it can do, let's learn how to set it up and how it works on Azure.

## Architecture for enabling protection of primary Azure VMware Solution to secondary

The following diagram illustrates the overall architecture of the solution:

:::image type="content"  source="../media/3-azure-vmware-solution-architecture.png" alt-text="Diagram depicting the architecture for enabling protection of primary Azure VMware Solution to secondary.":::

The solution architecture depicts the following configuration:

- ExpressRoute Global Reach connects circuits directly at the Microsoft Enterprise Edge (MSEE).

- MSEE represents the edge routers on the Microsoft side of the ExpressRoute circuit.

- Primary Azure VMware Solution is deployed in the primary region.

- Secondary Azure VMware Solution is deployed in the secondary region.  

## Deployment workflow for Azure VMware Solution

To deploy Azure VMware Solution in your test environment, you must perform the following steps:

1. Ensure that your subscription is enabled for Azure VMware Solution. Register Microsoft.AVS provider to create a private cloud. You can run that configuration either from the Azure portal or from Azure CLI by using the following command:

    ``` azure cli
    az provider register -n Microsoft.AVS --subscription <your subscription ID>
    ```

1. Use the following procedure to create Azure VMware Solution using Azure CLI:

    ``` azure cli
    az group create --name myResourceGroup --location eastus

    az vmware private-cloud create -g myResourceGroup -n myPrivateCloudName --location eastus --cluster-size 3 --network-block xx.xx.xx.xx/22 --sku AV36
    ```

### Connect to Azure Virtual Network with ExpressRoute

Now that you know how to deploy Azure VMware Solution private cloud, you need to establish a connection with an existing Azure resource by using an Azure Virtual Network and an ExpressRoute circuit. You also need to create an ExpressRoute virtual network gateway to connect with the Azure VMware Solution private cloud.

Use the following steps to connect to Azure Virtual Network with ExpressRoute:

> [!NOTE]
> These steps create a new virtual network, a gateway subnet, and an ExpressRoute virtual network gateway, and then connect the ExpressRoute to the virtual network gateway. You can also use existing virtual network provisioned with an existing ExpressRoute virtual network gateway.

1. Sign in to the [Azure portal](https://portal.azure.com).
2. Navigate to your subscription, then search for and select **Azure VMware Solution**.
3. In the **Manage** section, select **Connectivity**.
4. On the **AzurevNet connect** tab, select the **Create new** link to create a new virtual network, gateway subnet, and ExpressRoute virtual network gateway.

:::image type="content"  source="../media/3-create-virtual-network.png" alt-text="Screenshot of the Create virtual network tab in Azure VMware Solution.":::

### Set up ExpressRoute Global Reach

You need to connect both the primary and secondary Azure VMware Solution private clouds using ExpressRoute Global Reach.

With ExpressRoute Global Reach, you can link both the Azure VMware Solution sites and enable communication, which is necessary for disaster recovery. Both, primary and secondary Azure VMware Solution private clouds require that you provision the ExpressRoute circuit. With ExpressRoute Global Reach, you can make a private network between the primary and secondary Azure VMware Solution site.

You can use the following steps to deploy ExpressRoute Global Reach.

1. Sign in to the [Azure portal](https://portal.azure.com).
1. Navigate to your subscription and then search for and select **Azure VMware Solution**.
1. In the **Manage** section, select **Connectivity**.
1. On the **ExpressRoute Global Reach** tab, in the **On-prem cloud connections** section, select **+ Add**.
1. In the **On-prem cloud connections** window, provide information for circuit ID and Authorization key, and then select **Create**.

    :::image type="content"  source="../media/3-on-prem-cloud-connections.png" alt-text="Screenshot of the On-prem cloud connections window in Azure VMware Solution.":::

1. Verify that the **State** of the connection displays the status as **Connected**.

### Deploy Site Recovery Manager on Azure VMware Solution

After you prepare all requirements for setting up disaster recovery for your Azure VMware Solution private cloud, you should proceed with the installation on VMware SRM in Azure VMware Solution.

You can use the following steps to deploy VMware SRM:

1. Log in to the Azure portal.
1. Navigate to your subscription and search for **Azure VMware Solution**.
1. In the **Manage** section, select **Add-ons**.
1. On the navigation pane, under **Disaster Recovery**, select **Get Started**.
1. On the drop-down menu, select **VMware Site Recovery Manager (SRM) - vSphere replication** as a disaster recovery solution.
1. Provide a license key or select to use an evaluation version.
1. Accept the terms and conditions, and then select **Install**.

    :::image type="content"  source="../media/3-neavs-add-ons.png" alt-text="Screenshot of the Disaster recovery tab in Azure VMware Solution.":::

Ensure that both the primary and secondary Azure VMware Solution private clouds have provisioned VMware SRM.

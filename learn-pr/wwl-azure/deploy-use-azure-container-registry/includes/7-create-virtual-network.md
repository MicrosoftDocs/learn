Use this Try-This exercise to gain some hands-on experience with Azure Kubernetes Service.

This exercise shows you how to create a virtual network by using the Azure portal. A virtual network is the basis for private networks in Azure. Azure Virtual Network enables Azure resources like VMs to securely communicate with each other and the internet.

:::image type="content" source="../media/virtual-network-overview-111535e7.png" alt-text="Diagram showing how to create a virtual network.":::


> [!NOTE]
> To complete this exercise you'll need an [Azure Subscripton](https://azure.microsoft.com/free/).

## Sign in to Azure

Sign in to the [Azure portal](https://portal.azure.com/) with your Azure account.

## Create a virtual network

The following procedure creates a virtual network with a resource subnet.

1.  In the portal, search for and select **Virtual networks**.
2.  On the **Virtual networks** page, select **Create**.
3.  On the **Basics** tab of **Create virtual network**, enter or select the following information:
    
    | **Setting**          | **Value**                                                          |
    | -------------------- | ------------------------------------------------------------------ |
    | **Project details**  |                                                                    |
    | Subscription         | Select your subscription.                                          |
    | Resource group       | Select **Create new**.<br>Enter **RG\_AKS** in Name.Select **OK**. |
    | **Instance details** |                                                                    |
    | Name                 | Enter **VNet1**.                                                   |
    | Region               | Select **West US**.                                                |
    
    :::image type="content" source="../media/new-virtual-network-second-890aff28.png" alt-text="Diagram showing how to create a basic virtual network.":::
    
4.  Select **Next** and accept the default settings for the **Security** tab. Select **Next** at the bottom of the page.
5.  In the **IP Addresses** tab, under **IPv4 address space**, accept the default for **10.0.0.0/16**.
6.  Select **+ Add subnet**.
7.  Enter or select the following information in **Add subnet**:
    
    | **Setting**          | **Value**              |
    | -------------------- | ---------------------- |
    | Subnet name          | Enter **subnet1**.     |
    | Subnet address range | Enter **10.0.0.0/24**. |
    
    :::image type="content" source="../media/add-subnet-virtual-network-6d341dbd.png" alt-text="Diagram showing how to add a subnet.":::
    
8.  Select **Next**.
9.  Select **Review + create** at the bottom of the screen, and when validation passes, select **Create**.

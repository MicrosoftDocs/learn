While your company strives to provide sufficient levels of isolation between its customers, it’s also trying to integrate its own existing virtual local area network (VLAN)-based infrastructure with Azure Stack HCI deployments. Your intention is to identify a solution that would allow for implementing such integration by using the same technologies with which your internal Network team is already familiar. In a search for the solution, you decide to evaluate the use of Azure Stack HCI SDN logical networks. 

> [!NOTE]
> In the context of Azure Stack HCI networking, a *customer* or a *tenant* is defined as the owner of a set of IP subnets that are deployed in an enterprise or a datacenter. A customer can be a corporation or an enterprise with multiple departments or business units in a private datacenter that require network isolation. It could also be a tenant in a public datacenter that’s hosted by a service provider.

## Describe Azure Stack HCI tenant logical networks

Azure Stack HCI gives you the option to virtualize its network resources by implementing SDN virtual networks, then using them to isolate the virtualized workloads. At the same time, you can also implement networking by using SDN logical networks. This process doesn’t depend on the overlay network model, but instead uses the traditional VLAN-based technology. In this way, it facilitates an integration with your existing environment.

By modeling a VLAN-based network as an SDN logical network, you can apply network policies to workloads that are attached to these networks. For example, you can use the SDN distributed firewall to apply security access control lists (ACLs) to workloads that are attached to SDN logical networks. Applying the ACLs helps protect your VLAN-based workloads from both external and internal attacks. This is complimentary to existing hardware or software firewalls.

> [!NOTE]
> If the logical networks use VLANs, the physical compute host must connect to a trunked switch port that has access to the VLANs. The physical network adapters on the cluster nodes must not have any VLAN filtering activated.

## Create Azure Stack HCI tenant logical networks

The simplest method to create an Azure Stack HCI tenant logical network is to use Windows Admin Center, and involves the following sequence of steps:

1. In Windows Admin Center, connect to the Azure Stack HCI cluster.
1. In the **Tools** pane, in the **Networking** section, select **Logical networks**.
1. On the **Logical networks** page, select the **Inventory** tab, and then select **New**.
1. In the **Logical networks** pane, enter a name for the logical network.
1. In the **Logical subnet** section, select **Add**.
1. In the **Logical subnet** pane, perform the following tasks:
    1. Enter a **Logical subnet name**.
    1. Enter a **VLAN ID**.
    1. Enter an **Address Prefix** in the Classless Interdomain Routing (CIDR) notation.
    1. Enter the **Default Gateway**.
    1. As an option, enter the IP address of the **DNS** server.
    1. Select the **Public logical network** checkbox if the logical network will provide connectivity for external clients.
    1. For public logical networks, use the **+Add** link to add **Logical subnet IP Pools**, and specify the following information:
      - IP Pool Name
      - A Start IP address
      - An End IP address 
1. Back in the **Logical Subnet** pane, select **Add**.
1. Back in the **Logical networks** pane, select **Submit**.

:::image type="content" source="../media/2-create-logical-network.png" alt-text="Screenshot of the logical networks pane in Windows Admin Center when creating an Azure Stack H C I tenant logical network." border="false" lightbox="../media/2-create-logical-network.png":::

## Configure Azure Stack HCI tenant logical networks

Some common Azure Stack HCI tenant logical network configuration tasks involve adding and deleting subnets, and modifying existing subnet settings. However, you can also change the virtualization settings of a logical network.

Use the following procedure to modify the settings of a subnet:

1. In Windows Admin Center, connect to the Azure Stack HCI cluster.
1. In the **Tools** pane, in the **Networking** section, select **Logical networks**.
1. On the **Logical networks** page, select the **Inventory** tab, and then select the logical network you intend to configure.
1. In the pane of the logical network you selected, in the **Logical subnet** section, select **Settings**.
1. In the **Settings** pane, modify the settings, and then select **Save**.

To change the virtualization settings of a logical network:

1. In Windows Admin Center, connect to the Azure Stack HCI cluster.
1. In the **Tools** pane, in the **Networking** section, select **Logical networks**.
1. On the **Logical networks** page, select the **Inventory** tab, select the logical network for which you intend to change the virtualization settings, and then select **Settings**.
1. In the settings pane of the logical network you selected, select the **Enable network virtualization** checkbox, and then select **Submit**.

> [!NOTE]
> This effectively allows you to deploy a virtual network on top of the virtual network.

:::image type="content" source="../media/2-enable-network-virtualization.png" alt-text="Screenshot of the logical networks pane in Windows Admin Center depicting modifications to the settings for the selected network." border="false" lightbox="../media/2-enable-network-virtualization.png":::

## Delete Azure Stack HCI tenant logical networks

Using Windows Admin Center also simplifies deleting Azure Stack HCI tenant logical networks, reducing it to the following sequence of steps:

1. In Windows Admin Center, connect to the Azure Stack HCI cluster.
1. In the **Tools** pane, in the **Networking** section, select **Logical networks**.
1. On the **Logical networks** page, select the **Inventory** tab, select the logical network you intend to delete, and then select **Delete**.
1. When prompted for confirmation, select **Yes**.

:::image type="content" source="../media/2-delete-logical-network.png" alt-text="Screenshot of the logical networks pane in Windows Admin Center. A dialog box requests confirmation for deleting a tenant logical network." border="false" lightbox="../media/2-delete-logical-network.png":::

The diagram shows routing traffic from on-premises to an Azure NetApp Files volume in a Virtual WAN spoke VNet via a Virtual WAN hub with a VPN gateway and an Azure firewall deployed inside the virtual hub.

:::image type="content" source="../media/azure-firewall-routing-diagram.png" alt-text="Diagram that shows routing traffic from on-premises to an Azure NetApp Files volume through a Virtual WAN hub and Azure Firewall." border="true" lightbox="../media/azure-firewall-routing-diagram.png":::

- To learn how to install an Azure Firewall in a Virtual WAN hub, refer [Configure Azure Firewall in a Virtual WAN hub](https://learn.microsoft.com/azure/virtual-wan/howto-firewall).

- To force different traffic flows via the Azure Firewall installed in the hub, see [How to configure Virtual WAN Hub routing intent and routing policies](https://learn.microsoft.com/azure/virtual-wan/how-to-routing-policies).

- To force the Azure NetApp Files-bound traffic through Azure Firewall in the Virtual WAN hub, the effective routes of the virtual hub should have the specific IP address of the Azure NetApp Files volume pointing to the Azure Firewall.

The following image of the Azure portal shows an example virtual hub of effective routes. In the first item, the IP address is listed as 10.2.0.5/32. The static routing entry's destination prefix is IP-Azure NetApp Files-Volume/32, and the next hop is Azure-Firewall-in-hub. Origin points to the resource ID of the originating VPN gateway/Route table/Connection. AS Path indicates the AS Path for the branch.

:::image type="content" source="../media/virtual-hub-effective-routes.png" alt-text="Screenshot of virtual hub effective routes showing an Azure NetApp Files volume IP route through Azure Firewall." border="true" lightbox="../media/virtual-hub-effective-routes.png":::

### List Azure NetApp Files volume IP under virtual hub effective routes

To identify the private IP address associated with your Azure NetApp Files volume:

1. Navigate to the **Volumes** in your Azure NetApp Files subscription.
2. Identify the volume you're looking for. The private IP address associated with an Azure NetApp Files volume is listed as part of the mount path of the volume.

    :::image type="content" source="../media/volume-mount-path-ip.png" alt-text="Screenshot of an Azure NetApp Files volume showing the private IP address in the mount path." border="true" lightbox="../media/volume-mount-path-ip.png":::

#### Edit virtual hub effective routes

You can effect changes to a virtual hub's effective routes by adding routes explicitly to the virtual hub's route table.

1. In the virtual hub, navigate to **Route Tables**.
2. Select the route table you want to edit.

    :::image type="content" source="../media/virtual-hub-route-table.png" alt-text="Screenshot of a virtual hub route tables page showing default route table selected." border="true" lightbox="../media/virtual-hub-route-table.png":::

3. Choose a **Route name** then add the **Destination prefix** and **Next hop**.

    :::image type="content" source="../media/edit-route-table.png" alt-text="Screenshot of adding a route name, destination prefix, and next hop to a virtual hub route table." border="true" lightbox="../media/edit-route-table.png":::

4. Save your changes.

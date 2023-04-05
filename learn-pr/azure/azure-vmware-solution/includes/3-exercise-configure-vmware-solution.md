Use the following process to complete Contoso's Azure VMware Solution configuration.
1. Navigate to your Azure VMware Solution private cloud in Azure portal and select the "Internet Connectivity" menu. Select the "Don't connect or connect using default route from Azure" option.

   :::image type="content" source="../media/3-internet-connectivity.png" alt-text="Screenshot of Azure portal menu. The menu entry titled 'Don't connect or connect using the default route from Azure' is highlighted." lightbox="../media/3-internet-connectivity.png" lightbox="../media/3-internet-connectivity.png":::

1. Create an NSX-T Manager network segment in the Azure portal.

   :::image type="content" source="../media/3-network-segment.png" alt-text="Screenshot of the Azure portal showing how to add an NSX-T Manager network segment.":::

1. Create a DHCP server or DHCP relay in the Azure portal.

   :::image type="content" source="../media/3-dhcp.png" alt-text="Screenshot of the Azure portal showing how to add either a DHCP server or a DHCP relay into the AVS private cloud.":::

1. Configure a DNS forwarder in the Azure portal.

   :::image type="content" source="../media/3-dns-forwarder.png" alt-text="Screenshot of the Azure portal showing where to configure DNS zones under Workload Networking.":::

1. Deploy the VM as you would in any vSphere environment.
1. Log on to the VM created above and ensure that the VM doesn't have any internet connectivity.

You've now ensured that Azure VMware Solution private cloud is configured correctly. This allows you to build the foundation for securing outbound internet connectivity as discussed in following unit.

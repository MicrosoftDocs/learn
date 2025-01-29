Use the following process to complete Contoso's Azure VMware Solution configuration.

1. Navigate to your Azure VMware Solution private cloud in Azure portal and select the **Internet connectivity** menu. Select option, **Do not connect or connect using default route from Azure** which is the default setting when the Azure VMware Solution private cloud is initially deployed.

   :::image type="content" source="../media/3-internet-connectivity-selected.png" alt-text="Screenshot of Azure portal menu showing the entry titled, 'Do not connect or connect using the default route from Azure' is selected." lightbox="../media/3-internet-connectivity-selected.png":::

1. Create an NSX Manager network segment in the Azure portal.

   :::image type="content" source="../media/3-create-nsx-manager-network-segments.png" alt-text="Screenshot of the Azure portal showing how to add an NSX Manager network segment."lightbox="../media/3-create-nsx-manager-network-segments.png":::

1. Create a DHCP server or DHCP relay in the Azure portal.

   :::image type="content" source="../media/3-dhcp.png" alt-text="Screenshot of the Azure portal showing how to add either a DHCP server or a DHCP relay into the AVS private cloud.":::

1. Configure a DNS forwarder in the Azure portal.

   :::image type="content" source="../media/3-configure-dns-forwarder.png" alt-text="Screenshot of the Azure portal showing where to configure DNS zones under Workload Networking."lightbox="../media/3-configure-dns-forwarder.png":::

1. Deploy the VM as you would in any VMware vSphere environment.
1. Sign in to the VM you created and verify the VM doesn't have internet connectivity.

You've ensured that Azure VMware Solution private cloud is configured correctly. This allows you to build the foundation for securing outbound internet connectivity as discussed in the following unit.

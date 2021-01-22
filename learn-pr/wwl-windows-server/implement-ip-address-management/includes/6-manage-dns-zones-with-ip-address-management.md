Contoso can use IPAM to manage DNS servers and zones for all servers that the IPAM server manages. During discovery, IPAM discovers all DNS servers in the domains that were specified. 

## Perform DNS management

:::image type="content" source="../media/m14-ipam-3.png" alt-text="A screenshot of the IPAM console. The administrator has selected the DNS Zones tab. In the Details pane, the Contoso.com zone is selected.":::

You can use IPAM to perform the following DNS management tasks:

- Examine DNS servers and zones. You can examine all managed DNS servers, in addition to the forward lookup zones and the reverse lookup zones on those DNS servers. Zone status and health is available for forward lookup zones, but not for reverse lookup zones.
- Create new zones. To create DNS zones, on the navigation pane, select the **DNS and DHCP Servers** node. Right-click or access the context menu for the DNS server to which you want to add a zone, and then select **Create DNS zone**.
- Create DNS records. You can create DNS records for any zone that IPAM manages. To do this, perform the following steps:

  1. On the IPAM navigation pane, select **DNS Zones**, and then select the appropriate zone, for example, `contoso.com`.
  1. Right-click or access the context menu for the zone, and then select **Add DNS resource record**.
  1. Verify that the correct DNS zone name and DNS server name display in the list, and then add a new DNS resource record. For example, select **Resource record type A**, and then add the required information: name, FQDN, and IP address.

- Manage conditional forwarders. 
  - To add a conditional forwarder, on the navigation pane, select the **DNS and DHCP Servers** node. Right-click or access the context menu for the DNS server to which you want to add a zone, and then select **Create DNS conditional forwarder**.
  - To manage a conditional forwarder after you create it, on the navigation pane, under DNS Zones, select **Conditional Forwarders**. You can then manage the conditional forwarding settings in the **details** pane.
- Open the DNS console for any server that IPAM manages. You can open the **Microsoft Management Console (MMC)** for DNS by right-clicking or accessing the context menu for a server on the DNS and DHCP servers page, and then selecting **Launch MMC**.
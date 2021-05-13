Contoso IT administrators can configure DHCP servers and DHCP scope information by using the IPAM administration interface. IPAM enables them to configure multiple DHCP servers and to use functionality such as DHCP Failover so that the servers work together in their DHCP implementation.

:::image type="content" source="../media/m14-ipam-4.png" alt-text="A screenshot of the IPAM console. The administrator has selected the DHCP Scopes tab. In the details pane, the Contoso scope is selected.":::

## Configure DHCP servers

You typically perform DHCP configuration for individual servers from the DNS and DHCP servers page. You can perform several configuration tasks on a DHCP server from within the IPAM administration console:

- Examine DHCP scope information across all servers.
- Edit DHCP server properties. You can edit server properties such as DHCP audit logging, DNS dynamic update configuration, and media access control (MAC) address filtering.
- Edit DHCP server options. You can configure and create DHCP server options based on vendor or user classes.
- Configure DHCP vendor or user classes. You can examine and modify user and vendor classes.
- Configure DHCP policy. You can edit DHCP policy properties and conditions.
- Import DHCP policy. You can import DHCP policies by using files that other DHCP servers export.
- Add DHCP MAC address filters. You can add DHCP MAC address filters to allow or deny DHCP address assignments based on MAC addresses.
- Activate and deactivate DHCP policies. You can control the implementation of DHCP policies.
- Replicate DHCP servers. This option replicates the configuration of failover scopes on a server to failover partner servers.
- Launch the DHCP console. You can open the **DHCP** console for the selected server.

## Configure DHCP scopes

You can configure DHCP scope details in IPAM by performing the following tasks:

1. Edit the DHCP scope properties.
1. Duplicate a DHCP scope. Use a DHCP scope as a template for creating a new scope on the same server or on a different server.
1. Create a DHCP reservation.
1. Add to a DHCP superscope.
1. Configure a DHCP Failover.
1. Import a DHCP policy.
1. Activate and deactivate DHCP scopes.
1. Activate and deactivate DHCP policies for the selected scope.
1. Replicate a DHCP scope.
1. Remove a DHCP Failover configuration.
1. Remove a scope from a DHCP superscope.

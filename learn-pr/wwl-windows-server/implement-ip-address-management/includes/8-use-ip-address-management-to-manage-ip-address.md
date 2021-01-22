Contoso IT administrators can use IPAM to manage, track, audit, and report Contoso's IPv4 and IPv6 address spaces. The IPAM IP ADDRESS SPACE node provides them with IP address utilization statistics and historical trend data so that they can make informed planning decisions for dynamic, static, and virtual address spaces. 

:::image type="content" source="../media/m14-ipam-5.png" alt-text="A screenshot of the IPAM IP address space pane in Server Manager. The administrator has selected the IP Address Blocks tab for IPv4. In the details pane, the network 172.16.0.0/16 subnet is selected.":::

IPAM automatically discovers address spaces and utilization data from the DHCP servers that IPAM manages. Contoso can also import IP address information from CSV files. Administrators can use IPAM to detect overlapping IP address ranges that are defined on different DHCP servers. They can use this information to:

- Find free IP addresses within a range.
- Create DHCP reservations.
- Create DNS records.

## Manage IP addressing with views

You can customize the available components of the IP address space in the IPAM Administration Console by using any of the following views.

|View|Description|
|-----------------------|------------------------------------------------------------|
|IP address blocks|*IP address blocks* are the highest-level entities within an IP address space organization. An IP address block is an IP subnet marked by a start IP address and an end IP address. You can use IP address blocks to create and allocate IP address ranges to DHCP. You can add, import, edit, and delete IP address blocks. IPAM maps IP address ranges to the appropriate IP address block automatically based on the boundaries of the range.|
|IP address ranges|*IP address ranges* are the next hierarchical level of IP address space entities after IP address blocks. An IP address range is an IP subnet that's marked by a start IP address and an end IP address. IP address ranges typically correspond to a DHCP scope, a static IPv4 or IPv6 address range, or to an address pool that's used to assign addresses to hosts.|
|IP addresses|*IP addresses* are the addresses that make up the IP address range. IPAM enables end-to-end lifecycle management of IPv4 and IPv6 addresses, including record syncing with DHCP and DNS servers. IPAM maps an address to the appropriate range automatically based on the starting and ending address of the IP address range.|
|IP address inventory|The **IP Address Inventory** view lists of all IP addresses in the enterprise along with their device names and types. IP address inventory is a logical group within the **IP addresses** view. You can use this group to customize the way the address space displays for managing and tracking IP usage.|
|IP address range groups|Using IPAM, you can organize IP address ranges  into logical groups called *IP address range groups*. For example, you might organize IP address ranges geographically or by business division. You define logical groups by selecting the grouping criteria from built-in or user-defined custom fields.|

## Monitor DHCP and DNS servers

IPAM enables automated, periodic service monitoring of DHCP and DNS servers across a single forest or across multiple forests. In **Server Manager**, in the IPAM node, monitoring and management of DHCP and DNS servers is organized into the views listed in the following table.

|View|Description|
|--------------------|------------------------------------------------------------|
|DNS and DHCP servers|By default, managed DHCP and DNS servers are arranged by their network interface in /32 subnets for IPv4 and /128 subnets for IPv6. You can select the view so that it displays only DHCP scope properties, only DNS server properties, or both.|
|DHCP scopes|This view enables scope utilization monitoring. Utilization statistics are automatically collected periodically from a managed DHCP server. You can track important scope properties such as Name, ID, Prefix Length, and Status.|
|DNS zone monitoring|You enable zone monitoring for forward lookup zones. Zone status is based on events that IPAM collects. The status of each zone is summarized.|
|Server groups|You can organize managed DHCP and DNS servers into logical groups. For example, you might organize servers by business unit or geography. You define groups by selecting the grouping criteria from built-in or user-defined fields.|
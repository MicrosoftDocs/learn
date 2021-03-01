A DHCP scope is a range of IP addresses that are available for lease and that a DHCP server manages. Typically, a DHCP scope is confined to the IP addresses in a given subnet.

For example, if Contoso IT staff created a DHCP scope for the network 192.168.1.0/24, it could support a range from 192.168.1.1 through 192.168.1.254. When a computer or device on the 192.168.1.0/24 subnet requests an IP address, the scope that defined the range in this example allocates an address between 192.168.1.1 and 192.168.1.254.

Although it's not typical, a DHCP server can host scopes for multiple different subnets, in which case DHCP relay agents distribute those addresses to clients on other subnets.

> [!NOTE]
> A DHCP relay agent is an RFC 1542 compliant device that forwards DHCP broadcast traffic to other subnets that hosts a DHCP server.

> [!TIP]
> You can implement DHCP relay by using a Windows Server installed with Routing and Remote Access.

You do not need to assign all IP addresses in a given subnet to the scope. Usually, some IP addresses are excluded from the scope so that they are available for assignment as static addresses. For example, the first 20 addresses of the scope might be excluded and then statically assigned to routers, printers, and servers on the subnet.

## DHCP scope properties

To create and configure a scope, you must define the following properties:

- Name and description. This property identifies the scope. The name is mandatory.
- IP address range. This property lists the range of addresses available for lease. This property is mandatory.
- Subnet mask. Client computers use this property to determine their location in the organization’s network infrastructure. This property is mandatory.
- Exclusions. This property lists single addresses or blocks of addresses that are within the IP address range, but that will not be available for lease. This property is optional.
- Delay. This property indicates the amount of time to delay before sending DHCPOFFER. The default setting is 0 milliseconds.
- Lease duration. This property lists the lease duration. Use shorter durations for scopes that have limited IP addresses and use longer durations for more-static networks.
- Options. You can configure many optional properties on a scope, but typically you configure the following properties:

  - Option 003. Router (the default gateway for the subnet)
  - Option 006. DNS servers
  - Option 015. DNS suffix

- Activation. You must activate the scope before it can lease IP addresses.

:::image type="content" source="../media/m11-add-scope.png" alt-text="A screenshot of the New Scope Wizard. The administrator has entered a range of IP addresses for a scope on the IP Address Range page.":::

## Creating DHCP scopes by using Windows PowerShell

You can use Windows PowerShell to configure DHCP scopes and retrieve information. This is useful when you want to create scripts that automate scope management tasks. The following table lists five common Windows PowerShell cmdlets that you can use for scope management.

|Cmdlet name|Description|
|--|--|
|Add-DhcpServerv4Scope|Adds an IPv4 scope on the DHCP server.|
|Get-DhcpServerv4Scope|Returns the IPv4 scope configuration of the specified scopes.|
|Get-DhcpServerv4ScopeStatistics|Gets the IPv4 scope statistics corresponding to the IPv4 scope identifiers specified for a DHCP server service.|
|Remove-DhcpServerv4Scope| Deletes the specified IPv4 scopes from the DHCP server service.|
|Set-DhcpServerv4Scope|Sets the properties of an existing IPv4 scope on the DHCP server.|

## DHCP reservations

If you want a computer or device to obtain a specific address from the scope range, you can permanently reserve that address for assignment to that device in DHCP. Reservations are useful for tracking IP addresses assigned to devices such as printers. To create a reservation, select the scope in the **DHCP** console, and from the **Action** menu, select **New Reservation**.

:::image type="content" source="../media/m11-reservation.png" alt-text="A screenshot of the New Reservation dialog box. The administrator has added the required details as described in the following text.":::

You must provide the following information to create the reservation in the **New Reservation** dialog box:

- Reservation name. A friendly name to reference the reservation.
- IP address. The IP address from the scope that you want to assign to the device.
- MAC address. The MAC address of the interface to which you want to assign the address.
- Description. An optional field in which you can provide a comment about the reservation.

> [!TIP]
> If a client has already obtained an IP address from a DHCP server, you can convert the existing lease to a reservation in the DHCP console.

## Demonstration

The following video demonstrates how to create a DHCP scope using the DHCP console. The main steps in the process are:

1. Open the DHCP console.
2. In the IPv4 node, select the option to create a new scope.
3. Define the following properties:
    - Name
    - Starting and ending IP addresses
    - Subnet mask
    - Lease duration
    - Router information
    - Parent domain name
4. Activate the scope.
5. In the newly created scope, add a reservation. Define the following properties:

    - Reservation name
    - IP address
    - MAC address

 >[!VIDEO https://www.microsoft.com/videoplayer/embed/RWxDP4]
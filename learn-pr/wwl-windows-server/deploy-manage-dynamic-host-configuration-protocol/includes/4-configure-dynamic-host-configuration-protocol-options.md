DHCP servers can configure more than just an IP address. They also provide information about network resources, such as DNS servers and the default gateway. DHCP options are values for common configuration data. You can apply these options at the DHCP server, scope, reservation, or class option level. 

Contoso IT staff can apply DHCP options at the server, scope, class, and reservation levels. An option code identifies the DHCP options, and most option codes come from the Request for Comments (RFC) documentation found on the Internet Engineering Task Force (IETF) website.

:::image type="content" source="../media/m11-dynamic-host-configuration-protocol-options.png" alt-text="A screenshot of the DHCP console. The administrator has selected the Server Options node in the navigation pane. Three options are displayed: 003, 006, and 015.":::

The following table lists common option codes that Windows DHCP clients use.

|Option code|Name|
|--|--|
|001|Subnet mask|
|003|Router|
|006|DNS servers|
|015|DNS domain name|
|031|Perform router discovery|
|033|Static route|
|043|Vendor-specific information|
|047|NetBIOS scope ID|
|051|Lease time|
|058|Renewal (T1) time value|
|059|Rebinding (T2) time value|
|060|Pre-Boot Execution (PXE) client|
|066|Boot server host name|
|067|Bootfile name|
|249|Classless static routes|

### How DHCP options are applied

The DHCP client service applies the options in an order of precedence at four different levels. Going from least specific to most specific, they are:

1. Server level. Assigns a server-level option to all DHCP clients of the DHCP server.
1. Scope level. Assigns a scope-level option to all clients of a scope. Scope options override server options.
1. Class level. Assigns a class-level option to all clients that identify themselves as members of a class. Class options override both scope and server options.
1. Reserved client level. Assigns a reservation-level option to one DHCP client. Reserved client options apply to devices that have a DHCP reservation.

If you apply DHCP option settings at each level and they conflict, the option that you applied last overrides the previously applied setting. For example, if you configure the default gateway at the scope level, and then apply a different default gateway for a reserved client, the reserved client setting is the effective setting.

> [!TIP]
> Currently, you can't manage server-level DHCP options by using Windows Admin Center, and there are only a few scope-level options that you can manage.

## Where to configure DHCP options

Most DHCP options are configured at the scope level because the scope level represents a subnet where all clients have the same configuration needs. For example, the router and subnet mask options are unique for a subnet and you should configure them at the scope level.

> [!NOTE]
> The router option configures the clients' default gateway property.

It's common to configure the DNS server option at the server level because clients on multiple subnets in a location typically use the same DNS servers. For example, all clients at the London site use the same DNS servers even though the London site has clients on several subnets. You can also configure the DNS domain name at the server level if all clients are members of the same AD DS domain.

The class level supports specialized devices such as IP phones. The devices report their vendor class as part of the DHCP leasing process and the DHCP server provides the DHCP options specific to that vendor class. This is useful when the specialized devices are on a different virtual LAN (VLAN) but still part of the same broadcast domain. For example, when an office has a single network connection, and an IP phone and computer use the same network connection.

> [!NOTE]
> The class level includes user classes and vendor classes. You can manually configure the user class on computers running Windows operating systems. Typically, the manufacturer of the device configures the vendor class.

## Demonstration

The following video demonstrates how to configure DHCP server options using Server Manager. The main steps in the process are:

1. Open Server Manager.
2. From **Tools** select **DHCP**.
3. Add a new DHCP server to the DHCP console.
4. Expand an existing DHCP scope.
5. Select **Server Options**.
6. Configure the appropriate options for this DHCP server.

 >[!VIDEO https://www.microsoft.com/videoplayer/embed/RWxDP3]
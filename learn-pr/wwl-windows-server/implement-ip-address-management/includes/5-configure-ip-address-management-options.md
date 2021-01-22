Contoso IT administrators can configure IPAM to suit their environment and provide the level of manageability that they require. They can configure all the managed servers manually by creating and configuring the necessary firewall rules, security groups, scheduled tasks, and file shares. However, to simplify management, they should consider using GPOs to perform provisioning.

## GPO provisioning

When you select Group Policy provisioning, you're prompted to provide a prefix for the GPOs so that they can be easily identified. The GPOs' names display after you provide the prefix. You need to create these GPOs after completing the provisioning wizard.  

> [!IMPORTANT]
> The wizard configures IPAM to use the GPOs but doesn't create the GPOs.

You need to create the GPOs in the following table.

|GPO name|Description|
|--------|-----------|
|\<*Prefix*>_DHCP|This GPO applies settings that allow IPAM to monitor, manage, and collect information from managed DHCP servers on the network. It sets up IPAM provisioning scheduled tasks and adds Windows Defender Firewall inbound rules for Remote Event Log Management (RPC-EMAP and RPC), Remote Service Management (RPC-EMAP and RPC), and DHCP Server (RPCSS-In and RPC-In).|
|\<*Prefix*>_DNS|This GPO applies settings that allow IPAM to monitor and collect information from managed DNS servers on the network. It sets up IPAM provisioning scheduled tasks and adds Windows Defender Firewall inbound rules for RPC (TCP, Incoming), RPC Endpoint Mapper (TCP, Incoming), Remote Event Log Management (RPC-EMAP and RPC), and Remote Service Management (RPC-EMAP and RPC).|
|\<*Prefix*>_DC_NPS |This GPO applies settings that allow IPAM to collect information from managed domain controllers and NPS servers on the network for IP address tracking purposes. It sets up IPAM provisioning scheduled tasks and adds Windows Defender Firewall inbound rules for Remote Event Log Management (RPC-EMAP and RPC) and Remote Service Management (RPC-EMAP and RPC).|

### Create the required GPOs

To create the GPOs required by IPAM, you can use the `Invoke-IpamGpoProvisioning` Windows PowerShell cmdlet. Include the domain in which to create the GPOs, and the prefix for the GPO names. 

> [!IMPORTANT]
> If you don't run `Invoke-IpamGpoProvisioning` from the IPAM server, you must include the IPAM server name. 

When you run the cmdlet without a server name, the computer account from the local computer is added as a member of the **IPAMUG** group in AD DS. You must add the computer account of the IPAM server to this group.

The following example creates the IPAM GPOs with a prefix of **IPAM** in the `contoso.com` domain and adds the IPAM server **SEA-SVR2** to the **IPAMUG** group. This group is granted permissions on each managed server.

```powershell
Invoke-IpamGpoProvisioning -Domain contoso.com -GpoPrefixName IPAM -IpamServerFqdn SEA-SVR2.contoso.com
```

:::image type="content" source="../media/m14-ipam-2.png" alt-text="A screenshot of the Group Policy Management console. In addition to the Default Domain GPO, three other GPOs are displayed, as described in the preceding table.":::

The three GPOs are automatically linked to the root of the domain, but security filtering prevents them from applying to any servers. When you select a server for IPAM to manage, that server is added to the security filtering for the GPO, and then is given permission to apply the GPO. 

> [!WARNING]
> If the naming of the GPOs doesn't match what you specified in the provisioning wizard, this process will fail.

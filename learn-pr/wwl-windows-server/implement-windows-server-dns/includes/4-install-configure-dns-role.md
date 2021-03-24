You can create and configure DNS zones by using Windows Admin Center, DNS Manager, and Windows PowerShell. At the time of writing, Windows Admin Center provides access to those options users configure most commonly, including dynamic updates and zone storage. Other features, such as aging and scavenging, are only configurable by using DNS Manager and Windows PowerShell.

## Create zones

When you create a primary zone, you have the option to create a zone file or store the zone in AD DS. If you create a zone file, the zone is a *standard primary zone*. If you store the zone in AD DS, the zone is *Active Directory-integrated*. A secondary zone is always stored in a zone file.

If you configure a zone to be Active Directory-integrated, the zone data is stored in AD DS and replicated to domain controllers. You can choose from the following options:

- **To all DNS servers running on domain controllers in this forest**. Useful in a multi-domain forest when you want the zone available to DNS servers in all domains. When you select this option, the DNS zone is stored in the ForestDnsZones partition.
- **To all DNS servers running on domain controllers in this domain**. Selected by default and works well for single-domain environments. When you select this option, the DNS zone is stored in the DomainDnsZones partition.
- **To all domain controllers in this domain (for Windows 2000 compatibility)**. Seldom selected because replicating to all domain controllers in the domain is less efficient than replicating only to DNS servers running on domain controllers in the domain. When you select this option, the DNS zone is stored in the domain partition.
- **To all domain controllers in the scope of this directory partition**. Use this option to select an application partition that you have created to store the zone.

> [!TIP]
> For custom application partitions, you can specify the domain controllers in the forest to which the zone replicates.

### Zone transfers

Zone records synchronize from a primary zone to a secondary zone by performing a *zone transfer*. For each zone, you can control which servers hosting secondary zones can request a zone transfer. If you choose to allow zone transfers, you can control them with the following options:

- To any server
- Only to servers listed on the Name Servers tab
- Only to the following servers

You can also configure notifications for zone transfers. When notifications are enabled, the primary server notifies the secondary server when changes are available to synchronize.

> [!NOTE]
> After initial replication of a secondary zone is complete, incremental zone transfers occur.

### Security for dynamic updates

You can configure each DNS zone with security settings for dynamic updates. For Active Directory-integrated zones, you can restrict the zone to allow only secure dynamic updates. Secure dynamic updates ensure that only the client that owns a DNS record can update it. If a second device with the same name attempts a secure dynamic update, the record won't update. 

> [!IMPORTANT]
> When a zone isn't Active Directory-integrated, you can still allow dynamic updates, but you can't enforce security.

> [!TIP]
> Only domain-joined Windows computers that are part of the same forest can perform secure dynamic updates. To allow non-domain joined Windows clients or non-Windows devices to perform dynamic updates, you must allow nonsecure dynamic updates.

### Windows PowerShell cmdlets to manage DNS zones

There are many Windows PowerShell cmdlets that you can use to manage DNS zones. The following table lists some of the cmdlets that you can use.

| Cmdlet                       | Description                                        |
| - | -- |
| Add-DnsServerPrimaryZone     | Create a primary DNS zone                          |
| Add-DnsServerSecondaryZone   | Create a secondary DNS zone                        |
| Get-DnsServerZone            | View configuration information for a DNS zone      |
| Get-DnsServerZoneAging       | View aging configuration for a DNS zone            |
| Remove-DnsServerZone         | Removes a DNS zone                                 |
| Restore-DnsServerPrimaryZone | Reloads the zone content from AD DS or a zone file |
| Set-DnsServerPrimaryZone     | Modifies the settings of a primary DNS zone        |
| Start-DnsServerZoneTransfer  | Triggers a zone transfer to a secondary DNS zone   |

## Create records in DNS

You must create DNS resource records before they can be used for name resolution within the DNS infrastructure. When you create a DNS resource record, it exists within a DNS zone. A DNS zone constitutes several related records. You can manually create DNS records in a zone, but most host and pointer resource records for Windows servers and clients are created dynamically.

### Manual creation

When you create resource records to support a specific service or app, you can manually create the resource records. For example, you can create host or CNAME records, such as `app.contoso.com`, for a specific app running on a server. The record name might be easier for users to remember, and users don't need to reference the server name.

You can create resource records by using DNS manager, Windows Admin Center, or Windows PowerShell. The following table lists some Windows PowerShell cmdlets that you can use to create DNS resource records.

| Cmdlet                           | Description                                    |
| -- | - |
| Add-DnsServerResourceRecord      | Creates any resource record, specified by type |
| Add-DnsServerResourceRecordA     | Creates a host (A) resource record             |
| Add-DnsServerResourceRecordAAAA  | Creates a host (AAAA) resource record          |
| Add-DnsServerResourceRecordCNAME | Creates a CNAME alias resource record          |
| Add-DnsServerResourceRecordMX    | Creates an MX resource record                  |
| Add-DnsServerResourceRecordPtr   | Creates a PTR resource record                  |

### Dynamic creation

When you allow dynamic updates for a DNS zone, clients that use DNS register with the DNS server. The dynamic update creates host and pointer records for the client. Dynamic DNS makes it easier for you to manage DNS, because when dynamic DNS is enabled, the current IP address for a computer registers automatically after an IP address change.

> [!NOTE]
> The DHCP client service performs the registration, regardless of whether the client’s IP address is obtained from a DHCP server or is static.

Dynamic DNS registration is triggered by the following events:

- When the client starts, and the DHCP client service starts
- Every 24 hours while the DHCP client service is running
- When an IP address is configured, added, or changed on any network connection
- When an administrator executes the `Register-DNSClient` cmdlet
- When an administrator runs the `ipconfig /registerdns` command

> [!NOTE]
> By default, Windows DNS clients perform dynamic DNS registration.

## Demonstration

The following video demonstrates how to implement, create, and manage DNS zones and records using Windows Admin Center. The main steps in the process are:

1. Open **Microsoft Edge** and navigate to the **Windows Admin Center** site.
2. Connect to the appropriate remote server.
3. In **Windows Admin Center**, select **Tools** and then select **Roles & features**.
4. Install the DNS Server role.
5. On the new server, create a new DNS zone. Define the following properties:
    - Zone type
    - Zone name
    - Zone file
    - Dynamic update
6. In the new zone, create a new host record.
7. Open **Windows PowerShell**, and using the `Resolve-DnsName` cmdlet, verify name resolution is successful for the new record in the new zone.

 >[!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RE4MjvL]
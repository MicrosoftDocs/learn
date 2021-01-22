Contoso IT infrastructure staff must deploy DNS to support their apps and services, including AD DS. The first step in this process is planning and implementing DNS zones. 

## What is a DNS zone?

A *DNS zone* is the specific portion of a DNS namespace (such as `contoso.com`) that's hosted on a DNS server. A DNS zone contains resource records, and the DNS server responds to queries for records in that namespace. For example, the DNS server that's authoritative for resolving `www.contoso.com` to an IP address would contain the `Contoso.com` zone. 

Contoso IT infrastructure staff can choose to store the `Contoso.com` DNS zone content in a file or in the AD DS database.

> [!NOTE]
> On a DNS server which is also an AD DS domain controller, you can only choose to store the zones in the AD DS database.

When the DNS server stores the zone in a file:

- That file is in a local folder on the server.
- Only one copy of the zone is writable.
- Other copies, which are read-only, are referred to as *secondary zones*.

### Forward lookup zones

*Forward lookup zones* can hold a wide variety of different resource records, but the most common record type is a *host (A) record*. A host record is used to resolve a hostname to an IP address. 

:::image type="content" source="../media/m12-dns-1.png" alt-text="A screenshot of the Contoso.com zone in DNS. Displayed are various resource records. Also displayed is a reverse lookup zone for 172.16.10.0/24.":::

When using AD DS, the internal DNS servers for your organization have a zone that corresponds to the AD DS domain. For example, if the domain name for AD DS is `Contoso.com`, there also will be a `Contoso.com` DNS zone. AD DS stores resource records that Windows servers and clients use to locate network services.

> [!TIP]
> You don't have to make the DNS records containing your AD DS resource information available on the internet. In fact, you shouldn't.

If you're providing name resolution for a zone to internet clients, you can host the zone on a Windows server that's accessible on the internet.

> [!TIP]
> Another option is to place your internet-facing DNS servers in your perimeter network.

You also have the option to host the zone on a third-party DNS service that specializes in providing internet name resolution.

### Reverse lookup zones

*Reverse lookup zones* are used only for resolving an IP address to a name. A variety of apps, and sometimes administrators, use this functionality. For example, an administrator might notice a specific IP address in a log file and use a reverse lookup to identify the name of the computer that corresponds with the IP address.

:::image type="content" source="../media/m12-dns-2.png" alt-text="A screenshot of the 10.16.172.in-addr.arpa zone in DNS. Displayed are several PTR resource records. Also displayed is a forward lookup zone for Contoso.com.":::

You create reverse lookup zones only for IP address ranges for which you're responsible. 

> [!TIP]
> As a best practice, you should create reverse lookup zones for all the IP address ranges on your internal network and host them on your internal DNS servers. 

The zone name for reverse lookup zones ends with `in-addr.arpa` and is based on the IPv4 address range. For example, the zone name for the `172.16.35.0/24` reverse lookup zone will be `35.16.172.in-addr.arpa`. 

> [!TIP]
> Reverse lookup zones are always based on a full octet of the IP address.

### Primary and secondary zones

When you create a zone on a DNS server, you must identify whether it's a primary zone or a secondary zone. To create, edit, or delete resource records, you must use the primary zone. Because a secondary zone is a read-only copy of a primary zone, you can't manage resource records in a secondary zone. 

In most cases, a secondary zone periodically copies resource records directly from the primary zone. But in some complex configurations, a secondary zone can copy resource records from another secondary zone.

You can store a standard primary zone in a local file, or you can store zone data in AD DS. When you store zone data in AD DS, the zone is called *Active Directory-integrated* and enables additional features, such as secure dynamic updates. 

> [!NOTE]
> Active Directory-integrated zones are available only on domain controllers with the DNS Server role installed. Most Windows-based DNS servers use Active Directory-integrated zones.

## What are DNS records?

DNS records are the resource records stored in DNS zones. The DNS records contain the information that DNS servers send in response to DNS requests. All forward lookup and reverse lookup DNS zones contain the following records:

- Start of authority (SOA). Contains configuration information for the zone, including the name of the primary DNS server and how often secondary servers should be synchronized. There's one SOA record per zone.

- Name server (NS). Identifies a DNS server for the domain. There's one NS record for each DNS server that has a copy of the zone.

### Resource records in forward lookup zones

The following table describes some of the resource records available in forward lookup zones.

| DNS record type        | Description                                                  |
| ---------------------- | ------------------------------------------------------------ |
| Host (A)               | Used to resolve a name to an IPv4 address.                   |
| Host (AAAA)            | Used to resolve a name to an IPv6 address.                   |
| Alias (CNAME)          | Used to resolve a name to another name. For example, an alias can resolve `app.contoso.com` to `sea-svr1.contoso.com`. |
| Service location (SRV) | Used by applications to identify the location of servers hosting that application. For example, AD DS uses SRV records to identify the location of domain controllers and related services. |
| Mail exchanger (MX)    | Used to identify email servers for a domain.                 |
| Text (TXT)             | Used to store arbitrary strings of information in DNS.       |

### Resource records in reverse lookup zones

The most common record type created in reverse lookup zones is a pointer (PTR) record. A *pointer* record is used to resolve an IP address to a name. For example, a pointer record could be used to resolve the IP address `172.16.35.100` to `filesrv.contoso.com`. The pointer record would be named `100` and located in the `35.16.172.inaddr.arpa` zone.

### Time to live

All resource records are configured with a time to live (TTL). The TTL for a resource record defines how long DNS clients and DNS servers can cache a DNS response for the record. For example, if a record has a TTL of 60 minutes, when a client makes a DNS query for the record, the response is cached for 60 minutes. If the client attempts to use the queried and resolved name within that 60 minutes, the cached record is used.

> [!TIP]
> When you're troubleshooting cached DNS records, you might need to clear the cache on the DNS client and on the DNS server used by that client.
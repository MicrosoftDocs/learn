It's vital that the Contoso IT infrastructure team plan and implement *name resolution* carefully to support their apps and services. In addition to organizational apps and services, AD DS and general network communication also require DNS as a critical network service. 

Name resolution is the process of converting computer names to IP addresses. Name resolution is an essential part of computer networking because it's easier for users to remember names than abstract numbers, such as an IPv4 or IPv6 address. Windows supports a number of different methods for resolving computer names, the primary method being DNS.

## What is DNS?

DNS is an industry standard name resolution service. Servers running the DNS server role respond to requests from  hosts and other network devices to resolve computer names and hostnames into IP addresses. DNS servers can also resolve IP addresses into names. DNS servers use DNS resource records stored in DNS zones. Where a DNS server is unable to resolve a query for a network device, it might reference other DNS servers by using root hints or forwarding.

> [!NOTE]
> The exact format of the zone depends on the type of the zone.

You can create DNS resource records manually, or IP hosts and network devices can register their DNS records automatically with a DNS server.

The most common use for DNS is resolving full qualified domain names (FQDNs), such as `sea-dc1.contoso.com`, to IP addresses. Users require this functionality to access network resources and websites.

Administrators use name resolution in DNS when configuring and managing apps, in part because people can remember names more easily than IP addresses. Domain-joined Windows clients and servers also use DNS to locate domain controllers in an AD DS domain.

## DNS domain names

The naming structure that DNS uses is the *DNS namespace*. It's hierarchical, which means that it starts with a root domain. That root domain can have any number of subdomains. Each subdomain can, in turn, have any number of its own subdomains.

Domain names can be either public (internet-facing) or private. If they are private, you decide how to define your organization's namespace. If they are public, you must work with the Internet Corporation for Assigned Names and Numbers (ICANN) or other internet naming registration authorities that can delegate (sell) unique names to you. From these names, you can create appropriate subdomain names.

> [!TIP]
> To help in obtaining trusted certificates for apps and authentication, it's typical to use a public domain name that's registered on the internet.

## DNS servers

A DNS server responds to requests for DNS records that are made by DNS resolvers. For example, a Windows 10 client can send a DNS request to resolve `sea-dc1.contoso.com` to a DNS server, and the DNS server response includes the IP address of `sea-dc1.contoso.com`. 

A DNS server retrieves this information from a local database that contains resource records. Alternatively, if the DNS server doesn't have the requested information, it can forward DNS requests to another DNS server. A DNS server also caches previously requested information from other DNS servers.

While you can configure any Windows Server as a DNS server, it's also common to install the DNS server role on any Windows Server computer that's promoted to an AD DS domain controller. 

> [!NOTE] 
> Windows Server is configured to be a DNS server when you install the DNS server role.

## DNS zones and resource records

When a DNS server is responsible for resolving requests for a specific namespace, you create a zone on the DNS server that corresponds to the namespace. For example, if a DNS server is responsible for `contoso.com`, you would create a `contoso.com` zone. Inside the zone, you create resource records that contain the information that's used to respond to queries.

## DNS resolvers

A DNS resolver is a client—such as a Windows client—that needs to resolve DNS records. In Windows, the DNS Client service sends DNS requests to the DNS server that's configured in the IP properties. After receiving a response to a DNS request, Windows caches the response for future use. This is the *DNS resolver cache*. 

> [!NOTE]
> The Windows 10 computer checks its DNS cache before it petitions the DNS server in case it has recently resolved the required record.

:::image type="content" source="../media/m12-dns-client.png" alt-text="Diagram of a DNS client petitioning its configured DNS server. It performs a simple query for an IP address that's based on a name." border="false":::

> [!TIP]
> You can access the contents of the DNS resolver cache either by using the `Get-DnsClientCache` cmdlet, or by running the `ipconfig /displaydns` command. You can clear the contents of the DNS resolver cache either by using the `Clear-DnsClientCache` cmdlet, or by using the `ipconfig /flushdns` command.

It's worth noting that DNS isn't the only way in which host computers running Windows can resolve names. A Windows 10 computer can use the following methods, depending on configuration:

* Check DNS resolver cache.
* Check Hosts file located in C:\Windows\System32\Drivers\etc.
* Petition configured DNS server.
* Broadcast a NetBIOS name query.
* Check LMHOSTS file located in C:\Windows\System32\Drivers\etc.
* Use a configured NetBIOS name resolution service, such as Windows Internet Name Service (WINS).

  > [!TIP]
  > You can install the WINS server feature on Windows Server if your organization requires NetBIOS name resolution to support a specific app.

### Computer names and hostnames

A *hostname* is a user-friendly name that's associated with a host’s IP address and identifies it as a TCP/IP host. A hostname can't exceed 255 characters, and must contain only alphanumeric characters, periods, and hyphens. A hostname is an *alias* or a FQDN. The elements of the name include periods as separators. Applications use the structured FQDN on the internet. An example of an FQDN is `payroll.contoso.com`.

A *NetBIOS name* is a nonhierarchical name that some older apps use. A 16-character NetBIOS name identifies a network’s NetBIOS resource. A NetBIOS name represents a single computer or a group of computers. NetBIOS uses the first 15 characters for a specific computer’s name and the final sixteenth character to identify a resource or service on that computer. An example of a NetBIOS name is **SEA-SVR2[20h]**.

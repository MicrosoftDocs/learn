In Windows operating systems, DNS has two major functions: to resolve IP addresses to names (and vice versa), and to facilitate domain-level communications and authentication for AD DS. The ability to store SRV records allows domain-member clients to find domain controllers for domain authentication and security while load balancing access to the various domain controllers by using DNS round-robin functionality. 

However, internet-level untrusted users from outside the firewall should never be able to access the SRV records and other sensitive AD DS information from the internal DNS servers. That data must remain separate and inaccessible from outside the firewall. At the same time, DNS records of servers and services hosting internet level resources, such as web, mail, and proxy servers, must remain accessible.

This is the problem facing the infrastructure engineers at Contoso. They must determine a convenient way to manage around this problem.

## What is split DNS?

*Split DNS*, also known as split-horizon DNS, uses the same DNS domain name for both internet and internal domain-member resources. However, the DNS server role is assigned to separate servers: one or more servers for the internet, and the other server(s) for the AD DS domain. Deploying DNS this way requires extra steps to ensure that sensitive information found on the AD DS domain side is separated from the internet side, and to ensure that only the DNS server deployed on the internet side, that is, outside the inner firewall, can be accessed by queries from outside the firewall.
 
> [!NOTE]
> Because DNS is such a vital function for AD DS, the DNS server role is usually included with domain controllers when they're deployed.

You can integrate the DNS role into AD DS so that DNS records are stored as Active Directory objects and attributes. The DNS zone type in this instance is referred to as Active Directory-integrated. Active Directory-integrated zones replace DNS zone transfers with AD DS replication and can ensure secure dynamic updates of client records to the zone. In a domain, using Active Directory-integrated DNS is a best practice.

With split DNS, internal clients are only configured with the IP addresses of the Active Directory-integrated DNS servers, which are domain controllers. All client DNS dynamic updates are written to the domain controllers. All DNS queries from internal clients go only to these DNS servers.

If any name resolution is needed beyond the internal domain, such as for internet web servers, you must either create those records manually, or else use DNS policies to determine how those queries are resolved.  

> [!NOTE]
> You typically deploy internet-facing DNS servers in the perimeter network between the firewalls.

Although the internet-facing DNS servers have the same domain name as the Active Directory-integrated DNS servers, the internet-facing DNS servers don't store the same data. All records in the internet-facing DNS server zone are created manually.

> [!TIP]
> Normally, the internet-facing DNS server zone only contains records for itself and other servers that are located in the perimeter network and need to be accessed from the internet.

When a query to the internet-facing DNS server comes in from the internet requesting a resolution on any domain-level resource, such as an SRV record, the internet-facing DNS server rejects the query because it doesn't have any of the SRV records—these are only stored in the domain Active Directory-integrated DNS servers. Because it considers itself authoritative for the zone, the internet-facing DNS server does not make an iterative query to the Active Directory-integrated DNS servers.

> [!TIP]
> To further enhance security, you can set a firewall rule on the inside firewall, that is, the firewall between the internal and perimeter networks, to reject all DNS (TCP and UDP port 53) queries from the perimeter to the internal network, while still allowing DNS replies.

## Implement split DNS

Using the same namespace internally and externally simplifies resource access from the perspective of users, but it also increases management complexity. You should not make internal DNS records available externally, but some synchronization of records for external resources typically is required. For example, both your internal and external namespaces might use the name `Contoso.com`.

Using unique namespaces for the internal and public namespaces provides a clear delineation between internal and external DNS, and avoids the need to synchronize records between the namespaces. However, in some cases, having multiple namespaces might lead to user confusion. For example, you might choose the external namespace of `Contoso.com` and the internal namespace of `Contoso.local`.

> [!TIP]
> When you implement a unique namespace configuration, you're no longer tied to using registered domain names.

Using a subdomain of the public namespace for AD DS avoids the need to synchronize records between the internal and external DNS servers. Because the namespaces are linked, users typically find this structure easy to understand. For example, if your public namespace is `Contoso.com`, you might choose to implement your internal namespace as the subdomain AD, or as `AD.Contoso.com`.

## Considerations for split DNS

Having a matching internal and external DNS namespace can pose certain problems. However, split DNS can provide a solution to these problems. Split DNS is a configuration in which your domain has two root-server zones that contain domain-name registration information.

Your internal network hosts are directed to one zone, whereas external hosts are directed to another for name resolution. For example, in a non-split DNS configuration for the domain `contoso.com`, you might have a DNS zone that looks like the example in the following table.

| **Host**   | **Record type** | **IP address** |
| ---------- | --------------- | -------------- |
| www        | A               | 131.107.1.200  |
| Relay      | A               | 131.107.1.201  |
| Webserver1 | A               | 192.168.1.200  |
| Exchange1  | A               | 192.168.0.201  |

When a client computer on the internet wants to access the SMTP relay by using the published name of `relay.contoso.com`, it queries the DNS server that returns the result 131.107.1.201. The client then establishes a connection over SMTP to that IP address.

However, the client computers on the organization’s intranet also use the published name of `relay.contoso.com`. The DNS server returns the same result: a public IP address of 131.107.1.201. The client now attempts to establish a connection to the returned IP address by using the external interface of the publishing computer. Depending on the client configuration, this might or might not be successful.

By configuring two zones for the same domain name―one on each of the two DNS servers―you can avoid this problem.

The internal zone for `Contoso.com` would contain the information in the following table.

| **Host**   | **Record type** | **IP address**         |
| ---------- | --------------- | ---------------------- |
| www        | CNAME           | `Webserver1.contoso.com` |
| Relay      | CNAME           |`Exchange1.contoso.com`  |
| Webserver1 | A               | 192.168.1.200          |
| Exchange1  | A               | 192.168.0.201          |

The external zone for `Contoso.com` would contain the information in the following table.

| **Host** | **Record type** | **IP address**    |
| -------- | --------------- | ----------------- |
| www      | A               | 131.107.1.200     |
| Relay    | A               | 131.107.1.201     |
|          | MX              | `Relay.contoso.com` |

Now client computers in the internal and external networks can resolve the name `relay.contoso.com` to the appropriate internal or external IP address.

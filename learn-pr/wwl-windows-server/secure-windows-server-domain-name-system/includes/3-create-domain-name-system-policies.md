The infrastructure team at Contoso posed you a question: "How can Windows Server DNS handle the fact that we want different results to the same query to be returned to DNS resolvers based on their location?" They explained that for users in Seattle, the query for the FQDN `www.Contoso.com` should return a different IP address than for users in London.

## Scenarios for using DNS policies

You can use DNS policies to manipulate how a DNS server manages queries based on different factors. As an example, you might create a DNS policy to respond to queries asking for the IP address of a web server to respond with a different IP address based on the closest datacenter to the client.

> [!NOTE]
> This differs from other approaches, such as netmask reordering, because the client doesn't have the same local subnet address as the web server, but the particular web server is closer than others, from the perspective of the client.

You can create several DNS policies depending on your needs. There are various factors that might benefit from creating a DNS policy, based on the following scenarios:

- Application high availability. Clients are redirected to the healthiest endpoint for an application, where "healthiest" is determined by high availability factors in a failover cluster.
- Traffic management. Clients are redirected to the closest datacenter or server location.
- Split DNS. Clients receive a response based on whether they are internal or external, and the DNS records are split into different zone scopes.
- Filtering. DNS queries are blocked if they are from a list of malicious IP addresses or FQDNs.
- Forensics. Malicious DNS clients are redirected to a sink hole instead of the computer they are trying to reach.
- Time-of-day based redirection. Clients are redirected to datacenters based on the time of the day.

## DNS policy objects

To use the previously mentioned scenarios to create policies, you must identify groups of records in a zone, groups of clients on a network, or other elements. You can identify the elements by the DNS policy objects described in the following table.

| Element         | Description                                                  |
| --------------- | ------------------------------------------------------------ |
| Client subnet   | Represents the IPv4 or IPv6 subnet from which queries are sent to a DNS server. You create subnets to later define policies that you apply based on the subnet that generates the requests. For example, you might have a split DNS scenario where the name resolution request for `www.contoso.com` can be answered with an internal IP address to internal clients, and a different IP address to external clients. |
| Recursion scope | Represents unique instances of a group of settings that control DNS server recursion. A recursion scope holds a list of forwarders and specifies whether recursion is used. A DNS server can have multiple recursion scopes. You can use DNS server recursion policies to choose a recursion scope for a given set of queries. If the DNS server is not authoritative for certain queries, DNS server recursion policies let you control how to resolve those queries. In this case, you can specify which forwarders to use and whether to use recursion. |
| Zone scopes     | DNS zones can have multiple zone scopes, and each zone scope can contain its own set of DNS resource records. The same resource record can be present across multiple scopes, with different IP addresses depending on the scope. Additionally, zone transfers can occur at the zone-scope level. This will allow resource records from a zone scope in a primary zone to be transferred to the same zone scope in a secondary zone. |

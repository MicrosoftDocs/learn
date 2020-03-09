You have now successfully delegated the domain from the domain registrar to your Azure DNS and configured an A record to link the domain to your web server.

The next phase of the deployment is to improve resiliency, which can be achieved by using a load balancer. Load balancers distributes inbound data requests and traffic across one, or more backend servers.  They reduce the load on any one server and improve performance. This technology is well established, and will be used throughout your on-premises network.

You know the A record and CNAME record don't support direct connection to Azure resources like your load balancers. You've been tasked with finding out how to link the apex domain with an Azure load balancer.

In this unit, you'll learn about:

- Apex domains
- Azure alias records
- How they can be applied
- How to create alias record

## What is an apex domain?

The Apex domain represents the highest level of your domain. In our case that is wideworldimports.com. They're also known as zone apex, or root apex. It's often represented by the @ symbol in your DNS zone records. If you check the DNS zone for wideworldimports.com, you'll see there are two Apex domain records: NS and SOA.

The NS and SOA records are automatically created when you created the DNS zone.

CNAME records that you may need for a Traffic Manager profile or Azure Content Delivery Network (CDN) endpoints aren't supported at the zone apex level. Alias records are supported at zone apex level.

## What are alias records?

Azure alias records enable a zone apex domain to reference other Azure resources from the DNS zone, without the need to create complex redirection policies. One of the other possible uses for an Azure alias is to route all traffic through Azure Traffic Manager.

The Azure alias record can connect to two types of Azure resources: Traffic Manager Service and public IP addresses.

Benefits of using alias records:

- Provides lifecycle tracking of target resources, ensuring changes to any target resource are automatically applied to the DNS zone.
- Provides support for load balanced applications in the zone apex.
- Can reference Azure Traffic Manager and Public IP.

The alias record set supports the following DNS zone record types:

- **A**: The IPv4 domain name-mapping record
- **AAAA**: The IPv6 domain name-mapping record
- **CNAME**: The alias for your domain, and links to the A record

## Uses for alias records

The Azure alias records are useful for several scenarios.

- **Prevents dangling DNS records**: A dangling DNS record occurs when the DNS zone records aren't up-to-date with changes to IP addresses. Alias records prevent dangling references by tightly coupling the life cycle of a DNS record with an Azure resource.
- **Updates DNS record-set automatically when IP addresses change**: When the underlying IP address of a resource, service, or application is changed, the alias record ensures any associated DNS records are automatically refreshed.
- **Hosts load-balanced applications at the zone apex**: Alias records allow for zone apex resource routing to Azure Traffic Manager. 
- **Points zone apex to Azure CDN endpoints**: With alias records, you can now directly reference your Azure CDN.

An Alias record will allow you to link the zone apex (wideworldimports.com) to your load balancer. It will create a link to the Azure resource rather than a direct IP-based connection. So, if the IP address of the load balancer changes, the zone apex record will continue to work.

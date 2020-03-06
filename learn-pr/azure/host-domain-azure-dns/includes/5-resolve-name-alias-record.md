You have now successfully delegated the domain from the domain registrar to your Azure DNS and configured an A record to link the domain to your web server.

The next phase of the deployment is to improve resiliency, which can be achieved through using load balancers. Load balancer technology distributes inbound data requests and traffic across one, or more backend servers.  Thereby reducing the load on any one server and improving performance. This technology is well established, and will be used throughout your on-premises network.

You know the A record and CNAME record do not support direct connection to Azure resources like your load balancers. You have been tasked with finding out how to link the Apex domain with an Azure load balancer.

In this unit, you'll learn about:

- Apex domains
- Azure alias records
- How they can be applied
- How to create alias record

## Apex domains

The Apex domain represents the highest level of your domain. In our case that is wideworldimports.com. They're also known as zone apex, or root apex. It's often represented by the @ symbol in your DNS zone records. If you check the DNS zone for wideworldimports.com, you'll see there are two Apex domain records: NS and SOA.

The NS and SOA records are automatically created when you created the DNS zone.

## Alias Records

Azure alias records provide an additional level of record in your DNS zone. Which enables zone apex domains to reference other Azure resources from the DNS zone, without the need to create complex redirection policies. One of the other possible uses for an Azure alias is to route all traffic through Azure Traffic Monitor.

The Azure alias record can connect to two types of Azure resources: Traffic Manager Service and Public IP addresses.

Benefits of using alias records:

- The alias record provides lifecycle tracking of target resources, ensuring changes to any target resource are automatically applied to the DNS zone.
- Provides support for load balanced applications in the zone apex.
- The alias record can access other Azure resources. Presently it's limited to: Azure Traffic Manager and Public IP. Although others will be added over time.

The alias record set supports the following DNS zone record types:

- A - is the IPv4 domain name-mapping record.
- AAAA - is the IPv6 domain name-mapping record.
- CNAME - is the alias for your domain, and links to the A record.

## Applying alias records

The Azure alias record can be applied to a number of different scenarios.

### Mitigation of dangling DNS records. 

A dangling DNS record occurs when the DNS zone records aren't up-to-date with changes to IP addresses. When you get a dangling DNS record, you'll need to modify one of these DNS zone records: A, AAAA and CNAME.

### Automatic update of DNS records. 

When the underlying IP address of resource, service, or application is changed, Azure alias ensures any associated DNS records are automatically refreshed. Which can prevent dangling DNS records.

### Support zone apex load balancing. 

Alias records allow for zone apex resource routing to Azure Traffic Manager, or an Azure load balancer resource.

### Link Azure Content Design Network (CDN) to your DNS zone apex. 

With alias records, you can now directly reference your Azure Content Network.

From the above list of scenarios, **zone apex load balancing** will best meet your organizations requirements.  It provides you with the means to link the zone apex (wideworldimports.com) to the public IP address of your load balancer using an Alias record.
The benefit of using an Alias record is that it creates a link to an Azure resource rather than a direct IP-based connection.  So, if the IP address of the load balancer changes, the zone apex records will continue to work as before. Using zone apex load balancing will reduce your administrative maintenance overhead.  Additionally, it prevents dangling DNS record - where the dns zone records are no longer in synch with the backend servers and resources.

## Creating Alias Records

From the Azure portal, locate the resource group that contains the wideworldimports.com DNZ zone resource. Open the resource and add a record.  Adding an Alas record is similar to creating an A, AAAA, or CNAME record. The primary difference is the **Alias record set** option.  For an Alias record set it to **yes**. Once selected the remaining options change and you'll need to assign an **Azure Resource**.  In this instance, you'll select the public IP address of the load balancer, traffic manager service.  The Alias record will appear in the list of record sets associated with the DNS zone.

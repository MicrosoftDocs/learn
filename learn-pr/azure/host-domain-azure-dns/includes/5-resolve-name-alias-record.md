You have now successfully delegated the domain from the domain registrar to your Azure DNS and configured an A record to link the domain to your web server.

The next phase of the deployment is to improve resiliency. Which can be achieved through load balancers. This technology is well established, and used throughout your on-premises network.

You know the A record and CNAME record do not support direct connection to Azure resources like your load balancers. You have been tasked with finding out how to link the Apex domain with an Azure load balancer.

In this unit, you'll learn about:

- Apex domains
- Azure alias records
- How they can be applied
- How to create alias record

## Apex domains

The Apex domain represents the highest level of your domain. In our case that is wideworldimports.com. They are also known as zone apex, or root apex. It is often represented by the @ symbol in your DNS zone records. If you check the DNS zone for wideworldimports.com, you will see there are two Apex domain records: NS and SOA.

The NS and SOA records are automatically created when you created the DNS zone.

## Alias Records

Azure alias records provide an additional level of record in your DNS zone. Which enables zone apex domains to reference other Azure resources from the DNS zone, without the need to create complex redirection policies. One of the other possible uses for an Azure alias is to route all traffic through Azure Traffic Monitor.

At present the Azure alias record can connect to two types of Azure resources: Traffic Manager Service and Public IP addresses.

Benefits of using alias records:

- The alias record provides lifecycle tracking of target resources, ensuring changes to any target resource are automatically applied to the DNS zone.
- Provides support for load balanced applications in the zone apex.
- The alias record can access other Azure resources. Presently it is limited to: Azure Traffic Manager and Public IP. Although others will be added over time.

The alias record set supports the following DNS zone record types:

- A - is the IPv4 domain name-mapping record.
- AAAA - is the IPv6 domain name-mapping record.
- CNAME - is the alias for your domain, and links to the A record.

## Applying alias records

The Azure alias record can be applied to a number of different scenarios.

- **Mitigation of dangling DNS records** - When DNS records are not kept up-to-date with the latest changes to IP addresses. Typically this type of issue applies to the following DNS record types: A, AAAA and CNAME.
- **Automatic update of DNS records** - When the underlying IP address of resource, service, or application is changed, Azure alias ensures any associated DNS records are automatically refreshed. Which can prevent dangling DNS records.
- **Support zone apex load balancing** - Alias records allow for zone apex level resource routing to Azure Traffic Manager, which enables load balancing without costly redirection.
- **Link Azure CDN to your DNS zone apex** - With alias records you can now directly reference your Azure Content Network (CDN).

The zone apex load balancing is of most importance to you. Using this feature of alias records will allow you to create a link from the zone apex (wideworldimports.com) to the public IP address of your load balancer. By using alias records, should the IP address of the load balancer change at some future date, you know the zone apex alias record will automatically be updated. Which reduces maintenance overheads, prevents dangling DNS records, and improves the availability and resilience of your website.

## Creating Alias Records

An alias record is created in the same way any other DNS zone record.

On the Azure portal:

1. Navigate to the resource groups and locate the myResourceGroup.
1. Select the wideworldimports.com DNS zone.
1. Select **Add Record**.
    - **Name** - Leave the name blank, since it represents the DNS zone for wideworldimports.com.
    - **Type** - Select **A**. Even though we are creating an alias, it needs to be one of either: A, AAAA or CNAME.
    - **Alias record set** - Set this **Yes**.
    - **TTL** - is the time-to-live period. Which is how long each DNS server will cache the resolution before it is purged. Type: **1**.
    - **TTL unit** - allows you to specify the TTL unit, which can be: Seconds, Minutes, Hours, Days, and Weeks. Accept the default value of: **hours**.
    - **Azure Resource** - Select the public IP address of load balancer, or traffic manager service.
1. Select **OK** to add the record to your zone.

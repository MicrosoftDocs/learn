The web development team are busy completing the new company website.

In the past, you've used third-party vendors to register and host your domain details. One of the requirements of this redevelopment is to host the domain on your Azure servers.

You want to find out how Azure can assist in hosting the domain using Azure DNS.

In this unit, you'll learn what DNS is and how it works. Then see what Azure DNS is, and why you would use it.

## What is DNS

Azure DNS enables you to host your DNS records for your domains on Azure infrastructure. It uses the anycast networking routing methodology to choose a route to the closest available DNS server.

The DNS, or the Domain Name System, is a protocol within the TCP/IP standard. The DNS serves an essential role of translating the human-readable domain names, for example, www.wideworldimports.com into a known Internet Protocol (IP) address. IP addresses enable computers and network devices to identify and route requests between themselves.

Think of the DNS as a lookup table. It's much like using a phone book to find a telephone number. Only, in this case, the phone number is the IP address of the server hosting your website, web service, or load balancer.

The DNS uses a global directory hosted on servers around the world. Microsoft is part of that network providing a DNS service through Azure DNS.

> [!NOTE]
> A DNS server is also known as a DNS name server, or just a name server.

## How does DNS work

A DNS server carries out one of two primary functions:

- To maintain a local cache of recently accessed/used domain names and their IP addresses. Which provides a faster response to a local domain lookup request. If it can't find the requested domain, it passes the request to another DNS server. This process repeats at each DNS server until either a match is made, or the search times out.
- Maintaining the key-value pair database of IP addresses and any host or subdomain the DNS server has authority over. Which is often associated with mail, web, and other internet domain services.

### Finding a DNS server

In order for a computer, server or other network enabled device to access web-based resources it must reference a DNS server.

The DNS servers are assigned when requesting an IP address from your DHCP server. When you connect from your on-premises network, the DNS settings will come from your server. When accessing the web from an external location, like a hotel. The DNS settings will come from your ISP.

### Operation of a DNS server

Here is a simplified overview of a DNS server when resolving a domain name look up request:

- Check to see if the domain name is stored in the short-term cache. If so, the DNS server can resolve the domain request.
- If the domain isn't in the cache, it contacts one or more DNS servers on the web to see if they have a match. When found, it updates the local cache and resolves the request.
- If the domain   after a reasonable number of DNS checks, it responds with a "domain cannot be found" (404) error.

### IPv4 and IPv6

Every computer, server, or network enabled device on your network has an Internet Protocol (IP) address. An IP address, within your domain, will be unique. There are two standards of IP address: IPv4 and IPv6.

- **IPv4** is composed of four numbers, in the range 0 to 255, separated by a dot. For example: 127.0.0.1. Today, IPv4 is the most commonly used standard. Yet, with the increase in IoT devices, the IPv4 standard will eventually be unable to keep up.

- **IPv6** is a relatively new standard and will eventually replace IPv4. It's made up of eight groups of hexadecimal numbers, each separated by a colon. For example: fe80:11a1:ac15:e9gf:e884:edb0:ddee:fea3.

Today, more and more network devices are provisioned with both an IPv4 and an IPv6 address. The DNS name server now has the capability of resolving domain names to both IPv4 and IPv6 addresses.

### DNS settings for your domain

Whether the DNS server for your domain is hosted by a third-party or managed in-house, you'll need to configure it for each host type you're using:

- Web
- Email
- Other services you're using

As the administrator for your company, you want to set up a DNS server using Azure DNS. In this instance, the DNS server will act as a **Start of Authority** (SOA) for your domain.

### DNS record types

The configuration information for your DNS server is stored in zone files on your DNS server. Each zone file is called a record. These record types are the most commonly created and used, but there are others:

- **A** is the host record, and is the most common type of DNS record. It maps the domain/host name to the IP address.
- **CNAME** is the canonical name, or the alias for an A record. You would use CNAME if you had different domain names that all accessed the same website.
- **MX** is the mail exchange record. It maps mail requests to your mail server, whether hosted on-premises or in the cloud.

Besides the three record types above, there are also these record types:

- Wildcards
- CAA (Certificate Authority)
- NS (Name Server)
- SOA (Start of Authority)
- SPF (Sender policy framework)
- SRV (server locations)
- TXT.

The SOA and NS records are created automatically when you create a DNS zone using Azure DNS.

### Record sets

Some record types support the concept of record sets, or resource record sets. A Record set allow for multiple resources to be defined in a single record. For example, here is an A record that has one domain with two IP addresses:

    www.wideworldimports.com.     3600    IN    A    127.0.0.1
    www.wideworldimports.com.     3600    IN    A    127.0.0.2

> [!NOTE]
> SOA and CNAME records cannot contain record sets.

## What is Azure DNS

Microsoft provides a globally distributed name server infrastructure for hosting and managing your domains called Azure DNS. Built on Azure monitoring technology, it allows management of all your domains using your existing Azure credentials.

The Azure DNS will act as the **start of authority** (SOA) for your domain.

At present, you can't use Azure DNS to register a domain name. You'll still need to use a third-party domain registrar to register future domains.

## Why use Azure DNS to host your domain

Azure DNS is built on the Azure Resource Manager service, which comes with a host of benefits.

- Improved security
- Ease of use
- Private DNS domains
- Alias record sets

At this time, Azure DNS doesn't support Domain Name System Security Extensions or DNSSEC.  If you require this security extension, you should host those portions of your domain with a third party.

### Security Features

Azure DNS provides a number of security features:

- Role-based access control, which gives fine-grained control for user access to Azure resources. You can monitor their usage, control the resources and services they have access to.
- Activity logs, which let you track changes to resource and pinpoint where faults occurred.
- Resource locking, which gives a greater level of control to restrict or remove access to resource groups, subscriptions, or any Azure resources.

### Ease of use

Azure DNS is integrated into the Azure portal. Once you've logged in using your existing credentials, you can manage your Azure DNS alongside your existing resources. Using Azure DNS seamlessly integrates into your exiting billing and subscriptions.

Azure DNS will act as your SOA for your organization, allowing you to manage all your DNS records. Using the portal you can create and manage all your DNS zones.

### Private domains

This feature is presently in public preview, and will be made available soon.

A regular Azure DNS handles the translation of external domain names to an IP address. An Azure Private DNS extends that capability to virtual machines running on a virtual network. Sidestepping the need to create a custom DNS solution.

An Azure Private DNS allows you to use your own custom domain names and can provide resolution services for all your VMs.

### Alias Records

Alias records are a powerful feature of Azure DNS. They exist as part of the DNS record set, and  can point to an Azure resource. For example, you can set up an alias to direct traffic through the Traffic Manager profile, or use the Azure Content Delivery Network.

The alias record set is supported in the following DNS record types:

- A
- AAAA
- CNAME

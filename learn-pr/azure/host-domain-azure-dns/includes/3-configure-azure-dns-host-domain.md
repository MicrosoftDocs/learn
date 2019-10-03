The new company website is in final testing. The project manager has read your review of Azure DNS and is keen for to know what the next steps will be.

You've been tasked with planning the steps to allow the wideworldimports.com domain to be deployed using Azure DNS.

In this unit, you'll learn:

- Create a DNS zone for your domain using Azure DNS
- Understand how to link your domain to an Azure DNS zone.
- Configure custom DNS settings
- Understand the difference between private and public DNS zones.
- Understand different DNS record options

## Create a DNS zone in Azure

You've used a third-party domain-name registrar to register the wideworldimports.com domain. The domain is presently parked, since it doesn't point to your companies or any other website yet.

To begin hosting the domain name with Azure DNS, you'll first need to create a DNS zone for that domain. A DNS zone holds all the DNS entries for your domain.

When creating a DNS Zone, you'll need to supply the following details:

- **Name** - is the name of your domain, in this instance wideworldimports.com.
- **Subscription** - select the subscription to be used.
- **Resource group** - is the name of the resource group for domains. If one doesn't exist, you should create one. Which will allow for better control and management.
- **Location** - should be the nearest area to you, for example, East US.

### Obtain your Azure DNS name servers

Once you've created a DNS Zone for the domain, you need to get the name server details. From Azure portal resource group, find the DNS zone details, which include the newly created name servers (NS).

The name server details will be used to update the domain registrar's information to point to the Azure DNS zone we created.

### Update the domain registrar setting

As the owner of the domain, you need to log into the domain management application provided by your domain registrar. From the management application, edit the NS record, and change the NS details to match your Azure DNS name server details.
Changing NS details is called domain delegation. When delegating the domain, you must use all four name servers provided by Azure DNS.

### Verify delegation of domain name services

The next step is to verify the delegated domain now points to the Azure DNS zone you created for the domain. Which can take as little as 10 minutes, but could take longer.

To verity the success of the domain delegation, you'll need query the Start of Authority (SOA) record. The SOA record was automatically created when the Azure DNS zone was set up. You can do this using a third-party tool like nslookup.

The SOA record represents your domain and will become the reference point when other DNS servers are searching for your domain on the internet.

To verify the delegation you would use nslookup like this:

```dos
nslookup -type=SOA wideworldimports.com
```

## Configure your custom DNS settings

So far, you've registered a domain with your registrar and altered their NS records to point to the Azure DNS name space.

The domain name is wideworldimports.com. When used in a browser, the domain will resolve to your website. But what if you want to add in web servers, or load balancers. These resources need to have their own custom settings in the DNS zone, either as a CNAME, or an A record.

From Azure portal, find your DNS zone and add a record set for each custom domain you want to add. It is a good idea to find the IP address of the server you point the domain at.

Each A record requires the following details:

- **Name**, is the name of the custom domain, for example webserver1.
- **Type**, in this instance, it will A.
- **TTL**, represents the Time to Live. Which represents as a whole unit, where 1 is one hour. This value indicates how long the A record will live in a DNS cache before it expires.
- **IP address**, the IP address of the server this A record will resolve to.

If you exposed a web function, you would create a CNAME record that resolves to the Azure function.

## Private DNS zones

Azure DNS supports the provision of private DNS zones. While presently in public preview on Azure, the functionality will be available shortly.  A private DNS allows for domain name resolution on a virtual network. It allows you to create and use your own custom domain names within the virtual network without having to create a custom DNS solution.  Using domain names gives greater flexibility in the design of your network architecture.

A private DNS zone is only available within your domain, predominately using a VNET on your on-premises network. To create a private DNS, you must link the virtual network with the Private DNS zone.

Benefits of a private DNS:

- No need to invest in a bespoke DNS solution. DNS zones are now supported as part of the Azure infrastructure.
- All DNS record types are supported: A, CNAME, TXT, MX, SOA, AAAA, PTR, and SVR.
- Hostname records are managed automatically, the hostnames for VMs in your VNET are automatically maintained.
- Split-horizon DNS support allows the same domain name to exist in both private and public and to resolve to the correct one based on the originating request location.

### Link your VNET to a private DNS zone

There are a few things you'll need before you can link a VNET to a private DNS. First you'll create a Private DNS zone. Log into your Azure portal, and then search for and create a **private DNS zone**. Next, you'll need to create a VNET, which you'll do by creating a new **virtual network** resource.  Finally, you'll need to link them together. Start by finding the private DNS zone you created previously, and open the resource.  From within the resource, add a link to the virtual network you previously created.

### DNS records and configurations

The three primary records types needed in the public DNS zone are A, CNAME, and TXT.

#### A record

The A record maps a domain name to one or more IPv4 addresses. The settings for a webserver under the wideworldimports.com domain would be:

- Name: **websrv01**
- Resource group: The resource group allocated for the public domain.
- TTL: **3600**
- Record type: **A**
- IP address: The IP address assigned to the webserver.

#### CNAME record

The CNAME is the canonical name, or the alias for an A record. You would use CNAME if you had different domain names that all accessed the same website.

For your domain, the following settings are needed in the CNAME record.

- NAME: **wideworldimports.com**
- Resource group: The name of the resource group the domain is assigned to.
- TTL: **600**
- Record type: **CNAME**

#### TXT record

Used only at the time of configuration, the TXT record verifies that you own the custom domain.

To verify our domain, the following settings should be used:

- Name: **wideworldimports.com**
- Resource group: The name of the resource group the domain is assigned to.
- TTL: **3600**
- Record type: **TXT**

The new company website is in final testing. The project manager has read your review of Azure DNS and is keen for to know what the next steps will be.

You have been tasked with planning the steps to allow the www.wideworldimports.com domain to be deployed using Azure DNS.

In this unit, you'll learn:

- Create a DNS zone for your domain using Azure DNS
- Understand how to link your domain to an Azure DNS zone.
- Configure custom DNS settings
- Understand the difference between private and public DNS zones.
- Understand different DNS record options

## Create a DNS zone in Azure

You have used a third-party domain name registrar to register your domain: wideworldimports.com. This domain is presently in a parked state, since it does not point to your companies or any other website yet.

In order to start hosting the domain name with Azure DNS, you will first need to create a DNS zone for that domain. A DNS zone holds all the DNS entries for your domain.

When creating a DNS Zone, you will need to supply the following details:

- **Name** - is the name of your domain, in this instance wideworldimports.com.
- **Subscription** - select the subscription to be used.
- **Resource group** - is the name of the resource group for domains. If one doesn't exist, you should create one. Which will allow for better control and management.
- **Location** - should be the nearest area to you, for example East US.

### Obtain your Azure DNS name servers

Once you have created a DNS Zone for the domain, you need to find the name server details. From Azure portal's resource group, you can find the DNS zone details, which include the newly created name servers.

The name server details will be used to update the domain registrar's information to point to the Azure DNS zone we created.

### Update the domain registrar setting

As the owner of the domain, you need to log into the domain management application provided by your domain registrar. From the management application, you will need to edit the NS record. You will change the NS details to match your Azure DNS name server details. Changing NS details is called Domain delegation. When delegating the domain, you must use all four name servers provided by Azure DNS.

### Verify delegation of domain name services

The next step is to verify the delegated domain now points to the Azure DNS zone you created for the domain. Which can take as little as 10 minutes, but could take longer.

In order to verity the domain delegation has been successful, you will need query the SOA record that was automatically created when the Azure DNS zone was created. Which can be done using a third-party tool like nslookup, which will query the DNS zone SOA record

The SOA or start of authority record represents your domain and will become the reference point when other DNS servers are searching for your domain on the internet. 

To verify the delegation you would use nslookup like this:

```dos
nslookup -type=SOA wideworldimports.com
```

## Configure your custom DNS settings

So far, you've registered a domain with your registrar and altered their NS records to point to the Azure DNS name space.

The domain name is wideworldimports.com. When used in a browser, the domain will resolve to your website. But what if you want to add in web servers, load balances or the such. These resources need to have their own custom settings in the DNS zone, either as a CNAME or an A record.

From the Azure portal, you'll find your DNS zone and add a record set for each custom domain you want to add. Before you start, you should know the IP address of the server the custom domain will resolve to.

Each A record requires the following details:

- **Name**, is the name of the custom domain, for example webserver1.
- **Type**, in this instance, it will A.
- **TTL**, represents the Time to Live. Which represents as a whole unit, where 1 is one hour. This value indicates how long the A record will live in a DNS cache before it expires.
- **IP address**, the IP address of the server this A record will resolve to.

If you exposed a web function, you would create a CNAME record that resolves to the Azure function.

## Private DNS zones

**Public** - This DNS zone is available to the internet and includes Azure public-facing services.

**Private** - This DNS zone is only available within your domain, predominately using a VNET on your on-premises network.

Azure DNS supports the provision of private DNS zones. While presently in public preview on Azure, the functionality will be available shortly.  A private DNS allows for domain name resolution on a virtual network. Which allows you to create and use your own custom domain names within a virtual network without having to create a custom DNS solution.  Using domain names gives greater flexibility in the design of your network architecture.

To create a private DNS, you must link the virtual network with the Private DNS zone.

Benefits of a private DNS:

- **No need to invest in a bespoke DNS solution** - DNS zones are now supported as part of the Azure infrastructure.
- **All DNS record types are supported** - A, CNAME, TXT, MX, SOA, AAAA, PTR, and SVR.
- **Hostname records are managed automatically** - Hostnames for VMs in your VNET are automatically maintained.
- **Split-horizon DNS support** - allows the same domain name to exist in both private and public and to resolve to the correct one based on the originating request location.

### Link your VNET to a private DNS zone

> [!NOTE]
> Azure DNS private zones are currently in public preview.

Before you can link a VNET, you first need to create a Private DNS zone. To do this log into your Azure portal. Then search for and create a private DNS zone.  Which requires the following information:

- **Resource Group**, this is the resource group to be associated with the private domain you want tot create.
- **Name**, this is the private domain you want to create, for example, private.wideworldimports.com.

Now that you have a private network, you will need to create a VNET.

- From the Azure portal, select create a resource.
- Now choose **Networking**
- Finally select the type of network you want: **virtual network**.
- You'll need to give it a name, in this case we'll use: **pVNET**.
- Set the location to be the nearest one to you.
- Then select create.

This will create you a VNET, which needs to be connected to your DNS zone.

- From resource group, open the resource group associated with the private network. Once there selects the private.wideworldimports.com private DNS zone, you created earlier.
- Select Virtual network link and then select add.
- Give the new VNET link a name: **pLink**.
- Now you need create an association between the VNET and this link. Select the VNET you created earlier: **pVNET**.
- Check the auto registration box and select okay.

### DNS records and configurations

In your role as the administrator for your company, you now understand how to delegate the domain to Azure DNS zones and how to configure a virtual network to support a private DNS zone.

The three primary records types needed in the public DNS zone are A, CNAME, and TXT.

**A record**

The A record maps a domain name to one or more IP addresses. Typically these IP addresses will use the IPv4 standard. The settings for a webserver under the wideworldimports.com domain would be:

- Name: websrv01
- Resource Group: The resource group allocated for the public domain.
- TTL: 3600
- Type: A
- IP address: The IP address assigned to the webserver.

**TXT record**

Used only at the time of configuration, the TXT record verifies that you own the custom domain. 

To verify our domain, the following settings should be used:

- Name: wideworldimports.com
- Resource Group: The name of the resource group the domain is assigned to.
- Record Type: TXT
- TTL: 3600

**CNAME record**

This is the canonical name, or the alias for an A record. You would use this if you had different domain names that all accessed the same website.

For your domain, the following settings are needed in the CNAME record.

- NAME: wideworldimports.com
- ttl: 600
- record type: CNAME
- resource group: The name of the resource group the domain is assigned to.

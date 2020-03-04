The new company website is in final testing. You're working on the plan to deploy the wideworldimports.com domain by using Azure DNS. You need to understand what steps are involved.

In this unit, you'll learn how to:

- Create a DNS zone for your domain using Azure DNS
- Understand how to link your domain to an Azure DNS zone
- Configure custom DNS settings
- Understand the difference between private and public DNS zones
- Understand different DNS record options

## Step 1: Create a DNS zone in Azure

You used a third-party domain-name registrar to register the wideworldimports.com domain. The domain doesn't point to your organization's website yet.

To begin hosting the domain name with Azure DNS, you first need to create a DNS zone for that domain. A DNS zone holds all the DNS entries for your domain.

When creating a DNS Zone, you need to supply the following details:

- **Name**: The name of your domain, in this instance wideworldimports.com.
- **Subscription**: The subscription to be used.
- **Resource group**: The name of the resource group to hold your domains. If one doesn't exist, create one to allow for better control and management.
- **Location** - Nearest region to you, for example, East US.

## Step 2: Get your Azure DNS name servers

After you create a DNS Zone for the domain, you need to get the name server details. Go to the resource group to find the DNS zone details, which include the newly created name servers (NS).

The name server details is used to update the domain registrar's information so it points to the Azure DNS zone we created.

## Step 3: Update the domain registrar setting

As the owner of the domain, you need to sign in to the domain management application provided by your domain registrar. In the management application, edit the NS record, and change the NS details to match your Azure DNS name server details.

When you change the NS details that's called domain delegation. When you delegate the domain, you must use all four name servers provided by Azure DNS.

## Step 4: Verify delegation of domain name services

The next step is to verify the delegated domain now points to the Azure DNS zone you created for the domain. Which can take as little as 10 minutes, but could take longer.

To verity the success of the domain delegation, you query the Start of Authority (SOA) record. The SOA record was automatically created when the Azure DNS zone was set up. You can do this using a third-party tool like nslookup.

The SOA record represents your domain and will become the reference point when other DNS servers are searching for your domain on the internet.

To verify the delegation you would use nslookup like this:

```dos
nslookup -type=SOA wideworldimports.com
```

## Step 5: Configure your custom DNS settings

The domain name is wideworldimports.com. When used in a browser, the domain will resolve to your website. But what if you want to add in web servers, or load balancers. These resources need to have their own custom settings in the DNS zone, either as a CNAME, or an A record.

From Azure portal, you find your DNS zone and add a record set for each custom domain you want to add. It's a good idea to find the IP address of the server you point the domain at.

Each A record requires the following details:

- **Name**: The name of the custom domain, for example webserver1.
- **Type**: In this instance, it will A.
- **TTL**: Represents the Time to Live as a whole unit, where 1 is one hour. This value indicates how long the A record lives in a DNS cache before it expires.
- **IP address**: The IP address of the server this A record should resolve to.

If you exposed a web function, you would create a CNAME record that resolves to the Azure function.

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

## Step 6: Link your virtual network to a private DNS zone

Create a private DNS zone in Azure and link to the virtual network.
The new company website is in final testing. You're working on the plan to deploy the wideworldimports.com domain by using Azure DNS. You need to understand what steps are involved.

In this unit, you'll learn how to:

- Create and configure a DNS zone for your domain using Azure DNS
- Understand how to link your domain to an Azure DNS zone
- Create and configure a private DNS zone

## Configure a public DNS zone

A DNS zone is used to host the DNS records for a domain such as wideworldimports.com. 

### Step 1: Create a DNS zone in Azure

You used a third-party domain-name registrar to register the wideworldimports.com domain. The domain doesn't point to your organization's website yet.

To host the domain name with Azure DNS, you first need to create a DNS zone for that domain. A DNS zone holds all the DNS entries for your domain.

When creating a DNS Zone, you need to supply the following details:

- **Name**: The name of your domain, in this instance wideworldimports.com.
- **Subscription**: The subscription to be used.
- **Resource group**: The name of the resource group to hold your domains. If one doesn't exist, create one to allow for better control and management.
- **Location** - Nearest region to you, for example, East US.

### Step 2: Get your Azure DNS name servers

After you create a DNS Zone for the domain, you need to get the name server details from name servers (NS) record. You use these details to update your domain registrar's information and point to the Azure DNS zone.

### Step 3: Update the domain registrar setting

As the owner of the domain, you need to sign in to the domain management application provided by your domain registrar. In the management application, edit the NS record, and change the NS details to match your Azure DNS name server details.

When you change the NS details that's called domain delegation. When you delegate the domain, you must use all four name servers provided by Azure DNS.

### Step 4: Verify delegation of domain name services

The next step is to verify the delegated domain now points to the Azure DNS zone you created for the domain. Which can take as little as 10 minutes, but could take longer.

To verity the success of the domain delegation, you query the Start of Authority (SOA) record. The SOA record was automatically created when the Azure DNS zone was set up. You can do this using a third-party tool like nslookup.

The SOA record represents your domain and will become the reference point when other DNS servers are searching for your domain on the internet.

To verify the delegation you would use nslookup like this:

```dos
nslookup -type=SOA wideworldimports.com
```

### Step 5: Configure your custom DNS settings

The domain name is wideworldimports.com. When used in a browser, the domain resolves to your website. But what if you want to add in web servers, or load balancers? These resources need to have their own custom settings in the DNS zone, either as a CNAME, or an A record.

Each A record requires the following details:

- **Name**: The name of the custom domain, for example webserver1.
- **Type**: In this instance, it will A.
- **TTL**: Represents the Time to Live as a whole unit, where 1 is one hour. This value indicates how long the A record lives in a DNS cache before it expires.
- **IP address**: The IP address of the server this A record should resolve to.

If you exposed a web function, you would create a CNAME record that resolves to the Azure function.

### DNS records and configurations

The three primary records types needed in the public DNS zone are A, CNAME, and TXT.

#### A record

The A record maps a domain name to one or more IPv4 addresses. The settings for a webserver under the wideworldimports.com domain might look like:

- Name: **websrv01**
- Resource group: The resource group allocated for the public domain.
- TTL: **3600**
- Record type: **A**
- IP address: The IP address assigned to the webserver.

#### CNAME record

The CNAME is the canonical name, or the alias for an A record. You would use CNAME where you have different domain names that all accessed the same website. For example, you may need a CNAME in the wideworldimports zone where you want www.wideworldimports.com and wideworldimports.com to resolve to the same IP address. You would create the CNAME record in the wideworldimports zone with the following information.

- NAME: **www**
- TTL: **600** seconds
- Record type: **CNAME**

#### TXT record

The TXT record verifies that you own the custom domain. It's used only at the time of configuration.

To verify our domain, we might use the following information:

- Name: **wideworldimports.com**
- Resource group: The name of the resource group the domain is assigned to.
- TTL: **3600**
- Record type: **TXT**

## Configure private DNS zone

If you want to provide name resolution for virtual machines (VMs) within a virtual network and between virtual networks, create a private DNS zone.

### Step 1: Create private DNS zone

In the Azure portal, search on **private dns zones**. To create the private zone, you need enter a resource group and name of the zone. For example, the name might be something like private.wideworldimports.com.

### Step 2: Identify virtual networks

Let's assume your organization has already created your virtual machines (VMs) and virtual networks in a production environment. Identify the virtual networks associated with VMs that need name resolution support. To link the virtual networks to the private zone, you need the virtual network names.

### Step 3: Link your virtual network to a private DNS zone

To link the private DNS zone to a virtual network, you create a virtual network link. In the Azure portal, you go to the private zone and select **Virtual network links**. From there you select the virtual network you want to link to the private zone. You add a link virtual network link record for each virtual network that needs private name resolution support.

In the next unit, you'll learn how to create a public DNS zone.
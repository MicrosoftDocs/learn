In the previous unit, we discussed how you might go about setting up and configuring the widewworldimports.com domain to point to your Azure hosting on Azure DNS.

In this unit, you'll:

- Set up an Azure DNS and create a public DNS zone
- Create an A Record
- Verify the A record resolves to an IP address

## Create a DNS zone in Azure DNS

Before you can host the wideworldimports.com domain on your servers, you need to create a DNS zone. The DNS zone holds all the configuration records associated with your domain.

To create your DNS zone, follow these steps:

1. Sign in to the [Azure portal](https://portal.azure.com?azure-portal=true) with the account you used to activate this sandbox.
1. Select **+ Create a resource**.
1. Search for and select **DNS zone**.
1. Select **Create**.

    ![image showing the DNS Zone create option](../media/4-dnszonecreate.png)
1. Enter the following information:

    ![image showing the DNS zone create page](../media/4-creatednszone.png)

   |Field  |Value |
   |---------|---------|
   |Subscription     |  Concierge subscription       |
   |Resource group    |   <rgn>[sandbox resource group name]</rgn>      |
   |Name   |   wideworldimports.com    |

1. Select **Review + create**.
1. Select **Create**.

   It'll take a few minutes to create the DNS zone.
1. Select **Go to resource**.

   By default the NS and SOA records are automatically created. The NS record defines the Azure DNS name spaces and contains the four Azure DNS recordsets. You use all four recordsets when you update the registrar.

   The SOA record, or start of authority represents your domain, and is used when other DNS servers are searching for your domain.
1. Make a note of the NS record values as you'll need them next.

## Create a DNS record

Now the DNS zone exists, you need to create the necessary records to support the domain.

The primary record to create is the A record. This record contains the pairing between the IP address and the domain name. The A record can have multiple entries, called recordsets. When using recordsets, the domain name remains constant, while the IP address are different.

1. In the Azure portal, select **All Resources**.
1. Select **wideworldimports.com**.
1. Select the **+ Record set**. 

    ![Screenshot of the DNS zone page](../media/4-add-a-record.png)

1. Enter the following information:

    ![Image of the completed A record](../media/4-arecord.png)

    |Field  |Value |Description  |
    |---------|---------|---------|
    |Name     |   www      |Host name that you want to resolve to an IP address |
    |Type    |     A    |  The A record is the most commonly used. If you are using IPv6, you would select the **AAAA** type.     |
    |Alias record set    | No   | Can only be applied to A, AAAA, and CNAME record types.  |
    |TTL     |      1  | Time-to-live period which specifies how long each DNS server caches the resolution before it is purged.        |
    |TTL unit     |    hours     |  Allows you to specify the TTL unit, which can be: Seconds, Minutes, Hours, Days, and Weeks.  |
    |IP Address    |    10.10.10.10     |  The IP address the record name resolves to. In a real-world scenario, you would enter the public IP address for your web server.       |

1. Select **OK** to add the record to your zone.

In a real-world scenario, you may have more than one IP address set up for your webserver. In that case, you would add all the associated IP addresses as part of a recordset. You can update the recordset after it's created with additional IP addresses.

## Verify your global Azure DNS

In a real-world scenario, after you create the public DNS zone, you update the domain name registrar NS records to delegate the domain to Azure.

Even though we don't have a registered domain, it's still possible to verify the DNS zone works as expected by using the the nslookup tool.

### Use nslookup to verify the configuration

In this step, you use `nslookup` to verify the DNS zone configuration.

1. Use the Cloud Shell on the right to run the following command. Replace the name server address with one of the NS values you copied after you created the DNS zone.

    ```bash
    nslookup www.wideworldimports.com <name server address>
    ```

   The command should look something like the following:

    ```bash
    nslookup www.wideworldimports.com ns1-07.azure-dns.com
    ```

1. You should see the host name `www.wideworldimports.com` resolves to `10.10.10.10`.

   ![Screenshot of the Cloud Shell showing the nslookup results](../media/4-nslookup.png)

You have successfully setup a DNS zone and created an A record.


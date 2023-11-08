In the previous unit, we described setting up and configuring the wideworldimports.com domain to point to your Azure hosting on Azure DNS.

In this unit, you'll:

- Set up an Azure DNS and create a public DNS zone.
- Create an A record.
- Verify that the A record resolves to an IP address.

## Create a DNS zone in Azure DNS

Before you can host the wideworldimports.com domain on your servers, you need to create a DNS zone. The DNS zone holds all the configuration records associated with your domain.

To create your DNS zone:

1. Sign in to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) with the account you used to activate the sandbox.

1. On the Azure **home** page, under **Azure services**, select **Create a resource**. The **Create a resource** pane appears.

1. In the *Search services and marketplace* search box, search for and select **DNS zone** by Microsoft. The **DNS zone** pane appears.

1. Select **Create** > **DNS zone**.

    :::image type="content" source="../media/4-dnszonecreate.png" alt-text="Screenshot of DNS zone, with Create highlighted.":::

    The **Create DNS zone** pane appears.

1. On the **Basics** tab, enter the following values for each setting.

    | Setting  | Value |
    |---------|---------|
    | **Project details** |
    | Subscription  |  Concierge subscription  |
    | Resource group  | From the dropdown list, select <rgn>[sandbox resource group]</rgn> |
    | **Instance details** |
    | Name  |   The name needs to be unique in the sandbox. Use `wideworldimportsXXXX.com`, replacing the Xs with letters or numbers. |

    :::image type="content" source="../media/4-creatednszone.png" alt-text="Screenshot of Create DNS zone page.":::

1. Select **Review + create**.

1. After validation passes, select **Create**. It'll take a few minutes to create the DNS zone.

1. When deployment is complete, select **Go to resource**. Your **DNS zone** pane appears.

   By default, the NS and SOA record sets are automatically created and automatically deleted whenever a DNS zone is created or deleted. The NS record set defines the Azure DNS namespaces and contains the four Azure DNS records. You use all four records when you update the registrar.

   The SOA record represents your domain, and is used when other DNS servers are searching for your domain.

1. Make a note of the NS record values. You'll need them in the next section.

## Create a DNS record

Now that the DNS zone exists, you need to create the necessary records to support the domain.

The primary record set to create is the A record. The A record set is used to point traffic from a logical domain name to the hosting server's IP address. An A record set can have multiple records. In a record set, the domain name remains constant, while the IP addresses differ.

1. On the **DNS zone** pane for *wideworldimportsXXXX.com*, in the top menu bar, select **+ Record set**.

    :::image type="content" source="../media/4-add-a-record.png" alt-text="Screenshot of the DNS zone page, with + Record set highlighted." lightbox ="../media/4-add-a-record.png":::

    The **Add record set** pane appears.

1. Enter the following values for each setting.

    | Setting  | Value | Description  |
    |---------|---------|---------|
    | Name     |   www      | The host name that you want to resolve to an IP address. |
    | Type    |     A    |  The **A** record is the most commonly used. If you're using IPv6, select the **AAAA** type.     |
    | Alias record set    | No   | This can only be applied to A, AAAA, and CNAME record types.  |
    | TTL     |      1  | The time to live, which specifies the period of time each DNS server caches the resolution before it's purged.        |
    | TTL unit     |    Hours     |  This value can be seconds, minutes, hours, days, or weeks. Here, you're selecting hours.  |
    | IP Address    |    10.10.10.10     |  The IP address the record name resolves to. In a real-world scenario, you'd enter the public IP address for your web server. |

1. Select **OK** to add the record to your zone.

    :::image type="content" source="../media/4-arecord.png" alt-text="Screenshot of A record set." lightbox="../media/4-arecord.png":::

Note that it's possible to have more than one IP address set up for your web server. In that case, you'd add all the associated IP addresses as records in the A record set. After it's created, you can update the record set with additional IP addresses.

## Verify your global Azure DNS

In a real-world scenario, after you create the public DNS zone, you'd update the NS records of the domain-name registrar to delegate the domain to Azure.

Even though we don't have a registered domain, it's still possible to verify that the DNS zone works as expected by using the `nslookup` tool.

### Use nslookup to verify the configuration

Here's how to use `nslookup` to verify the DNS zone configuration.

1. Use Cloud Shell to run the following command. Replace the DNS zone name with the zone you created, and replace `<name server address>` with one of the NS values you copied after you created the DNS zone.

    ```bash
    nslookup www.wideworldimportsXXXX.com <name server address>
    ```

   The command should look something like the following:

    ```bash
    nslookup www.wideworldimportsXXXX.com ns1-04.azure-dns.com
    ```

1. You should see that your host name `www.wideworldimportsXXXX.com` resolves to 10.10.10.10.

    :::image type="content" source="../media/4-nslookup.png" alt-text="Screenshot of Cloud Shell, showing the nslookup results.":::

You've successfully set up a DNS zone and created an A record.

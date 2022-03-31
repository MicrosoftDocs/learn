## Troubleshoot issues with Domain Name System (DNS) records at public providers

Public DNS servers convert domain names to IP addresses to allow people to find web sites and other addresses on the internet. If your VM has internet connectivity, it will need to resolve names from public DNS servers. If you have problems with resolving names from public DNS servers, try the following:

1. Check your VM has internet connectivity.

1. From a command prompt, ping the IP address of the website you are trying to reach. If ping does not get a response, this tells you that the website is not available.

1. Check whether the DNS server is the primary server for the zone, or a secondary copied DNS server. Updates are made to the primary DNS server, so this will always include the latest changes and be the most up to date.  The primary DNS server is also known as the Authoritative DNS. The secondary DNS server is a read-only copy of the primary DNS server.

1. From a command prompt, run nslookup:

   nslookup *name IP address of the DNS server*;

   For example:

   nslookup app1 10.0.0.1

   If you get a failure or time-out response, check for recursion problems. Check the server that was used in your original query forwards queries by examining the Forwarders tab in the Server properties in the DNS console. If the Enable forwarders check box is selected, and one or more servers are listed, this server forwards queries.

   With recursion, all DNS servers that are used in the path of a recursive query must be able to respond and forward correct data. If they can't, a recursive query can fail because:

   - The query times out before it can be completed.

   - A server failed to respond.

   - A server provides incorrect data.

   Nslookup will also tell you whether the name has been resolved by an authoritative or non-authoritative server.

1. Flush the resolver cache by running the dnscmd /clearcache command in an Elevated Command Prompt window:

   - Right select Command Prompt and choose ‘Run as administrator’

   Type dnscmd *servername* /clearcache

   The *servername* is its IP address, FQDN, or hostname. If omitted, the local server is used.

   You can also use **ipconfig -flushdns** to clear the DNS cache.

   Alternatively, in an Elevated PowerShell window, run the following cmdlet:

   Clear-DnsServerCache

   Once you have cleared the cache, try again.

1. Check the DNS server address. If necessary, correct the address.

1. The [dig command](https://phoenixnap.com/kb/linux-dig-command-examples) (domain information groper) gives DNS information which is helpful in troubleshooting problems. It is a free utility which needs to be installed on Windows machines. To get dig information, run the following command:

   dig *domain name or IP*

   DIG displays the **status** of whether a query was successful.

   The **ANSWER SECTION** shows a response to a request sent in the **QUESTION SECTION.**

   The **SERVER** displays the address for the public DNS server.

   By default, dig looks up the **[A record](https://phoenixnap.com/kb/dns-record-types)** for a domain and shows which IP address the domain points to when resolving the name.

   Use **dig** with the **+trace** tag to see the full path to the destination:

   dig contoso.com +trace

   To check the delegated name servers, use the ns option:

   dig contoso.com ns

1. If a computer cannot be reached, try using the commands IPCONFIG / RELEASE and IPCONFIG /RENEW from the computer’s command prompt to refresh cached information. 
   > [!IMPORTANT] 
   > IPCONFIG /RELEASE will disconnect the computer from the internet. Run 
   > IPCONFIG /ALL to check the current information.

1. To check the IP configuration of a computer, run ipconfig /all at a command prompt. Scroll down to verify the IP address, subnet mask, and default gateway. The default gateway will be a router or firewall.

1. The tracert tools displays the route from source to destination. When troubleshooting DNS issues, it helps to identify where packets stopped on the network. Install the traceroute tool using the [apt package manager](https://phoenixnap.com/kb/how-to-manage-packages-ubuntu-debian-apt-get).

   If running on a Windows machine:

   tracert *domain name or IP*

1. If the computer uses the ISP's DNS, and you cannot resolve the issue, contact the ISP.

## Troubleshoot domain configuration issues

To use a domain name with Microsoft 365 products, you must set up your custom domain names in the Microsoft 365 admin center:

1. From the Microsoft 365 admin center, select [Setup](https://go.microsoft.com/fwlink/p/?linkid=2171997).

1. Under Get your custom domain set up, select View > Manage > Add domain.

1. Enter the domain name, and then select Next.

1. If your domain registrar is available, sign in to your domain registrar, and then select Next.

1. Choose the services for your new domain.

1. Select Next > Authorize > Next, and then Finish. Your new domain has been added.

You can check for problems with your domain by checking its status. Go to Setup > Domains and view the notifications in the Status column. If you see an issue, select the three dots (more actions), and then select Check health to display any issues occurring with your domain.

There are a couple of common reasons that domain verification doesn't work as it should:

1. The verification record value is incorrect. Check the value in the TXT verification record at your DNS host. This should include the "MS=" part of the record.

1. The record hasn't been saved. Some DNS hosts require you to save the zone file where the DNS record is stored. If this has not been saved, it will not be visible by Microsoft 365.

1. The record hasn't updated across the Internet. It can take a few minutes or a few hours for a new record to be visible.

## Troubleshoot delegation issues

Azure DNS zones allow you to manage the DNS records for a domain. For domain queries to reach Azure DNS, the parent domain must be delegated to Azure DNS. There are two types of DNS servers:

- An **authoritative** DNS server hosts DNS zones. It answers DNS queries for records in those zones only.

- A **recursive** DNS server doesn't host DNS zones. It answers all DNS queries by calling authoritative DNS servers to gather the data it needs.

Azure DNS provides an authoritative DNS service.

First, you need to know the name servers for your zone. Azure DNS allocates name servers from a pool each time a zone is created.

In the Azure portal, select **All resources**, and then select your DNS zone. Alternatively, enter your domain name in the Filter by name box. Retrieve the name servers from the DNS zone page.

For example, the zone contoso.net might be assigned name servers:

- ns1-01.azure-dns.com

- ns2-01.azure-dns.net

- ns3-01.azure-dns.org

- ns4-01.azure-dns.info

Azure DNS automatically creates authoritative NS records in your zone for the assigned name servers.

Now you have the name servers, you can update the parent domain. Each registrar has its own DNS management tools. From the registrar's DNS management page, edit the NS records and replace the NS records with the Azure DNS name servers.

The image shows an example DNS query, with contoso.net and partners.contoso.net in Azure DNS zones:

:::image type="content" source="../media/3-zones.png" alt-text="Diagram of a DNS query in the Azure DN zones.":::

Each delegation has two copies of the NS records - one in the parent zone pointing to the child, and another in the child zone itself. The 'contoso.net' zone contains the NS records for 'contoso.net', in addition to the NS records in 'net'. These records are called authoritative NS records and they sit at the apex of the child zone.

To troubleshoot domain delegation, try the following:

1. Check you have updated the domain with the name servers that Azure DNS provides. Use all four name servers, regardless of the name of your domain. Domain delegation doesn't require a name server to use the same top-level domain as your domain.

1. Include the trailing period at the end of the name server address. The trailing period indicates the end of a fully qualified domain name. Some registrars append the period if the NS name doesn't have it. To be compliant with the DNS RFC, always include the trailing period.

1. Delegations that use name servers in your own zone, sometimes called vanity name servers, are not supported in Azure DNS.

1. Verify that the delegation is working. Use a tool such as nslookup to query the Start of Authority (SOA) record. The SOA record is automatically created with the zone. Wait at least 10 minutes after delegation has been set up, as it can take a while for changes to propagate through the DNS system.

From a command prompt, enter a nslookup command:

nslookup -type=SOA contoso.net

The response should look similar to this:

Server: ns1-04.azure-dns.com

Address: 208.76.47.4

contoso.net

primary name server = ns1-04.azure-dns.com

responsible mail addr = msnhst.microsoft.com

serial = 1

refresh = 900 (15 mins)

retry = 300 (5 mins)

expire = 604800 (7 days)

default TTL = 300 (5 mins)

## Review Domain Name System (DNS) audit logs

Use DNS Analytics to help you to identify:

- Clients that are trying to resolve malicious domain names.

- Identify stale resource records.

- Identify frequently queried domain names and talkative DNS clients.

- View request load on DNS servers.

- View dynamic DNS registration failures.

DNS Analytics (Preview) collects, analyzes, and correlates Windows DNS analytic and audit logs and other related data from your DNS servers.

- You must install the Log Analytics agent on each Windows DNS server you want to monitor.

- If you are running Operations Manager, you will need to connect it to Azure Monitor.

The solution starts collecting data without the need of further configuration.

You can download DNS Analytics (Preview) from Azure Marketplace. For DNS related insights, the DNS server should be Windows Server 2012 R2 or later.

You can also access DNS Analytics via Azure Monitor and Log Analytics workspaces. In the Azure portal, go to Azure Monitor. On the Insights menu, select Insights Hub, and then select Log Analytics. The Overview page in Azure Monitor displays a tile for each solution installed in a Log Analytics workspace.

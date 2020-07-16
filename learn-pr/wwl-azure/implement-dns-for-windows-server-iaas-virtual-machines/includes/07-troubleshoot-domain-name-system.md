


As lead system engineer at Contoso, you need to know how to identify and resolve critical name resolution and DNS service problems. In this unit, you'll explore troubleshooting Azure DNS and Windows Server DNS, and general name resolution troubleshooting.

## Troubleshooting Azure DNS

If you experience problems administering Azure DNS, review the following table for guidance on how to proceed.

|Problem|What to check|
|----|-----|
|You can't create a DNS zone|Start by reviewing the Azure DNS audit logs. Also, remember that each DNS zone name must be uniquely named within a resource group. If you receive the error `You have reached or exceeded the maximum number of zones in subscription {subscription id}`, use another Azure subscription or delete zones. You can also contact Azure Support to increase your zone subscription limit. If you get the error `The zone '{zone name}' is not available`, try using a different zone name.|
|You can't create a DNS record|Start by reviewing the Azure DNS audit logs. Next, verify that the record set doesn't already exist. Verify that you are not attempting to create a record set at the zone root; if you are, use the `@` character as a prefix. Ensure you do not have an alias (CNAME) conflict. Also, check whether you have reached the limit on the record set number permitted in your DNS zone.  If you have, then either delete some record sets or contact Azure Support to increase the limit.|
|You can't resolve a DNS record|Verify that the queried records are correct. Make sure that the records are correct in Azure DNS. Verify that the petitioned records can be resolved on the Azure DNS name servers. If you're using a local computer to perform the query, check the DNS name cache. If necessary, empty this cache and try again.|

> [!NOTE] 
> You can access DNS log information using DNS Analytics. 

## Troubleshoot Windows Server DNS

Name resolution, like most other technologies, sometimes requires troubleshooting. Issues can occur when the DNS server, its zones, and its resource records are not configured properly. When resource records are causing issues, it can sometimes be difficult to identify the issue because configuration problems are not always obvious. Several tools are available to configure, manage, and troubleshoot DNS server and name resolution issues.

### Command-line tools and commands for troubleshooting

The command-line tools and procedures for troubleshooting name resolution and configuration issues are described in the following table.

|Tool|Description|
|------------------------|------------------------------------------------------------|
|NSLookup|Use to query DNS information. This tool is flexible and can provide valuable information about DNS server status. You also can use it to lookup resource records and validate their configuration. Additionally, you can test zone transfers, security options, and MX record resolution.|
|DNSCmd|Use to manage the DNS server role. This command-line tool is useful in scripting batch files to help automate routine DNS management tasks or to perform simple unattended setup and configuration of new DNS servers on your network.|
|DNSlint|Use to diagnose common DNS issues. This tool diagnoses configuration issues in DNS quickly, and can generate a report in HTML format regarding the status of the domain that you are testing.|
|IPConfig|Use to review IP configuration details that the computer uses. This command includes additional command-line options that you can use to troubleshoot and support DNS clients. For example, you can review the local DNS cache for the client computer by using the command `ipconfig /displaydns`, and you can clear the local DNS cache using the `ipconfig /flushdns` command. If you want to reregister a host in DNS, you can use the `ipconfig /registerdns` command.|
|Monitoring on DNS server|Perform simple local queries and recursive queries from the **Monitoring** tab in the **DNS Server Properties** dialog box to test whether the server can communicate with upstream servers. You also can schedule these tests to occur at regular intervals.|

> [!NOTE] 
> You must download DNSlint from the Microsoft download website as it is not included in Windows.

In Windows Server, you can also use Windows PowerShell cmdlets for DNS client and server management. Some of the most commonly used cmdlets are as described in the following table.

|Cmdlet|Description|
|-------------------- |------------------------------------------------------------ |
|`Clear-DNSClientCache`|This cmdlet clears the client cache, similar to the `ipconfig /flushdns` command.|
|`Get-DNSClient`|This cmdlet displays the details of the network interfaces.|
|`Get-DNSClientCache`|This cmdlet displays the content of the local DNS client cache.|
|`Register-DNSClient`|This cmdlet registers all the IP addresses on the computer onto the configured DNS server.|
|`Resolve-DNSName`|This cmdlet performs a DNS name resolution for a specific name, similar to the way NSLookup works.|
|`Set-DNSClient`|This cmdlet sets the interface-specific DNS client configurations on the computer.|
|`Test-DNSServer`|This cmdlet tests that a specified computer is a functioning DNS server.|

## Name resolution troubleshooting process

When troubleshooting name resolution, you must understand the name resolution methods that the computer uses, and the order in which the computer uses them. Be sure to clear the DNS resolver cache between resolution attempts. If you cannot connect to a remote host and suspect a name resolution problem, troubleshoot the name resolution by performing the following steps:

1. Open an elevated command prompt, and then clear the DNS resolver cache by entering the following command at a command prompt:

   ```powershell
   ipconfig /flushdns
   ```

   > [!NOTE] 
   > The equivalent Windows PowerShell command is: `Clear-DNSClientCache`.

2. Attempt to ping the remote host by its IP address. This helps identify whether the issue is related to name resolution. If the ping succeeds by using the IP address but fails by using its host name, then the problem is related to name resolution.
3. Attempt to ping the remote host by using its host name. For example, at Contoso, you would enter the following command at a command prompt:

   ```powershell
   Ping LON-DC1.contoso.com
   ```

   > [!NOTE] 
   > The equivalent Windows PowerShell command is: `Test-connection LON-DC1.Contoso.com`.

4. At the command prompt, enter the following command, and then select Enter:

   ```powershell
   NSLookup.exe -d2 LON-DC1.contoso.com. > filename.txt
   ```

   > [!NOTE] 
   > The equivalent Windows PowerShell command is: `Resolve-dnsname lon-DC1.Contoso.com. > filename.txt`.

5. Examine the contents of the filename.txt file to identify the failed stage in name resolution.

You should understand how to interpret the NSLookup command output so that you can identify whether the name resolution problem exists with the client computer’s configuration, the name server, or the configuration of records within the name server-zone database.

## Additional reading

You can learn more by reviewing the following document.

- [Gather insights about your DNS infrastructure with the DNS Analytics Preview solution](https://aka.ms/dns-analytics?azure-portal=true).
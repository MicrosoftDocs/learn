You create DNS policies based on level and type. You can use query-resolution policies to define how to manage client name resolution queries, and use zone-transfer policies to define zone transfers. 

> [!TIP]
> You can apply both policy types at the server or zone level.

You can create multiple query resolution policies at the same level if they have a different value for the processing order. Recursion policies are a special type of server-level policy. They control how a DNS server performs query recursion, if at all. Recursion policies only apply when query processing reaches the recursion path. You can choose a value of DENY or IGNORE for recursion for a given set of queries. Otherwise, you can choose a set of forwarders for a set of queries.

## Create and manage DNS policies

The high-level steps to resolve a host record differently for users from a specific IP address range are:

1. Create a DNS server client subnet for the IP address range.
1. Create a DNS server zone scope for the zone containing the host record.
1. Add a host record to the zone that is specific to the zone scope.
1. Add a DNS server query resolution policy that allows the DNS server client subnet to query the zone scope for the zone.

The following is an example of the steps used to configure the DNS policy by using Windows PowerShell:

```powershell
# Create the required subnets
Add-DnsServerClientSubnet -Name "LondonSubnet" -IPv4Subnet "172.16.18.0/24"
Add-DnsServerClientSubnet -Name "SeattleSubnet" -IPv4Subnet "172.16.10.0/24"
# Create the DNS server zone scopes
Add-DnsServerZoneScope -ZoneName "Contoso.com" -Name "LondonZoneScope"
Add-DnsServerZoneScope -ZoneName "Contoso.com" -Name "SeattleZoneScope"
# Add the required host records
Add-DnsServerResourceRecord -ZoneName "Contoso.com" -A -Name "www" -IPv4Address "172.16.10.41" -ZoneScope "SeattleZoneScope"
Add-DnsServerResourceRecord -ZoneName "Contoso.com" -A -Name "www" -IPv4Address "172.16.18.17" -ZoneScope "LondonZoneScope"
# Create the DNS server query resolution policies
Add-DnsServerQueryResolutionPolicy -Name "LondonPolicy" -Action ALLOW -ClientSubnet "eq,LondonSubnet" -ZoneScope "LondonZoneScope,1" -ZoneName "Contoso.com"
Add-DnsServerQueryResolutionPolicy -Name "SeattlePolicy" -Action ALLOW -ClientSubnet "eq,SeattleSubnet" -ZoneScope "SeattleZoneScope,1" -ZoneName "Contoso.com"
```

## Demonstration

The following video demonstrates how to implement DNS policies by using Windows PowerShell. The main steps in the process are:

1. Open Server Manager and open the DNS console.
2. Create a new alias record for an existing server in the Contoso.com zone.
3. Switch to a client computer and verify what IP address is returned when the alias is tested with NSLookup.
4. On a server, open an elevated Windows PowerShell window.
5. Run the `$s = New-PSSession –ComputerName <target server>` and then the `Enter-PSSession $s` command to connect to the `<target server>` with PowerShell remoting.
6. Create the required subnets by running the `Add-DnsServerClientSubnet` cmdlet.
7. Create the DNS server zone scopes by running the `Add-DnsServerZoneScope` cmdlet.
8. Add the required host records by running the `Add-DnsServerResourceRecord` cmdlet.
9. Create the DNS server query resolution policies by running the `Add-DnsServerQueryResolutionPolicy` cmdlet.
10. Switch back to the client, purge the resolver cache, and then test name resolution for the `www.Contoso.com`record.

 >[!VIDEO https://www.microsoft.com/videoplayer/embed/RWxDP5]

---



---
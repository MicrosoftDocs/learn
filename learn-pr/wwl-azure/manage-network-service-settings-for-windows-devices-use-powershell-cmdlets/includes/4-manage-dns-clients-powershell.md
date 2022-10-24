PowerShell offers cmdlets for managing DNS client settings, DNS name query resolution, and for securing DNS clients.

DNS client management cmdlets are part of the **DNSClient** PowerShell module and have the text “DnsClient” in the noun part of the name.

The following table lists common cmdlets for modifying DNS client settings.

*Table 1: Cmdlets for modifying DNS client settings*

| Cmdlet                         | Description                                                  |
| ------------------------------ | ------------------------------------------------------------ |
| **Get-DnsClient**              | Gets details about a network interface                       |
| **Set-DnsClient**              | Sets DNS client configuration settings for a network interface |
| **Get-DnsClientServerAddress** | Gets the DNS server address settings for a network interface |
| **Set-DnsClientServerAddress** | Sets the DNS server address for a network interface          |

> [!NOTE]
> **Set-DnsClient** requires an interface that an alias or index references.

The following command sets the connection-specific suffix for an interface:

```powershell
Set-DnsClient -InterfaceAlias Ethernet -ConnectionSpecificSuffix "adatum.com"
```

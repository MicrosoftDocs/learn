PowerShell supports the **NetSecurity** module that contains cmdlets to manage local Network Security configurations such as Windows firewall rules and IP security settings.

To manage firewall settings, use cmdlets that have the text “NetFirewall” in their names. For firewall rule management, use cmdlets that contain the noun “NetFirewallRule.”

The following table lists common cmdlets for managing firewall settings and rules.

*Table 1: Cmdlets for managing firewall settings and rules*

| Cmdlet                      | Description                            |
| --------------------------- | -------------------------------------- |
| **New-NetFirewallRule**     | Creates a new firewall rule            |
| **Set-NetFirewallRule**     | Sets properties for a firewall rule    |
| **Get-NetFirewallRule**     | Gets properties for a firewall rule    |
| **Remove-NetFirewallRule**  | Deletes a firewall rule                |
| **Rename-NetFirewallRule**  | Renames a firewall rule                |
| **Copy-NetFirewallRule**    | Makes a copy of a firewall rule        |
| **Enable-NetFirewallRule**  | Enables a firewall rule                |
| **Disable-NetFirewallRule** | Disables a firewall rule               |
| **Get-NetFirewallProfile**  | Gets properties for a firewall profile |
| **Set-NetFirewallProfile**  | Sets properties for a firewall profile |

You can use the **Get-NetFirewallRule** cmdlet to retrieve settings for firewall rules. You can enable and disable rules by using one of the following cmdlets:

- The **Set-NetFirewallRule** cmdlet with the *-Enabled* parameter
- The **Enable-NetFirewallRule** or **Disable-NetFirewallRule** cmdlets.

The following commands both enable firewall rules in the group **Remote Access**:

```powershell
Enable-NetFirewallRule -DisplayGroup "Remote Access"
```

and

```powershell
Set-NetFirewallRule -DisplayGroup "Remote Access" -Enabled True
```

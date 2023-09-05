Customizing a host pool's Remote Desktop Protocol (RDP) properties, such as multi-monitor experience and audio redirection, lets you deliver an optimal experience for your users based on their needs. You can customize RDP properties in Azure Virtual Desktop using the **-CustomRdpProperty** parameter in the **Set-RdsHostPool** cmdlet.

## Default Remote Desktop Protocol file properties

RDP files have the following properties by default:

| **RDP properties**         | **Desktops**                                                        | **RemoteApps**                  |
| -------------------------- | ------------------------------------------------------------------- | ------------------------------- |
| Multi-monitor mode         | Enabled                                                             | N/A                             |
| Drive redirections enabled | Drives, clipboard, printers, COM ports, USB devices, and smartcards | Drives, clipboard, and printers |
| Remote audio mode          | Play locally.                                                       | Play locally.                   |

## Add or edit a single custom Remote Desktop Protocol property

To add or edit a single custom Remote Desktop Protocol property, run the following PowerShell cmdlet:

```powershell
Set-RdsHostPool -TenantName <tenantname> -Name <hostpoolname> -CustomRdpProperty "<property>"
```

:::image type="content" source="../media/single-custom-remote-desktop-protocol-property-bfa9c82c.png" alt-text="Image showing adding or editing a single custom property.":::


## Add or edit multiple custom Remote Desktop Protocol properties

To add or edit multiple custom Remote Desktop Protocol properties, run the following PowerShell cmdlets by providing the custom RDP properties as a semicolon-separated string:

```powershell
$properties="<property1>;<property2>;<property3>"
Set-RdsHostPool -TenantName <tenantname> -Name <hostpoolname> -CustomRdpProperty $properties
```

:::image type="content" source="../media/multiple-custom-property-c539e1b8.png" alt-text="Image showing adding or editing a multiple custom property.":::


## Reset all custom Remote Desktop Protocol properties

You can reset individual custom Remote Desktop Protocol properties to their default values, or you can reset all custom remote desktop protocol properties for a host pool by running the following PowerShell cmdlet:

```powershell
Set-RdsHostPool -TenantName <tenantname> -Name <hostpoolname> -CustomRdpProperty ""
```

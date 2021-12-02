Customizing a host pool's Remote Desktop Protocol (RDP) properties, such as multi-monitor experience and audio redirection, lets you deliver an optimal experience for your users based on their needs. You can customize RDP properties in Azure Virtual Desktop using the **-CustomRdpProperty** parameter in the **Set-RdsHostPool** cmdlet.

## Default Remote Desktop Protocol file properties

RDP files have the following properties by default:

:::row:::
  :::column:::
    **RDP properties**
  :::column-end:::
  :::column:::
    **Desktops**
  :::column-end:::
  :::column:::
    **RemoteApps**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Multi-monitor mode
  :::column-end:::
  :::column:::
    Enabled
  :::column-end:::
  :::column:::
    N/A
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Drive redirections enabled
  :::column-end:::
  :::column:::
    Drives, clipboard, printers, COM ports, USB devices, and smartcards
  :::column-end:::
  :::column:::
    Drives, clipboard, and printers
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Remote audio mode
  :::column-end:::
  :::column:::
    Play locally.
  :::column-end:::
  :::column:::
    Play locally.
  :::column-end:::
:::row-end:::


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

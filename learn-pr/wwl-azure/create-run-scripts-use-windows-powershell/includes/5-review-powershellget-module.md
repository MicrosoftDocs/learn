The **PowerShellGet** module includes cmdlets for accessing and publishing items in the PowerShell Gallery. This module was introduced in Windows Management Framework 5.1, which is included in Windows 10 and Windows Server 2016. Windows PowerShell 5.1 ships with PowerShellGet version 1.0.0.1, which must be updated before you can reliably use it with the PowerShell Gallery. The current supported version for Windows PowerShell 5.1 is **PowerShellGet 2.2.5**.

> [!NOTE]
> PowerShell 7.4 and later ships with **Microsoft.PowerShell.PSResourceGet** — the next-generation successor to PowerShellGet. It provides the same core functionality through updated cmdlets such as `Find-PSResource` and `Install-PSResource`. PSResourceGet is also available for Windows PowerShell 5.1 from the PowerShell Gallery.

When you use the cmdlets in the **PowerShellGet** module for the first time, you're prompted to install the NuGet provider. NuGet is a package manager that can obtain and install packages on Windows. The cmdlets in the **PowerShellGet** module use the functionality in NuGet to interact with the PowerShell Gallery.

The following table lists the two cmdlets used most often to find content in the PowerShell Gallery.

*Table 1: Cmdlets used to find content in the PowerShell Gallery*

| Cmdlet        | Description                                                  |
| ------------- | ------------------------------------------------------------ |
| **Find-Module** | Use this cmdlet to search for Windows PowerShell modules in the PowerShell Gallery. At its simplest, it searches by module name, but you can also search by command name, version, DscResource, and RoleCapability. |
| **Find-Script** | Use this cmdlet to search for Windows PowerShell scripts in the PowerShell Gallery. At its simplest, it searches by script name, but you can also search by version. |

> **Additional reading:** You can also search for modules and scripts in the [PowerShell Gallery](https://aka.ms/ue14hl).

## TLS 1.2

The PowerShell Gallery requires the use of Transport Layer Security (TLS) 1.2 to help secure communication. Windows 10 and Windows Server 2016 don't support using TLS 1.2 in Windows PowerShell by default. To download PowerShell Gallery content, you need to enable TLS 1.2.

To enable TLS 1.2 for the current PowerShell prompt, run the following command:

```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 
```

To enable TLS 1.2 permanently, create the following registry keys:

```powershell
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NetFramework\v4.0.30319'-Name 'SchUseStrongCrypto' -Value '1' -Type DWord
```

```powershell
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord
```

## Private PowerShell Gallery

You can implement a private PowerShell gallery for your organization by creating your own NuGet feed. You can create a NuGet feed with a file share or a web-based application. To register the NuGet feed, use the **Register-PSRepository** cmdlet and specify the source location. After you register the repository, users can search it, just like the PowerShell Gallery.

> **Additional reading:** For more information about creating a NuGet feed, refer to [Hosting your own NuGet feeds](https://aka.ms/vm0ys1).


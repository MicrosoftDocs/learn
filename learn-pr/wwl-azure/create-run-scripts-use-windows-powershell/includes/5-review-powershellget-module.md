The **PowerShellGet** module includes cmdlets for accessing and publishing items in the PowerShell Gallery. This module was introduced in Windows Management Framework 5.0, which is included in Windows 10 and Windows Server 2016. You can upgrade older Windows operating systems to include Windows Management Framework 5.0 or newer and thereby obtain the **PowerShellGet** module. Alternatively, if you can't update to Windows Management Framework 5.0, there's a .msi installer for **PowerShellGet** that you can use on systems with Windows PowerShell 4.0.

When you use the cmdlets in the **PowerShellGet** module for the first time, you're prompted to install the NuGet provider. NuGet is a package manager that can obtain and install packages on Windows. The cmdlets in the **PowerShellGet** module use the functionality in NuGet to interact with the PowerShell Gallery.

The following table lists the two cmdlets used most often to find content in the PowerShell Gallery.

*Table 1: Cmdlets used to find content in the PowerShell Gallery*

| Cmdlet        | Description                                                  |
| ------------- | ------------------------------------------------------------ |
| **Find-Module** | Use this cmdlet to search for Windows PowerShell modules in the PowerShell Gallery. The simplest usage conducts searches based on the module name, but you can also search based on the command name, version, DscResource, and RoleCapability. |
| **Find-Script** | Use this cmdlet to search for Windows PowerShell scripts in the PowerShell Gallery. The simplest usage conducts searches based on the script name, but you can also search based on the version. |

> **Additional reading:** You can also search for modules and scripts in the [PowerShell Gallery](https://aka.ms/ue14hl).

## TLS 1.2

The PowerShell Gallery requires the use of Transport Layer Security (TLS) 1.2 to help secure communication. Windows 10 and Windows Server 2016 don't support using TLS 1.2 in Windows PowerShell by default. So, you need to enable TLS 1.2 to download PowerShell Gallery content.

To enable TLS 1.2 for the current PowerShell prompt, run the following command:

```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 
```

To fix this issue permanently on a computer, you need to create registry keys. You can run the following two commands to create the necessary keys:

```powershell
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NetFramework\v4.0.30319'-Name 'SchUseStrongCrypto' -Value '1' -Type DWord
```

```powershell
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord
```

## Private PowerShell Gallery

You can implement a private PowerShell gallery for your organization by creating your own NuGet feed. You can create a NuGet feed with a file share or a web-based application. When you have a private PowerShell gallery, you must register the NuGet feed by using the **Register-PSRepository** cmdlet and specifying the source location. After the repository is registered, users can search it, just like the PowerShell Gallery.

> **Additional reading:** For more information about creating a NuGet feed, refer to [Hosting your own NuGet feeds](https://aka.ms/vm0ys1).


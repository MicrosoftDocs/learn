Exchange Online PowerShell is the module that you can use to manage mail-related objects in Exchange Online, such as mailboxes, contacts, and distribution. Some of the information that you can review and manage by using Exchange Online PowerShell, such as email addresses, you can also review in the properties of user objects with AzureAD cmdlets. However, you can only manage mail-related properties by using Exchange Online PowerShell.

> [!NOTE]
> At the time of writing this learning path, the Exchange Online PowerShell V2 (EXO v2) module is the current version. When researching how to connect to Exchange Online, instructions indicating that you need to use PowerShell remoting or the **Connect-EXOPSSession** cmdlet are outdated and shouldn't be followed.

The EXO v2 module includes all of the original cmdlets for managing Exchange Online, and several additional cmdlets that include **EXO** in the cmdlet name. These EXO cmdlets, such as **Get-EXOMailbox**, are more efficient than the original cmdlets.

## Installing the EXO v2 module

The EXO v2 module is supported in Windows PowerShell 5.1 and PowerShell 7. Because it's supported in PowerShell 7, it's considered multiplatform. You can use the EXO v2 module in Windows, macOS, and Linux.

To install the EXO v2 module, run the following command:

```powershell
Install-Module -Name ExchangeOnlineManagement
```

## Preparing to connect

To use the EXO v2 module, you need to allow scripts. You can set the execution policy to **RemoteSigned** or **Unrestricted**. If you don't allow scripts, you'll notice the error **Files cannot be loaded because running scripts is disabled on this system**.

You also need to allow basic authentication for the WinRM client. This is enabled by default in Windows 10, but some organizations have disabled basic authentication for WinRM as part of security hardening. If Basic authentication isn't enabled, you'll notice the error **The WinRM client cannot process the request. Basic authentication is currently disabled in the client configuration**.

To review the authentication configuration for the Windows Remote Management (WinRM) client, run the following command:

```powershell
winrm get winrm/config/client/auth
```

To enable basic authentication for the WinRM client, run the following command:

```powershell
winrm set winrm/config/client/auth '@{Basic="true"}'
```

> [!NOTE]
> If you run this command from a command prompt instead of a PowerShell prompt, don't include the single quotes around `@{Basic="true"}`.

Even though you need to enable Basic authentication in the WinRM client, the EXO v2 module authenticates to Exchange Online by using Modern authentication. In some rare cases, Modern authentication might not be enabled for Exchange Online and you'll need to enable it.

> [!NOTE]
> All Exchange Online deployments should be using Modern authentication. This is because it has significant security enhancements over Basic authentication.

## Connecting to Exchange Online

You can connect to Exchange Online by using the **Connect-ExchangeOnline** cmdlet with no additional parameters. When you connect to Exchange Online, you're prompted for a username and password to sign in. You need to sign in with a user account that has sufficient privileges to complete the actions you want to perform. You might also be prompted for multifactor authentication.

> [!NOTE]
> For tenants in China or Germany, you need to use the *-ExchangeEnvironmentName* parameter and specify **O365China** or **O365Germany**, respectively. For secure US government tenants, you need to specify **O365USGovGCCHigh** or **O365USGovDOD**.

If you're behind a proxy server, you might need to provide proxy options as part of connecting. To do this, provide a **PSSessionOption** object the proxy configuration information. The following example depicts how to create a new **PSSessionOption** object and then use it when connecting to Exchange Online:

```powershell
$ProxyOptions = New-PSSessionOption -ProxyAccessType IEConfig
Connect-ExchangeOnline -PsSessionOption $ProxyOptions
```

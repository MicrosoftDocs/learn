Exchange Online PowerShell is the module that you can use to manage mail-related objects in Exchange Online, such as mailboxes, contacts, and distribution. Some of the information that you can review and manage by using Exchange Online PowerShell, such as email addresses, you can also review in the properties of user objects with Microsoft Graph PowerShell cmdlets. However, you can only manage mail-related properties by using Exchange Online PowerShell.

> [!NOTE]
> The current Exchange Online PowerShell module is the EXO V3 module (version 3.x). When researching how to connect to Exchange Online, instructions that reference PowerShell remoting, the `Connect-EXOPSSession` cmdlet, or the EXO V2 module are outdated and shouldn't be followed.

The EXO V3 module includes all of the original cmdlets for managing Exchange Online, and several additional cmdlets that include `EXO` in the cmdlet name. These EXO cmdlets, such as `Get-EXOMailbox`, are more efficient than the original cmdlets.

## Installing the Exchange Online PowerShell module

The Exchange Online PowerShell module is supported in Windows PowerShell 5.1 and PowerShell 7. Because it's supported in PowerShell 7, it's considered multiplatform. You can use it in Windows, macOS, and Linux.

To install the EXO v2 module, run the following command:

```powershell
Install-Module -Name ExchangeOnlineManagement
```

## Preparing to connect

To use the Exchange Online PowerShell module, you need to allow scripts. You can set the execution policy to `RemoteSigned` or `Unrestricted`. If you don't allow scripts, you'll see the error `Files cannot be loaded because running scripts is disabled on this system`.

The EXO V3 module uses REST API connections rather than remote PowerShell over WinRM. Basic authentication in WinRM isn't required and doesn't need to be configured.

## Connecting to Exchange Online

You can connect to Exchange Online by using the `Connect-ExchangeOnline` cmdlet with no additional parameters. When you connect to Exchange Online, you're prompted for a username and password to sign in. You need to sign in with a user account that has sufficient privileges to complete the actions you want to perform. You might also be prompted for multifactor authentication.

> [!NOTE]
> For tenants in China or Germany, you need to use the `-ExchangeEnvironmentName` parameter and specify `O365China` or `O365GermanyCloud`, respectively. For secure US government tenants, you need to specify `O365USGovGCCHigh` or `O365USGovDoD`.

If you're behind a proxy server, EXO V3's REST API connections use your system's default proxy settings automatically. If connections fail through a proxy, verify that the proxy allows outbound HTTPS traffic to Exchange Online endpoints.

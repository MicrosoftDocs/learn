As a best practice, administrators should have two user accounts. Each administrator should have a standard user account that's used for day-to-day activity and a second account with administrative permissions. Separating these roles helps to avoid accidental damage to computer systems and limits the potential effects of malware. The **Get-Credential** cmdlet can help you use the administrative account while you're still signed in to a standard user account.

Many of the scripts that administrators run require elevated privileges. For example, a script that creates Active Directory Domain Services (AD DS) user accounts requires administrative privileges. Even querying event logs from a remote computer might require administrative privileges.

One way to elevate privileges when you run a script is to use the **Run as administrator** option when you open the Windows PowerShell prompt. If you use **Run as administrator**, you're prompted for credentials. So, all actions performed at that Windows PowerShell prompt use the credentials provided.

As an alternative to using **Run as administrator** for running a script, you can have your script prompt for credentials instead. Many Windows PowerShell cmdlets allow an alternate set of credentials to be provided. That way, the credentials that the script obtains can be used to run individual commands in the script. You can prompt for credentials by using **Get-Credential**. The syntax for using the **Get-Credential** cmdlet is:

```powershell
$cred = Get-Credential
Set-ADUser -Identity $user -Department "Marketing" -Credential $cred
```

The default text in the pop-up window is “Enter your credentials.” You can customize this text to be more descriptive by using the *-Message* parameter. You can also fill in the **User name** box by using the *-UserName* parameter.

## Storing credentials by using Export-Clixml

You can store credentials to a file for later reuse without being prompted for credentials. To store credentials to a file, you use **Export-Clixml**. For a credential object, **Export-Clixml** encrypts the credential object before storing it in an XML file. Use the following syntax to store a credential object to a file.

```powershell
$cred | Export-Clixml C:\cred.xml
```

The encryption used by **Export-Clixml** is user-specific and computer-specific. That means that if you store the encrypted credentials, only you can retrieve the encrypted credentials and only on the computer you originally used to store them. This action helps keep the credentials secure, but it also means that they can't be shared with other users.

## Storing credentials by using the SecretManagement module

Microsoft has released the **SecretManagement** module that you can use to store and retrieve credentials. This method works better for storing credentials that can be shared among multiple users and computers. The cmdlets included in the **SecretManagement** module can access credentials from multiple secret vaults.

Some well-known vaults are:

- KeePass
- LastPass
- CredMan
- Azure KeyVault

The **SecretManagement** module is available in the PowerShell Gallery. You can install the **SecretManagement** module by running the following command:

```powershell
Install-Module Microsoft.PowerShell.SecretManagement
```

Microsoft also provides the **SecretStore** module that you can use to create a local secret vault for storing credentials. However, similar to using **Export-Clixml**, the vault is stored on the local machine and in the current user context.


You can also manage users, groups, and devices by using the Microsoft Graph PowerShell SDK. This approach uses the unified Microsoft Graph API, providing a comprehensive and efficient way to automate management tasks across Microsoft 365 services. PowerShell 7 and later is the recommended PowerShell version for use with the Microsoft Graph PowerShell SDK on all platforms. There are no more prerequisites to use the SDK with PowerShell 7 or later.  For more information, see [Install the Microsoft Graph PowerShell SDK](/powershell/microsoftgraph/installation?view=graph-powershell-1.0)

Before you begin, ensure you have the following requirement:

 - **Operating system** A Windows 10 or later, or a supported version of Windows Server.
 - **PowerShell**. You must have PowerShell 5.1 or newer, or PowerShell Core.
 - **Microsoft Graph PowerShell SDK**. The Microsoft Graph PowerShell SDK installed. If you haven't installed it yet, you can do so by running the following command in PowerShell:

```PowerShell
Install-Module -Name Microsoft.Graph -scope CurrentUser
```
### Connecting to Microsoft Entra with Microsoft Graph PowerShell SDK

To connect to Microsoft Entra, you can use the `Connect-MgGraph` cmdlet. This cmdlet prompts you to sign in to your Microsoft Entra account and then creates a connection to the Microsoft Graph service. You can then use the connection to run cmdlets to manage users, groups, and devices.

```PowerShell
Connect-MgGraph -Scopes "User.Read.All", "Group.ReadWrite.All", "Device.ReadWrite.All"
```
Adjust the scopes according to the permissions required for your specific tasks.

### Create users by using bulk import

You can import a .csv file containing account information to create multiple users in bulk, such as exporting from an existing on-premises directory, or use Microsoft Graph PowerShell SDK scripting to generate multiple accounts. To use bulk import, you first must assemble your user information, which might include the following table:

| UserName            | FirstName | LastName | DisplayName   | JobTitle   | Department |
| ------------------- | --------- | -------- | ------------- | ---------- | ---------- |
|AnneW@adatum.com|Anne|Wallace|Anne Wallace|President|Management|
|FabriceC@adatum.com|Fabrice|Canel|Fabrice Canel|Attorney|Legal|
|GarretV@adatum.com|Garret|Vargas|Garret Vargas|Operations|Operations|

Use the following script to read the .csv file and create the user accounts in Microsoft Entra:

```PowerShell
$users = Import-Csv -Path "C:\path\to\your\Users.csv"

foreach ($user in $users) {
    New-MgUser -UserPrincipalName $user.UserName `
               -GivenName $user.FirstName `
               -Surname $user.LastName `
               -DisplayName $user.DisplayName `
               -JobTitle $user.JobTitle `
               -Department $user.Department `
               -AccountEnabled $true `
               -MailNickname $user.FirstName `
               -UsageLocation "US" `
               -PasswordProfile @{ForceChangePasswordNextSignIn = $true; Password = "Password"}
}
```
This script reads the .csv file and creates a new user for each row in the file. The `New-MgUser` cmdlet creates a new user in Microsoft Entra with the specified properties.

By using the Microsoft Graph PowerShell SDK, you can efficiently manage Microsoft Entra objects with the flexibility and power of Microsoft Graph. This guide has introduced you to connecting to Microsoft Graph and creating users in bulk. Explore further to discover the full potential of automating your Microsoft 365 administration tasks with Microsoft Graph PowerShell.

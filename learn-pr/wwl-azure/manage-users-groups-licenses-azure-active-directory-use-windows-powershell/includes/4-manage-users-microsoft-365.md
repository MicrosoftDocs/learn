Before users can sign in and begin using Microsoft 365 services, you need to create user accounts for them. After you create the accounts, you might need to modify them. You can manage users in Microsoft 365 by using both Msol and AzureAD cmdlets. In both cases, you need to connect to Microsoft 365 before you can create and manage user accounts.

The following table lists the user attributes that you need to consider when creating user accounts.

*Table 1: User attributes*

| Property            | Required | Description                                                  |
| ------------------- | -------- | ------------------------------------------------------------ |
| **DisplayName**         | Yes      | This is the name that displays for users in the web-based management tools. |
| **UserPrincipalName**   | Yes      | This is the name that people use to sign in to Microsoft 365. This is also a unique identifier that you use when performing management tasks with PowerShell cmdlets. |
| **GivenName**/**FirstName** | No       | This property can be used by various Microsoft 365 services such as the Exchange Online address book. |
| **SurName**/**LastName**    | No       | This property can be used by various Microsoft 365 services such as the Exchange Online address book. |
| **Password**            | No       | A password is required to enable a user account. When you create a user with the **New-AzureADUser** cmdlet, you must set a password. |
| **LicenseAssignment**   | No       | This property specifies the licensing plan for the user, which in turn determines which Microsoft 365 services the user can access. You can assign licenses after you create the user. |
| **UsageLocation**       | No       | The usage location is a two-character country code. You can't assign a license if you haven't set a usage location. |

> [!NOTE]
> For more information about licensing user accounts, see Module 1 Unit 7, **Managing licenses in Microsoft 365 with PowerShell**.

## Manage users with AzureAD cmdlets

You can create user accounts in Microsoft 365 by using the **New-AzureADUser** cmdlet. The following code block depicts how you can use this cmdlet to create a new user account and set a password. The password is stored in an object required for that purpose. In this example, the *-AccountEnabled* parameter is set to `$true` to enable the account and allow the user to sign in. The *-PasswordProfile* and *-AccountEnabled* parameters are required:

```powershell
$UserPassword=New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$UserPassword.Password="Pa55w.rd"
New-AzureADUser -DisplayName "Abbie Parsons" -GivenName "Abbie" -SurName "Parsons" -UserPrincipalName AbbieP@adatum.com -UsageLocation US -PasswordProfile $UserPassword -AccountEnabled $true
```

You can query a list of user accounts in Microsoft 365 by using the **Get-AzureADUser** cmdlet. The following table lists commonly used parameters for this cmdlet.

*Table 2: Parameters for the Get-AzureADUser cmdlet*

| Parameter       | Description                                                  |
| --------------- | ------------------------------------------------------------ |
| -ObjectID     | Specifies the user principle name (UPN) or ObjectID of a specific user account to retrieve. Both properties are unique identifiers for a user account in Microsoft 365. |
| -Filter       | Specifies a filter in oPath format that you can use to query a specific set of user accounts. |
| -SearchString | Specifies a string that is matched against the start of the **DisplayName** and **UserPrincipalName** attributes. |
| -All          | By default, **Get-AzureADUser** returns only 100 results. If you set the -All parameter to `$true`, then all results are returned. The default value for this parameter is `$false`. |
| -Top          | When the -All parameter is `$false`, you can use -Top to specify the maximum number of results to return. |

> [!NOTE]
> The oPath format used for filters doesn't support using wildcards. If you need to perform a wildcard search of user accounts, you need to retrieve all the user accounts and then filter them by using the **Where-Object** cmdlet.

The following example depicts how to query a single Microsoft 365 user account:

```powershell
Get-AzureADUser -ObjectId AbbieP@adatum.com
```

The following example depicts how to query all the user accounts in a Microsoft 365 tenant:

```powershell
Get-AzureADUser -All $true
```

The following table lists other commonly used cmdlets for user account management.

*Table 3: AzureAD cmdlets for user account management*

| Cmdlet                                | Description                                |
| ------------------------------------- | ------------------------------------------ |
| **Set-AzureADUser**                     | Modifies the properties of a user account. |
| **Remove-AzureADUser**                  | Deletes a user account.                    |
| **Set-AzureADUserPassword**             | Sets the password for a user account.      |
| **Get-AzureADMSDeletedDirectoryObject** | Lists soft-deleted user accounts.           |

## Manage users with Msol cmdlets

You can create new user accounts in Microsoft 365 by using the **New-MsolUser** cmdlet. When you create an account with **New-MsolUser**, it's automatically enabled. The password is supplied as a string. If you don't specify a password, a randomly generated password is set automatically. The following code block depicts how you can create a new user account and set a password by using the cmdlet:

```powershell
New-MsolUser -DisplayName "Abbie Parsons" -FirstName "Abbie" -LastName "Parsons" -UserPrincipalName AbbieP@adatum.com -Password "Pa55w.rd"
```

You can query a list of user accounts in Microsoft 365 by using the **Get-MsolUser** cmdlet. The following table lists commonly used parameters for this cmdlet.

*Table 4: Parameters for the Get-MsolUser cmdlet*

| Parameter             | Descriptions                                                 |
| --------------------- | ------------------------------------------------------------ |
| -ObjectID           | Specifies the ObjectID for a specific user account to retrieve. |
| -UserPrincipalName  | Specifies the UPN for a specific user account to retrieve.   |
| -SearchString       | Defines a string that the display name and email addresses are searched for. This parameter behaves as a wildcard search for the specified string that can match any part of the display name or email addresses. |
| -All                | Retrieves all available results instead of the default 500 results. |
| -MaxResults         | Specifies to return more than the default 500 results when the -All parameter isn't used. |
| -ReturnDeletedUsers | Returns only soft-deleted users.                             |

The **Get-MsolUser** cmdlet doesn't have a generic filtering parameter. Instead, there are parameters for filtering based on specific attributes. For example, you can use the *-City* parameter to filter based on the **City** attribute configured in user accounts. To filter based on attributes that don't have a corresponding parameter, you need to retrieve all user accounts and then use the **Where-Object** cmdlet.

The following example depicts how to query a single Microsoft 365 user account:

```powershell
Get-MsolUser -UserPrincipalName AbbieP@adatum.com
```

The following example depicts how to query all user accounts in a Microsoft 365 tenant:

```powershell
Get-MsolUser -All
```

The following table lists other commonly used cmdlets for user account management.

*Table 5: Msol cmdlets for user account management*

| Cmdlet                      | Description                                |
| --------------------------- | ------------------------------------------ |
| **Set-MsolUser**              | Modifies user account properties. |
| **Remove-MsolUser**           | Deletes a user account.                    |
| **Set-MsolUserPassword**      | Sets a user account's password.      |
| **Set-MsolUserPrincipalName** | Changes the UPN for a user account.         |
| **Restore-MsolUser**          | Restores a soft-deleted user account.      |

## Synchronized users

Users that you create in Microsoft 365 with Windows PowerShell are cloud users. Many organizations use Microsoft Entra Connect to synchronize users and groups from on-premises AD DS to Microsoft 365. These users and groups are created by Microsoft Entra Connect. and as such you can't delete them directly in Microsoft 365. Instead, you need to delete the object in AD DS, and the deletion is synchronized to Microsoft 365.

When objects are synchronized from AD DS to Microsoft 365, the value of some attributes in AD DS is authoritative. This means you can't modify the attribute's value in Microsoft 365. Instead, you need to modify the value in AD DS, and then the modified value synchronizes to Microsoft 365. Attempting to modify these attributes in Microsoft 365 will generate an error.

The following list is some of the common attributes for which AD DS is authoritative:

- **UserPrincipalName**
- **DisplayName**
- **AccountEnabled**
- **ProxyAddresses** (email addresses)

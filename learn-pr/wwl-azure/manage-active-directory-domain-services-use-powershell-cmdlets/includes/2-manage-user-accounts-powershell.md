User management is a core responsibility of administrators. You can use the Active Directory module for Windows PowerShell cmdlets to create, modify, and delete user accounts individually or in bulk. User account cmdlets have the word “User” or “Account” in the noun part of the name. To identify the available cmdlets, include them in wildcard name searches when you're using **Get-Help** or **Get-Command**.

The following table lists common cmdlets for managing user accounts.

*Table 1: Cmdlets for user account management*

| Cmdlet                | Description                                                  |
| --------------------- | ------------------------------------------------------------ |
| **New-ADUser**            | Creates a user account                                       |
| **Get-ADUser**            | Retrieves a user account                                     |
| **Set-ADUser**            | Modifies properties of a user account                        |
| **Remove-ADUser**         | Deletes a user account                                       |
| **Set-ADAccountPassword** | Resets the password of a user account                        |
| **Unlock-ADAccount**     | Unlocks a user account that's been locked after exceeding the permitted number of incorrect sign-in attempts |
| **Enable-ADAccount**      | Enables a user account                                       |
| **Disable-ADAccount**     | Disables a user account                                      |

## Retrieving users

The **Get-ADUser** cmdlet requires that you identify the user or users that you want to retrieve. You can do this by using the *-Identity* parameter, which accepts one of several property values, including the Security Accounts Manager (SAM) account name or distinguished name.

Windows PowerShell only returns a default set of properties when you use **Get-ADUser**. To review other properties, you'll need to use the *-Properties* parameter with a comma-separated list of properties or the “*” wildcard.

For example, you can retrieve the default set of properties along with the department and email address of a user with the SAM account **anabowman** by entering the following command in the console, and then pressing the Enter key:

```powershell
Get-ADUser -Identity anabowman -Properties Department,EmailAddress
```

The other way to specify a user or users is with the *-Filter* parameter. The *-Filter* parameter accepts a query based on regular expressions, which later modules in this course describe in more detail. For example, to retrieve all AD DS users and their properties, enter the following command in the console, and then press the Enter key:

```powershell
Get-ADUser -Filter * -Properties *
```

> [!NOTE]
> The help for **Get-ADUser** includes examples that use features of Windows PowerShell that you'll learn about later in this course. For example, more advanced *-Filter* operations require comparison operators, which you'll learn about in the next module.

## Creating new user accounts

When you use the **New‑ADUser** cmdlet to create new user accounts, the -*Name* parameter is required. You can also set most other user properties, including a password. When you create a new account, consider the following points:

- If you don't use the *-AccountPassword* parameter, then no password is set, and the user account is disabled. You can't set the *-Enabled* parameter as `$true` when no password is set.
- If you use the *-AccountPassword* parameter to specify a password, then you must specify a variable that contains the password as a secure string or choose to enter the password from the console. A secure string is encrypted in memory.
- If you set a password, then you can enable the user account by setting the *-Enabled* parameter as `$true`.

The following table lists common parameters for the **New-ADUser** cmdlet.

*Table 2: Common parameters for New-ADUser*

| Parameter               | Description                                                  |
| ---------------------------- | ------------------------------------------------------------ |
| ‑AccountExpirationDate | Defines the   expiration date for a user account         |
| ‑AccountPassword           | Defines the password for a user account                      |
| ‑ChangePasswordAtLogon    | Requires a user account to change passwords at the next sign-in |
| ‑Department               | Defines the department for a user account                    |
| ‑DisplayName               | Defines the display name for a user account                  |
| ‑HomeDirectory             | Defines the location of the home directory for a user account |
| ‑HomeDrive                | Defines the drive letters that map to the home directory for a user account |
| ‑GivenName                 | Defines the first name of a user account                     |

To add a user account and set its Department attribute to **IT** , enter the following command in the console, and then press the Enter key:

```powershell
New-ADUser "Ana Bowman" -Department IT 
```

Because no password was set by the command you ran, the user account is disabled, and you can't enable it until a password is assigned.

> [!NOTE]
> Later in the course, you'll learn how to use comma-delimited files for bulk creation of user accounts with passwords automatically assigned.

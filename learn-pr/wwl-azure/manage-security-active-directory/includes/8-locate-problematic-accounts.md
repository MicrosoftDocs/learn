You should check your AD DS environment for accounts that haven't signed in for a specific period of time, or that have passwords with no expiration date.

Inactive user accounts usually indicate a person that left the organization and organization processes failed to remove or disable the account. The account might also have originally been shared by IT staff, but is no longer in use. These extra accounts represent additional opportunities for unauthorized users to gain access to your network resources.

Accounts with fixed passwords are less secure than accounts that are required to update their password periodically. If a third-party user obtains a user’s password, that knowledge is only valid until the user updates the password. If you configure an account with a password that the user doesn't have to update periodically, then a potential cybercriminal could have access to your network indefinitely. Ensuring regular password updates is especially important for highly privileged accounts.

When you find accounts that haven’t signed in for a specified number of days, you can disable those accounts. Disabling them allows you to reenable them should the person return. After you’ve located accounts that are configured with passwords that don't expire, you can take steps to ensure that an appropriate password update policy is enforced.

> [!NOTE]
> User accounts with credentials shared by multiple IT staff members should be avoided, even if they have a strong password policy. Shared accounts make it hard to track which individual performed a specific administrative task.

You can use Windows PowerShell or the AD DS Administrative Center to find problematic users. To use Windows PowerShell to find active users with passwords set to never expire, use the following command:

```powershell
Get-ADUser -Filter {Enabled -eq $true -and PasswordNeverExpires -eq $true}




```

Use the following Windows PowerShell command to find users that haven't signed in within the last 90 days, using Windows PowerShell:

```powershell
Get-ADUser -Filter {LastLogonTimeStamp -lt (Get-Date).Adddays(-(90))-and enabled -eq $true} -Properties LastLogonTimeStamp




```

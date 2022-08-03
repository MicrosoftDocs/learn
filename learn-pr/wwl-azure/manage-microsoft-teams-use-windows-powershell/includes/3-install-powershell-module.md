You can install the Microsoft Teams module from the PowerShell Gallery. To install the Microsoft Teams module, run the following command:

```powershell
Install-Module -Name MicrosoftTeams
```

The Microsoft Teams module doesn't update automatically. To update the SharePoint Online Management Shell, run the following command:

```powershell
Update-Module -Name MicrosoftTeams
```

## Connecting to Microsoft Teams

You can connect to Microsoft Teams by using the **Connect-MicrosoftTeams** cmdlet with no additional parameters. When you connect to Microsoft Teams, you're prompted for a username and password to sign in. You might also be prompted for multifactor authentication. Be sure to sign in with a user account that has sufficient privileges to perform the actions you want to complete.

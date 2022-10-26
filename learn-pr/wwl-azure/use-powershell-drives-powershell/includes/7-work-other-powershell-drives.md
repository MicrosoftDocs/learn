In addition to the file system drives, the registry drives, and the **Cert** drive, Windows PowerShell includes other drives:

- **Alias**. Review and manage Windows PowerShell aliases.
- **Env**. Review and manage Windows environment variables.
- **Function**. Review and manage Windows PowerShell functions.
- **Variable**. Review and manage Windows PowerShell variables.
- **WSMan**. Review and manage WS-Management configurations.

There are many providers included with other modules that can create PowerShell drives. For example, the process of installing management tools for Windows Server roles often includes additional drives such as:  

- **AD**. This drive is created by the ActiveDirectory provider, which is part of the ActiveDirectory module included with the Remote Server Administration Tools (RSAT). The ActiveDirectory provider supports reviewing and managing AD DS database contents, such as user and computer accounts.
- **IIS**. This drive is created by the WebAdministration provider, which is part of the WebAdministration module that's included with IIS management tools. The WebAdministration provider allows you to review and manage application pools, websites, web applications, and virtual directories.

> [!NOTE]
> The ActiveDirectory module includes many cmdlets for managing Active Directory objects. To review the cmdlets in the ActiveDirectory module, run **Get-Command -Module ActiveDirectory**.

> [!NOTE]
> The WebAdministration module includes many cmdlets for managing IIS. To review the cmdlets in the WebAdministration module, run **Get-Command -Module WebAdministration**.

These additional drives support using most of the standard provider verbs and nouns. There might also be specific cmdlets that can perform the same functions. For instance, you can use the **Get-Alias** cmdlet or the following provider-based command to return a list of all aliases in the current Windows PowerShell session:

```powershell
Get-Item -Path Alias:
```

In some cases, there are no equivalent cmdlets for a provider-based command. For example, there's no **Remove-Alias** cmdlet that deletes an alias, but you can use either of the following commands to delete an alias named **MyAlias**:

```powershell
Remove-Item -Path Alias:MyAlias
```

```powershell
Clear-Item -Path Alias:MyAlias
```

As with the other providers covered by earlier topics, the providers used to create these drives can have dynamic parameters or properties associated with them. The Alias provider, for example, includes the dynamic parameter *-Options*, which you can use to specify the Options property of an alias.

To understand what you can do with an item that's accessible through a drive, you should review the help for the provider that's used to create the drive. In the help, you can identify any dynamic parameters or properties. You can identify the provider used to create a drive by using the **Get-PSDrive** cmdlet. You can use the **Get-Help** cmdlet to review the help available for the provider. For example, you could use the command to review help for the Alias provider:

```powershell
Get-Help About_Alias_Provider
```

You can use Windows PowerShell to automate the management of most tasks involving Group Policy Objects (GPOs), including creating, deleting, backing up, reporting, and importing GPOs. You can also associate GPOs with Active Directory Domain Services (AD DS) OUs, including setting GPO inheritance and permissions. Group Policy management cmdlets require Remote Server Administration Tools (RSAT) installed.

Group Policy management cmdlets are part of the **GroupPolicy** module for Windows PowerShell. Cmdlet names include the prefix “GP” in the names, and most have “GPO” as the noun.

**Additional reading:** For more information on PowerShell Core module compatibility, refer to [PowerShell 7 module compatibility](https://aka.ms/powershell-7-module-compatibility).

The following table lists common cmdlets for managing GPOs.

*Table 1: Cmdlets for managing GPOs*

| **Cmdlet**              | **Description**                                                |
| ----------------------- | -------------------------------------------------------------- |
| **New-GPO**             | Creates a new GPO                                              |
| **Get-GPO**             | Retrieves a GPO                                                |
| **Set-GPO**             | Modifies properties of a GPO                                   |
| **Remove-GPO**          | Deletes a GPO                                                  |
| **Rename-GPO**          | Renames a GPO                                                  |
| **Backup-GPO**          | Backs up one or more GPOs in a domain                          |
| **Copy-GPO**            | Copies a GPO from one domain to another domain                 |
| **Restore-GPO**         | Restores a GPO from backup files                               |
| **New-GPLink**          | Links a GPO to an AD DS container                              |
| **Import-GPO**          | Imports GPO settings from a backed-up GPO                      |
| **Set-GPRegistryValue** | Configures one or more registry-based policy settings in a GPO |

## Creating a new GPO

**New-GPO** requires only the *-Name* parameter, which must be unique in the domain in which you create the GPO. By default, the GPO is created in the domain of the user who is running the command. **New-GPO** also doesn't link the created GPO to an AD DS container. To link a GPO to a container, use the **New-GPLink** cmdlet.

The following command creates a new GPO from a starter GPO:

```powershell
New-GPO -Name "IT Team GPO" -StarterGPOName "IT Starter GPO"

```

The following command links the new GPO to an AD DS organizational unit:

```powershell
New-GPLink -Name "IT Team GPO" -Target "OU=IT,DC=adatum,DC=com"

```

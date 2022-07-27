Windows PowerShell provides cmdlets that you can use to create, modify, and delete Active Directory Domain Services (AD DS) Organizational Units (OUs). Like the cmdlets for users, groups, and computers, you can use these cmdlets for individual operations or as part of a script to perform bulk operations. OU management cmdlets have the text “organizationalunit” in the name.

The following table lists cmdlets that you can use to manage OUs.

*Table 1: Cmdlets for OU management*

| Cmdlet                             | Description                        |
| ---------------------------------- | ---------------------------------- |
| **New-ADOrganizationalUnit**    | Creates an OU                |
| **Set-ADOrganizationalUnit**    | Modifies properties of an OU |
| **Get-ADOrganizationalUnit**    | Displays properties of an OU |
| **Remove-ADOrganizationalUnit** | Deletes an OU                |

## Creating new OUs

You can use the **New‑ADOrganizationalUnit** cmdlet to create a new OU to represent departments or physical locations within your organization.

The following table lists common parameters for the **New‑ADOrganizationalUnit** cmdlet.

*Table 2: Parameters for New‑ADOrganizationalUnit*

| Parameter               | Description                                                  |
| ---------------------------- | ------------------------------------------------------------ |
| ‑Name                           | Defines the name of a new OU                             |
| ‑Path                           | Defines the location of a new OU                             |
| ‑ProtectedFromAccidentalDeletion | Prevents anyone from accidentally deleting an OU; the default value is `$true` |

The following example is a command to create a new OU:

```powershell
New-ADOrganizationalUnit -Name Sales -Path "ou=marketing,dc=adatum,dc=com" -ProtectedFromAccidentalDeletion $true 
```
## Active Directory object cmdlets

You'll sometimes need to manage Active Directory objects that don't have their own management cmdlets, such as contacts. You might also want to manage multiple object types in a single operation, such as moving users and computers from one OU to another OU. The Active Directory module provides cmdlets that allow you to create, delete, and modify these objects and their properties. Because these cmdlets can manage all objects, they repeat some functionality of the cmdlets for managing users, computers, groups, and OUs.

***-ADObject** cmdlets sometimes perform faster than cmdlets that are specific to object type. This is because those cmdlets add the cost of filtering the set of applicable objects to their operations. Cmdlets for changing generic Active Directory objects have the text “Object” in the noun part of the name.

The following table lists cmdlets that you can use to manage Active Directory objects.

*Table 1: Cmdlets for managing Active Directory objects*

| Cmdlet                             | Description                        |
| ---------------------------------- | ---------------------------------- |
| **New-ADObject**     | Creates a new   Active Directory object                      |
| **Set-ADObject**     | Modifies properties of an Active Directory object            |
| **Get-ADObject**     | Displays properties of an Active Directory object            |
| **Remove-ADObject**  | Deletes an Active Directory object                           |
| **Rename-ADObject**  | Renames an Active Directory object |
| **Restore-ADObject** | Restores a deleted Active Directory object from the Active  Directory Recycle Bin |
| **Move-ADObject** | Moves an Active Directory object from one container to  another container |
| **Sync-ADObject** | Syncs an Active Directory object between two domain controllers |

## Creating a new Active Directory object

You can use the **New‑ADObject** cmdlet to create objects. When using **New-ADObject**, you must specify the name and the object type.

The following table lists common parameters for **New‑ADObject**.

*Table 2: Parameters for New‑ADObject*

| Parameter               | Description                                                  |
| ---------------------------- | ------------------------------------------------------------ |
| ‑Name            | Defines the name of an object                                |
| ‑Type            | Defines the LDAP type of an object                           |
| ‑OtherAttributes | Defines properties of an object that isn't accessible from other parameters |
| ‑Path | Defines the container in which an object is created |

The following command creates a new contact object:

```powershell
New-ADObject -Name "AnaBowmancontact" -Type contact 
```

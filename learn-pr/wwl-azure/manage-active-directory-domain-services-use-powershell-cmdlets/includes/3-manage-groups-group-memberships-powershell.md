The management of Active Directory groups closely relates to the management of users. You can use the Active Directory module for Windows PowerShell cmdlets to create and delete groups and to modify group properties. You can also use these cmdlets to change the group membership. 

## Managing groups

Cmdlets for modifying groups have the text “group” in their names. Cmdlets that modify group membership by adding members to a group, for example, have the text “groupmember” in their names. Cmdlets that modify the groups that a user, computer, or other Active Directory object is a member of have the text “principalgroupmembership” in their names.

The following table lists some common cmdlets for managing groups.

*Table 1: Cmdlets for group management*

| Cmdlet                             | Description                        |
| ---------------------------------- | ---------------------------------- |
| **New-ADGroup**                    | Creates a new group          |
| **Set-ADGroup**                    | Modifies properties of a group     |
| **Get-ADGroup**                    | Displays properties of a group     |
| **Remove-ADGroup**                 | Deletes a group                    |
| **Add-ADGroupMember**              | Adds members to a group            |
| **Get-ADGroupMember**              | Displays members of a group        |
| **Remove-ADGroupMember**           | Removes members from a group       |
| **Add-ADPrincipalGroupMembership** | Adds group membership to an object |
| **Get-ADPrincipalGroupMembership** | Displays group membership of an object |
| **Remove-ADPrincipalGroupMembership** | Removes group membership from an object |

## Creating new groups

You can use the **New‑ADGroup** cmdlet to create groups. When you create groups by using the **New‑ADGroup** cmdlet, you must use the *‑GroupScope* parameter in addition to the group name. This parameter is the only one required.

The following table lists common parameters for **New‑ADGroup**.

*Table 2: Common parameters for New-ADGroup*

| Parameter               | Description                                                  |
| ---------------------------- | ------------------------------------------------------------ |
| ‑Name       | Defines the name of a group                           |
| ‑GroupScope     | Defines the scope of a group as **DomainLocal**, **Global**, or **Universal**; you must  provide this parameter |
| ‑DisplayName    | Defines the Lightweight Directory Access Protocol (LDAP)  display name for an object |
| ‑GroupCategory  | Defines whether a group is a security group or a  distribution group; if you don't specify either, a security group is created |
| ‑ManagedBy      | Defines a user or group that can manage a group              |
| ‑Path          | Defines the OU or container in which a group is created      |
| ‑SamAccountName | Defines a name that is backward-compatible with older  operating systems |

For example, to create a new group named **FileServerAdmins**, enter the following command in the console, and then press the Enter key:

```powershell
New-ADGroup -Name FileServerAdmins -GroupScope Global 
```

## Managing group membership

As previously mentioned, you can use the **`*-ADGroupMember`** or the **`*-ADPrincipalGroupMembership`** cmdlets to manage group management in two different ways. The difference between the two is a matter of focusing on an object and modifying the groups to which it belongs, or focusing on the group and modifying the members that belong to it. Additionally, you can choose which set to use based on the decision to *pipe* a list of members to the command or provide a list of members.

**`*-ADGroupMember`** cmdlets modify the membership of a group. For example:

- You can add or remove members of a group.
- You can pass a list of groups to these cmdlets.
- You can't *pipe* a list of members to these cmdlets.

**`*-ADPrincipalGroupMembership`** cmdlets modify the group membership of an object such as a user. For example:

- You can add a user account as a member to a group.
- You can't provide a list of groups to these cmdlets.
- You can *pipe* a list of members to these cmdlets.

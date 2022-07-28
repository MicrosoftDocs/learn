The Active Directory module for Windows PowerShell also has cmdlets to create, modify, and delete computer accounts. You can use these cmdlets for individual operations or as part of a script to perform bulk operations. The cmdlets for managing computer objects have the text “computer” in their names.

The following table lists cmdlets that you can use to manage computer accounts.

*Table 1: Cmdlets for computer account management*

| Cmdlet                             | Description                        |
| ---------------------------------- | ---------------------------------- |
| **New-ADComputer**                | Creates a new computer account                        |
| **Set-ADComputer**                | Modifies properties of a computer account                    |
| **Get-ADComputer**                | Displays properties of a computer account                    |
| **Remove-ADComputer**             | Deletes a computer account                                   |
| **Test-ComputerSecureChannel**    | Verifies or repairs the trust relationship between a computer and the domain |
| **Reset-ComputerMachinePassword** | Resets the password for a computer account                   |

## Creating new computer accounts

You can use the **New-ADComputer** cmdlet to create a new computer account before you join the computer to the domain. You do this so that you can create the computer account in the correct OU before deploying the computer.

The following table lists common parameters for **New-ADComputer**.

*Table 2: Common parameters for New-ADComputer*

| Parameter               | Description                                                  |
| ---------------------------- | ------------------------------------------------------------ |
| ‑Name | Defines the name of a computer account                 |
| ‑Path     | Defines the OU or container where a computer account is  created |
| ‑Enabled  | Defines whether the computer account is enabled or  disabled; by default, a computer account is enabled, and a random password is generated |

The following example is a command that you can use to create a computer account:

```powershell
New-ADComputer -Name LON-CL10 -Path "ou=marketing,dc=adatum,dc=com" -Enabled $true 
```

## Repairing the trust relationship for a computer account

You can use the **Test-ComputerSecureChannel** cmdlet with the *-Repair* parameter to repair a lost trust relationship between a computer and a domain. You must run the cmdlet on the computer with the lost trust relationship.

## Account vs. device management cmdlets

**-ADComputer** cmdlets are part of the Active Directory module and manage the computer object, not the physical device or its operating system. For example, you can use the **Add‑Computer** cmdlet to join a computer to a domain. To manage the properties of the physical computer and its operating system, use the **-Computer** cmdlets.

Experienced system administrators are familiar with the graphical Registry Editor, which they can use to manage registry keys, entries, and values. However, you can also manage the registry by using Windows PowerShell and the Registry provider.

You can use the **New-PSDrive** cmdlet to create PowerShell drives for any part of the registry. PowerShell uses the Registry provider to create two PowerShell drives automatically:

- **HKLM**. Represents the **HKEY_LOCAL_MACHINE** registry hive.

- **HKCU**. Represents the **HKEY_LOCAL_USER** registry hive.

You access registry keys by using cmdlets with the **Item** and **ChildItem** nouns, whereas you access entries and values by using cmdlets with the **ItemProperty** and **ItemPropertyValue** nouns. This is because PowerShell considers registry entries to be properties of a key item.

To return all the registry keys under the **HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion** path, run the following command:

```powershell
Get-ChildItem HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion
```

Within the registry, a registry key is equivalent to a folder within a file system that's used to organize information. The information used by apps is stored in registry values. The value name is a unique identifier for the value, and the value data is the information used by apps.

For example, to return the registry values under the **HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run** path, run the following command:

```powershell
Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
```

You can use the **Get-ItemPropertyValue** cmdlet to obtain the value of a specific registry entry. For example, if you want to return the path to the Windows Defender executable identified by the value **WindowsDefender** entry, run the following command:

```powershell
Get-ItemPropertyValue HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run -Name WindowsDefender
```

> [!NOTE]
> The Registry provider doesn't support the **Invoke-Item** cmdlet. There's no default action for registry keys, entries, or values.

The Registry provider supports a dynamic parameter, *-Type*, for the ***-ItemProperty** cmdlets that are unique to the Registry provider. The following table lists valid parameter values and their equivalent registry data types.

*Table 1: Registry data types*

| **Parameter value** | **Registry data type**                      |
| ------------------- | ------------------------------------------- |
| String              | REG_SZ                                      |
| ExpandString        | REG_EXPAND_SZ                               |
| Binary              | REG_BINARY                                  |
| DWord               | REG_DWORD                                   |
| MultiString         | REG_MULTI_SZ                                |
| QWord               | REG_QWORD                                   |
| Unknown             | Unsupported types such as REG_RESOURCE_LIST |

The Registry provider supports transactions that allow you to manage multiple commands as a single unit. The commands in a transaction will either all be committed (completed) or the results will be rolled back (undone). This feature allows you to set multiple registry values together without worrying that some of the settings will be updated successfully while others might fail. Use the *-UseTransaction* parameter to include a command in a transaction.

> [!NOTE]
> For more information about transactions in Windows PowerShell, refer to the **about_Transactions** help topic.

> [!NOTE]
> Remember to back up your registry settings before you attempt to modify registry keys and values. You can export registry settings to a file by using the **reg.exe** command.

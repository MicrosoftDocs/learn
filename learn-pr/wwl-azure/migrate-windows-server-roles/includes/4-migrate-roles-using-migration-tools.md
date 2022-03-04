The Windows Server Migration Tools copy role and feature configuration, but don't install the necessary roles and features on the destination server.

> [!IMPORTANT]
> Before you migrate a role or feature, you must install that role or feature on the destination server in preparation for the migration. 

If the destination server is prepared with the necessary roles and features, you can export the configuration from the source server and then import the configuration on the destination server.

Most Windows PowerShell cmdlets install as modules and are automatically available at a Windows PowerShell prompt. To use the Windows Server Migration Tools cmdlets, you must load a snap-in first, as demonstrated in the following example:

`Add-PSSnapin Microsoft.Windows.ServerManager.Migration`

The following table lists the Windows Server Migration Tools cmdlets.

| Cmdlet| Description|
| :--- | :--- |
| `Get-SmigServerFeature` | Lists the Windows features that can be migrated from either the local computer or a migration store. |
| `Export-SmigServerSetting` | Exports the settings for the specified Windows features and operating system (OS) from the local computer to a migration store. |
| `Import-SmigServerSetting` | Imports the settings for the specified Windows features and OS from a migration store to the local computer. |
| `Send-SmigServerData` | Sends shares and data from the source server to a destination server. |
| `Receive-SmigServerData` | Receives shares and data from the source server. |

> [!WARNING]
> You should use Storage Migration Service instead of `Send-SmigServerData` and `Receive-SmigServerData`.

## Export settings

Before you export settings from the source server, you can run the `Get-SmigServerFeature` cmdlet to verify which feature settings can be exported. This cmdlet provides the feature names and IDs that you must specify during the export.

When you run the `Export-SmigServerSetting` cmdlet on the source server, you specify which Windows features to export. You also have the option to specify that local users, local groups, and IP configuration should be exported. The migration store you create with `Export-SmigServerSetting` is encrypted and protected with a password that you specify during the export.

## Import settings

Before you import settings from a migration store, run the `Get-SmigServerFeature` cmdlet to verify which feature settings can be imported. Use this information to verify that the necessary Windows features install on the destination server.

When you run the `Import-SmigServerSetting` cmdlet on the destination server, you must provide the path to the migration store and the password to decrypt it.

> [!TIP]
> If you don't provide a password in the command, you're prompted for one. 

You also must identify which Windows features should be imported. In some cases, settings for Windows features must be migrated in a specific order. To guarantee that settings apply in the correct order, import the settings separately by running `Import-SmigServerSetting` multiple times.

You can choose to specify that local users, local groups, or IP configuration import from the migration store. When you import IP configuration, you must specify the hardware address of the IP configuration and the hardware address of the network card in the destination server.


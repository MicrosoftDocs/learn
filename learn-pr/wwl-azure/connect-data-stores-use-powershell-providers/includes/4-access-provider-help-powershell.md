You can display a list of available providers by using the **Get-PSProvider** cmdlet. Be aware that providers can be added into Windows PowerShell when you load modules, and they don't display until loaded. For example, when you run the **Import-Module ActiveDirectory** command to load the **ActiveDirectory** module or use module autoloading when running an Active Directory cmdlet, a PowerShell provider for Active Directory is included.

Some providers include help files that you can review. Help files use the naming format **about_ProviderName_Provider**. For example, the help file for the FileSystem provider is **about_FileSystem_Provider**. You can review this help file's contents by running the following command:

```powershell
Get-Help about_FileSystem_Provider
```

Cmdlets that work with providers use the nouns **Item** and **ItemProperty**. To list cmdlets that work with providers, run the following cmdlets:

```powershell
Get-Command *-Item,*-ItemProperty
```

Examples for every scenario might not be in commands’ help, because the commands are designed to work with any provider. The intent of provider help is to supplement command help with more specific descriptions and examples.


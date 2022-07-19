*Modules* are groups of related PowerShell capabilities that are bundled together into a single unit. For the purposes of this class, you can think of them as containers hosting multiple cmdlets. Modules help with organizing cmdlets into distributable units. Microsoft and other software companies provide modules as part of the management tools for their applications and services.

To use a module's cmdlets, the module must be loaded into the current PowerShell session. Typically this takes place automatically but, depending on your configuration, might require that you load modules explicity by running the **Import-Module** cmdlet. Some server products, such as Microsoft Exchange Server, provide a shortcut to what appears to be a dedicated management shell. However, this is really a normal PowerShell console session with application-specific modules already loaded.

## Autoloading

In Windows PowerShell version 3.0 and newer, modules load automatically if you run a cmdlet that is part of that module. This works if the module that contains the cmdlet is in a folder under the module load paths. By default, these folders include **%systemdir%\\WindowsPowerShell\\v1.0\\Modules** and **%userprofiles%\\Documents\\WindowsPowerShell\\Modules**. The list of folders is stored in the `$env:PSModulePath` environment variable. When you explicitly import a module by name, PowerShell checks the locations referenced by that environment variable.

For PowerShell 7, the **PSModulePath** includes the following locations:

`C:\Users\<user>\Documents\PowerShell\Modules` `C:\Program Files\PowerShell\Modules` `C:\Program Files\PowerShell\7\Modules` `C:\Program Files\WindowsPowerShell\Modules` `C:\WINDOWS\System32\WindowsPowerShell\v1.0\Modules`

**Note:** When using Windows PowerShell, the path **%systemdir%\\WindowsPowerShell\\v1.0\\Modules** is commonly referred to by using the combination of the `$PSHome` environment variable (which points to **%systemdir%\\WindowsPowerShell\\v1.0**) and the **Modules** path (i.e. by using the `$PSHome\Modules` notation). For PowerShell 7.0, the `$PSHome` environment variable refers to **C:\\Program Files\\PowerShell\\7**.

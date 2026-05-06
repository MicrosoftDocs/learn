You can create modules to store functions and share those functions among scripts. After you put your functions into modules, they're discoverable just as cmdlets are. Like the built-in Windows modules, your modules also load automatically when a function is required.

> [!NOTE]
> Name your functions in modules using the same verb-noun naming convention as cmdlets. For example, use the verb-noun format.

> [!NOTE]
> Functions in modules can include comment-based help that **Get-Help** can discover. Include the help information in each function to enable this.

If you already have your functions in a Windows PowerShell script file, convert it to a module by renaming it with the **.psm1** file extension. The file structure doesn't need to change.

Windows PowerShell uses the `$PSModulePath` environmental variable to define the paths from which modules are loaded. In Windows PowerShell 5.1, the following paths are listed:

- **C:\\Users\\UserID\\Documents\\WindowsPowerShell\\Modules**
- **C:\\Program Files\\WindowsPowerShell\\Modules**
- **C:\\Windows\\System32\\WindowsPowerShell\\1.0\\Modules**

Windows PowerShell 7 includes the following other paths:

- **C:\\Users\\UserID\\Documents\\PowerShell\\Modules**
- **C:\\Program Files\\PowerShell\\Modules**
- **C:\\Program Files\\PowerShell\\7\\Modules**

> [!NOTE]
> The PowerShell 7 user-scope path (`Documents\PowerShell\Modules`) is different from the Windows PowerShell 5.1 user-scope path (`Documents\WindowsPowerShell\Modules`). Modules stored in the 5.1 path aren't automatically loaded in PS7 user-scope sessions.

> [!NOTE]
> If you store modules in **C:\\Users\\UserID\\Documents\\WindowsPowerShell\\Modules**, they're only available to a single user.

Modules aren't placed directly in the **Modules** directory. Instead, you must create a subfolder with the same name as the file and place the file in that folder. For example, if you have a module named **AdatumFunctions.psm1**, you'd place it in **C:\\Program Files\\WindowsPowerShell\\Modules\\AdatumFunctions**.

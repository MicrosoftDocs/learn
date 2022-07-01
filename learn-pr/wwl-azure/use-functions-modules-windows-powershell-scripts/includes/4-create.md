You can create modules to store functions and share those functions among scripts. After you put your functions into modules, they're discoverable just as cmdlets are. Also, like the modules included with Windows, the modules you create load automatically when a function is required.

> **Note:** As a best practice, you should name your functions in modules with a naming structure similar to the cmdlet naming convention. For example, you would use the verb-noun format.

> **Note:** Functions in modules can include comment-based help that's discoverable by using **Get-Help**. To support this, you need to include the help information in each function.

In many cases, you already have your functions in a Windows PowerShell script file. To convert a script file containing only functions to a module, rename it with the **.psm1** file extension. No structural changes in the file are required.

Windows PowerShell uses the `$PSModulePath` environmental variable to define the paths from which modules are loaded. In Windows PowerShell 5.0, the following paths are listed:

- **C:\\Users\\UserID\\Documents\\WindowsPowerShell\\Modules**
- **C:\\Program Files\\WindowsPowerShell\\Modules**
- **C:\\Windows\\System32\\WindowsPowerShell\\1.0\\Modules**

Windows PowerShell 7 includes the following additional paths:

- **C:\\Program Files\\PowerShell\\Modules**
- **C:\\Program Files\\PowerShell\\7\\Modules**

> **Note:** If you store modules in **C:\\Users\\UserID\\Document\\WindowsPowerShell\\Modules**, they're only available to a single user.

Modules aren't placed directly in the **Modules** directory. Instead, you must create a subfolder with the same name as the file and place the file in that folder. For example, if you have a module named **AdatumFunctions.psm1**, you'd place it in **C:\\Program Files\\WindowsPowerShell\\Modules\\AdatumFunctions**.

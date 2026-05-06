*Members* are the various components of an object and include:

- Properties, which describe attributes of the object. Examples of properties include a service name, a process ID number, and an event log message.
- Methods, which invoke an action on an object. For example, a process object can be stopped, and an event log can be cleared.
- Events, which trigger when something happens to an object. A file might trigger an event when it is updated, or a process might trigger an event when it has output to produce.

PowerShell primarily deals with properties and methods. For most commands that you run, the default on-screen output doesn't include all of an object’s properties. Some objects have hundreds of properties, and the full list won't fit on the screen. PowerShell includes several configuration files that list the object properties that should display by default. That's why you notice three properties when you run **Get-Service**.
> [!NOTE]
> In Windows PowerShell 5.1, these default views are stored in `.ps1xml` files in the PowerShell installation directory. In PowerShell 7 and later, they are compiled into the runtime and no longer exist as files on disk.
Use the **Get-Member** command to list all the members of an object. This command lists all the properties, even those that don't display on the screen by default. This command also lists methods and events and displays the type name of the object. For example, the objects that **Get-Service** produces have the type name **System.ServiceProcess.ServiceController**.

> [!NOTE]
> In PowerShell 7, `Get-Service | Get-Member` reports the TypeName as `System.Service.ServiceController#StartupType` due to additional properties added by the PowerShell Extended Type System (ETS). The underlying .NET type is the same — if you see a different TypeName in your terminal, this is expected when running PowerShell 7.

> [!NOTE]
> **Get-Member** has an alias: **gm**.

To use **Get-Member**, just pipe any command output to it. For example, enter the following command in the console, and then select Enter:

```powershell
Get-Service | Get-Member
```

> [!NOTE]
> The first command runs, produces its output, and then passes that output to **Get‑Member**. Use caution when you run commands that might modify the system configuration, because those commands make changes to the system. You can't use the *-WhatIf* parameter, which indicates to PowerShell to only test and display the results of the command, when you want to pipe to **Get-Member**. The *-WhatIf* parameter prevents the command from producing any output. That means **Get-Member** receives no input, and therefore doesn't display any output.


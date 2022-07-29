If Windows PowerShell is unable to bind pipeline input by using the **ByValue** technique, it tries to use the **ByPropertyName** technique. When using the **ByPropertyName** technique, Windows PowerShell attempts to match a property of the object passed to a parameter of the command to which the object was passed. This match occurs in a simple manner. If the input object has a **Name** property, it will be matched with the parameter **Name** because they're spelled the same. However, it will only pass the property if the parameter is programmed to accept a value by property name. This means that you can pass output from one command to another when they don't logically go together.

For example:

```powershell
Get-LocalUser | Stop-Process
```

The first command puts objects of the type **LocalUser** into the pipeline. The second command has no parameters that can accept that kind of object. The second command also has no parameters that accept a generic **Object** or **PSObject**. Therefore, the **ByValue** technique fails.

Because the **ByValue** technique fails, Windows PowerShell changes to the **ByPropertyName** technique. To predict what it will try to do, you can review the properties of the objects that the first command produces. In this example, run the following command:

```powershell
Get-LocalUser | Get-Member
```

You also need to make a list of parameters of the second command that can accept pipeline input by using **ByPropertyName**. To make that list, view Help for the second command:

```powershell
Get-Help Stop-Process -ShowWindow
```

By making this list, you'll see that the **Stop-Process** command has more than one parameter that accepts pipeline input by using **ByPropertyName**. Those parameters are **–Name** and **–Id**. The objects that Get-LocalUser produces don't have an ID property, so the **–Id** parameter isn't considered. The objects that **Get-LocalUser** produces have a **Name** property. Therefore, the contents of the **Name** property attach to the **–Name** parameter of **Stop-Service**. This means that **Stop-Service** will try to stop a service with a name that is the same as a user. If you try this step in Windows PowerShell, you'll notice that any errors that you receive are because a process can't be found with the target name. However, you wouldn't want to do this step in a real-world scenario. 

## Renaming properties

Most often, a property name from an output object doesn't match the name of an input parameter exactly. You can change the name of the property by using **Select-Object** and create a calculated property. For example, to view the processes running on all computers in your Windows Server Active Directory, try running the following command:

```powershell
Get-ADComputer -Filter * | Get-Process
```

However, this command doesn't work. No parameter for **Get-Process** matches a property name for the output of **Get-ADComputer**. View the output of **Get-ADComputer** | Get-Member and Get-Help **Get-Process** and you'll see that what you want is to match the **Name** property of **Get-ADComputer** with the -ComputerName parameter of **Get-Process**. You can do that by using **Select-Object** and changing the property name for the **Get-ADComputer** command’s **Name** property to ComputerName, and then passing the results to **Get-Process**. The following command will work:

```powershell
Get-ADComputer -Filter * | Select-Object @{n='ComputerName';e={$PSItem.Name}} | Get-Process
```

Another common use of the **ByPropertyName** technique is when you import data from comma-separated value (CSV) or similar files, and you feed that data to a command so that you can process a specific list of users, computers, or other resources. 
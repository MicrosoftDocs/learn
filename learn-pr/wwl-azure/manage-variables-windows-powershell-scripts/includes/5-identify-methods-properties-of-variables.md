Just as objects in Windows PowerShell have properties and methods, so do variables. The properties and methods that you can use vary depending on what's stored in the variable. If a variable contains an object such as an Active Directory Domain Services (AD DS) user account or a Windows service, then the properties and methods for the variable match those for the object. If a variable is the DateTime type, then the properties and methods for DateTime are available.

The simplest method for identifying the properties and methods that are available for a variable is to pipe the variable to the **Get-Member** cmdlet. The **Get-Member** cmdlet displays all the available properties and methods for a specific variable based on its variable type. For example:

```powershell
$logFile | Get-Member
```

To browse through the properties and methods for a variable, you leverage the tab completion feature by entering the name of the variable appended with a dot. When you select the **Tab** key, the properties and methods available for the variable display.

When you review the properties and methods for a variable, some of them will be easily understandable. If you don't understand how to use a property or method for a variable, you can review documentation for that variable type in the Microsoft .NET Framework Class Library. Each variable type has its own section in the documentation. For example, the documentation for Decimal variables is located in Decimal Struct.

> **Additional reading:** For more information on .NET Framework variable types, refer to the **Structs** section at [System Namespace](https://aka.ms/system-namespace).

The documentation for the .NET Framework is oriented towards developers and sometimes can be difficult to understand. You can also search the internet for examples relating to a specific method or property. Many examples are available online.


A method is an action that you can perform on an object. Repository objects that you query by using Common Information Model (CIM) or Windows Management Instrumentation (WMI) have methods that reconfigure the manageable components that the objects represent. For example, the **Win32_Service** class instances represent background services. The class has a **Change** method that reconfigures many of a service’s settings, including the sign-in password, name, and start mode.

When you query instances of a class, you can use the **Get-Member** cmdlet to discover the methods available for that type of object. The following examples depict how to use **Get-Member** to review the properties and methods for instances of **Win32_Service**:

```powershell
Get-WmiObject -Class Win32_Service | Get-Member -MemberType Method
```

```powershell
Get-CimInstance -ClassName Win32_Service | Get-Member -MemberType Method
```

You can also use **Get-CimClass** to review the methods available for a specific class:

```powershell
Get-CimClass -Class Win32_Service | Select-Object -ExpandProperty CimClassMethods
```

The methods available to managing object instances vary, depending on the type of object. The output of the commands doesn't explain how to use the methods, so unless you already know how to use them, you will need to find the relevant documentation by relying on other sources of information, such as results of an internet search.

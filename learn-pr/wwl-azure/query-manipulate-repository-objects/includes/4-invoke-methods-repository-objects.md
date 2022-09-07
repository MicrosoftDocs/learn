To use a method on an object, you invoke it. You can accomplish this by using direct invocation, which includes a reference to the object that supports the method, followed by the method name. Alternatively, you can use the **Invoke-WmiMethod** or **Invoke-CimMethod** cmdlets. If you use the cmdlets, the cmdlet you use needs to match the type of object you're working with.

## Direct invocation

Direct invocation is typically used when you've loaded Windows Management Instrumentation (WMI) objects into a variable. Then, you can invoke methods available for that object type by specifying the variable name, a dot (**.**), and then the method. This is similar to how you display property values for an object contained in a variable. The following example queries the spooler service as a WMI object and then invokes the **StopService** method.

```powershell
$WmiSpoolerService = Get-WmiObject -Class Win32_Service -Filter "Name='Spooler'"
$WmiSpoolerService.StopService()
```

The **StopService** method in the previous example doesn't require any parameters to be passed to it, so there's no value within the parentheses. If you invoke a method that requires parameters, their values are placed within the parentheses. The following example sets the value of the start mode parameter to **Manual**:

```powershell
$WmiSpoolerService.ChangeStartMode("Manual")
```

To identify the parameters required for a method, you should review the documentation for its class. Be aware that parameters for WMI method parameters need to be passed in a specific order. To identify the order, you can use the **GetMethodParameters()** method. The following example queries the parameters for the **Change** method:

```powershell
$WmiSpoolerService.GetMethodParameters("Change")
```

If the method requires multiple parameters and you don't want to change some of them, you can pass a `$null` value for the parameters you don't want to change. Additionally, you don't need to specify parameters that are positioned after the one you want to change. In the following example, the Change method has 11 parameters, but only the second parameter (display name) is being configured.

```powershell
$WimSpoolerService.Change($null,"Printer Service")
```

> [!NOTE] 
> Because `$null` is treated as a parameter value to skip when calling a method, you can't set a value to `$null` by invoking a method on a WMI object.

> [!NOTE] 
> Objects retrieved by **Get-CimInstance** are static and don't have methods. Therefore, you can't use them by relying on direct invocation.

## Using the Invoke-WmiMethod cmdlet

The **Invoke-WmiMethod** cmdlet is another way to invoke a method for a WMI object with different syntax. The *-Name* parameter is used to specify the method to invoke and the *-Argument* parameter is used to specify the parameter values that are passed to the method. If required, multiple parameters are passed as a comma-separated list or array. The parameter values need to be in a specific order just as they were for direct invocation.

You can use the **Invoke-WmiMethod** cmdlet by itself, or you can use the pipeline to send it a WMI object. Here are two examples that work the same way:

```powershell
Get-WmiObject -Class Win32_OperatingSystem | Invoke-WmiMethod -Name Win32Shutdown -Argument 0
```

```powershell
Invoke-WmiMethod -Class Win32_OperatingSystem -Name Win32Shutdown -Argument 0
```

The **Get-WmiObject** and **Invoke-Method** cmdlets both have the *-ComputerName* parameter that lets you run the cmdlet on a remote computer.

## Using the Invoke-CimMethod cmdlet

The **Invoke-CimMethod** cmdlets provide similar functionality to the **Invoke-WmiMethod** cmdlet, but argument list for **Invoke-CimMethod** is a dictionary object. Such an object consists of one or more key-value pairs. The key for each pair is the parameter name, and the value for each pair is the corresponding parameter value. In the following example, **Path** is the name of the parameter and **Notepad.exe** is the value:

```powershell
Invoke-CimMethod -ComputerName LON-DC1 -ClassName Win32_Process -MethodName Create -Arguments @{CommandLine='Notepad.exe'}
```

To include multiple parameters in the dictionary, use a semicolon to separate each key-value pair. Because the parameters are named, the key-value pairs can be in any order.

To invoke a method on a specific instance of an object, you retrieve the object first by using the **Get-CimInstance** cmdlet. You can pipe the object directly to the **Invoke-CimMethod** cmdlet or store it in a variable first. If the object provides all of the necessary information, then you don't need to specify any arguments. The following example retrieves any running instances of Notepad.exe and terminates them:

```powershell
Get-CimInstance -ClassName Win32_Process -Filter "Name='notepad.exe'" | Invoke-CimMethod -MethodName Terminate
```

If you use the *-ComputerName* or *-CIMSession* parameters with the **Get-CimInstance** cmdlet and pipe the resulting object to the  **Invoke-CimMethod** cmdlet, the method is invoked on whatever computer or session the object came from. For example, to terminate a process on a remote computer, you can run the following command:

```powershell
Get-CimInstance -ClassName Win32_Process -Filter "Name='notepad.exe'" -Computername LON-DC1 | Invoke-CimMethod -MethodName Terminate
```

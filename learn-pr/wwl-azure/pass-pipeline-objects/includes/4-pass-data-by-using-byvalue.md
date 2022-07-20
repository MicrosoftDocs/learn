When passing data by using **ByValue**, a parameter can accept complete objects from the pipeline when those objects are of the type that the parameter accepts. A single command can have more than one parameter accepting pipeline input **ByValue**, but each parameter must accept a different kind of object. 

For example, **Get-Service** can accept pipeline input **ByValue** on both its **–InputObject** and **–Name** parameters. Each of those parameters accept a different kind of object. **–InputObject** accepts objects of the type ServiceController, and **–Name** accepts objects of the type **String**. Consider the following example:

```powershell
'BITS','WinRM' | Get-Service
```

Here, two string objects are piped into **Get-Service**. They attach to the **–Name** parameter because that parameter accepts that kind of object, **ByValue**, from the pipeline.

To predict the function that Windows PowerShell performs with the object in the pipeline, you need to determine the kind of object in the pipeline. For this purpose, you can pipe the object to Get-Member. The first line of output tells you the kind of object that the pipeline contained. For example:

```powershell
PS C:\> "BITS","WinRM" | Get-Member
 
   TypeName: System.String

Name             MemberType            Definition
----             ----------            ----------
```

Here, the pipeline contains objects of the type System.String. Windows PowerShell often abbreviates type names to include only the last portion. In this example, that is **String**.

Then you examine the full Help for the next command in the pipeline. In this example, it is **Get-Service**, and you would find that both the **–InputObject** and **–Name** parameters accept input from the pipeline **ByValue**. Because the pipeline contains objects of the type **String**, and because the **–Name** parameter accepts objects of the type **String** from the pipeline **ByValue**, the objects in the pipeline attach to the **–Name** parameter.

## Generic object types

Windows PowerShell recognizes two generic kinds of object, Object and PSObject. Parameters that accept these kinds of objects can accept any kind of object. When you perform **ByValue** pipeline parameter binding, Windows PowerShell first looks for the most specific object type possible. If the pipeline contains a **String**, and a parameter can accept **String**, that parameter will receive the objects.

If there is no match for a specific data type, Windows PowerShell will try to match generic data types. That behavior is why commands like **Sort-Object** and **Select-Object** work. Each of those commands have a parameter named **–InputObject** that accepts objects of the type **PSObject** from the pipeline **ByValue**. This is why you can pipe any type of object to those commands. Their **–InputObject** parameter will receive any object from the pipeline because it accepts objects of any kind.



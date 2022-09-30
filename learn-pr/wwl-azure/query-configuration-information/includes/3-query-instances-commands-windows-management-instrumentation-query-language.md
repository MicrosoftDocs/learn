Once you've identified the class you want to query, you can use Windows PowerShell to retrieve the specific instances of that class. For example, if you want to retrieve all instances of the **Win32_LogicalDisk** class from the **root\CIMv2** namespace, run either of the following commands:

```powershell
Get-WmiObject -Class Win32_LogicalDisk
```

```powershell
Get-CimInstance -ClassName Win32_LogicalDisk
```

> [!NOTE] 
> The output from these commands is formatted differently, but they contain the same information.

> [!NOTE] 
> When using **Get-CimInstance**, you can use tab completion for the class name. This isn't possible with **Get-WmiObject**.

Both the *-Class* parameter of **Get-WmiObject** and the *-ClassName* parameter of **Get-CimInstance** are positional. The names of positional parameters don't need to be specified. That means the following commands provide the same results:

```powershell
Get-WmiObject Win32_LogicalDisk
```

```powershell
Get-CimInstance Win32_LogicalDisk
```

## Filtering instances

By default, both commands retrieve all available instances of the specified class. You can specify filter criteria to retrieve a smaller set of instances. The filter languages used by these commands don't use Windows PowerShell comparison operators. Instead, they use traditional programming operators, as listed in the following table.

*Table 1: Programming operators*

| **Comparison**                                   | **WMI and CIM operator**              | **Windows PowerShell operator**        |
| ------------------------------------------------ | ------------------------------------- | -------------------------------------- |
| Equal to                                         | **=**                                 | **-eq**                                |
| Not equal to                                     | **<>**                                | **-ne**                                |
| Greater than                                     | **>**                                 | **-gt**                                |
| Less than                                        | **<**                                 | **-lt**                                |
| Less than or equal to                            | **<=**                                | **-le**                                |
| Greater than or equal to                         | **>=**                                | **-ge**                                |
| Wildcard string match                            | **LIKE** (with **%** as the wildcard) | **-like** (with ***** as the wildcard) |
| Require two or more conditions to be true        | **AND**                               | **-and**                               |
| Require one of two or more conditions to be true | **OR**                                | **-or**                                |

For example, to retrieve only the instances of **Win32_LogicalDisk** for which the **DriveType** property is **3**, run either of the following commands:

```powershell
Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType=3"
```

```powershell
Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3"
```

> [!NOTE] 
> Many class properties use integers to represent different kinds of things. For example, in the **Win32_LogicalDisk** class, a **DriveType** property of **3** represents a local fixed disk. A value of **5** represents an optical disk, such as a DVD drive. You have to examine the class documentation to learn what each value represents.

## Querying by using WQL

Both WMI and CIM accept query statements written in WMI Query Language (WQL). WQL is a subset of Structured Query Language (SQL) that is specific to querying WMI. Their format is fairly intuitive so it's relatively straightforward to author them. For example, the following queries are equivalent to the previously described commands that retrieve the specific instance of the **Win32_LogicalDisk** class:

```powershell
Get-WmiObject -Query "SELECT * FROM Win32_LogicalDisk WHERE DriveType = 3"
```

```powershell
Get-CimInstance -Query "SELECT * FROM Win32_LogicalDisk WHERE DriveType = 3"
```

> **Additional reading:** For more information about WQL, refer to [WQL (SQL for WMI)](https://aka.ms/sql-for-wmi).

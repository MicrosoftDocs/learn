Namespaces organize the object classes that you can query with Common Information Model (CIM) and Windows Management Instrumentation (WMI). You can list namespaces to identify potentially useful object classes.

You can use the **Get-WmiObject** cmdlet to list all the namespaces on either the local or a remote computer. To list the namespaces on the local computer, run the following command:

```powershell
Get-WmiObject -Namespace root -List -Recurse | Select -Unique __NAMESPACE
```

> [!NOTE] 
> If you receive errors when running the previous command, ensure that you're using an elevated Windows PowerShell prompt. Some namespaces have security requirements that allow only administrators to access them.

You can use the **Get-CimInstance** cmdlet to list the namespaces within a specific namespace, but it doesn't provide a *-Recurse* parameter to list all available namespaces in a single command. However, the CIM cmdlets support tab completion for the *-Namespace* parameter, similar to how you can use tab completion when entering a file system path. Using tab completion for the namespace is a browsing method that you can use to explore the available namespaces.

In this module, you'll primarily use the **root\\CIMv2** namespace, which includes all the classes related to the Windows operating system and your computer’s hardware. **root\\CIMv2** is the default namespace. Therefore, you don't have to specify the namespace when querying instances from it, unless otherwise noted.

## Listing classes

Most of the time, when you use Common Information Model (CIM) and Windows Management Instrumentation (WMI) you're trying to accomplish a specific task. To identify how to accomplish that task, you typically do an internet search to identify if anyone has provided sample code that accomplishes a similar task. Then you can modify that code for your purposes and identify the CIM or WMI classes that they're using. When you don't find useful sample code, you might want to browse the available classes to check if anything is suitable.

To explore the classes available to you by using CIM and WMI, you can list the classes available in a namespace. For example, to list all the classes in the `root\CIMv2` namespace, run either of these commands:

```powershell
Get-WmiObject -Namespace root\CIMv2 -List
```

```powershell
Get-CimClass -Namespace root\CIMv2
```

Windows PowerShell doesn't list classes in any particular order. You can sort the output of your queries alphabetically to find classes more easily. For example, if you want a class that represents a process but don't know the class name, you can quickly refer to the “P” section of a sorted list and start to search for the word *process*. To produce an alphabetical list of classes in the **root\CIMv2** namespace, run either of the following commands:

```powershell
Get-WmiObject -Namespace root\cimv2 -List | Sort Name
```

```powershell
Get-CimClass -Namespace root\CIMv2 | Sort CimClassName
```

> [!NOTE] 
> In the **root\CIMv2** namespace, you'll notice some class names that start with **Win32_** and others that start with **CIM_**. This namespace is the only one that uses these prefixes. Classes that start with **CIM_** are typically abstract classes. Classes that start with **Win32_** are typically more specific versions of the abstract classes, and they contain information that's specific to the Windows operating system.

Many administrators feel that the repository is difficult to work with. Finding the class that you need to perform a particular task is a guessing game. You have to guess what the class might be named and then review the class list to figure out whether you're correct. Then you must query the class to determine whether it contains the information that you need. Because many classes outside the **root\CIMv2** namespace are not well-documented, this is your best approach. 

No central directory of repository classes exists. The repository doesn't include a search system. You can use Windows PowerShell to perform a basic keyword search of repository class names. For example, to find all the classes in the `root\CIMv2` namespace having *network* in the class name, use the following command:

```powershell
Get-CimClass *network* | Sort CimClassName
```

However, this technique does not provide the ability to search class descriptions because that information isn't stored in the repository. An internet search engine provides more viable alternative to search for possible class names.

> [!NOTE] 
> You might notice some class names that begin with two underscores (__). These are system classes that WMI and CIM use internally.

> [!NOTE] 
> There are several free graphical tools that you can use to browse WMI and CIM classes. To find these tools, use a search engine to search for **WMI explorer** or **CIM explorer**.

There's one specific WMI class object that can cause problems for system administrators. This is the **Win32_Product** class. You can use this class to query installed software, but be aware that returning the results takes a long time and has negative performance implications. When you query this class, the provider performs a Windows Installer (MSI) reconfiguration on every MSI package on the system as the query is being performed. Microsoft recommends using the **Win32reg_AddRemovePrograms** class as an alternative, but this class is only available on systems with the Microsoft Endpoint Configuration Manager client installed.

**Additional reading:** You can find the Microsoft Support page for this MSI reconfiguration issue at [Event log message indicates that the Windows Installer reconfigured all installed applications](https://aka.ms/jlgark).

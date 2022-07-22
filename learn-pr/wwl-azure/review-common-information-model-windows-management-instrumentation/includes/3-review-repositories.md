The repository that Common Information Model (CIM) and Windows Management Instrumentation (WMI) use is organized into namespaces. A *namespace* is a folder that groups related items for organizational purposes.

Namespaces contain classes. A *class* represents a manageable software or hardware component. For example, the Windows operating system provides classes for processors, disk drives, services, user accounts, and so on. Each computer on the network might have slightly different namespaces and classes. For example, a domain controller might have a class named **ActiveDirectory** that doesn't exist on other computers.

To find the top-level namespaces, run the following command:

```powershell
Get-CimInstance -Namespace root -ClassName __Namespace
```

> [!NOTE] 
> In the previous command, there are two underscores (_) in the class name of `__Namespace`.

Some of the namespaces returned might include:

- subscription
- DEFAULT
- CIMV2
- msdtc
- Cli
- Intel_ME
- SECURITY
- HyperVCluster
- SecurityCenter2
- RSOP
- Intel
- PEH
- StandardCimv2
- WMI
- directory
- Policy
- virtualization
- Interop
- Hardware
- ServiceModel
- SecurityCenter
- Microsoft
- Appv
- dcim

When you work with the repository, you typically work with instances. An *instance* is an actual occurrence of a class. For example, if your computer has two processor sockets, you'll have two instances of the class that represents processors. If your computer doesn't have an attached tape drive, you'll have zero instances of the tape drive class.

Instances are objects, similar to the objects that you've already used in Windows PowerShell. Instances have properties, and some instances have methods. *Properties* describe the attributes of an instance. For example, a network adapter instance might have properties that describe its speed, power state, and so on. *Methods* tell an instance to do something. For example, the instance that represents the operating system might have a method to restart the operating system.

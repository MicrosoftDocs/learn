In this module, you learned about the structure of the namespaces that contain classes and to query instances of a class. You also learned to query remote computers by using ad-hoc connections and CIM sessions. The following are the key takeaways:
-	Namespaces organize the object classes that you can query with CIM and WMI. You can list namespaces to identify potentially useful object classes.
-	To list all the namespaces on either the local or a remote computer, use the Get-WmiObject cmdlet.
-	The root\CIMv2 namespace includes all the classes related to the Windows operating system and your computer’s hardware. The root\CIMv2 is the default namespace. 
-	You can use Windows PowerShell to perform a basic keyword search of repository class names.
-	Both WMI and CIM accept query statements written in WMI Query Language (WQL). WQL is a subset of Structured Query Language (SQL) that is specific to querying WMI. 
-	Use WMI and CIM cmdlets to query and manage remote computers. WMI and CIM cmdlets have different capabilities and different syntaxes for remote connections.
-	A CIM session is a persistent configuration object that's used when creating a connection to a remote computer.

## Additional reading

To learn more, go through the following documents:

- [Win32 Provider](https://aka.ms/Win32-provider)
- [CIM Classes (WMI)](https://aka.ms/CIM-classes-wmi)
- [Event log message indicates that the Windows Installer reconfigured all installed applications​](https://aka.ms/jlgark)
- ​[WQL (SQL for WMI)](https://aka.ms/sql-for-wmi)
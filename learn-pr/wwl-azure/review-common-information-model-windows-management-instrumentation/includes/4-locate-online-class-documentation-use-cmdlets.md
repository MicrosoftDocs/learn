Although many Microsoft product groups and independent software vendors expose management information in the repository, only some of them offer official documentation. In most cases, an internet search for a class name provides your best option for finding the documentation that exists.

Classes provided by the Win32 provider are commonly used and well-documented. These classes are accessible through Common Information Model (CIM) and Windows Management Instrumentation (WMI) cmdlets. The names for these classes use the format Win32_*ObjectType*. For example, you can access operating system information by using the **Win32_OperatingSystem** class.

> **Additional reading:** You can review the documentation for Win32 classes on [Win32 Provider](https://aka.ms/Win32-provider).

CIM classes are also well-documented and they are available when using the CIM cmdlets. The names for these classes use the format CIM_*ObjectType*. For example, you can query operating system information by using the **CIM_OperatingSystem** class. Some CIM classes provide the same information as an equivalent Win32 class.

> **Additional reading:** You can review the documentation for the CIM classes on [CIM Classes (WMI)](https://aka.ms/CIM-classes-wmi).

To a certain extent, classes are self-documenting. You can use the **Get-Member** cmdlet to review the properties and methods available for a class. To do this, you query an instance of a class and then pipe it to **Get-Member**. For example, to get properties and methods for the **Win32_OperatingSystem** class, run the following command:

```powershell
Get-CimInstance -Namespace root\cimv2 -ClassName Win32_OperatingSystem | Get-Member
```

Windows PowerShell Help doesn't contain any information about CIM and WMI classes. CIM and WMI are external technologies that Windows PowerShell can use and understand. However, because they are external technologies, Windows PowerShell Help doesn't document the repository classes.

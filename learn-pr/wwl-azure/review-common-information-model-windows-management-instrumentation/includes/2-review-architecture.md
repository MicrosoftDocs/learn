Windows Management Instrumentation (WMI) and Common Information Model (CIM) are related technologies. Both technologies are based on industry standards that the Distributed Management Task Force (DMTF) defines. The DMTF defines independent management standards that can be implemented across different platforms or vendor enterprise environments. WMI, which is the Microsoft implementation of the Web-Based Enterprise Management (WBEM) standard, is an older technology that's based on preliminary standards and proprietary technology. CIM is a newer technology that's based on open, cross-platform standards.

Both technologies provide a way to connect to a common information repository (also known as the *WMI repository*). This repository contains management information that you can query and manipulate. There are two parallel sets of cmdlets that you can use to perform tasks by using WMI or CIM.

## CIM cmdlets

You can use CIM cmdlets to access the repository on local or remote computers. Multiple protocols for connectivity are supported and the protocol varies, depending on how the connection is created. Component Object Model (COM) is a protocol for local communication between software components. Distributed COM (DCOM) is an older proprietary Microsoft protocol for connectivity which uses dynamic ports. Web Services for Management (WS-MAN) is a web-based protocol defined by the DMTF for connectivity. A WS-MAN listener is configured automatically on port **5985**. Also, a secure listener is created on port **5986** if a certificate is available.

CIM cmdlets can create connections in three ways:

- Local connections. When you don't specify a remote computer, the CIM cmdlets use a local COM session to access and communicate with the repository.
- Ad-hoc connections. When you specify a remote computer by using the *-ComputerName* parameter with a CIM cmdlet, the remote connection uses WS-MAN.
- CIM sessions. You can precreate a CIM session with specific options for connectivity to remote computers. When you create a CIM session, you can specify whether to use WS-MAN or DCOM.

To use the CIM cmdlets on a remote computer, the remote computer doesn't need to have PowerShell installed. The remote computer needs to support WS-MAN to connect to it with CIM cmdlets. You can use CIM cmdlets with Linux computers.

In Windows, WS-MAN connectivity is provided by the Windows Remote Management (WinRM) service. This service also provides support for Windows PowerShell remoting, but PowerShell remoting is not required for the CIM cmdlets.

## WMI cmdlets

WMI cmdlets use the same repository as CIM cmdlets. The only difference is how the WMI cmdlets connect to a remote computer.

WMI cmdlets don't support session-based connections. These commands support only ad-hoc remote connections over DCOM. Whether used by WMI or CIM commands, DCOM might be difficult to use on some networks. DCOM uses the remote procedure call (RPC) protocol, which connects by using randomly selected port numbers. Special firewall exceptions are required for DCOM to work correctly.

The Windows Management Instrumentation service provides the connectivity for WMI. WMI cmdlets don't require any version of the Windows Management Framework on a remote computer. They also don't require Windows PowerShell remoting to be enabled. If the remote computer has the Windows Firewall feature enabled, you need to ensure that the remote administration exceptions are enabled on the remote computer. If the remote computer has a different local firewall enabled, equivalent exceptions must be created and enabled.

## Should you use CIM or WMI?

In general, you should use CIM cmdlets instead of the older WMI cmdlets. Microsoft considers the WMI commands within Windows PowerShell to be deprecated, although the underlying WMI repository is still a current technology. You should rely primarily on CIM commands and use WMI commands only when CIM commands aren't practical.

CIM cmdlets also provide easier network connectivity. Because CIM cmdlets use WS-MAN for remote connectivity, the firewall rules for known ports are easier to create than the randomly generated ports used by DCOM. If remote computers don't support using WS-MAN, you can specify the use of DCOM for connectivity by using a CIM session.

## Using cmdlets instead of classes

The repository is not well-documented, so discovering the classes that you need to perform a specific task might be difficult and impractical. If there is a PowerShell cmdlet for managing a specific item such as networking, then it's typically easier to use that cmdlet instead of the equivalent class methods exposed through CIM cmdlets. These purpose-built cmdlets often use CIM or WMI but hide their complexity from you. This approach gives you the advantages of Windows PowerShell cmdlets, such as discoverability and built-in documentation, while also giving you the existing functionality of the repository.

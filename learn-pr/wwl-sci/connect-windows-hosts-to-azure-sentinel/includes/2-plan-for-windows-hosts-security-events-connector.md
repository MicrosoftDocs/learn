You have three Windows security events connector options to stream events from Windows devices to Microsoft Sentinel.  

Based on your organization requirements, you have the option of installing an agent on each windows device to forward events to Microsoft Sentinel.  There are two agents available:
- Windows Security Events via AMA Connector
- Security Events via Legacy Agent Connector

The third option is to configure a Windows Event Collector device to receive events from the Windows devices. The Windows Event Collector device would then forward events to Microsoft Sentinel with the **Windows Forwarded Events connector**.  

 > [!NOTE]
 > All three connectors are installed from corresponding Content Hub solutions.

## Windows Security Events via AMA Connector vs. Security Events via Legacy Agent Connector

The Windows Security Events via AMA Connector has the following differences from the Security Events via Legacy Agent Connector:

Benefits:
- Manage collection settings at scale 
- Azure Monitoring Agent shared with other solutions
- Performance improvements
- Security improvements

Limitations:
 - None.

Requirements:
- non-Azure VM's/devices require Azure Arc.


### Azure Arc
Azure Arc is an agent installed on the device or VM that allows the device to be managed the same as an Azure VM. Azure Arc provides other functionality including running Azure based services in a hybrid environment.  

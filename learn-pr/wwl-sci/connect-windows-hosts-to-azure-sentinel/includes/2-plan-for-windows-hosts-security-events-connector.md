You have two Windows security events Content Hub solution options to stream events from Windows devices to Microsoft Sentinel.

The first option is to install the *Windows Security Events* Content Hub solution. You can choose either of the two agent data connectors available:

- Windows Security Events via AMA Connector
- Security Events via Legacy Agent Connector

The second option is to install the *Windows Forwarded Events* Content Hub solution and configure a Windows Event Collector device to receive events from the Windows devices. The Windows Event Collector device would then forward events to Microsoft Sentinel with the *Windows Forwarded Events* data connector.  

 > [!NOTE]
 > Microsoft recommends installation of Windows Security Events via AMA Connector. The Legacy connector uses the Log Analytics agent which was deprecated Aug 31, 2024, and thus should only be installed where AMA isn't supported.

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

Azure Arc uses the *Azure Connected Machine* agent (azcmagent) installed on the device or VM that allows the device to be managed the same as an Azure VM. Azure Arc provides other functionality including running Azure based services in a hybrid environment.  

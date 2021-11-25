Azure Defender for IoT security agents offer enhanced security capabilities, such as monitoring remote connections, active applications, login events, and operating system configuration best practices. Security agents handle raw event collection from the device operating system, event aggregation to reduce cost, and configuration through a device module twin. Security messages are sent through your IoT Hub, into Azure Defender for IoT analytics services.

A reference architecture for Linux and Windows security agents is provided with support for both C\# and C.

You can use the following workflow to deploy and test your Azure Defender for IoT security agents:

1.  Enable Azure Defender for IoT service to your IoT Hub.
2.  If your IoT Hub has no registered devices, Register a new device.
3.  Create an azureiotsecurity security module for your devices. To install the agent on an Azure simulated device instead of installing on an actual device, spin up a new Azure Virtual Machine (VM) in an available zone.
4.  Deploy an Azure Defender for IoT security agent on your IoT device, or new VM.
5.  Follow the instructions for **trigger\_events** to run a harmless simulation of an attack. The simulated attack provides an opportunity to verify that Azure Defender for IoT alert are triggered as expected.

## Understand security agent options

Security agents offer the same set of features for C and C\#, and support for similar configuration options is provided for both language options.

The C-based security agent has a lower memory footprint, and is the ideal choice for devices with fewer available resources.

:::row:::
  :::column:::
    
  :::column-end:::
  :::column:::
    **C-based security agent**
  :::column-end:::
  :::column:::
    **C\#-based security agent**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Open-source
  :::column-end:::
  :::column:::
    Available under MIT license in GitHub
  :::column-end:::
  :::column:::
    Available under MIT license in GitHub
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Development language
  :::column-end:::
  :::column:::
    C
  :::column-end:::
  :::column:::
    C\#
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Supported Windows platforms?
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Windows prerequisites
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    WMI
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Supported Linux platforms?
  :::column-end:::
  :::column:::
    Yes, x64 and x86
  :::column-end:::
  :::column:::
    Yes, x64 only
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Linux prerequisites
  :::column-end:::
  :::column:::
    libunwind8, libcurl3, uuid-runtime, auditd, audispd-plugins
  :::column-end:::
  :::column:::
    libunwind8, libcurl3, uuid-runtime, auditd, audispd-plugins, sudo, netstat, iptables
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Disk footprint
  :::column-end:::
  :::column:::
    10.5 MB
  :::column-end:::
  :::column:::
    90 MB
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Authentication to IoT Hub
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Security data collection
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Event aggregation
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Remote configuration through security module twin
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::


## Security agent installation guidelines

For Windows: The Install SecurityAgent.ps1 script must be executed from an Administrator PowerShell window.

For Linux: The InstallSecurityAgent.sh must be run as superuser. We recommend prefixing the installation command with “sudo”.

## Choose an agent "flavor"

Answer the following questions about your IoT devices to select the correct agent:

 -  Are you using Windows Server or Windows IoT Core?

Deploy a C\#-based security agent for Windows.

 -  Are you using a Linux distribution with x86 architecture?

Deploy a C-based security agent for Linux.

 -  Are you using a Linux distribution with x64 architecture?

Both agent flavors can be used. Deploy a C-based security agent for Linux and/or Deploy a C\#-based security agent for Linux.

Both agent flavors offer the same set of features and support similar configuration options.

## Supported platforms

The following list includes all currently supported platforms.

:::row:::
  :::column:::
    **Azure Defender for IoT agent**
  :::column-end:::
  :::column:::
    **Operating System**
  :::column-end:::
  :::column:::
    **Architecture**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    C
  :::column-end:::
  :::column:::
    Ubuntu 16.04
  :::column-end:::
  :::column:::
    x64
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    C
  :::column-end:::
  :::column:::
    Ubuntu 18.04
  :::column-end:::
  :::column:::
    x64
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    C
  :::column-end:::
  :::column:::
    Debian 9
  :::column-end:::
  :::column:::
    x64, x86
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    C\#
  :::column-end:::
  :::column:::
    Ubuntu 16.04
  :::column-end:::
  :::column:::
    x64
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    C\#
  :::column-end:::
  :::column:::
    Ubuntu 18.04
  :::column-end:::
  :::column:::
    x64
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    C\#
  :::column-end:::
  :::column:::
    Debian 9
  :::column-end:::
  :::column:::
    x64
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    C\#
  :::column-end:::
  :::column:::
    Windows Server 2016
  :::column-end:::
  :::column:::
    X64
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    C\#
  :::column-end:::
  :::column:::
    Windows 10 IoT Core, build 17763.
  :::column-end:::
  :::column:::
    x64
  :::column-end:::
:::row-end:::

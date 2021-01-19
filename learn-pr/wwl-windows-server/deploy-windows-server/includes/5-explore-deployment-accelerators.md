
Contoso IT infrastructure staff  must consider using software tools to help them plan their upgrade and migration to Windows Server 2019. Along with guidance content to help you design and plan your Windows Server deployment, Microsoft also supplies solution accelerators to aid in the process.

Solution accelerators are free, scenario-based guides and automations designed to help you with planning, deploying, and operating Microsoft products and technologies. Solution Accelerator scenarios focus on security and compliance, management and infrastructure, and communication and collaboration.

## Microsoft Deployment Toolkit

You can use the MDT to automate the deployment of Windows operating systems, applications, desktops, laptops, tablets, and servers in the enterprise.

> [!TIP]
> The MDT helps you configure the unattended answer files and provides tools for automating additional components and settings.

The MDT allows you to automate the creation of a reference computer and then capture that computer to an image, which you then can deploy to target computers. However, this feature is more applicable to building client computers running Windows 10 rather than building servers.

> [!NOTE]
> MDT lets you build and deploy both boot and install images.

Both boot and install image types are available as .wim files found on the installation media for Windows operating systems. Whenever you update a deployment share, the update process checks for changes and creates a new light-touch installation (LTI) boot image. The boot image is created in both a .wim file and an .iso image file, which you then can use to create bootable media.

While you'll usually use the original install.wim file found in the sources directory of the installation media to deploy an image, in rare cases you might want to customize both the image as it exists as a .wim file in the MDT Deployment Share, and through the deployment of the image.

> [!TIP]
> If you want to create a custom image, using MDT, you can deploy a .wim file to a reference computer, configure the reference computer, and then capture the reference computer in its entirety to a .wim file. You can later deploy this .wim file to many computer devices, and even add software, drivers, and apps to the image as part of customizing it when deploying.

When you follow the LTI process (which uses only the tools available in the MDT), you perform the following high-level steps:

1. Install the MDT, create a deployment share on the management computer, and then import the source files that you want to use.
1. Create a task sequence and boot image for the reference computer.
1. Update the deployment share with any changes.
1. Boot the reference computer with the MDT media. This will provide access to the task sequence files, the task sequence, and the boot image to the reference computer.
1. Run the deployment wizard to install the operating system on the reference computer, and capture an image of the reference computer.
1. Copy the captured image to the management computer.
1. Create the boot image and task sequence to deploy the captured image to target computers.
1. Update the deployment share.
1. Boot the target computer with the MDT media. This will provide the reference computer with access to the task sequence files, the task sequence, and the boot image.
1. Run the deployment wizard to install the operating system on the target computer.



## Microsoft Assessment and Planning Toolkit

The Microsoft Assessment and Planning Toolkit (MAP) is an agentless solution accelerator that analyzes the inventory of an organization’s server infrastructure, performs an assessment, and then creates reports that you can use for upgrade and migration plans.

:::image type="content" source="../media/m4-map.png" alt-text="A screenshot of the Microsoft Assessment and Planning Toolkit. The administrator has selected the Overview tab. Displayed are options for a number of scenarios, including Server, currently selected.":::

MAP is available for Windows Server 2019, Windows 10, and for other scenarios, such as:

- Assessing the environment for Microsoft 365 and Office 2019.
- Sizing your desktop virtualization needs for Virtual Desktop Infrastructure (VDI).
- Migrating to Microsoft Azure VM.
- Virtualizing Linux servers to Hyper-V.
- Setting up SQL Server platforms in the cloud.
- Planning Hyper-V servers.
- Assessing Microsoft Volume licensing compliance and positioning for Server and Cloud Enrollment.

Use the MAP to perform the tasks described in the following table.

| Task                                                         | Explanation                                                  |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| Inventory your organization’s IT infrastructure              | Based on the inventory, MAP displays a detailed report about which machines can run Windows Server 2019, which machines can run Windows Server 2019 with minimum system requirements, and which machines are not capable of running Windows Server 2019. MAP also recommends specific upgrades that ensure computers can run Windows Server 2019. |
| Generate a report or proposal based on the Windows Server 2019 Readiness Assessment | The report or proposal is a document that contains an executive overview, assessment results, next steps, and a worksheet summarizing Windows Server 2019 readiness for computers that are running Windows Server. |
| Capture the performance metrics of the current IT infrastructure to help plan consolidation and server virtualization. | The performance assessment generates reports on performance and presents the server consolidation recommendations. |
| Estimate server utilization based on that metric before and after the virtualization. | You can also choose which current physical servers are the best candidates for virtualization and the hosts on which you should place those VMs. |

MAP uses technologies that are already available in your IT environment to perform inventory and assessments. These technologies include Windows Management Instrumentation (WMI), the Remote Registry service, Simple Network Management Protocol (SNMP), AD DS, and the Computer Browser service.

### MAP discovery

MAP can discover Windows, Linux, UNIX, and VMware servers, computers, and virtual machines. It has the following discovery methods for creating an inventory:

- AD DS. Requires domain credentials. You can use this method to discover all computers in all domains, or in specified domains, containers, and organization units.

- Windows networking protocols, using the WIN32 LAN Manager application programming interface (API). Requires the Computer Browser service to be running on the computer, or the server running MAP. You can use this method to discover Windows workgroups and Windows NT 4.0 domains.

- Configuration Manager. MAP can use Configuration Manager for discovery. For discovery, you require the primary site server name and appropriate credentials for Configuration Manager or Systems Management Server.

- IP Address Range. You can scan for computer and servers using one or more IP address ranges, up to a maximum of 100,000 addresses.

- NetBIOS names. You also can discover computers and servers by entering their NetBIOS names manually, or by importing the names from a text file.

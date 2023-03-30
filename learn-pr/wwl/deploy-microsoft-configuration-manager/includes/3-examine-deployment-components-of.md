
Building on their use in MDT, boot images are Windows Preinstallation Environment (Windows PE) images that are used to start a Windows deployment. You can start boot images from a CD or DVD, an ISO file, a USB device, or over the network using a Pre-Boot Execution Environment (PXE) server. The boot images connect to the deployment share on the server and start the deployment. The creation process for a boot image in Configuration Manager is like that in MDT. Configuration Manager also allows the creation of an MDT boot image within its own UI when both tools are integrated.<br>

Configuration Manager provides two default boot images: One to support x86 platforms and the other to support x64 platforms. These images are stored in the i386 or x64 folders in the following share on the site server:

**\\\\&lt;SiteServerName&gt;\\SMS\_&lt;sitecode&gt;\\osd\\boot\\**

The default boot images are updated or regenerated depending on the action that you take. You can customize boot images in many ways to facilitate troubleshooting or expand capability; however, you must consider some key concepts:

 -  The architecture of the boot image must be appropriate for the architecture of the destination computer. For example, an x64 destination computer can boot and run an x86 or x64 boot image. However, an x86 destination computer can boot and run only an x86 boot image.
 -  Make sure that the boot image contains the network and storage drivers that are required to provision the destination computer.
 -  Insure you included all the required applications.

The Windows ADK is required as part of the prerequisites to set up a Configuration Manager hierarchy. Windows ADK loads a set of boot images based on a specific version of Windows. These images evolve as Windows does and follows a support matrix in relation to Configuration Manager site server support.

Starting with Configuration Manager 2006 and beyond, boot images have cloud capability that expands options for modern deployment; however, with the introduction of Autopilot and the use of OEM images from a vendor, the requirement to start devices from a boot image has less relevance.

The initial creation of boot images in MDT and Configuration is similar, as are the tools with which to customize the image itself. Note, that storage locations are different and, when using MDT and Configuration Manager together, only the boot images associated with Configuration Manager are referenced in the Configuration Manager task sequences through the UI.

#### OS Images

Operating system images in Configuration Manager are stored in the Windows Imaging (WIM) file format and represent a compressed collection of reference files and folders that are required to successfully install and configure an operating system on a computer. For all operating system deployment scenarios, you must select an operating system image. You can use the default operating system image or build the operating system image from a reference computer that you configure.

OS images after often used for the output of a capture task sequence and where enterprises store their golden .WIM images.

#### **Operating System Upgrade Packages**

Operating system upgrade packages are the source setup files for an operating system, such as Windows 10 or Windows 11. You can also use this package to deliver a vanilla image down onto a device. You import operating system upgrade packages to Configuration Manager from a DVD or mounted ISO file.

#### Device Drivers

You can install device drivers on destination computers without including them in the operating system image that is being deployed. Configuration Manager provides a driver catalog that contains references to all the device drivers that you import into Configuration Manager. The driver catalog is in the **Software Library** workspace and consists of two nodes: **Drivers** and **Driver Packages**. The **Drivers** node lists all the drivers that you've imported into the driver catalog. You can use this node to discover the details about each imported driver, to change what driver package or boot image a driver belongs to, to enable or disable a driver, and more.

Drive management is another topic in the deployment community with many different strategies and techniques to achieve similar goals. Configuration Manager provides you with the capability to be sure that only the correct drivers are applied to a piece of hardware albeit in a static way. Also, it's important that these are kept up to date, or you use a modern driver strategy as part of your long-term transition to modern management where drivers are applied direct from the vendors as opposed to driver packs.

#### Software Updates

Software updates in Configuration Manager provide a set of tools and resources that can help manage the complex task of tracking and applying software updates to client computers in the enterprise. An effective software update strategy is key to ensuring compliance within the enterprise and Configuration Manager allows this by building on the basic offerings of MDT and providing a management plane that can segregate updates by type or OS, and even work with existing processes for release management. Some of the components include software update groups, queries, and deployments.

#### Task Sequences

While MDT traditionally supports a lite-touch deployment (LTI), Configuration Manager takes this one step further and provides schedule-based deployments, which can be fully automated and require no user interaction. This is often referred to as zero-touch installation (ZTI), which requires the use of task sequences.

Configuration Manager supports the use of task sequences to automate several of the components in Configuration Manager. These components include software update packages, the application model (including deployment types), and more modern features, such as the Cloud Management Gateway, which open up deployment and management to remote clients.

Task sequences are defined in the Configuration Manager console. In the **Software Library** workspace, expand **Operating Systems** and select **Task Sequences**. The **Task Sequences** node, including subfolders that you create, is replicated throughout the Configuration Manager hierarchy.

Over the last several years, ZTI was the popular choice to take the headache away from the user. With the introduction of Windows Autopilot, there's now the potential for more user participation in the experience. This participation makes more options available in the deployment space and the concept of devices being shipped to a user's home and being provisioned on site is now a real possibility.

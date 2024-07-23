

Boot images in MDT and Configuration Manager are Windows PE images that initiate a Windows deployment, accessed through various mediums such as CD, ISO, USB or network. The boot images then connect to the deployment share to begin the deployment. Configuration Manager also allows for the creation of MDT boot images within its UI when both tools are integrated.

Configuration Manager provides two default boot images: One to support x86 platforms and the other to support x64 platforms. These images are stored in the `i386` or `x64` folders in the following share on the site server:

**\\\\< SiteServerName >\\SMS\_< sitecode >\\osd\\boot\\**

The default boot images are updated or regenerated depending on the action that you take. You can customize boot images in many ways to facilitate troubleshooting or expand capability; however, you must consider some key concepts:

 -  The architecture of the boot image must be appropriate for the architecture of the destination computer. For example, an x64 destination computer can boot and run an x86 or x64 boot image. However, an x86 destination computer can boot and run only an x86 boot image.
 -  Make sure that the boot image contains the network and storage drivers that are required to provision the destination computer.
 -  Insure you included all the required applications.

The Windows ADK is required as part of the prerequisites to set up a Configuration Manager hierarchy. Windows ADK loads a set of boot images based on a specific version of Windows. These images evolve as Windows does and follows a support matrix in relation to Configuration Manager site server support.

From Configuration Manager 2006 onwards, boot images have gained cloud capability, opening up new possibilities for modern deployment. However, as Autopilot and the utilization of OEM images from vendors have been introduced, the necessity of starting devices from a boot image has become less significant.

When it comes to the initial creation of boot images in both MDT (Microsoft Deployment Toolkit) and Configuration Manager, the process is similar, and the tools used for customizing the image. However, it's worth noting that the storage locations may vary. If MDT and Configuration Manager are utilized together, it's important to remember that only the boot images associated with Configuration Manager will be referenced within the Configuration Manager task sequences through the user interface (UI).

#### OS Images

Operating system images in Configuration Manager are stored in the Windows Imaging (WIM) file format and representing a compressed collection of reference files and folders that are required to successfully install and configure an operating system on a computer. For all operating system deployment scenarios, you must select an operating system image. You can use the default operating system image or build the operating system image from a reference computer that you configure.

OS images after often used for the output of a capture task sequence and where enterprises store their golden .WIM images.

#### **Operating System Upgrade Packages**

Operating system upgrade packages serve as the source files for an OS upgrade or to deliver a vanilla image. These packages are imported to Configuration Manager from a mounted ISO or DVD.

#### Device Drivers

You can install device drivers on destination computers without including them in the operating system image that is being deployed. Configuration Manager provides a driver catalog that contains references to all the device drivers that you import into Configuration Manager. The driver catalog is in the **Software Library** workspace and consists of two nodes: **Drivers** and **Driver Packages**. The **Drivers** node lists all the drivers that you've imported into the driver catalog. You can use this node to discover the details about each imported driver, to change what driver package or boot image a driver belongs to, to enable or disable a driver, and more.

Drive management is a notable subject within the deployment community, encompassing diverse strategies and techniques that aim to accomplish similar objectives. Configuration Manager empowers you to ensure the precise application of appropriate drivers to hardware, albeit in a static manner. It's equally important to regularly update these drivers or adopt a modern driver strategy as part of a long-term transition to modern management, where drivers are obtained directly from vendors rather than relying on driver packs.

#### Software Updates

Software updates in Configuration Manager provide a set of tools and resources that can help manage the complex task of tracking and applying software updates to client computers in the enterprise. An effective software update strategy is key to ensuring compliance within the enterprise and Configuration Manager allows this by building on the basic offerings of MDT and providing a management plane that can segregate updates by type or OS, and even work with existing processes for release management. Some of the components include software update groups, queries, and deployments.

#### Task Sequences

While MDT traditionally supports a lite-touch deployment (LTI), Configuration Manager takes this one step further and provides schedule-based deployments, which can be fully automated and require no user interaction. This is often referred to as zero-touch installation (ZTI), which requires the use of task sequences.

Configuration Manager supports the use of task sequences to automate several of the components in Configuration Manager. These components include software update packages, the application model (including deployment types), and more modern features, such as the Cloud Management Gateway, which open up deployment and management to remote clients.

Task sequences are defined in the Configuration Manager console. In the **Software Library** workspace, expand **Operating Systems** and select **Task Sequences**. The **Task Sequences** node, including subfolders that you create, is replicated throughout the Configuration Manager hierarchy.

Over the last several years, ZTI was the popular choice to take the headache away from the user. With the introduction of Windows Autopilot, there's now the potential for more user participation in the experience. This participation makes more options available in the deployment space and the concept of devices being shipped to a user's home and being provisioned on site is now a real possibility.

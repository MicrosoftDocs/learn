
The Microsoft Deployment Toolkit (MDT) is a unified collection of tools, processes, and guidance for automating desktop and server deployment. You can use it to create reference images or as a complete deployment solution. MDT is one of the most important tools available to IT professionals today.

In addition to reducing deployment time and standardizing desktop and server images, MDT enables you to manage security and ongoing configurations more easily. MDT builds on top of the core deployment tools in the Windows Assessment and Deployment Kit (Windows ADK). MDT provides extra guidance and features designed to reduce the complexity and time required for deployment in an enterprise environment.

MDT supports the deployment of Windows 10 or later, and Windows Server and provides support for zero-touch installation (ZTI) when working with Configuration Manager.

MDT has been heavily used by IT administrators over the years to help with the deployment of Windows 7 and 10. MDT is often used as the base to create clean corporate images, and has the flexibility to act independently or to integrate with Configuration Manager. By integrating MDT with Configuration Manager, MDT can expand the default capabilities and open more options for deployment customization.

> [!NOTE]
> It's important to understand that with the transition to Windows Autopilot and Microsoft Intune, MDT caters to a specific scenario where devices are likely built and managed on premises. As you shift to modern management and deployment, you should plan your procedures to ensure that you understand the ramification of and have a place for MDT in your strategy going forward.

### MDT setup prerequisites

To enable a successful Windows deployment, you must plan and assemble the MDT infrastructure prior to the delivery of the operating system.

Some of the key elements of the architecture of an MDT delivery include:

 -  **Active Directory Domain Services Environment**. Joins endpoints to Active Directory during the deployment process to a specified OU.
 -  **Windows 2016 or later server**. Hosts the MDT installation and setup of the deployment share for content that will be used during the capture or deployment process.
 -  **Windows ADK**. Includes the most recent Windows Assessment and Deployment Kit (ADK) to match the target Windows version of destination clients. This install takes place on the MDT server and supports the creation of boot images to service new client OS installs.
 -  **Windows Deployment Services (optional)**. Facilitates a network-driven initialization of the OS deployment.
 -  **Windows Server Update Services (optional)**. Includes a Windows 2016 or 2019 Server to house the Windows Update metadata and connection to Microsoft. The content downloaded can be utilized by MDT to deliver software updates during the OS deployment process.

### Exploring MDT

MDT offers numerous tools to help you plan and deploy Windows and, regardless of the size of the enterprise, all the components remain the same. Some of the key features and components that are available when planning a deployment setup include:

 -  Windows 10 or later client support.
 -  Windows Server 2016 and later support.
 -  The ability to automate a sequential set of tasks into a single repeatable deliverable that can be replicated onto many devices. This can include the installation of an operating system, line-of-business applications, language packs, scripts, and more.
 -  Deployment of a user empowering interface that enables end users to customize their Windows OS installation.
 -  Displays the status of currently running deployments.
 -  Offline BitLocker, which saves hours of encryption time by having BitLocker enabled during the Windows Preinstallation Environment (Windows PE) phase.
 -  Support for running the **User State Migration Tool (USMT)** capture offline, during the Windows PE phase of the deployment.
 -  Granular customization that enables the IT Admin to deliver an OSE tailored to the organization’s needs.

### Exploring the components of MDT

After installing MDT on a server and creating a deployment share using Deployment Workbench, there are several components that work together to help you plan, build, and maintain the delivery of Windows to new or existing devices that require a rebuild.

:::image type="content" source="../media/microsoft-deployment-toolkit-deploy-workbench-4c069d30.png" alt-text="Screenshot of the Deployment Workbench.":::


Boot images are the Windows PE images that start the OS deployment. This is essentially a minimal OS that contains limited components and services. You can start boot images from a CD or DVD, an ISO file, a USB device, or over the network using a Pre-Boot Execution Environment (PXE) server. The boot images connect to the deployment share on the server and start the deployment. You'll usually create two default boot images: One to support x86 platforms and one to support x64 platforms. These images are stored in the i386 or x64 folders, respectively. As part of the setup and configuration of MDT, the Windows ADK will be installed on the designated server that delivers the OoB boot images for x86 and x64. It's important to remember that when using UEFI firmware that the correct boot image is available for the target OS.

When deciding whether to add drivers to a Windows PE image, you should first determine if the existing image has network capability on the target device. If so, drivers may not be needed during the Windows PE stage and can be delivered later during deployment.

> [!NOTE]
> Consider adding a custom background to your boot image

The key components of Deployment Workbench include:

 -  **Operating system (OS images)**. Using the Deployment Workbench, you import the operating systems you want to deploy. You can import either the full source (such as the full Windows 10 DVD/ISO) or a custom image that you've created. The full-source operating systems are primarily used to create reference images; however, you can also use them for normal deployments. The Windows installation files include the default OS image. This image is a basic OS image that contains a standard set of drivers. When using the default OS image, you can use task sequence steps to later install apps and make other configurations on a device.
 -  **Applications**. Using the Deployment Workbench, you also add the applications you want to deploy. MDT supports virtually every executable Windows file type. The file can be a standard .exe file with command-line switches for an unattended install, a Microsoft Windows Installer (MSI) package, a batch file, or a VBScript. In fact, it can be just about anything that can be executed unattended. MDT also supports the new Universal Windows apps.
 -  **Drivers**. Using the Deployment Workbench, you can plan and deliver several different driver types to your enterprise. For ease and simplicity, you can use MDT to structure your drivers by make and model and profile them so that drivers are only available for the hardware that you configure.
    
    :::image type="content" source="../media/microsoft-deployment-toolkit-driver-folder-structure-f5ab9fd5.png" alt-text="Screenshot of the Drivers folders in Deployment Workbench.":::
    
    
    > [!TIP]
    > To avoid driver conflicts, it is important to have a strategy for managing drivers when planning and delivering Windows. A key aspect of this is ensuring you plan the driver file structure in MDT and the deployment share to isolate the vendor and model of hardware. This will ensure that any appropriate drivers that are required for boot images or installation can be identified and utilized accordingly.

 -  **Packages**. Using the Deployment Workbench, you can add any Microsoft packages that you want to use. The more commonly added packages are language packs, and the Deployment Workbench Packages node works well for those. You also can add security and other updates this way. However, we generally recommend that you use Windows Server Update Services (WSUS) for operating system updates. The rare exceptions are critical hotfixes that aren't available through WSUS, packages for the boot image, or any other package that needs to be deployed before the WSUS update process starts.
 -  **Task Sequences**. Task sequences are the heart and soul of the deployment solution. When creating a task sequence, you need to select a template. The templates are in the Templates folder in the MDT installation directory, and they define the default actions in the sequence. You can think of a task sequence as a list of actions that need to be executed in a certain order. Each action can also have conditions. Some examples of actions include:
     -  **Gather**. Reads configuration settings from the deployment server.
     -  **Format and Partition**. Creates the partition(s) and formats them.
     -  **Inject Drivers**. Determines which drivers the machine needs and downloads them from the central driver repository.
     -  **Apply Operating System**.
     -  **Windows Update**. Connects to a WSUS server and updates the machine.

The role of MDT isn't to manage your Windows upgrades. Its primary focus is building and rebuilding your devices with a specific set of configurations. To manage upgrades and begin the journey to Windows as a Service (WaaS), you should look for tools that exist in the modern managed toolset, such as Microsoft Endpoint Manager or Windows Update for Business (WuFB).

MDT can function as a standalone product. It can also integrate with Configuration Manager, although that subject is outside the scope of this training. That being said, it's important to remember that for an on-premises delivery of Windows, a combination of MDT and Configuration Manager provides a 'best of breed' solution. MDT creates the golden image, and Configuration Manager manages the delivery and evolution of the device after it's delivered to the end user.

As you transition to some of the modern management tools, it's likely that a combination of Windows Autopilot and Intune will begin to perform many of the tasks associated with MDT. For example, the top three benefits of using Autopilot in modern deployments include eliminating OS image re-engineering, customizing the out-of-box experience, and preconfiguring policies and ensuring security with enrollment status. There are scenarios in which Autopilot isn't suited. In these cases, MDT would be the more appropriate tool to use. These scenarios include:

 -  Bare-metal deployments.
 -  When the storage hardware where Windows 11 is installed must be replaced.
 -  When the Windows 11 installation has become corrupt.
 -  When an organization requires prompts for custom user information beyond what the out-of-box experience provides (such as customizing the LTI interface with MDT).

To determine if MDT can be part of your overall deployment strategy, create a checklist of questions and answers to help you plan. For example:

 -  Do you want to deploy a standard golden image to your users?
 -  How many applications are part of this image?
 -  Should users have choice about which applications they have?
 -  Should each device be the same?
 -  How many hardware types do you need to manage?
 -  Do you need to deploy applications after the device has been built?
 -  How will you deliver software updates?

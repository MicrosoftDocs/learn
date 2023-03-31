
You can use the Deployment Workbench to create and deploy Windows 11 or later images. Many of the same components are used in both the capture process and when delivering Windows 11 or later to an endpoint. This agility enables you to adapt to whichever scenario presents itself, while still using the same toolset. This unit examines the creation, management, and deployment of images from MDT.

### Reference images

Creating a reference image is the foundation to standardizing the operating system configuration delivered to your users. You use MDT to create these images with the necessary configuration and build upon some of the prerequisites, such as a deployment share and configuration rules and settings.

Traditionally, enterprises have always created a custom (or golden) image with which to imprint on their endpoints. While they serve a purpose, images can become technician intensive due to the cadence of Windows and the constant changes that arise. Autopilot attempts to bridge the gap. But, for now, consider the reasons behind creating a golden image (such as core applications or perhaps a timely unique installation sequence) and plan for it, rather than doing it because you always have.

Make a checklist of how your current platform is put together and then look for ways to streamline that process, or consider if you could do it in a more efficient way, such as:

 -  Do you have any applications as part of your image that requires constant updating?
 -  Do you have a process for keeping your core image up to date with security updates?
 -  Are there any legacy steps or tasks that are no longer required?

You can import both original media and custom images that you've created into the Deployment Workbench. The following image showcases a standard Windows setup directory that can be imported.

:::image type="content" source="../media/window-10-enterprise-files-fb4ca293.png" alt-text="Screenshot of the root folder of a Windows 10 Enterprise image.":::


The Deployment Workbench is where you store your default image.

:::image type="content" source="../media/operate-system-image-files-dbcac027.png" alt-text="Screenshot of OS image in the Deployment Workbench.":::


### Add an application to the captured image

Before you create an MDT task sequence, you must first add any applications, and scripts you want to install to the MDT build lab share. Select the source files and add the application under the application pane.

If you need to add multiple applications, consider using Windows PowerShell to speed up the process. The following example shows connecting to the deployment share using the MDT PowerShell Support modules and then adding a sample application.

```powershell
Import-Module "C:\Program Files\Microsoft Deployment Toolkit\bin\MicrosoftDeploymentToolkit.psd1"
New-PSDrive -Name "DS001" -PSProvider MDTProvider -Root "D:\MDTBuildLab"
$ApplicationName = "Install - Office365 ProPlus - x64"
$CommandLine = "setup.exe /configure configuration.xml"
$ApplicationSourcePath = "D:\Downloads\Office365"
Import-MDTApplication -Path "DS001:\Applications\Microsoft" -Enable "True" -Name $ApplicationName -ShortName $ApplicationName -CommandLine $CommandLine -WorkingDirectory ".\Applications\$ApplicationName" -ApplicationSourcePath $ApplicationSourcePath -DestinationFolder $ApplicationName -Verbose
```

### Deploy a reference image with a task sequence

To create a capture and then deploy Windows 11 or later with MDT, you'll create a task sequence. A task sequence is a sequential set of steps that will reference various components imported into MDT up to this point (OS images, applications etc.) When you create these using the MDT wizard, you're presented with various templates to help with each scenario. For this lesson, we'll focus on a deployment task sequence.

Some of the key steps in the development task sequence and their role in delivering an automated delivery of Windows include:

 -  **Gather**. Collects information locally and stores it as variables for use during the task sequence.
 -  **Format and Partition Disk**. Formats and creates an appropriate disk layout for the target endpoint.
 -  **Apply OS Image**. Applies a standard Windows image or a custom \*.WIM file from a previously ran capture process.
 -  **Inject Drivers**. Allows specific drivers to be applied to certain target devices.
 -  **Install Applications**. Allows for an application imported in MDT to be installed sequentially.

An example task sequence is show below:

:::image type="content" source="../media/task-sequence-example-f676c21f.png" alt-text="Screenshot of a Task Sequence.":::


You can create task sequences by using a wizard or building it from scratch.

> [!NOTE]
> When creating golden images, it is a best practice to do this on a virtual machine to ensure there are no rogue drivers injected into your image. At this stage, no drivers should be as part of the deployment consideration unless the virtual machine is unable to establish a network connection.

When capturing and deploying Windows, be sure to familiarize yourself with the Unattend.xml file. This helps the Windows installation move through the various passes and applies any relevant customization. System Image Manager helps you review and showcase answer files for Windows.

:::image type="content" source="../media/system-image-manager-2b34e5e8.png" alt-text="Screenshot of the Windows System Image Manager,":::


With the move to modern management, IT Admins are becoming more and more conscious of the pitfalls associated with the creation and management of a golden image. With technologies such as Windows Autopilot building upon the OEM edition of Windows 10 or later, this approach is being adopted more frequently and golden images are being used less. IT Admins are instead adopting to start with the Windows installation media and customize one layer up. This creates a more 'plug and play' approach to Windows deployment and management and is less engineering heavy. Autopilot, however, doesn't address all scenarios, such as deployments to bare-metal devices. For an organization that may have regulatory requirements or has an image composition that is extremely complex, the ability to imprint a golden image may still offer some value.

### Methods of installation

The following provides a brief overview and comparison between traditional and modern methods:

Traditional Method Deployment

 -  In traditional deployments, **lite-touch installations (LTI)** are automated deployments that require some user intervention, such as a user must be present at the computer to initiate an installation, which then continues automatically. Both MDT and Configuration Manager support LTI deployments. Users might choose LTI deployments using MDT, since MDT requires minimal infrastructure and less complex than zero-touch deployments.
 -  In **zero-touch installations (ZTI)**, the deployment is completely automated without any user intervention and can be initiated without user intervention. This can be beneficial when performing many deployments simultaneously. ZTI deployments can be more difficult to implement than LTI/UDI deployments and require Configuration Manager.
 -  With **user-driven installations (UDI)**, the user can interact during the deployment, giving them certain choices for configuration. These options can include choosing the device name, selecting apps to install, language, etc. Unlike ZTI, where every setting must be defined (which can lead to complex or numerous task sequences), UDI allows the end user to decide certain options.

For example, if a deployment must support seven languages, seven task sequences might be created or a complex script to ascertain what language to deploy based on some criteria, and IT would need to assume ownership to identify each user's language. Allowing the user to choose their own language during deployment reduces the need for IT to devote resources. Alternatively, for a shared device, such as a kiosk, ZTI might make more sense.

UDI deployments require both MDT and Configuration Manager. MDT integrates and extends the capabilities of Configuration Manager and adds the graphical deployment wizard to facilitate the user-drive experience in traditional image deployments.

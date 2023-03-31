
Until Windows 11, the method of choice for deploying an OS was typically imaging the device. Imaging is applying a preconfigured OS to a large group of computers. This has historically been the preferred method of large-scale deployments where manual installation methods could be more practical. Traditional methods like imaging are still supported for Windows 11 or later.

### Default and custom images

Administrators must decide whether to use the default Windows image or create a custom image when choosing an image to deploy.

The Windows installation files include the default OS image, install.wim. This image is a basic OS image that contains a standard set of drivers. When you use the default OS image, configuring the OS and installing applications must be done separately after the image is deployed.

Configurations and applications can be included in custom images. Tools such as Deployment Image Servicing and Management (DISM.exe) can be used to service and prepare Windows images. DISM is a command line tool that can capture the image of a reference computer with the desired OS, settings, and applications. DISM can also be used to mount the image and make modifications.

Sysprep is then used to generalize the image prior to deployment. Before deploying a Windows image to new PCs, you must first generalize the image. This process removes computer-specific information such as installed drivers and the computer security identifier (SID). Generalizing the image makes it ready for deployment.

There are advantages and disadvantages to using default and custom images, as outlined in the following chart.

| Default Image                                               | Custom Image                                                |
|-------------------------------------------------------------|-------------------------------------------------------------|
| No need to create an image                                  | Image must be created and maintained                        |
| Applications and settings must be applied separately        | Applications and Settings can be included in custom image   |
| One image per architecture (x86/x64) can be used for the organization | The configuration and application requirements (and sometimes hardware) of each group within an organization can typically require several images to be created and maintained |
| Updates to applications don't require the image to be re-built | Updates to applications cause images to become stale, requiring images to be updated or re-created frequently |
| Overall deployment time is typically slower, as configurations must be applied and applications installed after the OS image is deployed | Overall deployment time is typically faster with the configurations and applications included in the image |
| Some applications can be difficult to automate the installation | When applications are installed on the reference machine, they're typically easier to deploy when included with the image |



### Thin versus thick images

When choosing how to image, thin and thick images refer to what the image contains beyond the OS. A thin image may be the default image or a custom image with just the OS and a few drivers required to ensure the OS installs correctly. Alternatively, a thick image might be the OS and several applications widely used across the organization.

At first, thick images can appear as a more attractive option. However, thick images become more difficult to manage over time. Eventually, applications require updates, and configuration changes are often needed. With every deployment, these changes and updates must be applied. As the updates accumulate over time, deployment time can significantly increase. With multiple images to support, managing versions of apps and configurations can become difficult. As time passes, the need to rebuild the image increases to the point where it becomes necessary. The effort to rebuild images can negate the time initially saved with thick images.

For these reasons, thin images are recommended, applying configurations and installing applications after deployment. While they take some extra up-front effort, updates become easier to manage, and images don't become "stale" as quickly. Organizations can automate these post-deployment tasks with minimal maintenance to the images themselves using GPOs and device policies to apply configurations using solutions like Endpoint Manager.

### Boot from VHD

Instead of installing the OS directly on the physical drive, Windows 7 and later devices also support boot from VHD. Using tools such as Hyper-V, PowerShell, or the Disk Management console, a .vhd or .vhdx file can be created. You can apply a Windows image file and boot from it as if it were natively installed on the storage device.

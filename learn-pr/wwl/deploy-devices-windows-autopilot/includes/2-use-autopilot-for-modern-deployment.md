

Modern deployment methods take a new approach to provisioning devices. One of the key benefits of Windows 11 and later is a feature called Windows Autopilot. Windows Autopilot is a cloud-based deployment method. With Autopilot, you can set up and preconfigure new and existing Windows 11 or later devices. Users in your organization use a new operating system out-of-the-box experience (OOBE) to configure their devices without needing a Windows image.

Autopilot offers the following advantages over on-premises deployment methods:

 -  You don't need to use images.
 -  You don't need to customize the deployments by injecting drivers.
 -  You don't need to deploy and maintain a deployment infrastructure.
 -  Configuring Autopilot deployments are relatively simple compared to traditional image creation and management.
 -  With no images to deploy, heavy bandwidth consumption is no longer a concern.

Windows Autopilot is cloud-driven and based around Azure AD Premium and Microsoft Intune. Using Windows Autopilot, you can:

 -  Join devices to Azure AD automatically.
 -  Auto enroll your users' devices into MDM services.
 -  Restrict the creation of the Administrator account.
 -  Customize the OOBE content specifically to your organization.

### New devices

Most organizations purchase new devices from an Original Equipment Manufacturer (OEM). In this process, they typically buy the device with an OEM license of Windows 11 (usually Pro edition). Organizations rarely desire the OEM image, and until Windows 10, they reimaged the device to configure it to organizational requirements.

It's no longer necessary to reimage the device when it already has Windows 11 or later. Regardless of the OEM image configuration or installed applications, Autopilot can reconfigure the device to suit the organization's requirements, including installing Line-Of-Business Apps and even changing the edition (such as switching from Pro to Enterprise).

From the user's standpoint, turning on the device initiates an Out-of-Box Experience (OOBE), during which the organization determines which options can be configured by the user. One potential benefit is the ability to have a zero-touch installation (ZTI) experience, meaning the device is ready to use simply by plugging it in and turning it on.

### Refresh existing devices

Over time, scenarios arise where it may be beneficial to refresh the device. Performance may be impacted as more apps are installed over time, and it can lead to intermittent issues or challenges that are not easily resolved. IT might elect to perform a wipe-and-load, and as with new deployments, Autopilot can be used instead of traditional methods. Similarly, if a device is reassigned to another user, Autopilot can be used to reset the device with a new OOBE as if the device was wiped and reimaged.

Windows 11 and later still supports traditional deployment. Many organizations use image-based deployment to upgrade their computers to Windows 11, although in-place upgrade is the recommended upgrade path when upgrading from Windows 8.1. Once a device is upgraded to Windows 11, organizations have the choice as to whether they continue to use image-based deployment or adopt modern deployment methods such as Autopilot or, in the case of upgrading from Windows 11, using Feature update.

### Autopilot compared to traditional methods

The following table compares traditional and modern Windows 11 deployment.

|                               | Traditional deployment                                                         | Modern deployment |
|-------------------------------|--------------------------------------------------------------------------------|-------------------|
| Deploys Windows 11 images   | Yes                                                                            | No                |
| Can be used with any preinstalled operating system  | Yes                                                                            | No                |
| Requires a previous Windows 11 installation | No                                                                             | Yes               |
| Uses an on-premises infrastructure | Yes                                                                            | No                |
| Tools for preparing the deployment  | Windows ADK, Windows Deployment Services, Microsoft Deployment Toolkit (MDT), and Configuration Manager | Windows Configuration Designer and Windows Autopilot |



There are certain circumstances where traditional installation methods must be used instead of Autopilot. These scenarios include:

 -  Bare-metal deployments.
 -  When the storage hardware where Windows 11 is installed must be replaced.
 -  In the event of a corrupted Windows 11 installation.
 -  When an organization requires prompts for custom user information beyond what the OOBE provides (such as customizing the LTI interface with MDT).

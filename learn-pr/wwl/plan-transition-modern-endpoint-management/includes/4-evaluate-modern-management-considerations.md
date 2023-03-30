
Modern deployment methods take a different approach to OS deployment. Modern methods serve to remove the imaging process wherever possible. Instead of completely wiping the existing data and replacing it, these options transform the existing operating system with little or no user interaction and without deploying a new image. The outcome is the same; a device that functions as if a fresh install of Windows was performed, but no images were involved in the process. Because of this, modern deployment options are typically faster, more efficient, and have lower network utilization.

Modern methods do require that Windows 11 be installed on the target device. For devices still running Windows 7 or 8.1, the in-place upgrade method is recommended (in-place upgrade is examined in the next unit). For devices running another operating system or no operating system, traditional methods must be used. But once the device has Windows 11 installed, there are few reasons to continue using traditional methods such as imaging. Even for new devices, which typically come with some edition of Windows 11, imaging isn't necessary to transform the OS to the desired edition and configuration.

Modern deployment can change an installed Windows 11 operating system in many ways, such as:

 -  Removing pre-installed software.
 -  Upgrading a Windows 11 edition.
 -  Joining a Windows 11 device to AD DS or Microsoft Azure Active Directory (Azure AD).
 -  Enrolling a Windows 11 device in a mobile device management (MDM) solution, such as Configuration Manager or Intune, which performs a final and more advanced customization.
 -  Restricting the Administrator account creation.
 -  Creating and auto-assigning devices to configuration groups based on a device's profile.
 -  Customizing OOBE content specific to the organization.

### Modern transition considerations

As you begin the transition from a traditional delivery of an OS to a more modern approach, there are several key components that you'll be familiar with in traditional deployment projects. The following chart provides a high-level overview of these considerations to help you determine the best approach and tooling to help you plan your journey forward.

|                  | MDT | Configuration Manager | Windows Autopilot |
|------------------|:-----:|:-----------------------:|:--------------------:|
| Require the creation of golden images | Yes | Yes | No |
| Ability to reset existing OS | No | No | Yes |
| Ability to perform a bare metal build | Yes | Yes | No |
| Can be used with any preinstalled operating system | Yes | Yes | Windows 11 only |
| Installation of applications during OS deployment/provisioning | Yes | Yes | Yes |
| Deployment of applications post-build | No | Yes | Yes |
| Migration of user data | Yes - USMT | Yes - USMT | Yes - OneDrive/ESR |
| Perform an in-place upgrade | Yes | Yes | Yes (in combination with Configuration Manager) |

After you've considered these requirements, there are two paths for transition:

 -  Migration of existing technologies and utilizing the benefits that each setup can offer.
 -  An adoption of modern technologies from the outset.

The remaining units in this module examine some of the key aspects around these paths.

### Image with Modern Methods

While modern methods are preferred as they offer easier configuration and management, sometimes traditional methods using imaging may be needed. Some of the more common day-to-day scenarios that are likely to require organizations to consider using imaging with modern management include:

 -  A device experiences a BSOD and can't boot into Windows at all, resulting in the need for a bare-metal build.
 -  When you deliver a series of complex applications and dependencies onto a device, which is then co-managed.
 -  There's a hardware failure of a device that requires network connectivity to install applications or join a corporate Active Directory domain.

This is most notably in situations such as client storage drive replacements, bare-metal deployments, and devices that don't support an upgrade path to the desired OS.

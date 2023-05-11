

Modern deployment methods take a different approach to OS deployment. Modern methods serve to remove the imaging process wherever possible. Instead of completely wiping the existing data and replacing it, these options transform the existing operating system with little or no user interaction and without deploying a new image. The outcome is the same; a device that functions as if a fresh install of Windows was performed, but no images were involved in the process. Because of this, modern deployment options are typically faster, more efficient, and have lower network utilization.

To utilize modern methods, it's essential to have Windows 11 installed on the target device. For devices still running Windows 7 or 8.1, the in-place upgrade method is recommended (in-place upgrade is examined in the next unit). For devices running another operating system or no operating system, traditional methods must be used. But once the device has Windows 11 installed, there are few reasons to continue using traditional methods such as imaging. Even for new devices, which typically come with some edition of Windows 11, imaging isn't necessary to transform the OS to the desired edition and configuration.

Modern deployment can change an installed Windows 11 operating system in many ways, such as:

 -  Removing preinstalled software.
 -  Upgrading a Windows 11 edition.
 -  Joining a Windows 11 device to AD DS or Microsoft Azure Active Directory (Azure AD).
 -  Enrolling a Windows 11 device in a mobile device management (MDM) solution such as Configuration Manager or Intune facilitates an advanced customization phase for the device. During this stage, various settings, policies, and management features specific to the MDM solution are configured, enhancing the device's overall customization and management capabilities.
 -  Restricting the Administrator account creation.
 -  Creating and autoassigning devices to configuration groups based on a device's profile.
 -  Customizing OOBE content specific to the organization.

### Modern transition considerations

As you begin the transition from a traditional delivery of an OS to a more modern approach, there are several key components that you're familiar with in traditional deployment projects. The following chart provides a high-level overview of these considerations to help you determine the best approach and tooling to help you plan your journey forward.

|                  | MDT | Configuration Manager | Windows Autopilot |
|------------------|:-----:|:-----------------------:|:--------------------:|
| Require the creation of golden images | Yes | Yes | No |
| Ability to reset existing OS | No | No | Yes |
| Ability to perform a bare metal builds | Yes | Yes | No |
| Can be used with any preinstalled operating system | Yes | Yes | Windows 10/11 only |
| Installation of applications during OS deployment/provisioning | Yes | Yes | Yes |
| Deployment of applications post-builds | No | Yes | Yes |
| Migration of user data | Yes - USMT | Yes - USMT | Yes - OneDrive/ESR |
| Perform an in-place upgrade | Yes | Yes | Yes (in combination with Configuration Manager) |

After you've considered these requirements, there are two paths for transition:

 -  Migration of existing technologies and utilizing the benefits that each setup can offer.
 -  An adoption of modern technologies from the outset.

The remaining units in this module examine some of the key aspects around these paths.

### Image with Modern Methods

While modern methods of management are preferred due to their ease of configuration and administration, there are situations where traditional methods using imaging become necessary. These scenarios often arise in day-to-day operations, and some common examples include:

 -  When a device encounters a Blue Screen of Death (BSOD) and fails to boot into Windows, requiring a fresh installation from scratch.
 -  Deploying a series of complex applications and their dependencies to a device that is already co-managed.
 -  Dealing with hardware failures on a device that necessitate network connectivity for application installation or joining a corporate Active Directory domain.

These scenarios commonly occur when handling tasks such as replacing client storage drives, conducting bare-metal deployments, or dealing with devices that can't be upgraded to the desired operating system.

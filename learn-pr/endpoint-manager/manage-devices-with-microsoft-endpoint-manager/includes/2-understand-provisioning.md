Provisioning is a process where your organization issues new or repurposed devices to individuals in your organization. Before a device is enrolled with Intune or Configuration Manager, you may need to provision the device. As part of the provisioning process, the individual user signs in to the device and steps through the process of connecting to your organization. You can either enroll the devices with Intune or Configuration Manager during the provisioning process or after, depending on the platform and your needs.

> [!IMPORTANT]
> If you're familiar with provisioning and your organization currently uses image-based provisioning to install a specific configuration to a device, you should consider modern provisioning going forward.

Modern provisioning provides the following benefits:

- Decreases costly IT workload by autogenerating the creation of each device image
- Provides self-service provisioning directly by end users
- Provides faster time to productivity for end users
- Increases out-of-the-box security
- Lowers operational expenses

## Provisioning Windows devices

To provision Windows devices, you can use Windows Autopilot. Windows Autopilot simplifies enrolling devices in Intune. Building and maintaining customized operating-system images is a time-consuming process. You might also spend time applying these custom operating-system images to new devices to prepare them for use before giving them to your end users. With Microsoft Intune and Autopilot, you can give new devices to your end users without the need to build, maintain, and apply custom operating-system images to the devices. When you use Intune to manage Autopilot devices, you can manage policies, profiles, apps, and more after they're enrolled.

> [!video https://www.microsoft.com/videoplayer/embed/RE4C7G9?autoplay=false]

There are four types of Windows Autopilot deployment:

- **Self-Deploying Mode** for kiosks, digital signage, or shared devices. Self-deploying mode joins the device into Azure Active Directory, enrolls the device in Intune (or another MDM service) leveraging Azure AD for automatic MDM enrollment, and ensures that all policies, applications, certificates, and networking profiles are provisioned on the device, leveraging the enrollment status page to prevent access to the desktop until the device is fully provisioned.
- **White Glove** enables partners or IT staff to pre-provision a Windows 10/11 PC so that it's fully configured and business-ready.
- **Autopilot for existing devices** enables you to easily deploy the latest version of Windows 10/11 to your existing devices.
- **User Driven Mode** for traditional users. This process is designed to be simple so that anyone can complete it, enabling devices to be shipped or distributed to the end user directly with simple instructions.

There are a number of alternative ways to provision devices as well. Configuration Manager offers several methods to deploy Windows OS to Windows devices, such as using Software Center, standalone media, a preboot execution environment (PXE), multicast, and more. Intune also offers provisioning using bulk enrollment for your Azure AD tenant.

## Provisioning Apple devices

To provision Apple devices (iOS and macOS devices), you can use Apple Business Manager (ABM) or Apple School Manager (ASM). You can set up Intune to enroll iOS/iPadOS/macOS devices purchased through Apple's Automated Device Enrollment (ADE) (formerly Device Enrollment Program). Automated Device Enrollment lets you enroll large numbers of devices without ever touching them. You can ship devices like iPhones, iPads, and MacBooks directly to users. When the user turns on the device, Setup Assistant, which includes the typical out-of-box-experience for Apple products, runs with pre-configured settings and the device enrolls into management.

## Provisioning Android devices

To provision corporate-owned Android devices, you can use Android Enterprise **zero-touch** program. When the device is started, it checks whether it has been assigned an enterprise configuration. If it has, then it starts the fully managed device provisioning process. By using zero-touch, you can have large number of devices provisioned and enrolled without ever touching them.

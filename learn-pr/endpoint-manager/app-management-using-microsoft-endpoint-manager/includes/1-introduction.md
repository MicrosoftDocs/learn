You can use Microsoft Intune to manage the apps that your company's workforce uses on their devices. This functionality is called mobile application management (MAM). MAM in Intune is designed to protect organization data at the application level, including custom apps and store apps. App management can be used on organization-owned devices and personal devices. When it's used with personal devices, only organization-related access and data are managed.

## Video - Interactive guide to managing devices

The following interactive guide steps you through the Microsoft Intune admin center to show you how to manage and protect devices.


> [!VIDEO https://mslearn.cloudguides.com/guides/Manage%20and%20protect%20mobile%20and%20desktop%20applications%20with%20Microsoft%20Endpoint%20Manager]


Suppose that you're the administrator of a company with several thousand employees. Your company uses Microsoft Office to create and share information internally and externally. Your company allows employees to use their own devices. You must implement the rules that are enforced when employees attempts to access, move, or copy corporate data using managed apps.

Microsoft Intune supports two MAM configurations:

- **Intune MDM + MAM**: IT administrators can only manage apps using MAM and app protection policies on devices that are enrolled with Intune mobile device management (MDM). To manage apps using MDM + MAM, customers should use the Intune console in the Microsoft Intune admin center.
- **MAM without device enrollment**: MAM without device enrollment, or MAM-WE, allows IT administrators to manage apps using MAM and app protection policies on devices not enrolled with Intune MDM. This configuration means Intune can manage apps on devices enrolled with third-party EMM providers. To manage apps using MAM-WE, customers should use the Intune console in the Microsoft Intune admin center. Also, Intune can manage apps on devices enrolled with third-party enterprise mobility management (EMM) providers or not enrolled with an MDM at all.

When apps are managed in Intune, administrators can:

- **Protect company data at the app level.** You can add and assign mobile apps to user groups and devices, allowing your company data to be protected at the app level. You can protect company data on both managed and unmanaged devices because mobile app management doesn't require device management. The management is centered on the user identity, which removes the requirement for device management.
- **Configure apps to start or run with specific settings enabled.** In addition, you can update existing apps already on the device.
- **Assign policies to limit access and prevent data from being used outside your organization.** You choose the setting for these policies based on your organization's requirements. For example, you can:
  - Require a PIN to open an app in a work context.
  - Control the sharing of data between apps.
  - Prevent the saving of company app data to a personal storage location.
- **Support apps on a variety of platforms and operating systems.** Each platform is different. Intune and Configuration Manager provides available settings specifically for each supported platform.
- **See reports about which apps are used, and track their usage.** In addition, Intune and Configuration Manager provides endpoint analytics to help you assess and resolve problems.
- **Do a selective wipe by removing only organization data from apps.**
- **Ensure personal data is kept separate from managed data.** End-user productivity isn't affected and policies don't apply when using the app in a personal context. The policies are applied only in a work context, which gives you the ability to protect company data without touching personal data.

## Learning objectives

In this module, you will:

- Understand how your organization's apps can be configured and protected.
- Understand the app lifecycle.
- Learn about the data protection framework using app protection policies.

## Prerequisites

- None

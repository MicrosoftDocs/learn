Microsoft Endpoint Manager is a single, integrated management platform for managing, protecting, and monitoring all of your organization's endpoints.

Endpoints include the mobile devices, desktop computers, virtual machines, embedded devices, and servers that your organization uses. Additionally, endpoints also include the apps used by your organization. 

By protecting and monitoring your organization's endpoints using Microsoft Endpoint Manager, you do the following:
- Protect the data that the people at your organization are accessing.
- Ensure your organization is using proper credentials to access and share company data.
- Safeguard the devices and apps that access your organization resources.
- Confirm security rules are in place based on your organizations requirements. 

The Microsoft Endpoint Manager console helps keep your organization's cloud and on-premises devices, apps, and data secure. Endpoint Manager integrates Microsoft Intune, Microsoft Endpoint Configuration Manager, co-management, Desktop Analytics, and Windows Autopilot.

## Microsoft Intune

Microsoft Intune, which is available within Microsoft Endpoint Manager, is a cloud-based mobile device management (MDM) and mobile application management (MAM) provider for your apps and devices. It lets you control features and settings on Android, Android Enterprise, iOS/iPadOS, macOS, and Windows 10 devices. It integrates with other services, including Microsoft 365 and Azure Active Directory (Azure AD) to control who has access, and what they have access to, and Azure Information Protection for data protection. If you have on-premises infrastructure, such as Exchange or an Active Directory, the Intune connectors are also enrollment, access, and authentication. Intune is included in Microsoft's [Enterprise Mobility + Security (EMS) suite](https://www.microsoft.com/microsoft-365/enterprise-mobility-security). 

## Microsoft Endpoint Configuration Manager

Configuration Manager is an on-premises management solution to manage desktops, servers, and laptops that are on your network or internet-based. You can cloud-enable it to integrate with Intune, Azure AD, Microsoft Defender ATP, and other cloud services. Use Configuration Manager to deploy apps, software updates, and operating systems, as well as configure sites and clients, and run and monitor management tasks.

## Co-management

Co-management is where you concurrently manage Windows 10 devices with both Configuration Manager and Microsoft Intune. It combines your existing on-premises Configuration Manager investment with the cloud using Intune and other Microsoft 365 cloud services. You choose whether Configuration Manager or Intune is the management authority. Co-management enables you to concurrently manage Windows 10 devices by using both Configuration Manager and Microsoft Intune. You keep some tasks on-premises, while running other tasks in the cloud with Intune.

## Desktop Analytics

Desktop Analytics is a cloud-based service that integrates with Configuration Manager. It provides insight and intelligence for you to make more informed decisions about the update readiness of your Windows clients. The service combines data from your organization with data aggregated from millions of devices connected to the Microsoft cloud. It provides information on security updates, apps, and devices in your organization, and identifies compatibility issues with apps and drivers. Create a pilot for devices most likely to provide the best insights for assets across your organization.

## Windows Autopilot

Windows Autopilot simplifies enrolling devices in Intune. Windows Autopilot offers a zero-touch, self-service Windows deployment platform. The Windows Autopilot process runs immediately after powering on a new computer for the first time, enabling employees to configure new devices to be business-ready with just a few clicks. You can also use Windows Autopilot to reset, repurpose and recover devices. This solution enables an IT department to achieve the above with little to no infrastructure to manage, with a process that's easy and simple.

Windows Autopilot is designed to simplify all parts of the lifecycle of Windows devices, for both IT and end users, from initial deployment through the eventual end of life. Leveraging cloud-based services, it can reduce the overall costs for deploying, managing, and retiring devices by reducing the amount of time that IT needs to spend on these processes and the amount of infrastructure that they need to maintain, while ensuring ease of use for all types of end users.

Before a modern management approach was available, building and maintaining customized operating system images was a time-consuming process. You might also have spent time applying these custom operating system images to new devices to prepare them for use before giving them to your end users. With Microsoft Intune and Autopilot, you can give new devices to your end users without the need to build, maintain, and apply custom operating system images to the devices. When you use Intune to manage Autopilot devices, you can manage policies, profiles, apps, and more after they're enrolled. 

Windows Autopilot enables you to:
- Automatically join devices to Azure Active Directory (Azure AD) or Active Directory (via Hybrid Azure AD Join).
- Auto-enroll devices into MDM services, such as Microsoft Intune.
- Restrict the Administrator account creation.
- Create and auto-assign devices to configuration groups based on a device's profile.
- Customize Out-of-box-experience (OOBE) content specific to the organization.

## Additional resources
- [Tutorial: Walkthrough Intune in Microsoft Endpoint Manager](https://docs.microsoft.com/mem/intune/fundamentals/tutorial-walkthrough-endpoint-manager)
- [Evaluate Configuration Manager by building your own lab environment](https://docs.microsoft.com/mem/configmgr/core/get-started/evaluate-with-lab-environment) 
- [Quickstart: Try Microsoft Intune for free](https://docs.microsoft.com/mem/intune/fundamentals/free-trial-sign-up)

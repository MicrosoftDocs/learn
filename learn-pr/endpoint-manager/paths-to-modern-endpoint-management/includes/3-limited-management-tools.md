When your organization has little to no modern endpoint management tools in use, you should consider either of the following options:
- Move directly to cloud endpoint management using Microsoft Intune.
- Use tenant attach or co-management with Microsoft Endpoint Configuration Manager. 

Both of these endpoint management solutions are part of Microsoft Endpoint Manager. If you don't have a requirement to manage some devices on-premises, solely using Microsoft Intune may best fit your needs. Microsoft Intune, which is part of Microsoft Endpoint Manager, provides the cloud infrastructure, the cloud-based mobile device management (MDM), cloud-based mobile application management (MAM), and cloud-based PC management for your organization. It lets you protect your organization by controlling features and settings on Android, Android Enterprise, iOS/iPadOS, macOS, and Windows 10 devices. It integrates closely with Azure Active Directory (Azure AD) for identity and access control and it integrates with Azure Information Protection and other advanced threat protection products for data protection.

If you need to use both cloud and on-premises device management, consider using tenant attach or co-management with Microsoft Endpoint Configuration Manager. Microsoft Endpoint Configuration Manager is the leading PC management solution on the market. You use it to manage desktops, servers, and laptops that are on your network or are internet-based. If you use Configuration Manager, you should attach your Configuration Manager deployment to the Microsoft 365 cloud, which will provide integration with Intune, Azure AD, Microsoft Defender for Endpoint, and other cloud services. Use Configuration Manager to deploy apps, software updates, and operating systems, as well as configure sites and clients, and run and monitor management tasks. Configuration Manager supports Windows and macOS versions. 

## Benefits of using Intune

By using Intune to manage your organization's endpoints, you gain the following benefits:
- No need to set up and operate your own management infrastructure.
- Native integration with cloud-powered security controls and risk-based conditional access for apps and data.
- Flexible support for diverse corporate and bring-your-own-device (BYOD) scenarios, while increasing productivity and collaboration.
- Maximize your investment and accelerate time to value with fast rollout of services and devices with end-to-end integration across familiar Microsoft stack.

## Benefits of using Configuration Manager

Cloud attach allows you to leverage both Microsoft Intune and Microsoft Endpoint Configuration Manager from Microsoft Endpoint Manager.

When you enroll Configuration Manager clients in co-management, you gain the following immediate value:

- Conditional access with device compliance
- Intune-based remote actions, such as restart, remote control, or factory reset
- Centralized visibility of device health
- Link users, devices, and apps with Azure Active Directory (Azure AD)
- End-to-end, robust OS deployment with Windows Autopilot
- Optionally extend your device management infrastructure using co-management with Configuration Manager.

## Next steps

For detailed steps when you currently don't use an endpoint management solution and want to use Microsoft Intune, see the [Deployment guide: Setup or move to Microsoft Intune](https://docs.microsoft.com/mem/intune/fundamentals/deployment-guide-intune-setup?azure-portal=true#currently-dont-use-anything).

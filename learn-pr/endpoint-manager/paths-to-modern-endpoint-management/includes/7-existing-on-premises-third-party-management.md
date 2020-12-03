If you currently use a different Mobile Device Management platform, you can consider moving your endpoints to Intune cloud management or co-management with Intune and Configuration Manager. 

As mentioned earlier in this module, Microsoft Intune is available within Microsoft Endpoint Manager. It is a cloud-based mobile device management (MDM) and mobile application management (MAM) provider for your apps and devices. It lets you protect your organization by controlling features and settings on Android, Android Enterprise, iOS/iPadOS, macOS, and Windows 10 devices. It integrates closely with Azure Active Directory (Azure AD) for identity and access control and Azure Information Protection for data protection.

You use Configuration Manager to manage desktops, servers, and laptops that are on your network or are internet-based. If you use Configuration Manager, you should attach your Configuration Manager deployment to the Microsoft 365 cloud, which will provide integration with Intune, Azure AD, Microsoft Defender ATP, and other cloud services. 

Devices should only have one Mobile Device Management (MDM) provider. It's common to switch from another MDM provider, such as AirWatch, MobileIron, or MaaS360, to Intune. The biggest challenge is that users must unenroll their devices from the current MDM provider, and then enroll in Intune. 

## Benefits of using Intune

As mentioned earlier in this module, using Intune to manage your organization's endpoints, you gain the following benefits:
- No need to setup and operate your own management infrastructure.
- Native integration with cloud-powered security controls and risk-based conditional access for apps and data.
- Flexible support for diverse corporate and bring-your-own-device (BYOD) scenarios, while increasing productivity and collaboration.
- Maximize your investment and accelerate time to value with fast rollout of services and devices with end-to-end integration across familiar Microsoft stack.

## Benefits of co-management

As mentioned earlier in this module, by moving your organization's endpoints to Intune (for your cloud-based endpoints) and Configuration Manager (for your on-premises based endpoints), you gain the following benefits:
- Native integration with cloud-powered security controls and risk-based conditional access for apps and data. 
- Flexible support for diverse corporate and bring-your-own-device (BYOD) scenarios while increasing productivity and collaboration.
- Maximize your investment and accelerate time to value with fast rollout of services and devices with end-to-end integration across familiar Microsoft stack 

Benefits of using co-management:
- Conditional access with device compliance  
- Remote actions from Intune  
- Configuration Manager client health  
- Azure Active Directory (Azure AD)  
- Modern provisioning - Windows Autopilot  
- Web based admin for Config Manager 
- Unified helpdesk and troubleshooting 
- Cloud intelligence drive management 

## Next steps

For detailed steps when you currently use Microsoft Endpoint Configuration Manager as your on-premises management solution and you need to also use Microsoft Intune via cloud-attach management, see the [Currently use a third party MDM provider](https://docs.microsoft.com/mem/intune/fundamentals/deployment-guide-intune-setup#currently-use-a-third-party-mdm-provider?azure-portal=true).
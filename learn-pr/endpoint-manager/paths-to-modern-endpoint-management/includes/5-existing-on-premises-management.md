If you're currently using Microsoft Endpoint Configuration Manager as your on-premises management solution, you can easily add cloud-attach management. Configuration Manager supports Windows and macOS devices. And, cloud attach allows you to leverage both Configuration Manager and Microsoft Intune from Microsoft Endpoint Manager.

It is important to understand that you have more than one option when considering a migration path to device management in the cloud. Any of the following options will put you on the path to modern endpoint management:
- Add tenant attach with Microsoft Endpoint Configuration Manager
- Set up co-management with Microsoft Endpoint Configuration Manager
- Move from Configuration Manager to Intune
- Start from scratch with Microsoft 365 and Intune

As previously mentioned in this module, Configuration Manager is the leading PC management solution on the market. You use it to manage desktops, servers, and laptops that are on your network or are internet-based. If you use Configuration Manager, you should attach your Configuration Manager deployment to the Microsoft 365 cloud, which will provide integration with Intune, Azure AD, Microsoft Defender ATP, and other cloud services. Use Configuration Manager to deploy apps, software updates, and operating systems, as well as configure sites and clients, and run and monitor management tasks. Configuration Manager supports Windows and macOS versions. The devices you manage with Configuration Manager can run in virtual environments. This includes Hyper-V on Windows servers as well as Virtual Machines (VM) in Azure. If you run a server as an Azure-based VM, you can install the Configuration Manager client on that device. For more information about Configuration Manager, see [Understand Microsoft Endpoint Configuration Manager](https://docs.microsoft.com/learn/modules/intro-to-endpoint-manager/4-endpoint-configuration-manager/?azure-portal=true).

## Benefits of co-management

By moving your additional endpoint to Intune to manage your organization's endpoints, you gain the following benefits:
- Native integration with cloud-powered security controls and risk-based conditional access for apps and data. 
- Flexible support for diverse corporate and bring-your-own-device (BYOD) scenarios while increasing productivity and collaboration.
- Maximize your investment and accelerate time to value with fast rollout of services and devices with end-to-end integration across familiar Microsoft stack 

Benefits of using co-management:
- Conditional access with device compliance  
- Remote actions from Intune  
- Configuration Manager client health  
- Azure Active Directory (Azure AD)  
- Modern provisioning - Windows Autopilot  
- Web-based admin for Configuration Manager 
- Unified helpdesk and troubleshooting 
- Cloud intelligence drive management 

There are two main paths to reach co-management:

- **Existing Configuration Manager clients**: You have Windows 10 devices that are already Configuration Manager clients. You set up hybrid Azure AD, and enroll them into Intune.
- **New internet-based devices**: You have new Windows 10 devices that join Azure AD and automatically enroll to Intune. You install the Configuration Manager client to reach a co-management state.

## Next steps

For detailed guidance when you currently use Microsoft Endpoint Configuration Manager as your on-premises management solution and need to understand your endpoint management options, see the [Currently use Configuration Manager](https://docs.microsoft.com/mem/intune/fundamentals/deployment-guide-intune-setup?azure-portal=true#currently-use-configuration-manager).
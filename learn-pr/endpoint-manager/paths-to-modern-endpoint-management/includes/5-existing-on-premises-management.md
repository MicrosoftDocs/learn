If you're currently using Microsoft Endpoint Configuration Manager as your on-premises management solution, you can easily add cloud-attach management. Configuration Manager supports Windows and macOS devices. And, cloud attach allows you to leverage both Configuration Manager and Microsoft Intune from Microsoft Endpoint Manager.

If you currently use an on-premises device management platform other than Configuration Manager, consider moving your endpoints to Configuration Manager. Going forward, you will also have the option to use co-management with Intune and Configuration Manager.

You use Configuration Manager to manage desktops, servers, and laptops that are on your network or are internet-based. If you use Configuration Manager, you should attach your Configuration Manager deployment to the Microsoft 365 cloud, which will provide integration with Intune, Azure AD, Microsoft Defender for Endpoint, and other cloud services. 

As previously mentioned in this module, Configuration Manager is the leading PC management solution on the market. You use it to manage desktops, servers, and laptops that are on your network or are internet-based. If you use Configuration Manager, you should attach your Configuration Manager deployment to the Microsoft 365 cloud, which will provide integration with Intune, Azure AD, Microsoft Defender for Endpoint, and other cloud services. Use Configuration Manager to deploy apps, software updates, and operating systems, as well as configure sites and clients, and run and monitor management tasks. Configuration Manager supports Windows and macOS versions. The devices you manage with Configuration Manager can run in virtual environments. This includes Hyper-V on Windows servers as well as Virtual Machines (VM) in Azure. If you run a server as an Azure-based VM, you can install the Configuration Manager client on that device. 

To leverage both Configuration Manager and Microsoft Intune from Microsoft Endpoint Manager, you can add cloud-attach management. There are two steps to cloud attach your on-premises devices. The first step of attachment is called tenant attach, which is registering your Intune tenant with your Configuration Manager deployment. The second step is called co-management, which is concurrently managing Windows 10 devices with both Configuration Manager and Microsoft Intune. These are incremental steps on the journey to having full cloud attachment. You get immediate value through tenant attach and you get additional value through co-management.

If you decide to move from another endpoint management solution, you should start by noting the tasks your running and the features you use. When devices unenroll, we recommend using conditional access to block devices until they enroll in the new endpoint management solution. Use a phased approach. Start with a small group of pilot users, and add more groups until you reach full scale deployment. Monitor the helpdesk load and enrollment success of each phase. When you're satisfied with the first phase of migrations, repeat the migration cycle for each following phase.

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

Once you decide to move to Configuration Manager or extend your existing Configuration Manager solution, there are two main paths to reach co-management:

- **Existing Configuration Manager clients**: You have Windows 10 devices that are already Configuration Manager clients. You set up hybrid Azure AD, and enroll them into Intune.
- **New internet-based devices**: You have new Windows 10 devices that join Azure AD and automatically enroll to Intune. You install the Configuration Manager client to reach a co-management state.

> [!NOTE]
> It's important to understand that you have more than one option when considering a migration path to device management in the cloud. Any of the following options will put you on the path to modern endpoint management:
> - Add tenant attach with Microsoft Endpoint Configuration Manager
> - Set up co-management with Microsoft Endpoint Configuration Manager
> - Move from Configuration Manager to Intune
> - Start from scratch with Microsoft 365 and Intune

## Next steps

For detailed guidance when you currently use Microsoft Endpoint Configuration Manager as your on-premises management solution and need to understand your endpoint management options, see the [Currently use Configuration Manager](https://docs.microsoft.com/mem/intune/fundamentals/deployment-guide-intune-setup?azure-portal=true#currently-use-configuration-manager).
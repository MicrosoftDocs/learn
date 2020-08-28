Microsoft Endpoint Manager is a single, integrated management platform for managing, protecting, and monitoring all of your organization's endpoints.

Endpoints include the mobile devices, desktop computers, virtual machines, embedded devices, servers, and shared devices that your organization uses. Examples of shared and specialized devices include retail point of sale devices, ruggedized devices, digital interactive whiteboards, conference room devices, and holographic wearable computers. Additionally, endpoints also include the apps used by your organization.

By protecting and managing your organization's endpoints using Microsoft Endpoint Manager, you accomplish the following actions:
- Protect the data that the people at your organization are accessing.
- Ensure your organization is using proper credentials to access and share company data.
- Safeguard the devices and apps that access your organization resources.
- Ensure that new members of your organization have a great experience on-boarding to your organization.
- Confirm security rules are in place based on your organizations requirements. 
- Confirm that every member of your organization has a device that is configured and protected.
- Ensure that all your corporate services are easily available to end users on all the devices they use.
- Ensure that end users get the best possible experience based on first class support for all the products that they need to use.

The Microsoft Endpoint Manager console helps keep your organization's cloud and on-premises devices, apps, and data secure. Endpoint Manager integrates Microsoft Intune, Microsoft Endpoint Configuration Manager, Desktop Analytics, and Windows Autopilot. 

> [!IMPORTANT]
> If you already have Microsoft Intune or Microsoft Endpoint Configuration Manager you already have Microsoft Endpoint Manager. These are all now one management system.

![Diagram of Microsoft Endpoint Manager](../media/intro-to-endpoint-manager-01.png)

To quickly step through the areas of Microsoft Endpoint Manager, see [Tutorial: Walkthrough Intune in Microsoft Endpoint Manager](https://docs.microsoft.com/mem/intune/fundamentals/tutorial-walkthrough-endpoint-manager).

## Microsoft Intune

Microsoft Intune, which a part of Microsoft Endpoint Manager, provides the cloud infrastructure, the cloud-based mobile device management (MDM), cloud-based mobile application management (MAM), and cloud-based PC management for your organization. It lets you protect your organization by controlling features and settings on Android, Android Enterprise, iOS/iPadOS, macOS, and Windows 10 devices. It integrates closely with Azure Active Directory (Azure AD) for identity and access control and Azure Information Protection and advanced threat protection products for data protection. When you use it with Microsoft 365, you can enable your workforce to be productive on all their devices while keeping your organization's information protected. If you have on-premises infrastructure, such as Exchange or an Active Directory, you can use Intune connectors to help you connect to external services. Intune, which is a part of Microsoft Endpoint Manager, is included in Microsoft's [Enterprise Mobility + Security (EMS) suite](https://www.microsoft.com/microsoft-365/enterprise-mobility-security). 

In the following diagram, you can see how Intune interacts with other components in both your on-premises and cloud infrastructure:

![Diagram of Intune infrastructure](../media/intro-to-endpoint-manager-02.png)

## Microsoft Endpoint Configuration Manager

Configuration Manager is the leading PC management solution on the market. You use it to manage desktops, servers, and laptops that are on your network or are internet-based. If you use Configuration Manager, you should attach your Configuration Manager deployment to the Microsoft 365 cloud, which will provide integration with Intune, Azure AD, Microsoft Defender ATP, and other cloud services. Use Configuration Manager to deploy apps, software updates, and operating systems, as well as configure sites and clients, and run and monitor management tasks. Configuration Manager supports Windows and Mac OS versions. The devices you manage with Configuration Manager can run in virtual environments. This includes Hyper-V on Windows servers as well as Virtual Machines (VM) in Azure. If you run a server as an Azure based VM, you can install the Configuration Manager client on that device.

![Diagram of Configuration Manager infrastructure](../media/intro-to-endpoint-manager-03.png)

### Cloud Attach

There are two steps to cloud attach your on-premises devices. The first step of attachment is called **tenant attach**, which is registering your Intune tenant with your Configuration Manager deployment. The second step is called **co-management**, which is concurrently managing Windows 10 devices with both Configuration Manager and Microsoft Intune. These are incremental steps on the journey to having full cloud attachment. You get immediate value through tenant attach and you get additional value through co-management.

#### Tenant attach

Tenant attach allows you to recognize your Configuration Manager devices and infrastructure by the Intune cloud service and take actions from Microsoft Endpoint Manager. Once you connect Configuration Manager you gain instant cloud value. Configuration Manager uses the Configuration Manager connector to enable data flow to Microsoft Endpoint Manager. It requires a connection to an Intune tenant, and doesn't require turning on co-management.

#### Co-management

Co-management is where you concurrently manage Windows 10 devices with both Configuration Manager and Microsoft Intune. It combines your existing on-premises Configuration Manager and Active Directory investment with the cloud by using Intune, Azure AD, and other Microsoft 365 cloud services. You choose whether Configuration Manager or Intune is the management authority. You keep some tasks on-premises, while running other tasks in the cloud with Intune.

There are two main paths to reach co-management:  
- **Existing Configuration Manager clients**: You have Windows 10 devices that are already Configuration Manager clients. You set up hybrid Azure AD, and enroll them into Intune.  
- **New internet-based devices**: You have new Windows 10 devices that join Azure AD and automatically enroll to Intune. You install the Configuration Manager client to reach a co-management state.  

When you enroll existing Configuration Manager clients in co-management, you gain the following immediate value:  
- Conditional access with device compliance  
- Intune-based remote actions, such as restart, remote control, or factory reset
- Centralized visibility of device health  
- Link users, devices, and apps with Azure Active Directory (Azure AD)  
- Modern provisioning with Windows Autopilot  

In the following diagram, you can see how Windows 10 devices can be manged with both Configuration Manager and Microsoft Intune:

![Diagram of cloud and on-premises infrastructure](../media/intro-to-endpoint-manager-09.png)

## Desktop Analytics

Desktop Analytics is a cloud-based service that integrates with Configuration Manager to help you update devices. It provides insight and intelligence for you to make more informed decisions about the update readiness of your Windows clients. The service combines data from your organization with data aggregated from millions of devices connected to the Microsoft cloud. It provides information on apps, and devices in your organization, identifies compatibility issues with apps and drivers, suggest mitigations based on cloud enabled data insights, and create pilots that represent the entire application and driver state across a minimal set of devices.

## Endpoint Analytics
Endpoint analytics aims to improve user productivity and reduce IT support costs by providing insights into how your organization is working and the quality of the experience you're delivering to your end users. Endpoint Analytics can help identify configuration or hardware issues that may be slowing down devices, provide recommended actions to remediate them and proactively make changes without disrupting end users or generating a help desk ticket.

## Windows Autopilot

Windows Autopilot simplifies enrolling devices in Intune. You provide the enrollment details up front before the end user receives a new computer. The Windows Autopilot process runs immediately after powering on a new computer for the first time, enabling employees to configure new devices to be business-ready with just a few clicks. You can also use Windows Autopilot to reset, repurpose, and recover devices. Leveraging cloud-based services, you can automatically join devices to Azure AD, auto-enroll devices into MDM services, such as Microsoft Intune, restrict rights on the computer, auto-assign devices to configuration groups, and customize the Out-of-box-experience (OOBE) content to be specific for your organization.
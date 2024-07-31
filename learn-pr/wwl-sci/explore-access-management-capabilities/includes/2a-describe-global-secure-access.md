
Microsoft Entra now provides a new set of products under the heading of Microsoft Global Secure Access. Global Secure Access is the unifying term used for both Microsoft Entra Internet Access and Microsoft Entra Private Access. 

Microsoft Entra Internet Access secures access to Software as a Service (SaaS) applications, including Microsoft Services, and public internet apps while protecting users, devices, and data against internet threats.

Microsoft Entra Private Access provides your users, whether in an office or working remotely, secure access to your private, corporate resources.

Microsoft Entra Internet Access and Microsoft Entra Private Access come together as a solution that converges Zero Trust network, identity, and endpoint access controls so that you can secure access to any app or resource, from any location, device, or identity. This type of solution represents a new network security category called Security Service Edge (SSE).

Microsoft's Security Service Edge solution, Global Secure Access, provides advanced protections for your internet-based resources and resources running in your private cloud or on-premises infrastructure.

The solution employs a Global Secure Access client that gives organizations control over network traffic at the end-user computing device. Organizations gain the ability to route specific traffic profiles through Microsoft Entra Internet Access and Microsoft Entra Private Access. Routing traffic in this method allows for more controls enabled by deep integration with conditional access policies and risks assessed in real time, across identity, device, location, and applications to protect any app or resource.

:::image type="content" source="../media/global-secure-access-v3.png" alt-text="Image showing components that make up Global Secure Access.":::

### Microsoft Entra Private Access

VPN solutions are often used as a primary method to control corporate network access. Once private network connectivity is established, the front door to your network is unlocked and on top of that, it's common for users and devices to be over-permissioned. This significantly increases your organization's attack surface.

Microsoft Entra Private Access can be deployed to block lateral attack movement, reduce excessive access, and replace legacy VPNs. The service provides your users - whether in an office or working remotely - secured access to your private, corporate resources.

Conceptually, the way Private Access works is that for a given set of private resources you want to secure, you set up a new enterprise application that serves as a container for those private resources. The new application has a network connector that serves as a broker between the Private Access service and the resource a user wants to access. Now clearly, enterprises have different requirements for accessing different private resources, so Microsoft Entra Private Access provides two ways in which you can set up the private resources you want to have accessed through the service.

- Quick Access - As previously described, Private Access works by creating a new enterprise application that serves as a container for the private resources you want to secure. With Quick Access, you determine which private resources to add to the "container" or enterprise application; which, we'll call the Quick Access application. The private resources you add to the Quick Access Application are defined by the FQDN, IP address, IP or address range, and ports used to access the resource. This information is referred to as a Quick Access application segment. You can add many application segments to the Quick Access application. You can then link conditional access policies to the Quick Access application.

    :::image type="content" source="../media/quick-access-diagram.png" lightbox="../media/quick-access-diagram.png" alt-text="Diagram of Microsoft Entra Private Access with showing the components of Quick Access.":::

- Global Secure Access app - Global Secure Access app, also referred to as Per-app Access, provides a more granular approach. With Global Secure Access app, you can create multiple "containers" or enterprise application. For each of these new enterprise apps, you define the properties of the private resource, and you assign users and groups and assign specific conditional access policies. For example, you may have a group of private resources you need to secure, but for which you want to set different access policies  based on how they're accessing the resource or for a specific time frame.

    :::image type="content" source="../media/per-app-access-diagram.png" lightbox="../media/per-app-access-diagram.png" alt-text="Diagram of Microsoft Entra Private Access with showing the components of Global Secure Access app, also referred to as Per-app Access.":::

### Microsoft Entra Internet Access

A Secure Web Gateway (SWG) is a cybersecurity solution that protects users from web-based threats by filtering internet traffic and enforcing security policies.

Microsoft Entra Internet Access provides an identity-centric Secure Web Gateway (SWG) solution for Software as a Service (SaaS) applications, including Microsoft Services, and other Internet traffic. It protects users, devices, and data from the Internet's wide threat landscape with best-in-class security controls and visibility through Traffic Logs.

Some of the key features include:

- Protection against user identity or token theft by using Conditional Access policies to perform a compliant network check for access to resources.  
    - Compliant network enforcement happens at authentication plane and at the data plane. Authentication plane enforcement is performed by Microsoft Entra ID at the time of user authentication. Data plane enforcement works with services that support Continuous Access Evaluation (CAE)
    - Continuous Access Evaluation (CAE) is a security feature where apps and Microsoft Entra constantly communicate to ensure user access is up-to-date and secure. If something changes, like a user’s location or a security concern arises, the system can quickly adjust or block access in near real-time, ensuring policies are always enforced.
- Tenant restrictions to prevent data exfiltration to other tenants or personal accounts including anonymous access.
- Internet Access traffic forwarding profile policies to control which internet sites can be accessed to ensure remote workers connect to the internet in a controlled and secure way.
- Web content filtering to regulate access to websites based on their content categories and domain names.
- and many more...

### Global Secure Access Dashboard

Global Secure Access includes a dashboard that provides you with visualizations of the network traffic acquired by the Microsoft Entra Private and Microsoft Entra Internet Access services. The dashboard compiles the data from your network configurations, including devices, users, and tenants into several widgets. Those widgets, in turn, provide you with information you can use to monitor and improve your network configurations. Some of the available widgets include:

- Global Secure Access snapshot
- Alerts and notifications (preview)
- Usage profiling (preview)
- Cross-tenant access
- Web category filtering
- Device status

***Global Secure Access snapshot***

The Global Secure Access snapshot widget provides a summary of how many users and devices are using the service and how many applications were secured through the service. The widget defaults to showing all types of traffic, but you can change the filter to show Internet Access, Private Access, or Microsoft traffic.

:::image type="content" source="../media/global-secure-access-snapshot-widget.png" lightbox="../media/global-secure-access-snapshot-widget.png" alt-text="Screenshot of the Global Secure Access snapshot widget.":::

***Usage profiling (preview)***

The Usage profiling widget displays usage patterns for Internet Access, Private Access, or Microsoft 365  over a selected period of time and by category.

:::image type="content" source="../media/dashboard-usage-profiling.png" lightbox="../media/dashboard-usage-profiling.png" alt-text="Screenshot of the usage profiling widget.":::

***Alerts and notifications (preview)***

The Alerts and notifications widget shows what is happening in the network and helps identify suspicious activities or trends identified by the network data.

This widget provides the following alerts:

- Unhealthy remote network: An unhealthy remote network has one or more device links disconnected.
- Increased external tenants activity: The number of users accessing external tenants has increased.
- Token and device inconsistency: The original token is used on a different device.
- Web content blocked: Access to the website has been blocked.

:::image type="content" source="../media/dashboard-alerts-notifications.png" lightbox="../media/dashboard-alerts-notifications.png" alt-text="Screenshot of the dashboard alerts notifications widget.":::

***Cross-tenant access***
Global Secure Access provides visibility into the number of users and devices that are accessing other tenants. This widget displays the following information:

- Sign-ins: The number of sign-ins through Microsoft Entra ID to Microsoft services in the last 24 hours. This widget provides you with information about the activity in your tenant.
- Total distinct tenants: The number of distinct tenant IDs seen in the last 24 hours.
- Unseen tenants: The number of distinct tenant IDs that were seen in the last 24 hours, but not in the previous seven days.
- Users: The number of distinct user sign-ins to other tenants in the last 24 hours.
- Devices: The number of distinct devices that signed in to other tenants in the last 24 hours.

:::image type="content" source="../media/cross-tenant-access.png" lightbox="../media/cross-tenant-access.png" alt-text="Screenshot of the cross tenant access widget.":::

***Web category filtering***

The Web category filtering widget displays the top categories of web content that were blocked or allowed by the service. These categories can be used to determine what sites or categories of sites you might want to block.

***Device status***
The Device status widgets display the active and inactive devices that you have deployed.

:::image type="content" source="../media/device-status.png" lightbox="../media/device-status.png" alt-text="Screenshot of the device status widget.":::


For many organizations, Configuration Manager has been at the center of their deployment strategy. Configuration Manager capabilities provide a one-stop shop not only for OS deployments but also application management and device health.

Starting in version 1910, Configuration Manager is now part of Microsoft Endpoint Manager. Microsoft Endpoint Manager is a suite of tools that work together to unlock many of the scenarios and challenges that enterprises face in today’s world. These tools bring about a modern mindset and approach to situations that have always existed or ones that are ever evolving, such as working from home and remote management.

This unit examines how you can use Configuration Manager to support a Windows deployment. It also explores how Configuration Manager, along with co-management, helps to build the foundation on your journey towards modern management.

The following Microsoft management solutions are all now part of Microsoft Endpoint Manager:

 -  Configuration Manager
 -  Microsoft Intune
 -  Endpoint Analytics
 -  Windows Autopilot
 -  Other features in the Device Management Admin console

### The role of Configuration Manager in a modern desktop journey

Configuration Manager has traditionally served as an on-premises management solution, primarily focusing on the management of desktops, servers, and laptops within your network. This includes devices accessible through a DMZ if needed. However, with the emergence of modern management tools like Intune and Autopilot, along with continuous innovations to Configuration Manager itself, the product has evolved to bridge the gap between traditional and contemporary management approaches.

By integrating Azure Active Directory, the Microsoft Defender security stack, and the Endpoint Manager admin console, Configuration Manager now provides a unified and comprehensive management experience. This single pane of glass functionality has never been more relevant than it's today. While retaining its existing capabilities, such as application deployment, software updates, and device management, Configuration Manager gains added value when combined with Intune and co-management. This combination offers the flexibility to align the most suitable tool with the specific scenario at hand, enabling a truly modern and agile approach to management.

> [!TIP]
> While it is not the sole responsibility of a modern desktop admin, be mindful of Configuration Manager's support cadence, known as Current Branch. Innovation and changes come much more frequently in today's world, and a Desktop Administrator should be mindful of this to take advantage of these innovations for the delivery of a modern desktop.

### The foundations of MDT

Traditionally, Configuration Manager admins have used both Configuration Manager for management and control, and the Microsoft Desktop Toolkit (MDT) for the extra value and flexibility that it brings. Prior to Current Branch (CB), some options and methods were more readily available in MDT than they were in Configuration Manager, including:

 -  Some of the key benefits of combining the tools include:
 -  Access to a wider expanse of task sequence variables with which to utilize during OS deployment.
 -  MDT Rules engine offers a raft of in-built options to aid OS deployment.
 -  The ability to install Windows features without the knowledge of code.
 -  Log file collection out of a template task sequence wizard.

With the advancements of Windows and Configuration Manager, along with the support of PowerShell integration, many of the previously innovative options of MDT can now be done in a different way. Many admins have chosen to use these new advancements in place of where MDT was once used.

As mentioned previously, when planning and strategizing your OS needs, the scenario and deployment methods you use should dictate the toolset you select rather than using them simply because they were always used. An array of tools exists across MDT and Configuration Manager, and these decisions will help you plan, which is the most appropriate to use. When deciding whether to combine MDT and Configuration Manager, it's important to consider an organization's specific needs. This will help determine whether using one tool or both is the best choice for the Desktop admin.

### Configuration Manager overview

Configuration Manager offers a raft of capabilities, most of which fit into a deployment strategy in some shape or form. Many enterprises use Configuration Manager for its 'Single Pane of Glass' methodology to maintain devices, whether this is the delivery of the OS and applications, or the servicing and management of the device. The 'Single Pane of Glass' methodology brings disparate systems together into one system.

With the use of co-management for the modern transition and the Endpoint Manager console, the ever-evolving sync between the two has made the investment in Configuration Manager even more valuable. Some of the key elements that Configuration Manager Current Branch offers (as of CB2010) include:

 -  OS Deployment
 -  Application Management
 -  Update Management
 -  Servicing Management
 -  Device Inventory (CMDB)
 -  Basic License Tracking
 -  Self-Service Software Catalog
 -  Cloud Management capability
 -  Real-Time query and reporting
 -  Enterprise Scalability
 -  Azure AD Integration
 -  Proactive cadence adoption through Desktop Analytics
 -  Remote Control
 -  User Settings Capture and Restore

The introduction of a Cloud Management Gateway (CMG) has become crucial to enabling enterprises to service their clients with the recent surge in remote working, meaning this is one of the most heavily utilized modern features within the platform.

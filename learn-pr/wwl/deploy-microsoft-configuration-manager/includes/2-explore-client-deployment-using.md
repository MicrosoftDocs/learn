
For many organizations, Configuration Manager has been at the center of their deployment strategy. Configuration Manager capabilities provide a one-stop shop not only for OS deployments but also application management and device health.

Starting in version 1910, Configuration Manager is now part of Microsoft Endpoint Manager. Microsoft Endpoint Manager is a suite of tools that work together to unlock many of the scenarios and challenges that enterprises face in today’s world. These tools bring about a modern mindset and approach to situations that have always existed or ones that are ever evolving, such as working from home and remote management.

This unit examines how you can use Configuration Manager to support a Windows deployment. It also explores how Configuration Manager, along with co-management, helps to build the foundation on your journey towards modern management.

The following Microsoft management solutions are all now part of Microsoft Endpoint Manager:

 -  Configuration Manager
 -  Microsoft Intune
 -  Desktop Analytics
 -  Windows Autopilot
 -  Other features in the Device Management Admin console

### The role of Configuration Manager in a modern desktop journey

Configuration Manager has traditionally been an on-premises management solution to manage desktops, servers, and laptops that are on your network or internet-based through a DMZ. With the advancement of modern management tools, such as Intune and Autopilot, along with the constant innovative changes to Configuration Manager, the product can now effectively act as a bridge between how things were done, and how things can be done in a more modern and agile way. With the integration of Azure Active Directory, the Microsoft Defender security stack, and the Endpoint Manager admin console, Configuration Manager acts as a single pane of glass has never been more relevant than it's today. All the existing capabilities, such as application deployment, software updates, and device management, can still be utilized but when combined with Intune and co-management, you now have the flexibility to truly align the right tool with the scenario you're facing.

> [!TIP]
> While it is not the sole responsibility of a modern desktop admin, be mindful of Configuration Manager's support cadence, known as Current Branch. Innovation and changes come much more frequently in today's world, and a Desktop Administrator should be mindful of this to take advantage of these innovations for the delivery of a modern desktop.

### The foundations of MDT

Traditionally, Configuration Manager admins have used both Configuration Manager for management and control, and the Microsoft Desktop Toolkit (MDT) for the additional value and flexibility that it brings. Prior to Current Branch (CB), some options and methods were more readily available in MDT than they were in Configuration Manager, including:

 -  Some of the key benefits of combining the tools include:
 -  Access to a wider expanse of task sequence variables with which to utilize during OS deployment.
 -  MDT Rules engine offers a raft of in-built options to aid OS deployment.
 -  The ability to install Windows features without the knowledge of code.
 -  Log file collection out of a template task sequence wizard.

With the advancements of Windows and Configuration Manager, along with the support of PowerShell integration, many of the previously innovative options of MDT can now be done in a different way. Many admins have chosen to use these new advancements in place of where MDT was once used.

As mentioned previously, when planning and strategizing your OS needs, the scenario and deployment methods you use should dictate the toolset you select rather than using them simply because they were always used. An array of tools exists across MDT and Configuration Manager, and these decisions will help you plan, which is the most appropriate to use. Because both MDT and Configuration Manager share similarities, the needs of an organization will help to outline whether a combination of the two, or one specific tool, is the best choice for the Desktop admin.

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

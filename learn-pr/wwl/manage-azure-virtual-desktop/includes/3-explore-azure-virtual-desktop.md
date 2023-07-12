

Azure Virtual Desktop is a cloud-based service for desktop and application virtualization. It operates within the cloud infrastructure, offering users secure and remote access to their desktop environments and applications from various devices and locations.

With Azure Virtual Desktop running on Azure, you can:

1. Establish a multi-session Windows 11 or Windows 10 environment that offers a comprehensive Windows experience with scalability.
1. Deploy Microsoft 365 Apps for enterprise and optimize them for multi-user virtual scenarios.
1. Migrate your existing Remote Desktop Services (RDS) and Windows Server desktops and applications to any device.
1. Virtualize both desktop environments and individual applications.
1. Administer desktops and applications across various Windows and Windows Server operating systems through a unified management platform.

### Key Capabilities
With Azure Virtual Desktop, establish a scalable and flexible environment:

 - Create a comprehensive desktop virtualization environment within your Azure subscription, eliminating the need for gateway servers.
 - Publish host pools as needed to support diverse workloads.
 - Use your own image for production workloads or test from the Azure Gallery.
 - Save on costs with pooled, multi-session resources. The Windows  - and Windows  - Enterprise multi-session capabilities, exclusive to Azure Virtual Desktop and the Remote Desktop Session Host (RDSH) role on Windows Server, allow for a significant reduction in virtual machines and operating system overhead while maintaining resource availability for users.
 - Offer individual ownership with personal (persistent) desktops.
 - Implement autoscale to automatically adjust capacity based on time of day, specific weekdays, or fluctuating demand, aiding in cost management.

## To deploy and manage virtual desktops:

 - Use the Azure portal, Azure CLI, PowerShell, and REST API to configure host pools, create app groups, assign users, and publish resources.
 - Publish full desktops or individual remote apps from a single host pool, establish separate app groups for distinct user sets, or assign users to multiple app groups to minimize the number of images.
 - Utilize built-in delegated access for role assignment and diagnostic collection to better understand configuration or user errors as you manage your environment.
 - Employ the new Diagnostics service for error troubleshooting.
 - Manage only the image and virtual machines, not the infrastructure. There's no need for personal management of Remote Desktop roles, as with Remote Desktop Services, just the virtual machines in your Azure subscription.

## Assign and connect users to virtual desktops:

 - Once assigned, users can use any Azure Virtual Desktop client to access their published Windows desktops and applications. Connect from any device via a native application on your device or the Azure Virtual Desktop HTML5 web client.
 - Securely connect users through reverse connections to the service, eliminating the need to open inbound ports.
Azure Virtual Desktop is a desktop and application virtualization service that runs in the Azure cloud. Azure Virtual Desktop works across devices (Windows, Mac, iOS, Android, and Linux) with apps that you can use to access remote desktops and apps.

:::image type="content" source="../media/all-data-f2ce8092.png" alt-text="Diagram of data and OS.":::


You can also use most modern browsers to access Azure Virtual Desktop-hosted experiences.

This module helps Desktop Infrastructure Architects, Cloud Architects, Desktop Administrators, or System Administrators explore Azure Virtual Desktop and build virtualized desktop infrastructure (VDI) solutions at enterprise scale. Enterprise-scale solutions generally cover 1,000 virtual desktops and above.

Most demand for enterprise virtual desktop solutions comes from:

 -  Security and regulation applications like financial services, healthcare, and government.
 -  Elastic workforce needs like remote work, mergers and acquisition, short-term employees, contractors, and partner access.
 -  Specific employees like bring your own device (BYOD) and mobile users, call centers, and branch workers.
 -  Specialized workloads like design and engineering, legacy apps, and software development test.

## Architecture

:::image type="content" source="../media/azure-virtual-desktop-architecture-f63f16d7.png" alt-text="Diagram of an Azure Virtual Desktop service architecture.":::


The diagram above shows a typical architectural setup for Azure Virtual Desktop.

 -  The application endpoints are in the customer's on-premises network. ExpressRoute extends the on-premises network into the Azure cloud, and Microsoft Entra Connect integrates the customer's Active Directory Domain Services (AD DS) with Microsoft Entra ID.
 -  The Azure Virtual Desktop control plane handles Web Access, Gateway, Broker, Diagnostics, and extensibility components like REST APIs.
 -  The customer manages AD DS and Microsoft Entra ID, Azure subscriptions, virtual networks, Azure Files or Azure NetApp Files, and the Azure Virtual Desktop host pools and workspaces.
 -  To increase capacity, the customer uses two Azure subscriptions in a hub-spoke architecture, and connects them via virtual network peering.

Azure Virtual Desktop service architecture is similar to Windows Server Remote Desktop Services. Microsoft manages the infrastructure and brokering components, while enterprise customers manage their own desktop host virtual machines (VMs), data, and clients.

:::image type="content" source="../media/you-manage-virtual-desktop-80254b3b.png" alt-text="Diagram that shows how Microsoft manages the infrastructure and brokering components.":::


## Components Microsoft manages

Microsoft manages the following Azure Virtual Desktop services as part of Azure:

 -  **Web Access**: The Web Access service within Window Virtual Desktop lets users access virtual desktops and remote apps through an HTML5-compatible web browser as they would with a local PC, from anywhere on any device. You can secure Web Access using multifactor authentication in Azure Active Directory.
 -  **Gateway**: The Remote Connection Gateway service connects remote users to Azure Virtual Desktop apps and desktops from any internet-connected device that can run an Azure Virtual Desktop client. The client connects to a gateway, which then orchestrates a connection from a VM back to the same gateway.
 -  **Connection Broker**: The Connection Broker service manages user connections to virtual desktops and remote apps. The Connection Broker provides load balancing and reconnection to existing sessions.
 -  **Diagnostics**: Remote Desktop Diagnostics is an event-based aggregator that marks each user or administrator action on the Azure Virtual Desktop deployment as a success or failure. Administrators can query the event aggregation to identify failing components.
 -  **Extensibility components**: Azure Virtual Desktop includes several extensibility components. You can manage Azure Virtual Desktop using Windows PowerShell or with the provided REST APIs, which also enable support from third-party tools.

## Components you manage

Customers manage these components of Azure Virtual Desktop solutions:

 -  **Azure Virtual Network**: Azure Virtual Network lets Azure resources like VMs communicate privately with each other and with the internet. By connecting Azure Virtual Desktop host pools to an Active Directory domain, you can define network topology to access virtual desktops and virtual apps from the intranet or internet, based on organizational policy. You can connect an Azure Virtual Desktop to an on-premises network using a virtual private network (VPN), or use Azure ExpressRoute to extend the on-premises network into the Azure cloud over a private connection.

:::image type="content" source="../media/virtual-network-connection-10929655.png" alt-text="Diagram of a VNET connection from datacenter to Azure.":::


 -  **Azure AD**: Azure Virtual Desktop uses Azure AD for identity and access management. Azure AD integration applies Azure AD security features like conditional access, multifactor authentication, and the Intelligent Security Graph, and helps maintain app compatibility in domain-joined VMs.
 -  **AD DS**: Azure Virtual Desktop VMs must domain-join an AD DS service. You can use Azure AD Connect to associate AD DS with Azure AD.
 -  **Azure Virtual Desktop session hosts**: A host pool can run the following operating systems:
     -  Windows 10 Enterprise and Windows 11 Enterprise
     -  Windows 10 Enterprise Multi-session
     -  Windows Server 2012 R2 and above
     -  Custom Windows system images with pre-loaded apps, group policies, or other customizations

You can choose VM sizes, including GPU-enabled VMs. Each session host has an Azure Virtual Desktop host agent, which registers the VM as part of the Azure Virtual Desktop workspace or tenant. Each host pool can have one or more app groups, which are collections of remote applications or desktop sessions that users can access.

 -  **Azure Virtual Desktop workspace**: The Azure Virtual Desktop workspace or tenant is a management construct to manage and publish host pool resources.

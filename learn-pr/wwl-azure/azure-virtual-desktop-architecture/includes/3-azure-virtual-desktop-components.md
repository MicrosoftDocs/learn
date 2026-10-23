Azure Virtual Desktop service architecture is similar to Windows Server Remote Desktop Services. Microsoft manages the infrastructure and brokering components, while enterprise customers manage their own desktop host virtual machines (VMs), data, and clients.

:::image type="content" source="../media/you-manage-virtual-desktop-80254b3b.png" alt-text="Diagram that shows how Microsoft manages the infrastructure and brokering components.":::


## Components Microsoft manages

Microsoft manages the following Azure Virtual Desktop services as part of Azure:

 -  **Web Access**: The Web Access service within Window Virtual Desktop lets users access virtual desktops and remote apps through an HTML5-compatible web browser as they would with a local PC, from anywhere on any device. You can secure Web Access using multifactor authentication in Microsoft Entra ID.
 -  **Gateway**: The Remote Connection Gateway service connects remote users to Azure Virtual Desktop apps and desktops from any internet-connected device that can run an Azure Virtual Desktop client. The client connects to a gateway, which then orchestrates a connection from a VM back to the same gateway.
 -  **Connection Broker**: The Connection Broker service manages user connections to virtual desktops and remote apps. The Connection Broker provides load balancing and reconnection to existing sessions.
 -  **Diagnostics**: Remote Desktop Diagnostics is an event-based aggregator that marks each user or administrator action on the Azure Virtual Desktop deployment as a success or failure. Administrators can query the event aggregation to identify failing components.
 -  **Extensibility components**: Azure Virtual Desktop includes several extensibility components. You can manage Azure Virtual Desktop using Windows PowerShell or with the provided REST APIs, which also enable support from third-party tools.

## Components you manage

Customers manage these components of Azure Virtual Desktop solutions:

 -  **Azure Virtual Network**: Azure Virtual Network lets Azure resources like VMs communicate privately with each other and with the internet. Plan network connectivity for the session hosts' identity configuration and the resources users need to access. AD DS domain-joined session hosts need connectivity to their domain controllers, but domain-controller connectivity isn't required simply to deploy Microsoft Entra joined session hosts. When your deployment needs access to an on-premises network, use a virtual private network (VPN) or Azure ExpressRoute as appropriate.

:::image type="content" source="../media/virtual-network-connection-10929655.png" alt-text="Diagram of a VNET connection from datacenter to Azure.":::


 -  **Microsoft Entra ID**: Azure Virtual Desktop uses Microsoft Entra ID for identity and access management. Microsoft Entra integration applies Microsoft Entra security features like conditional access, multifactor authentication, and the Intelligent Security Graph, and helps maintain app compatibility in domain-joined VMs.
 -  **Session host join options**: Join session hosts to the same Microsoft Entra tenant as your users, or to an Active Directory domain provided by AD DS or Microsoft Entra Domain Services. AD DS is one supported option, not a requirement for every deployment. Keep session hosts in a host pool on the same join type. For a hybrid-identity deployment using AD DS, Microsoft Entra Connect can synchronize on-premises identities to Microsoft Entra ID. See [Microsoft Entra joined session hosts](/azure/virtual-desktop/azure-ad-joined-session-hosts) for the requirements and considerations for that join option.
 -  **Azure Virtual Desktop session hosts**: Supported 64-bit operating system editions include:
     -  Windows 11 Enterprise and Windows 11 Enterprise multi-session
     -  Windows 10 Enterprise and Windows 10 Enterprise multi-session
     -  Windows Server 2025, Windows Server 2022, Windows Server 2019, and Windows Server 2016

Support depends on the specific operating system release's lifecycle and the applicable licensing requirements. Verify the current [Azure Virtual Desktop prerequisites](/azure/virtual-desktop/prerequisites#operating-systems-and-licenses) before selecting an image.

Custom images can include preinstalled applications and other customizations, but must use a supported session host operating system. Customizing an image doesn't remove operating system support, licensing, or identity requirements.

You can choose VM sizes, including GPU-enabled VMs. Each session host has an Azure Virtual Desktop host agent, which registers the VM as part of the Azure Virtual Desktop workspace or tenant. Each host pool can have one or more app groups, which are collections of remote applications or desktop sessions that users can access.

 -  **Azure Virtual Desktop workspace**: The Azure Virtual Desktop workspace or tenant is a management construct to manage and publish host pool resources.

# Module design

## Title

  Protect your Azure Virtual Network resources by using Azure Firewall

## Role(s)

- *Administrator*

## Level

- *Beginner*  

## Product(s)

- *Azure Firewall*

## Prerequisites

- *Knowledge of basic networking concepts like virtual networks, subnets, and IP addressing*
- *Familiarity with networking security fundamental concepts like network security groups, firewall, service endpoints*

## Summary

*Add the summary [(Guidance)](id-guidance-introductory-summaries.md)*

## Learning objectives

1. Deploy and configure Azure Firewall to protect outbound network traffic for Windows Virtual Desktop

## Chunk your content into subtasks

Identify the subtasks of *module title*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| TODO | TODO | TODO | TODO | TODO |
| TODO | TODO | TODO | TODO | TODO |
| TODO | TODO | TODO | TODO | TODO |

## Outline the units

*Add more units as needed for your content*

1. **Introduction**

    Suppose you work at a large accounting firm where you've just deployed Windows Virtual Desktop. Your organization is using Windows Virtual Desktop to provide your workforce access to virtualized desktops and apps including some legacy apps. Because of the sensitive data your organization works with, network security is very important to you. You don't want any unauthorized network traffic in your Windows Virtual Desktop environment. You want to start by limiting outbound network traffic for Windows Virtual Desktop by using Azure Firewall.

1. **Use Azure Firewall to protect Window Virtual Desktop deployments**

    - Briefly: What is Azure Firewall
    - Briefly: What is WVD
    - Why use Azure Firewall with WVD
    - How Azure Firewall is used with WVD
    - Architecture of Azure Firewall + WVD


1. **Exercise- Set up the WVD host pool and register VM host**

    Create WVD host pool

    1. Create resource group.
    1. [Create a Windows Virtual Desktop host pool](https://docs.microsoft.com/azure/virtual-desktop/create-host-pools-powershell#use-your-powershell-client-to-create-a-host-pool) (with PowerShell or UI?).
    1. Create a registration token to authorize a session host to join the host pool.
    1. Copy token to notepad.
    1. Add Azure Active Directory users to the default desktop app group for the host pool? (Do we need this step?)

    Create VM
    1. [Create Windows VM](https://docs.microsoft.com/azure/virtual-machines/windows/quick-create-portal) that'll act as host.

    [Register VM to WVD host pool](https://docs.microsoft.com/azure/virtual-desktop/create-host-pools-powershell#register-the-virtual-machines-to-the-windows-virtual-desktop-host-pool)

    1. Connect to VM
    1. [Install the Remote Desktop Session Host (RDSH) role](https://docs.microsoft.com/azure/virtual-desktop/create-host-pools-powershell#use-your-powershell-client-to-create-a-host-pool)?
    1. Download and install Windows Virtual Desktop Agent.
    1. Enter copied registration token when installing WVD agent.
    1. Download and install Windows Virtual Desktop Agent Bootloader.
    1. Verify VM is associated with WVD (in portal?)

1. **Plan Azure Firewall deployment**

   Planning considerations

   - Overview of general steps to deploy Azure Firewall


1. **Exercise - Deploy Azure Firewall**

   "Deploy Azure Firewall and configure your Windows Virtual Desktop host pool subnet User Defined Route (UDR) to route all traffic via the Azure Firewall. Your default route now points to the firewall."

    **Steps**:

    1. Create subnet for Azure Firewall (AzureFirewallSubnet) on same Vnet as WVD(?) Resource: [Tutorial: Deploy & configure Azure Firewall using the Azure portal | Microsoft Docs](https://docs.microsoft.com/azure/firewall/tutorial-firewall-deploy-portal#set-up-the-network)
    1. [Deploy firewall](https://docs.microsoft.com/azure/firewall/tutorial-firewall-deploy-portal#deploy-the-firewall)
 
1. **Allow outbound network access from the host pool to Windows Virtual Desktop**

    - Overview of steps to route traffic
    - Rules and configurations needed host outbound for WVD
    - Diagram to show the pieces??

1. **Exercise - Route network traffic through Azure Firewall**

 
    1. Configure WVD host pool subnet User Defined Route all traffic via Firewall (default route now points to firewall):
    
        [Create a default route](https://docs.microsoft.com/azure/firewall/tutorial-firewall-deploy-portal#create-a-default-route) - steps here include creating Firewall-route (in route tables) and then from that route associating with the WVD subnet.
    1. Create application rule collection (see [Configure application rule](https://docs.microsoft.com/azure/firewall/tutorial-firewall-deploy-portal#configure-an-application-rule)) & 
        1. add rule to enable Windows VirtualDesktop FQDN tag
		1. Source IP address range is host pool Vnet
		1. Protocol is https
		1. Destination is WindowsVirtualDesktop
    1. Need to explicitily allow in firewall application rules exact FQDNs you need - not all captured in     WindowsVirtualDesktop FQDN. (**Do we need to do this in the exercise or can we just mention in conceptual unit?**)
	   - Allow https access from host pool subnet to specific URLs (in article).
	   - Use log analytics query to get exact ones.
    1. Create network rule collection with specific rules (see last main bullet in [Host pool outbound access..](https://docs.microsoft.com/azure/firewall/protect-windows-virtual-desktop#host-pool-outbound-access-to-windows-virtual-desktop) & [Configure network rule](https://docs.microsoft.com/azure/firewall/tutorial-firewall-deploy-portal#configure-an-application-rule)).

1. **Allow outbound network access from the host pool to the Internet**

    - When the list of allowed destinations is well-defined (e.g. Microsoft 365 access). 
    - Use Azure Firewall application and network rules to configure the required access.
    - To filter outbound user Internet traffic using an existing on-premises secure web gateway, configure web browsers or other applications running on the Windows Virtual Desktop host pool with an explicit proxy configuration.

1. **Exercise - Create application rule to allow outbound network traffic**
    
    1. Sign into VM and try to connect to blocked endpoint like google? 
    1. Review firewall network log (?) - specifically which one is this [Azure Firewall logs and metrics](https://docs.microsoft.com/en-us/azure/firewall/logs-and-metrics#diagnostic-logs). Should show ?
    1. Change application rule to allow google?
    1. Review firewall network log.

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

## Notes

## Resources

- https://docs.microsoft.com/azure/firewall/protect-windows-virtual-desktop 
- https://docs.microsoft.com/azure/firewall/overview

Related modules:

- https://docs.microsoft.com/learn/modules/hub-and-spoke-network-architecture/
- https://docs.microsoft.com/learn/modules/intro-to-azure-networking/
- https://docs.microsoft.com/learn/modules/network-fundamentals-2/4-firewalls-network-security
# Module design

## Title

 Protect your Windows Virtual Desktop deployment by using Azure Firewall

## Role(s)

- *Administrator*

## Level

- *Beginner*  

## Product(s)

- *Azure Firewall*
- *Windows Virtual Desktop*

## Prerequisites

- *Knowledge of basic networking concepts like virtual networks, subnets, and IP addressing*
- *Familiarity with networking security fundamental concepts like network security groups, firewall, service endpoints*

## Summary

Deploy Azure Firewall. Configure the subnet for your Windows Virtual Desktop host pool to route all network traffic through Azure Firewall. Allow outbound network access from the host pool to Windows Virtual Desktop by configuring the subnet, an application rule and a network rule collection.

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

    Suppose you work at a large accounting firm where you've just deployed a Windows Virtual Desktop host pool. Your organization is using Windows Virtual Desktop to provide your workforce access to virtualized desktops and apps including some legacy apps. Because of the sensitive data your organization works with and your organization's network security requirements, network security is very important to you. You can't have any unauthorized network traffic in your Windows Virtual Desktop environment. You want to start by limiting outbound network traffic for Windows Virtual Desktop by using Azure Firewall.

1. **Use Azure Firewall to protect Window Virtual Desktop deployments**

    - Briefly: What is Azure Firewall
    - Briefly: What is WVD
    - Why use Azure Firewall with WVD
    - How Azure Firewall is used with WVD
    - Architecture of Azure Firewall + WVD


1. **Exercise- Set up the WVD host pool and register VM host**

    Create WVD host pool

    1. Create resource group.
    1. [Create a Windows Virtual Desktop host pool](/azure/virtual-desktop/create-host-pools-powershell#use-your-powershell-client-to-create-a-host-pool) (with PowerShell or UI?).
    1. Create a registration token to authorize a session host to join the host pool.
    1. Copy token to notepad.

    Create VM
    1. [Create Windows VM](/azure/virtual-machines/windows/quick-create-portal) that'll act as host. Create using Windows 10 image not server - so we don't have to install host role or disable firewall to download agents.

    [Register VM to WVD host pool](/azure/virtual-desktop/create-host-pools-powershell#register-the-virtual-machines-to-the-windows-virtual-desktop-host-pool)

    1. Connect to VM
    1. Download and install Windows Virtual Desktop Agent.
    1. Enter copied registration token when installing WVD agent.
    1. Download and install Windows Virtual Desktop Agent Bootloader.
    1. Verify VM is associated with WVD (in portal?) - should say available in portal

1. **Plan Azure Firewall deployment**

   - Planning considerations - reference content covered in this module that applies to next exercise: [Introduction to Azure Firewall](https://learn.microsoft.com/training/modules/introduction-azure-firewall/3-how-azure-firewall-works)
   - Rule types (overview)
   - Deployment options (overview)
   - Overview of general steps to deploy Azure Firewall and context with WVD. See below.

    The following is from the intro module, should talk about deployment for WVD and how it's related to these steps:
   Use the following general steps to set up an instance of Azure Firewall:

    - Create a hub virtual network that includes a subnet for the firewall deployment. (WVD will be hub Vnet)
    - Create the spoke virtual networks and their subnets and servers. (Don't need this for WVD)
    - Peer the hub and spoke networks. (Don't need this step for WVD)
    - Deploy the firewall to the hub's subnet.
    - For outbound traffic, create a default route that sends traffic from all subnets to the firewall's private IP address. 
    - Configure the firewall with rules to filter inbound and outbound traffic.

    Also: "For production deployments, a hub and spoke model is recommended, where the firewall is in its own VNet. The workload servers are in peered VNets in the same region with one or more subnets." See [Tutorial: Deploy and configure Azure Firewall using the Azure portal](/azure/firewall/tutorial-firewall-deploy-portal).

1. **Exercise - Deploy Azure Firewall**

   "Deploy Azure Firewall and configure your Windows Virtual Desktop host pool subnet User Defined Route (UDR) to route all traffic via the Azure Firewall. Your default route now points to the firewall."

    **Steps**:

    1. Create subnet for Azure Firewall (AzureFirewallSubnet) on same Vnet as WVD(?) Resource: [Tutorial: Deploy and configure Azure Firewall using the Azure portal](/azure/firewall/tutorial-firewall-deploy-portal#set-up-the-network)
    1. [Deploy firewall](/azure/firewall/tutorial-firewall-deploy-portal#deploy-the-firewall)

1. **Allow outbound network access for Windows Virtual Desktop**

    Allow outbound network access from the host pool to Windows Virtual Desktop:

    - Overview of steps to route traffic
    - Specific rules and configurations needed host outbound for WVD
    - Diagram to show the pieces??

   Allow outbound network access from the host pool to the Internet:

    - When the list of allowed destinations is well-defined (e.g. Microsoft 365 access). 
    - Use Azure Firewall application and network rules to configure the required access.
    - To filter outbound user Internet traffic using an existing on-premises secure web gateway, configure web browsers or other applications running on the Windows Virtual Desktop host pool with an explicit proxy configuration.

1. **Exercise - Route network traffic through Azure Firewall**

 
    1. Configure WVD host pool subnet User Defined Route all traffic via Firewall (default route now points to firewall):
    
        [Create a default route](/azure/firewall/tutorial-firewall-deploy-portal#create-a-default-route) - steps here include creating Firewall-route (in route tables) and then from that route associating with the WVD subnet.
    1. Create application rule collection (see [Configure application rule](/azure/firewall/tutorial-firewall-deploy-portal#configure-an-application-rule)) & 
        1. add rule to enable Windows VirtualDesktop FQDN tag
		1. Source IP address range is host pool Vnet
		1. Protocol is https
		1. Destination is WindowsVirtualDesktop
    1. Need to explicitily allow in firewall application rules exact FQDNs you need - not all captured in     WindowsVirtualDesktop FQDN. 
	   - Allow https access from host pool subnet to specific URLs (in article).

    1. Create network rule collection with specific rules (see last main bullet in [Host pool outbound access..](/azure/firewall/protect-windows-virtual-desktop#host-pool-outbound-access-to-windows-virtual-desktop) & [Configure network rule](/azure/firewall/tutorial-firewall-deploy-portal#configure-an-application-rule)).
    1. Verify Firewall is working (use PS query)

    ```powershell
    "rdgateway", "rdbroker","rdweb"|%{Invoke-RestMethod -Method:Get -Uri https://$_.wvd.microsoft.com/api/health}|ft -Property Health,TimeStamp,ClusterUrl
     ```
    If all 3 component services are healthy, the firewall is working, if 1 or more are not healthy, the firewall is not working.

1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module?

## Notes

## Resources

- https://learn.microsoft.com/azure/firewall/protect-windows-virtual-desktop 
- https://learn.microsoft.com/azure/firewall/overview

Related modules:

- [Introduction to Azure Firewall](https://learn.microsoft.com/training/modules/introduction-azure-firewall/3-how-azure-firewall-works)
- https://learn.microsoft.com/training/modules/hub-and-spoke-network-architecture/
- https://learn.microsoft.com/training/modules/intro-to-azure-networking/
- https://learn.microsoft.com/training/modules/network-fundamentals-2/4-firewalls-network-security

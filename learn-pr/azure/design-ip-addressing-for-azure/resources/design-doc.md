# Module Design

## Title

Design an IP addressing scheme for your Azure infrastructure

## Role(s)

- Solution architect

## Level

- Beginner

## Product(s)

- Azure

## Prerequisites

- Knowledge of basic networking concepts (subnets, IP addressing, etc.)
- Familiarity with Azure virtual networking

## Summary

A good Azure IP addressing scheme provides flexibility, room for growth, and integration with on-premises networks. This ensures communication works for deployed resources, minimizes public exposure of systems, and allows the company to have flexibility in their network. If not properly designed, systems may not be able to communicate, and additional work will be required to remediate.

## Learning objectives

- Identify the private IP addressing capabilities of Azure virtual networks
- Identify the public IP addressing capabilities of Azure
- Identify the requirements for IP addressing when integrating with on-premises networks

## Chunk your content into subtasks

Identify the subtasks of *Design an IP addressing scheme for your Azure infrastructure*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ------- | ------------------------------------------------------------ | -------------------------------------------------------- | ------------------------------------------------ | ------------------------------------------------------------ |
| Gather network requirements    | Plan out their IP addressing                                                      | Knowledge check                                                     | 1                                              | Yes                                                         |
| Evaluate requirements for integrating with on-premises networks   | Integrate their existing network with Azure                                                         | Knowledge check                                                     | 3                                            | Yes                                                        |
| Evaluate Azure constraints for public and private IP addresses | Plan public IP addressing and understand how public addressing works                                                         | Knowledge check                                                     | 2                                             | Yes                                                 |
| Design and implement virtual Network | Assign public and private IP addresses                                                        | Exercise                                                     | 1 & 2                                             | Yes   |

## Outline the units

1. **Introduction**

   An organization is beginning a project to move many of their services out of their existing data center and into Azure. They want to ensure that they can integrate their existing network with Azure and properly plan out their IP addressing so they don’t run out of IP addresses and have the capacity for future growth. They also need to properly plan their public IP addressing and understand how public addressing works.

1. **Network IP addressing and integration**

     - Describe a typical on-premises network design (diagrams of the network may be included).
     - Describe a typical Azure network design (diagrams of the network may be included).
     - Describe requirements for IP addressing when integrating with on-premises networks & network integration methods
         - Express Route
         - Peering VPN
         - VPN Gateway
    <!-- added section to discuss network integration methods, in the module, will add how each network integration method impacts the IP addressing  -->

   It is important to identify the current private IP address scheme on the on-premises network, as there can be no overlap for interconnected networks. You can have the same range for multiple VNets, the limitation only comes into play when you try to connect them to other networks. So you can have 10.10.0.0/16 network for the on-premises network and 10.20.0.0/16 for your Azure network.

1. **Public and private IP addressing in Azure**

   Describe the constraints and limitations for public and private addresses, including:

    - Public IP - Public IP addresses are assigned from a pool of addresses in each Azure region. Public IP prefix is currently available in West Central US, West US, West US 2, Central US, North Europe, West Europe, and Southeast Asia. You cannot specify the public IP addresses for the prefix. Azure allocates public IP addresses for the prefix, based on the size that you specify. You cannot change the range, once you have created the prefix. Addresses from the range can only be assigned to Azure Resource Manager resources. Some of the resources you can associate a public IP address with are:
      - Virtual machine network interfaces
      - Internet-facing load balancers
      - VPN gateways
      - Application gateways

   <!-- please see additional notes on static public IP -->

   - Static public IP address allocation - Even when you set the allocation method to static, you cannot specify the actual IP address assigned to the public IP address resource. Azure assigns the IP address from a pool of available IP addresses in the Azure location the resource is created in. Azure allocates public IP addresses from a range unique to each region in each Azure cloud. Public IP addresses are region-specific and cannot be moved between Azure regions. Likewise you cannot bring your own Public IP addresses to Azure. If you are planning to have data centers in different regions, you would have a different public IP address for each region and then use a technology like Azure Traffic Manager to balance between the region-specific instances of a service. Azure services such as SQL or Azure Storage are addressed across regions based on region-specific public IP.

     <!-- removed the link and added the relevant  limits -->
   - Private IP - In Azure Resource Manager, you can have 1,000 Virtual networks & 3,000 subnets per virtual network. 65,536 private IP addresses per virtual network. Each subnet must have a unique address range, specified in CIDR format, within the address space of the virtual network. The address range cannot overlap with other subnets in the virtual network. 

    <!-- please see the new bullet points with basic properties of net, reserved IPs and relevant limits of Vnets -->
   - Basic properties of VNet - Private IP addresses are assigned to each NIC within each VM, using either the static or dynamic method. Private IP addresses are assigned from the range that you specified in the subnet settings of your VNet. The first x.x.x.1-x.x.x.3 IP addresses are reserved in Azure by default for all Vnets. The first and last IP addresses of each subnet are also reserved for protocol conformance. Azure has an internal DHCP service that is responsible for assigning and maintaining lease of IP addresses assigned to every instance within Azure. To put it simply, the .2 and .3 are used by internal Azure services that are not visible or configurable by the customers. A VNet is limited to a single region. You can add, remove, expand, or shrink a subnet if there are no VMs or services deployed within it. In the Azure Resource Manager, a private IP address is associated to the following types of Azure resources.
       - Virtual machine network interfaces
       - Internal load balancers
       - Application gateways

    <!-- please see notes on Re-IPing a network-->
   - Re-IP'ing a network - If you run into a situation where for some reason you have to re-IP your network. Some subnets are fully assigned whilst other subnets have spare unassigned address available. You can reassign subnets in your network if there are no VMs or services deployed within it. If any resources exist in the subnet, you must either move the resources to another subnet, or delete them from the subnet first. The steps you take to move or delete a resource vary depending on the resource. Azure also provides the ability to move entire Vnet to another resource group or subscription. Tools and scripts associated with the resources that are moved will not work until you update the resource with the new resource group/subscription ID.
  
1. **Planning the IP addressing for your networks**

     List the main questions to ask, including:

     - How many devices do you have on the network?
     - How many devices are you planning to add in the future to the network?

     This is so you can plan the right amount of IP address based on the network devices and reserve extra address for future growth. So when your network expands you do not have to redesign IP address scheme.

     - Based on the services running on the infrastructure, what devices do you need to separate?
     - How many subnets do you need to have?
     - How many devices are you going to have per subnet?  
     - How many devices are you planning to add in the future to the subnet?
     - How many subnets are you planning to or you may add in the future?
     - Explain Classless Inter-Domain Routing (CIDR) and how it is used

     Highlight when services running on the infrastructure need to be separated. How to identify the services that require isolation.

     For example, your frontend servers can be accessed by public devices, but the backend servers will need to be isolated. This is where subnets will help to isolate the network and provide additional layer of security.  

   **Knowledge  Check**

    - Identify where public IP addresses are assigned in Azure. Which of the following do you assign a public IP to ...
      - Front-End Server
      - Azure Load Balancer
      - Azure Data Lake
      - Azure Key Vault

    - Identify what's needed when you connect a virtual network to an on-premises network using an Azure VPN Gateway, the virtual network must have a...
       - Dedicated Leased Line
       - Dedicated subnet for the gateway
       - Dedicated Network Security Group
       - Dedicated Azure Load Balancer

    - What does Virtual Machine has to have in order to communicate with other resources in the resource group ?
       - Azure Load Balancer
       - Azure Traffic Manager
       - Network Security Group
       - Network Interface Card

    - Based on your current Network, you need 10 subnets and you are reserving 6 subnets for future expansion. You need 30 Hosts in each subnet. Which of the following CIDR helps you to get the required subnets & hosts?
       - 10.0.0.0/8  
       - 10.10.0.0/16
       - 10.10.10.0/24  
       - 10.10.10.0/28

1. **Exercise - Design and implement IP addressing for Azure virtual networks**

    - Paper exercise - Provide example data for an organization, with information on network devices, services, and infrastructure.

      Design an IP address scheme to meet specific requirements, such as:
      <!--  added 3 vnets and on-premises network to the exercise-->

       - Minimum no of host required per subnet 100.
       - Minimum no of Subnets required for the network 10 (diagrams may be included  of the network to aid in the exercise).
         - You have integrated 3 Vnets from 3 different regions (North Europe, West India, and UK West.)
         - You also have connected your on-premises network into Azure using Azure VPN Gateway

    - Hands-on exercise - Create a vnet and assign an IP address

        Make sure this exercise creates multiple VNets and integrates them as per the prior design exercise above.

      *This exercise is designed for the Azure CLI*

      1. Create the virtual network
      1. Add subnets (frontend and backend)
      1. Create the first VM and assign to Frontend
      1. Create the 2nd VM and assign to Backend
      1. Assign the Frontend VM a Public IP address
      1. Test connectivity to the Frontend VM
      1. Test isolation of Backend VM

1. **Summary**

   How did you solve the problem in the initial scenario with the knowledge learned in the module?
    - Identified the private & public IP addressing capabilities of Azure virtual networks
    - Identified how to integrate with on-premises network with Azure and plan out IP address scheme for your Azure infrastructure.
    - Set up public and private IP address on Virtual Network

**Supporting resources**

VNet planning: https://docs.microsoft.com/azure/virtual-network/virtual-network-vnet-plan-design-arm

Public IP addressing prefix: https://docs.microsoft.com/azure/virtual-network/public-ip-address-prefix
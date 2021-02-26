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

1. Deploy and configure Azure Firewall protect network traffic for Windows Virtual Desktop

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

    Suppose you're an administrator for a Windows Virtual Desktop deployment at a large account firm....

    Azure Firewall can help you lock down your environment and filter outbound traffic.

    ...provide additional protection for your Windows Virtual Desktop host pool using Azure Firewall.

    WVD scenario? Would that apply to other types or resources?

    Provide a scenario of a real-world job-task that shows how the technology is used in practice (from the module proposal):

    *Add your scenario [(Guidance)](id-guidance-scenarios.md)*

1. **Plan Azure Firewall deployment**

   Planning considerations

   - Azure Firewall rules needed; rules needed for WVD
   Overview of general steps to deploy Azure Firewall

1. **Exercise- Set up the network and deploy Azure Firewall**

   Set up initial resources needed:

   1. Create virtual network.
   1. Create VM that'll act as host (https://docs.microsoft.com/azure/firewall/tutorial-firewall-deploy-portal). (WVD pretend set up.)

1. **Use Azure Firewall to protect Window Virtual Desktop deployments**

    - Why use Azure Firewall with WVD
    - How Azure Firewall is used with WVD
    - Architecture of Azure Firewall + WVD
    - Overview of steps to deploy Azure Firewall for WVD 
      - Rules and configurations needed host outbound for WVD and for internet

1. **Exercise - Route network traffic for Windows Virtual Desktop through Azure Firewall**

    List the steps which apply the learning content from previous unit:

    1. Configure WVD host pool subnet User Defined Route all traffic via Firewall (default route now points to firewall)
    1. Create application rule collection & 
        1. add rule to enable Windows VirtualDesktop FQDN tag
		1. Source IP address range is host pool Vnet
		1. Protocol is https
		1. Destination is WindowsVirtualDesktop
    1. Need to explicitily allow in firewall application rules exact FQDNs you need - not all captured in     WindowsVirtualDesktop FQDN. 
	   - Allow https access from host pool subnet to specific URLs (in article).
	   - Use log analytics query to get exact ones.
    1. Create network rule collection with specific rules…(see article).
    1. Test connection.

1. **Knowledge check**

    What types of questions will test *learning objective*?

    - Question type
    - Question type

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
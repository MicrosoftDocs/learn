# Module Design

## Title

Monitor and troubleshoot your end-to-end Azure network infrastructure using network monitoring tools

## Role(s)

- Solution architect

## Level

- Beginner

## Product(s)

- Azure

## Prerequisites

- Basic familiarity with Azure networking concepts (IP addressing, subnetting, routing, network security groups)
- Basic familiarity with Azure network integration concepts (VPN, ExpressRoute, peering)

## Summary

Use Network Watcher tools, diagnostics, and logs to help find and fix networking issues in your Azure infrastructure.

## Learning objectives

1. Identify the tools available to manage and troubleshoot network connectivity in Azure
1. Select the proper tool to manage and troubleshoot network connectivity for various use cases

## Chunk your content into subtasks

Identify the subtasks of Monitor and troubleshoot your end-to-end Azure network infrastructure using network monitoring tools:

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ------- | ------------------------------------------------------------ | -------------------------------------------------------- | ------------------------------------------------ | ------------------------------------------------------------ |
| Identify the purpose of Azure Network Watcher features    | Identifying the right tools for troubleshooting                                                         | Knowledge check                                                     | 1                                             | Yes                                                         |
| Evaluate the Azure Network Watcher features   | How to restore connectivity                                                       | Knowledge check                                                     | 1 & 2                                            | Yes                                                        |
| Determine the cause of the fault     |        Identifying where connectivity is failing                                                   | Knowledge check                                                     | 1                                            | Yes                                                          |
|Enable Network Watcher and utilize its features     |        Basic familiarity with Azure Network Feature                                                  | Exercise                                                     | 1 & 2                                            | Yes                                                          |

## Outline the units

1. **Introduction**

   Companies that use virtual machines (VMs) in Azure may need tools to troubleshoot communication problems.

   You are the Azure architect at for an engineering company. One of your colleagues has deployed a VM in Azure and is having network connectivity issues. You’re the Azure architect for the project, so they have come to you for help. You’ve worked through these issues in the past and would like to help your colleague learn how they can troubleshoot these issues themselves if they come up in the future. You take them through the tools in Azure Network Watcher to help them identify and remediate the issues.

   Engineers can use Azure Network Watcher to monitor, diagnose, and gain insight into their network health and performance with metrics. The features can be broken down into four areas: monitoring, network diagnostic tools, metrics, and logs.

   In this module, you will about the facilities within Network Watcher and use them to diagnose a communication problem between two VMs.

1. **Troubleshoot networking using Network Watcher monitoring and diagnostic tools**

   Focus for this unit to be on Connection Monitor, IP flow verify, Next hop, Packet capture, Connection troubleshoot, Effective security rules, and Effective routes.

   1. Describe the main monitoring tools:

      - Topology - helps to see network level topology overview, various interconnections, and associations between network resources in an Azure Resource Group.
      - Connection Monitor - enables you to configure and track connection reachability, latency, and network topology changes. If there is an issue, it tells you why it occurred and how to fix it.
      - Network Performance Monitor - gives you the ability to track and alert on latency/packet drops over time. It enables you to have a centralized view of your network monitoring requirements. To monitor your hybrid connections using Network Performance Monitor (NPM), ensure that the workspace associated with NPM is in a supported region. NPM can monitor connectivity between networks and applications in any part of the world, from a workspace that is hosted in one of the following regions: West Europe, West Central US, East US, East Japan, South East Asia, South East Australia, South UK, and US Government Virginia.

   1. Describe the main network diagnostic tools:

      - IP flow verify - 5-Tuple packet parameter-based verification mechanism to detect if a packet is allowed or denied
      - Next hop - determine the next hop for packets routed in the azure network topology, primary helping in troubleshooting user-defined routing.
      - Effective security rules - enables you to view network security groups associated with the chosen interface. You can view inbound and outbound rules. This tool is handy when you have to view more than one rule or route.
      - VPN troubleshoot - provides the ability to troubleshoot virtual network gateway and connections
      - Packet capture - allows you to capture incoming and outgoing network traffic packets of a virtual machine. You can also automate remote packet capture with triggers to proactively  capture traffic.  The default limit is 100 Packet capture sessions per region and maximum limit is 10,000. These limits are for the number of sessions only, not saved captures. You can save packets captured in Azure storage or locally on your pc.
      - Connection troubleshoot - provides the capability to check a direct TCP connection from a virtual machine (VM) to a VM, fully qualified domain name (FQDN), URI, or IPv4 address  

   1. Provide four use case scenarios for troubleshooting using Azure Network Watcher monitoring and diagnostics. Use this format:

      - A. What the problem is (Title)
      - B. How to troubleshoot that issue using Network Watcher monitoring and diagnostics tools  (Paragraph)
      - C. An example solution (Paragraph)

      Use case scenarios to include:
         - One of your colleagues has deployed a virtual machine in Azure and is having network connectivity issues
         - VPN connection not working
         - No servers listening on designated destination ports
         - Diagnose network routing problems from a VM

   Knowledge check:

      A. To capture traffic on VM, Azure Network Watcher requires the:

         - Network watcher Agent VM Extension
         - Azure Traffic Manager
         - Azure Load Balance
         - Azure Storage Account  

      B. To resolve latency issues on the network, which Azure Network Watcher features can you use?

         - IP flow verify
         - Next hop
         - VPN Gateway Troubleshooting  
         - Connection troubleshoot


1. **Exercise - Troubleshoot networking using Network Watcher monitoring and diagnostic tools**

    1. Create the virtual network
    1. Add subnets (front-end and back-end)
    1. Create the first VM with Network watcher Agent VM Extension and assign to Frontend
    1. Create the second VM Network watcher Agent VM Extension and assign to Backend
    1. Introduce a configuration mistake that impacts on communication between the VMs.
    1. Enable Network Watcher

       *The steps below are better suited for Azure portal, as the novice user may not be able comprehend the output of PowerShell commands, plus GUI displays some features better than PowerShell*

    1. Check connectivity between two virtual machines in the same resource group over port 80
    1. View Network Topology
    1. Determine the Next Hop
    1. Use Connection Troubleshoot between the two VMs to diagnose the configuration mistake that you introduced earlier.

1. **Troubleshoot networking using Network Watcher metrics and logs**

   The main focus for this unit to be on Flow logs.

   1. Describe the main metrics

      - Usage and quotas - Each Microsoft Azure resource can be used up to its quota. Each subscription has separate quotas and usage is tracked per subscription. Only one instance of Network Watcher is required per subscription per region.

   1. Describe the main logs

      - Flow logs - solution to capture logs related to the network traffic that is allowed or denied by the security rules.
      - Network security group (NSG) flow logs allows you to view information about ingress and egress IP traffic through a network security group. NSG flow logs do not support Storage accounts (classic)
      - Diagnostic logs - logs for Azure networking resources such as network security groups, public IP addresses, load balancers, virtual network gateways, and application gateways.
      - Traffic Analytics - monitors your cloud environment and provides visibility into user and application activity across Azure. Traffic Analytics analyzes NSG Flow logs across Azure regions and subscriptions and equips you with actionable information to optimize network performance.

   1. Provide several use case scenarios for troubleshooting using Azure Network Watcher metrics and logs. Use this format:

      - A. What the problem is (Title)
      - B. How to troubleshoot that issue using Network Watcher metrics and logs (Paragraph)
      - C. An example solution (Paragraph)

      Use case scenarios to include:

        - Customer reports of slow performance
        - Virtual machine firewall rules blocking traffic
        - Frontend and backend subnet unable to communicate

   Knowledge check:

      A. How can you automate remote network monitoring with packet capture?

         - Use Azure Traffic Manager  
         - Use Azure Load Balancer
         - Use IP flow verify
         - Trigger packet capture by setting alerts

      B. Which feature helps to see network level topology overview, various interconnections, and associations between network resources in an Azure Resource Group?

         - Topology
         - Connection troubleshoots
         - Role Based Access Control
         - Network security group View

1. **Exercise - Troubleshoot networking using Network Watcher metrics and logs**

   In this exercise, students configure NSG flow logs for the VMs they created in the previous exercise. They use the flow logs to troubleshoot an incorrect configuration.

   1. Introduce a configuration problem that prevents correct communication between the VMs. This problem should be something that can be diagnosed from a flow log.
   1. Configure a network security group (NSG)
   1. Register the Microsoft.Insights provider
   1. Enable the NSG flow log
   1. Generate network traffic between VMs that will be caught in the flow log.
   1. Download and view the flow log. Diagnose the problem.
   1. Fix the problem.

1. **Summary**

   Azure Network Watcher empowers engineers to *monitor*, *diagnose*, and *gain insight* into their network health and performance with metrics. In this module, we looked at four tool categories and the features offered. Azure Network Watcher provides all the tools needed to monitor, troubleshoot, and optimize your network. For more information check out the Supporting resources.  

Supporting resources

Troubleshoot outbound connections: https://docs.microsoft.com/azure/network-watcher/network-watcher-connectivity-portal

Packet capture: https://docs.microsoft.com/azure/network-watcher/network-watcher-packet-capture-manage-portal

NSG flow logs: https://docs.microsoft.com/azure/network-watcher/network-watcher-nsg-flow-logging-overview 
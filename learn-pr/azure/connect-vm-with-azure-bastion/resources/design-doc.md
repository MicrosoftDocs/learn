# Title
Connect to virtual machines through the Azure portal by using Azure Bastion

## Role(s)

Administrator

## Level

Beginner

## Product(s)

Azure Bastion

## Prerequisites

- Experience managing remote connections to virtual machines
- Familiarity with networking concepts like virtual networks, public and private IPs, and network protocols SSH, RDP, and TLS
 
## Summary

Evaluate Azure Bastion. Deploy Azure Bastion to replace existing jumpbox solution. Monitor remote sessions by using diagnostic logs. Manage remote sessions by disconnecting a user session.

## Learning objectives

1. Describe the features and benefits of Azure Bastion
1. Configure and use Azure Bastion to connect to an Azure Virtual Machine (Or something like "Demonstrate you can securely connect to VM by using the Azure portal and Bastion")
1. Monitor and manage remote sessions  

## Chunk your content into subtasks

Identify the subtasks of *Connect to virtual machines through the Azure portal by using Azure Bastion*

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Evaluate Azure Bastion | Investigate a different way to remotely connect and manage the app VM | Knowledge check | Describe features and benefits | Yes  |
| Create AzureBastionSubnet |Investigate a different way to remotely connect and manage the app VM | Exercise | Configure and use Azure Bastion to connect to an Azure Virtual Machine | No; combine w/ subtask for same objective |
| Deploy Azure Bastion for VNet |Investigate a different way to remotely connect and manage the app VM | Exercise | Configure and use Azure Bastion to connect to an Azure Virtual Machine | No; combine w/ subtask for same objective  |
| Connect to demo app VM |Investigate a different way to remotely connect and manage the app VM | Exercise | Configure and use Azure Bastion to connect to an Azure Virtual Machine | No; combine w/ subtask for same objective |
| Configure network security group rules for additional security | Investigate a different way to remotely connect and manage the app VM | Exercise | Configure and use Azure Bastion to connect to an Azure Virtual Machine | Yes |
| Enable diagnostic settings to get session logs | Investigate a different way to remotely connect and manage the app VM | Exercise | Monitor and manage remote sessions  |No w/ subtask for same objective |
| View sessions | Investigate a different way to remotely connect and manage the app VM | Exercise | Monitor and manage remote sessions  | No combine w/ subtask for same objective  |
| Force disconnect session | Investigate a different way to remotely connect and manage the app VM | Exercise | Monitor and manage remote sessions  | No combine w/ subtask for same objective |

## Outline the units

*Add more units as needed for your content*

1. **Introduction**

   Suppose you're the IT administrator for an internal HR app that's on your organization's internal network. The app runs on an Azure Virtual Machine (VM) that's not publicly exposed. You're using a jumpbox to be able to manage the VM and app remotely. This jumpbox is an Azure VM that has a public IP, which you connect to by using RDP. The jumpbox is on the same Azure Virtual Network as the app VM. So from the jumpbox, you can connect to the app VM that's on the internal network.

   You've locked down network traffic to the jumpbox by using an Azure network security group. The network security group allows RDP but denies all other network traffic.

   Periodically, you maintain the jumpbox by applying updates and security patches. You'd rather use that time for other projects. So you'd like to investigate another way to remotely connect and manage the app VM without having to publicly expose the internal HR app or manage an additional VM.

1. **What is Azure Bastion?**

   Azure Bastion provides a secure remote connection from the Azure portal to Azure virtual machines (VMs) over Transport Layer Security (TLS). Provision Azure Bastion to the same Azure Virtual Network as your VMs. Then connect to any VM on that virtual network directly from the Azure portal. 

   Intro points:
   - RDP/SSH connectivity to all VMs in same VNet
   - Don't need additional client, agent, or software
   - Deployment applies to a virtual network not subscription or VM. (Right now, if a customer manages multiple VNets & they're peered, they'd need a bastion deployment for each VNet. September or October, there will be support for peering. So if customer has multiple VNets but they're peered, then just need one Bastion deployment that applies to that network "group".)

   How it works

   - Diagram that shows the high-level architecture. Reuse: diagram from 
https://docs.microsoft.com/azure/bastion/bastion-overview. Include process steps. Cynthia's version has numbered steps that could be simplified.

   Security points:

   - Doesn't expose RDP or SSH ports or public IP. (Protection against port scanning)
   - Provides a single hardened access point.
   - Can integrate with existing firewalls and your security perimeter using an HTML5 based web client and standard SSL ports.
   - Network traffic stays within the virtual network.
   - Configure network security groups (NSGs) to allow connections only from the Bastion host. (Best practice) Don't need to manage other NSGs.
   - Can monitor and manage remote connections (by enabling diagnostics settings and viewing/managing sessions on Bastion resource)
   
   **Other solutions for Bastion & jumpbox**?

   Support points:

   - Browsers supported
   - Keyboard layout?
   - IPv4 not IPv6
   - Include concurrent session info?
   - Features supported: copy/paste; file copy not supported

   Roles required:

   If user doesn't have access to the resource group, then either they'd need to be granted access to the resource group or the resource itself (bastion). This isn't any different than any other Azure resource.
   
   How to create (high-level overview)

   - Prereqs: address space
   - Create in portal (which will show in first exercise)
   - Create by using Azure PowerShell: show sample commands from https://docs.microsoft.com/azure/bastion/bastion-create-host-powershell
   - CLI: https://docs.microsoft.com/azure/bastion/create-host-cli
   -  What gets created when you deploy (Show this in next unit exercise?)

   **What are the most important takeaways from this unit for the KC?**

   **Knowledge check**

   Add three questions that measure the objective:
   "Describe the features and benefits of Azure Bastion"
   Break that down into what the top 3 takeaways:
   1. What is Bastion/why you'd use it (have 2 wrong statements and one right)
   1. What does deployment apply to (sub, VNet, RG)
   1. Have scenario and have them pick what stuff they'd configure/set up? e.g. Wrong answer: Create a VM for bastion and set up network security group to allow RDP/SSH for bastion (unclear on NSG changed needed): Versus right answer: Set up subnet for bastion, deploy for VM (use default NSGs), update NSG for ??

1. **Exercise – Connect to a virtual machine using the Bastion Service**

    1. Customer runs script that creates existing environment: 
       - Creates jumpbox (Windows) + "app" VM (Ubuntu) that's on a private network. 
       - Jumpbox has public IP.
       - Need address space to use for AzureBastionSubnet as part of set up.
    1. Explain what resources are created with script and have them look at the resource group in the portal (that shows list of resources).
    1. Connect to jumpbox using RDP.
    1. From jumpbox SSH to app VM. Run some commands to demonstrate you're on the app VM.
    1. Exit from the VMs.
    1. Go to the app VM in the Azure portal. 
    1. Create the AzureBastionSubnet and connect to VM.
    1. Connect > Bastion.
    1. Run some commands to demonstrate you're on the app VM.
    1. Look at RG to see bastion resource(s) created.
    1. Go to jumpbox in list.
    1. Shut down and delete the jumpbox.

1. **Secure Azure Bastion with a network security group**

   **Talk about the default - what's gets set up and what best practice changes you should make?** Not clear on what those are - a bit confused by docs.

   "As a best practice, you should have a network security group to restrict what ports and source IP addresses can connect to your Bastion service. This hardens the service and provides another level of security."  (Copied from Cynthia's draft and this is a bit confusing to me. Isn't this the default?)
   
   From overview doc: "Azure Bastion is a fully managed platform PaaS service from Azure that is hardened internally to provide you secure RDP/SSH connectivity. You don't need to apply any NSGs on Azure Bastion subnet. Because Azure Bastion connects to your virtual machines over private IP, you can configure your NSGs to allow RDP/SSH from Azure Bastion only."

   - So extra thing you need to do is: "Configure your NSGs to allow RDP/SSH from Azure Bastion only"?  

   Include diagram that shows how NSG fits in & describe diagram.

   High-level overview of what you need to add and how.
   From Cynthia's doc (and again aren't these the defaults?: 
   "To configure the NSG you will need to add inbound and outbound rules.

   - Allow TCP access from the Azure Gateway Manager on ports 443 or 4443. The Azure Gateway Manager facilitates portal connections to the Bastion service.  

   - Allow TCP access from the internet on port 443.

   - Allow outbound TCP access from the Azure Cloud on port 443. This facilitates diagnostic logging."
   
   Reference: https://docs.microsoft.com/azure/bastion/bastion-nsg

   "As a best practice, you can add the Azure Bastion Subnet IP address range in this rule to allow only Bastion to be able to open these ports on the target VMs in your target VM subnet." - have this be the exercise for next unit?

1. **Exercise - Configure network security group to only allow bastion to open ports RDP/SSH on app VM**
  
   Need to identify the specific NSGs to update and if this would work in sandbox.
   
   How to test that our changes worked?

1. **Monitor and manage remote sessions**

   Diagnostic logs - What, why, how. Reference: https://docs.microsoft.com/azure/bastion/diagnostic-logs

   Monitor sessions - what, why, & how. Reference: https://docs.microsoft.com/azure/bastion/session-monitoring

   **These seem pretty straightforward. Any other key points, limitations, or common customer questions we should cover?**

1. **Exercise - Enable diagnostic logs and monitor remote sessions**
   
   Enable diagnostics: https://docs.microsoft.com/azure/bastion/diagnostic-logs
   1. Enable resource log.
   1. Sign in via Bastion to get something generated? Leave connection open?
   1. View diagnostic log.
   
   Monitor sessions: https://docs.microsoft.com/azure/bastion/session-monitoring
   1. View sessions.
   1. Sign in via Bastion and leave connection open?
   1. Force disconnect session?
   
1. **Summary**

    How did you solve the problem in the initial scenario with the knowledge learned in the module? 
    
    *Add your summary [(Summary guidance)](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-module-summary-unit)*

## Notes

Sources:

- https://docs.microsoft.com/azure/bastion/bastion-overview
- https://docs.microsoft.com/en-us/azure/bastion/quickstart-host-portal
- https://docs.microsoft.com/azure/bastion/diagnostic-logs
- https://docs.microsoft.com/azure/bastion/session-monitoring

Scripts to possibly leverage:

- https://docs.microsoft.com/learn/modules/troubleshoot-inbound-connectivity-azure-load-balancer/4-exercise-set-up-environment 
- https://github.com/MicrosoftDocs/mslearn-troubleshoot-inbound-network-connectivity-azure-load-balancer/blob/master/src/scripts/setup.sh)
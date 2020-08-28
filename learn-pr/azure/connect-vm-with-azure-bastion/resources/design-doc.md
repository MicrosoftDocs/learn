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

Evaluate Azure Bastion. Deploy Azure Bastion to securely connect to Azure Virtual Machines directly within the Azure Portal, to effectively replace existing jumpbox solution. Monitor remote sessions by using diagnostic logs. Manage remote sessions by disconnecting a user session.

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
| Configure network security group rules | Investigate a different way to remotely connect and manage the app VM | Knowledge check | Configure and use Azure Bastion to connect to an Azure Virtual Machine | Yes |
| Enable diagnostic settings to get session logs | Investigate a different way to remotely connect and manage the app VM | Exercise | Monitor and manage remote sessions  |No w/ subtask for same objective |
| View sessions | Investigate a different way to remotely connect and manage the app VM | Exercise | Monitor and manage remote sessions  | No combine w/ subtask for same objective  |
| Force disconnect session | Investigate a different way to remotely connect and manage the app VM | Exercise | Monitor and manage remote sessions  | No combine w/ subtask for same objective |

## Outline the units

*Add more units as needed for your content*

1. **Introduction**

   Suppose you're the IT administrator for an internal HR app that's hosted in your organization's network in Azure. The app runs on an Azure Virtual Machine (VM) that's not publicly exposed to the internet. You're using a jumpbox to be able to manage the VM and app remotely. This jumpbox is an Azure VM that has a public IP, which you connect to by using RDP. The jumpbox is on the same Azure Virtual Network as the app VM. So from the jumpbox, you can connect to the app VM that's on the internal network.

   You've locked down network traffic to the jumpbox by using an Azure network security group. The network security group allows RDP and SSH requests from the local Azure virtual network and denies all other inbound requests to the public IP, across all ports.

   Periodically, you maintain the jumpbox by applying updates and security patches. You'd rather use that time for other projects. So you'd like to investigate another way to remotely connect and manage the app VM without having to publicly expose the internal HR app or manage an additional VM.

1. **What is Azure Bastion?**

   Azure Bastion provides a secure remote connection from the Azure portal to Azure virtual machines (VMs) over Transport Layer Security (TLS). Provision Azure Bastion to the same Azure Virtual Network as your VMs or a peered virtual network. Then connect to any VM on that virtual network or a peered virtual network directly from the Azure portal. 

   ***Intro points***
   - RDP/SSH connectivity to all VMs in same VNet or peered VNet
   - Don't need additional client, agent, or software
   - Deployment applies to a virtual network not subscription or VM. (Right now, if a customer manages multiple VNets & they're peered, they'd need a bastion deployment for each VNet. September or October, there will be support for peering. So if customer has multiple VNets but they're peered, then just need one Bastion deployment that applies to that network "group".)

   ***Security points***

   - Doesn't expose RDP or SSH ports or public IP addresses for the target VMs. (Protection against port scanning)
   - "Protect against zero-day exploits. Hardening in one place only: Azure Bastion is a fully platform-managed PaaS service. Because it sits at the perimeter of your virtual network, you don’t need to worry about hardening each of the virtual machines in your virtual network. The Azure platform protects against zero-day exploits by keeping the Azure Bastion hardened and always up to date for you.": From docs Bastion overview page.
   - Integrate with native Azure Virtual Network security appliances - such as Azure Firewall. (Per Michael: "I don't think we should call out any HTML5 web based clients or services")
   - Traffic initiated from the Azure Bastion to target virtual machines stays within the virtual network. (The browser connects to the Bastion host over the internet via the public IP of the Bastion.)
   - Configure NSGs to only allow remote connections to the target Virtual Machines from the Bastion host.(Best practice) Don't need to manage other NSGs.
   - Can monitor and manage remote connections (by enabling diagnostics settings and viewing/managing sessions on Bastion resource)

   ***Other solutions for Bastion & jumpbox***?

   ***Support points***

   - Browsers supported
   - Keyboard layout?
   - IPv4 not IPv6
   - Include concurrent session info?
   - Features supported: copy/paste; file copy not supported

   ***Roles required***

   If user doesn't have access to the resource group, then either they'd need to be granted access to the resource group or the resource itself (bastion). This isn't any different than any other Azure resource.


   
1. **How does Azure Bastion work?**

   ***How it works***

   - Diagram that shows the high-level architecture. Reuse: diagram from 
https://docs.microsoft.com/azure/bastion/bastion-overview. Include process steps. Cynthia's version has numbered steps that could be simplified.

   ***NSGs***
 
   From overview doc: "Azure Bastion is a fully managed platform PaaS service from Azure that is hardened internally to provide you secure RDP/SSH connectivity. You don't need to apply any NSGs on Azure Bastion subnet...."

   - If no NSGs, then you don't need to do anything. (Bastion works fine with the default nsg that's created with new VM.)
   - If they have NSG deployed and configured, then they need to make sure Bastion can connect to VMs via RDP/SSH. "As a best practice,"..."add the Azure Bastion Subnet IP address range in this rule to allow only Bastion to be able to open these ports on the target VMs in your target VM subnet."  Also needs to allow:
      - Allow TCP access from the Azure Gateway Manager on ports 443 or 4443. The Azure Gateway Manager facilitates portal connections to the Bastion service. 
      - Allow TCP access from the internet on port 443.
      - Allow outbound TCP access from the Azure Cloud on port 443. This facilitates diagnostic logging."

   Reference: https://docs.microsoft.com/azure/bastion/bastion-nsg

   ***How to deploy Bastion host (high-level overview)***

   - Prereqs: address space
   - Create in portal - 2 methods:
     - Create the BastionSubnet and deploy the Bastion Host as a part of the VNet creation experience (new). Include screenshots to show how this is done and the resources you end up with.
     - Or if you have existing VNet/VM, add subnet & then deploy bastion host from VM connection. (This is what we'll show in exercise.)
   - Create by using Azure PowerShell: show sample commands from https://docs.microsoft.com/azure/bastion/bastion-create-host-powershell
   - CLI: https://docs.microsoft.com/azure/bastion/create-host-cli
   -  What gets created when you deploy (Show this in next unit exercise?)

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

1. **Monitor and manage remote sessions**

   Diagnostic logs - What, why, how. Reference: https://docs.microsoft.com/azure/bastion/diagnostic-logs

   Monitor sessions - what, why, & how. Reference: https://docs.microsoft.com/azure/bastion/session-monitoring

   Include from [FAQ](https://docs.microsoft.com/azure/bastion/bastion-faq):
   - Limit for how many connections can be monitored. 25 per RDP connection & 50 for SSH.
   - Workaround: Add one bastion per vNet or create & move to another vNet.
   - Do not include in content but at the end of calendar year will be able to scale # of connections. Will need work item to update content then.

1. **Exercise - Enable diagnostic logs and monitor remote sessions**
   
   Enable diagnostics: https://docs.microsoft.com/azure/bastion/diagnostic-logs
   1. Enable resource log.
   1. Sign in via Bastion to get something generated? Leave connection open?
   1. View diagnostic log.
   
   Monitor sessions: https://docs.microsoft.com/azure/bastion/session-monitoring
   1. View sessions.
   1. Sign in via Bastion and leave connection open?
   1. Force disconnect session?
1. **Knowledge check**

   Add three questions that measure the objective:
   "Describe the features and benefits of Azure Bastion"
   Break that down into what the top 3 takeaways:
   1. What is Bastion/why you'd use it (have 2 wrong statements and one right)
   1. What does deployment apply to (sub, VNet, RG)
   1. Have scenario and have them pick what stuff they'd configure/set up? Like you're creating a VNet that you'll use to deploy VMs. What are the steps involved to deploy a Bastion host? Include NSGs to cover NSG unit.

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
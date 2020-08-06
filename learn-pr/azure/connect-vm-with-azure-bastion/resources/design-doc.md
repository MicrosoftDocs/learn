# Title
Connect to virtual machines securely (over the internet?) using Azure Bastion

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

*Add the summary [(Summary guidance)](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductory-summaries)*

## Learning objectives

1. Describe the features and benefits of Azure Bastion
1. Configure and use Azure Bastion to connect to an Azure Virtual Machine 
1. Monitor and manage remote sessions  

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

Suppose you're the IT administrator for an internal HR app that's on your organization's internal network. The app runs on an Azure Virtual Machine (VM) that's not publically exposed. You're using a jumpbox to be able to manage the VM and app remotely. This jumpbox is an Azure VM that has a public IP which you connect to over the internet. It's on the same Azure Virtual Network as the app VM. So from the jumpbox, you can connect to the app VM that's on the internal network.

Recently, you've noticed some suspicious sign-in attempts on the jumpbox. You'd like to investigate a more secure way to remotely connect and manage the app VM.

1. **What is Azure Bastion?**

   Azure Bastion provides a secure remote connection from the Azure portal to Azure virtual machines (VMs) over Transport Layer Security (TLS). Provision Azure Bastion to the same Azure Virtual Network as your VMs. Then connect to any VM on that virtual network directly from the Azure portal. 

   Intro points:
   - RDP/SSH connectivity to all VMs in same VNet
   - Don't need additional client, agent, or software
   - Deployment is per virtual network not subscription or VM. 

   How it works

   - Diagram that shows the highlevel architecture. Reuse: diagram from 
https://docs.microsoft.com/azure/bastion/bastion-overview. Include process steps. Cynthia's version has numbered steps that could be simplified.

   Security points:

   - Doesn't expose RDP or SSH ports or public IP. (Protection against port scanning)
   - Provides a single hardened access point.
   - Can integrate with existing firewalls and your security perimeter using a HTML5 based web client and standard SSL ports.
   - Network traffic stays within the virtual network.
   - Configure network security groups (NSGs) to allow connections only from the Bastion host. (Best practice) Don't need to manage other NSGs.

   Support points:

   - Browsers supported
   - Keyboard layout?
   - IPv4 not IPv6
   - Include concurrent session info?
   - Features supported: copy/paste; file copy not supported

   Roles required (include?)

   How to create (very high level overview)

   - Create in portal (which will show in first exercise)
   - Create by using Azure PowerShell: show sample comands from https://docs.microsoft.com/azure/bastion/bastion-create-host-powershell
   - CLI? Do we have this yet?

   **What are the most important take-aways from this unit for the KC?**

   **Knowledge check**

   What types of questions will test *learning objective*? *[(Knowledge check guidance)](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-knowledge-check)*
   - Question type
   - Question type

1. **Exercise – Connect to a virtual machine using the Bastion Service**

    List the steps which apply the learning content from previous unit:

    1. Customer runs script that creates existing enviroment: jumpbox + "app" VM (Ubuntu) that's on a private network. Jumpbox has public IP. 
    1. Connect to jumpbox using SSH and then ping the "app" VM.
    1. Remove public IP from jumpbox.
    1. Use "jumpbox" as target VM to spin up Bastion. (Create subnet, etc)
    1. Connect to app VM using bastion. Show what info you need to have for SSH connection.
    1. Have then do some small tasks on VM? What? Copy/paste something? (Note: "As IT/app admin, you might need to deploy code, manage files, update app.")
    1. Should we do something else with the jumpbox like decomission it??

1. **Secure Azure Bastion with a network security group**

   Talk about the default - what's gets setup and what best practice changes you should make?

   "As a best practice, you should have a network security group to restrict what ports and source IP addresses can connect to your Bastion service. This hardens the service and provides another level of security."  (Copied from Cynthia's draft and this is a bit confusing to me. Isn't this the default?)
   
   From overview doc: "Azure Bastion is a fully managed platform PaaS service from Azure that is hardened internally to provide you secure RDP/SSH connectivity. You don't need to apply any NSGs on Azure Bastion subnet. Because Azure Bastion connects to your virtual machines over private IP, you can configure your NSGs to allow RDP/SSH from Azure Bastion only."

   - So extra thing you need to do is: "Configure your NSGs to allow RDP/SSH from Azure Bastion only."  

   Include diagram that shows how NSG fits in & describe diagram.

   Highlevel overview of what you need to add and how.
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

   Diagnotic logs - What, why, how. Reference: https://docs.microsoft.com/azure/bastion/diagnostic-logs

   Monitor sessions - what, why, & how. Reference: https://docs.microsoft.com/azure/bastion/session-monitoring

1. **Exercise - Enable diagnotic logs and monitor remote sessions**
   
   Enable diagnotics: https://docs.microsoft.com/azure/bastion/diagnostic-logs
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

Note any additional information that may be beneficial to this content such as links, reference material, etc.
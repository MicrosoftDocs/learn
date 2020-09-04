Suppose you're the IT administrator for an internal HR app that's hosted in your organization's network in Azure. The app runs on an Azure Virtual Machine (VM) that's not publicly exposed to the internet. You're using a jumpbox to be able to manage the VM and app remotely. This jumpbox is an Azure VM that has a public IP, which you connect to by using RDP. The jumpbox is on the same Azure Virtual Network as the app VM. So from the jumpbox, you can connect to the app VM that's on the internal network.

You've locked down network traffic to the jumpbox by using an Azure network security group. The network security group allows RDP and SSH requests from the local Azure virtual network and denies all other inbound requests to the public IP, across all ports.

To keep your internal app VMs remotely accessible, you have to maintain the VM jumpbox by applying updates and security patches. This maintenance work takes time away from other projects. So you'd like to investigate another way to remotely connect and manage the app VM without having to publicly expose the internal HR app or manage an additional VM.

## Learning objectives

In this module, you will:

- Evaluate Azure Bastion as a replacement for a VM jumpbox solution
- Configure Bastion to securely connect to VM
- Manage remote sessions by enabling diagnostic logs and monitoring remote sessions

## Prerequisites

- Experience managing remote connections to virtual machines
- Familiarity with networking concepts like virtual networks, public and private IPs, and network protocols SSH, RDP, and TLS
Azure Virtual Network NAT is a network address translation service running in Azure. With Azure Virtual Network NAT, you can provide secure outbound connectivity to virtual instances in a private subnet so they can connect outside your virtual network.

## Example scenario

Imagine you work for an online retail company that intensively uses Azure VMs for various purposes. These VMs are deployed within several scale sets, and they make connections to various resources on the internet. These resources include partner services APIs, online databases, and other services such as the Windows Update service. Some of these VMs have instance-level public IP addresses assigned, while others have only private IP addresses.

Your colleague who administers and manages these VMs reports that some of them have connection timeouts and longer delays when connecting to services on the internet. You suspect that port exhaustion might be an issue. You decide to implement an Azure Virtual Network NAT resource as a NAT gateway service to resolve these issues. This will enable your VMs to connect to the internet more securely by using a dedicated public IP, while also sharing the full scope of ports.

After completing this module, you’ll know more about the Azure Virtual Network NAT service, how it works, and how to recognize scenarios where you should deploy and use it. You’ll also learn about the high-level steps for deploying and configuring Azure Virtual Network NAT.

## What will we be doing?

In this module, you’ll be introduced to the Azure Virtual Network NAT service. You’ll also discuss usage scenarios, learn how it works, and explore the steps you should take to deploy and configure it.

## What is the main goal?

By the end of this module, you’ll be able to describe Azure Virtual Network NAT, recognize scenarios where it would work well, and know how to deploy it in basic usage scenarios.

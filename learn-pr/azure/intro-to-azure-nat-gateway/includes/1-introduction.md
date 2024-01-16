Azure NAT Gateway is a network address translation service running in Azure. With Azure NAT Gateway, you can provide secure outbound connectivity to virtual instances in a private subnet so they can connect outside your virtual network.

## Example scenario

Imagine that you work for an online retail company that intensively uses Azure VMs for various purposes. These VMs are deployed within several scale sets, and they make connections to various resources on the internet. These resources include partner services APIs, online databases, and other services such as the Windows Update service. Some of these VMs have instance-level public IP addresses assigned, while others have only private IP addresses.

Your colleague who administers and manages these VMs reports that some of them have connection timeouts and longer delays when connecting to services on the internet. You suspect that port exhaustion might be an issue. You decide to implement an Azure NAT Gateway resource to resolve these issues. Azure NAT Gateway enables your VMs to connect to the internet more securely by using a dedicated public IP, while also sharing the full scope of ports.

After completing this module, you’ll know more about the Azure NAT Gateway service, how it works, and how to recognize scenarios where you should deploy and use it. You also learn about the high-level steps for deploying and configuring Azure NAT Gateway.

## What will we be doing?

In this module, we get an introduction to the Azure NAT Gateway service. We learn about usage scenarios, how the service works, and explore the steps you should take to deploy and configure it.

## What is the main goal?

By the end of this module, you're able to describe Azure NAT Gateway, recognize scenarios where it would work well, and know how to deploy it in basic usage scenarios.

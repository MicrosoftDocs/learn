Azure Load Balancer provides an effective means to distribute work across a set of virtual machines. Using Load Balancer helps you to scale a system effectively while maintaining throughput, and keeping response times low. Load Balancer depends on the correct configuration for the network, virtual machines, and applications being load balanced. If any of these items aren't set up correctly, then Load Balancer might not operate effectively, resulting in poor performance for your system.

Imagine you're an administrator for a large retail company that uses Load Balancer to distribute inbound internet traffic to your virtual machines. You've configured an alert in Azure Monitor to notify you when a virtual machine fails a load balancer health check. Recently, another administrator made some changes to the virtual network configuration. Several alerts tell you that the health checks for all virtual machines behind the load balancer are failing. You must determine the cause of these failures and rectify them quickly.

## Learning objectives

In this module, you'll:

- Identify common load balancer inbound connectivity issues.
- Identify steps to resolve issues when virtual machines aren't responding to a health probe.

## Prerequisites

- Basic understanding of Azure Load Balancer.
- Familiarity with Azure Virtual Machines.
- Basic understanding of Azure Monitor.

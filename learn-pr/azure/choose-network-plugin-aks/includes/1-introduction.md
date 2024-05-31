When you set up an Azure Kubernetes Service (AKS) cluster, it's important to consider the different options of network plugins for your business. Network plugins are required to configure network connectivity so applications or pods in the cluster can communicate with each other.

## Example scenario

Let's say you're a network administrator for Tailwind Traders, a traditional brick-and-mortar retailer. You've shifted to selling online and have built your site on Azure. The company sees several opportunities to improve its e-commerce website, including converting from a traditional monolithic application to a microservices architecture.

Tailwind Traders suspects that deploying the microservices in AKS clusters can help with container orchestration. However, you're unsure of which network plugin to choose for your AKS clusters.

## What is covered?

By the end of this module, you'll understand:

* What a Kubernetes network plugin is
* The pros, cons, and limitations of kubenet (basic)
* The pros, cons, and limitations of Azure CNI (advanced)
* Key decision criteria for choosing a network plugin

## What is the main goal?

By the end of this module, you're able to determine the tradeoffs and choose the best networking plugin on AKS that addresses your business scenario and network constraints.

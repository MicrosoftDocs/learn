When setting up an Azure Kubernetes Service (AKS) cluster, choosing a network plugin is mandatory for the cluster to be operational. The role of a network plugin is to configure network connectivity so pods running on anywhere in the cluster can communicate with each other.

## Example scenario

Suppose you are the network administrator for Tailwind Traders, a traditional brick-and-mortar retailer, which has found success selling online. The company sees several opportunities to improve its e-commerce website; for example, converting from a traditional monolithic application to a microservices architecture.

Tailwind Traders suspects that deploying the microservices in AKS clusters can help with container orchestration, but it needs help understanding which network plugin to use for the AKS clusters.

## What will we be doing?

By the end of this module, you will:

* Understand what a Kubernetes network plugin is
* Understand the pros, cons, and limitations of kubenet
* Understand the pros, cons, and limitations of Azure CNI
* Understand the key decision criteria when selecting a plugin

## What is the main goal?

By the end of this session, you'll be able to choose the networking plugin for AKS that best addresses your business scenario and network constraints.

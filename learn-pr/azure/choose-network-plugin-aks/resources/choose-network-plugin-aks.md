# Choose the best network plugin for AKS

## Role(s)

- administrator
- network-engineer
- solution-architect

## Level

- intermediate

## Product(s)

- Azure Kubernetes Service
- Virtual Network

## Prerequisites

- A basic understanding of Azure Kubernetes Service concepts such as Kubernetes API, cluster and pod
- Familiarity with basic networking concepts like CIDR, IP address allocation and NAT
- Basic understanding of Azure Virtual networks

## Summary

In this module, you'll learn about two networking plugins for AKS (Azure Kubernetes Services): Azure CNI and Azure Kubenet. You'll learn what they are, how they differ, and when you should choose one over the other.

## Learning objectives

By the end of this session, you'll be able to choose the networking plugin for AKS which best addresses your business scenario understanding the following concepts:

1. understand what is a Kubernetes network
2. understand what is Kubenet (pros, cons and limitations)
3. know how to deploy an AKS cluster with Kubenet
4. understand what is Azure CNI (pros, cons and limitations)
5. know how to deploy an AKS cluster with Azure CNI

## Chunk your content into subtasks

Identify the subtasks of **Choose network plugin for AKS**

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Understand the different network plugins available for AKS | Help make a choice | Knowledge check | 1 | Yes |
| Understand kubenet | Help make a choice | Knowledge check | 1 | Yes |
| Understand Azure CNI | Help make a choice | Knowledge check | 1 | Yes |



## Outline the units


1. **Introduction**

    Provide a scenario of a real-world job-task that shows how the technology is used in practice:
    
    Suppose you are the network administrator for - Tailwind Traders, a traditional brick-and-mortar retailer, which has found success selling online. The company sees several opportunities to improve its e-commerce website. For example, converting from a traditional monolith application to a microservices architecture.

    Tailwind Traders suspects that deploying the microservices in an AKS cluster (Azure Kubernetes Cluster) for container orchestration can help in both their production and development/experimental environment. The company knows they need to make a network plugin choice for their AKS clusters, and wants to understand the future impact of that choice for when their cluster usage continues to expand based on predicted growth patterns.

    As a network administrator you have a predetermined address pool 10.1.0.0/24 carved out for the development/experimental workloads and 10.2.0.0/16 for the production workloads.

 

    *Add your scenario [(Scenario guidance)](/help/learn/id-guidance-scenarios)*

2. **Azure Network Plugin options**

    - Why do we need a network plugin for AKS

    - Kubenet (basic) networking
        - explain Kubenet
        - how communication would work in a Kubenet AKS cluster
        - Deployment methods for Kubenet (create and configure Virtual Network or integrate into existing virtual network)
        - Diagram for Kubenet
    - Azure CNI (advanced) networking
        - explain CNI
        - How communication would work in a CNI AKS cluster
        - Deployment methods for CNI (create and configure Virtual Network or integrate into existing virtual network)
        - Diagram for CNI
    - IP address planning
        - Maximum pods per node in Kubenet and CNI

3. **Analyze decision criteria**

    - Starvation/Exhaustion of IPv4 address
    - Full network connectivity and the need to be reach a Pod via Pod Private Ip address from connected networks/Direct pod addressing requirements
    - Multiple AKS clusters sharing a subnet
    - Latency sensitivity caused due to extra hop for pod communication
    - Complexity of maintaining and operating Route tables and user defined routes
    - Requirements for additional capabilities such as - 
        - Virtual Nodes add on
        - Windows Node Pools
        - Azure Network Policies (Azure Policies)



4. **Kubenet for development/experimental environment**

    - There are several development/experimental features to be deployed. Accommodating all of those features in the limited IP address space carved out for development environment would be challenging.
    - Development/Experimental features environment does not need to have rapid scaling capabilities that Virtual Nodes with ACI provides
    - In the development environment most of the communication is self contained to services running within the AKS cluster. 
    - Minor latency in the development environment is acceptable.
    - Latency sensitivity caused due to additional hop for pod communication
    - Operational overhead of maintaining route tables and user defined routes in a development environment is acceptable compared to managing this in a production environment where there are pre-existing route tables for routing traffic.

5. **CNI for production environment**

    - Deploying the production web application in the AKS cluster using CNI is possible because there are enough IPs to accommodate the scale of the production environment.
    - Production cluster requires several services outside of the cluster to address the pods directly via pod private IP address
    - Production environment is extremely sensitive to latency
    - Production environment already has route tables configured with Network Virtual Appliances and introducing Kubenet would add additional overhead to manage the UDRs and route tables
    - Production clusters need the additional capabilities to burst into ACI Virtual nodes for rapid scaling and be able to use Azure Network Policies.
    - Production clusters also have applications which are currently leveraging windows node pools

6. **Knowledge check**

    - Question on max IP address for Kubenet vs CNI cluster
    - Question on which AKS Network plugin supports windows Node pools
    - Can two AKS Kubenet clusters be deployed in a single Azure Virtual network subnet ? (y/n)



7. **Summary**
In this module, you learned:

    - What are the different networking plugin options available on AKS (Azure Kubernetes Services): Azure CNI and Azure Kubenet.
    - How do the network plugins differ from each other
    - How to choose the best network plugin for your business needs

## Notes


### Questions:


Add node pool subnet in CNI as part of module
Don't let production and dev distinction confuse people

# Design an Azure Kubernetes Service network with Azure CNI

## Role(s)

- Solution Architect

## Level

- Intermediate

## Product(s)

- Azure Kubernetes Service

## Prerequisites

- Understand containers at a beginner level
- Understand Kubernetes at a beginner level

## Summary

Understand Kubernetes networking concepts. How the needs of your application, its dependencies on other components and services and security considerations can affect network design. Create an appropriate network for your Azure Kubernetes Service cluster.

## Learning objectives

Upon completing this module, you'll be able to:

1. List the key Kubernetes resource types that require network access.
1. Assess an application's needs and how that could affect network design.
1. Understand the options for securing network communications
1. Design a network for an Azure Kubernetes Service cluster using Azure CNI networking

## Chunk your content into subtasks

Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with?
 ---- | ---- | ---- | ---- | ----
Overview of Kubernetes Networking  | Understand the high-level requirements for Kubernetes networks | Knowledge Check | 1 | Yes
Analyze your workloads | Determine the needs of the workloads that will be running on the Kubernetes cluster | Knowledge Check | 2 | Yes
Determine cluster sizing | Determine the needs of the workloads that will be running on the Kubernetes cluster | Knowledge Check | 2 | Yes
Connectivity requirements | Determine the needs of the workloads that will be running on the Kubernetes cluster | Knowledge Check | 2 | Yes
Network security | Understand the network security components that will be needed to follow your company's policies and security requirements | Knowledge Check | 3 | Yes
Design an Azure CNI-based network | Use the information you've gathered in the previous tasks to complete a network design | Knowledge Check | 4 | Yes

## Outline the units

1. **Introduction**

    You're an architect who works for a business that wants to offer a new web-based product to your customers. The product will differentiate your business and give you a lead over your competitors. You want to use cloud native methods to allow rapid delivery of a product and then add new features. The application handles some private information, so ensuring the security of this data will be important.

    You want to build the application using containers and will be adopting DevOps practices. The application consists of multiple services. Some of those services need to communicate with other services in Azure. Some of those services need to communicate with existing services running in your on-premises infrastructure.

    Your company has recently standardized on Kubernetes to host all container-based workloads and you've been tasked with designing the cluster for the new service. However, you've quickly come to realize the design of the network is critically important. Where do you begin with designing your network?

1. **Overview of Kubernetes Networking**

    A Kubernetes cluster needs network addresses available to assign to pods, services, and nodes.

    - Understand how IP addresses are used by key Kubernetes components
        - Explain that pods, nodes, and services all need IP addresses
        - Pods are ephemeral and IP addresses can change frequently
        - Nodes run pods and Kubernetes core components and they need network connectivity
        - A Kubernetes Service provides access to pods using an IP address that is fixed throughout the life of the service

    **Knowledge check**

    - What is the purpose of a Kubernetes service?
    - What types of Kubernetes resources need IP addresses?

1. **Analyze your workloads**

    Before you can begin your network design, you need to understand the workloads that will be running on your cluster

    - Determine how many pods will be running on each node
        - Explain that you need to know how many pods your cluster will be running
        - Pods are distributed across multiple nodes
    - Determine how many nodes will be running in your cluster
        - Nodes should be sized appropriately for the workloads they'll be running
        - Decide whether you'll be using auto scaling
        - Explain the considerations for cluster upgrades
    - What environment will the cluster be serving?
        - Determine if your cluster will be hosting workloads for a development, test, staging, or production environment.
        - Explain why the environment might affect the network design
    - Understand the network connectivity requirements for your workloads
        - You'll need to know if your workloads need to communicate with other workloads or services in the same cluster.
        - You'll need to know if your workloads will receive incoming requests from sources external to your cluster.
        - Explain why the network design might be affected.
    - Identify components with specific networking requirements
        - Some components that are needed for workloads running on your Kubernetes cluster may have specific networking requirements. - Explain why the network design might be affected.

    **Knowledge check**

    - You upgrade your cluster to a new Kubernetes version that's been released. What effect might the upgrade have on IP addresses used by your cluster's services, pods and nodes?

1. **Securing network communications**
    - Using a Web Application Firewall to monitor and control traffic being sent to your cluster
        - Explain how a Web Application Firewall can be used to protect your cluster from malicious incoming network traffic
    - Using a Firewall to monitor and control traffic leaving your cluster
        - Explain how a firewall can be used to monitor and control the network traffic being sent from your cluster.
    - Using a bastion to access cluster nodes and workloads.
        - Explain how a bastion service could be used to provide a secure method to access the cluster nodes or pods
    - Using Network Security Groups.
    - Using Network Policies to monitor and control traffic inside your cluster.

    **Knowledge check**
    - You've deployed a new AKS cluster to a network that was created by your company's network team. It's configured to send all egress traffic to a firewall. What services, at a minimum, does your network team need to allow through the firewall to allow your AKS cluster to work correctly?
    - You ensure that you configure secure communications for the applications running within your AKS cluster to ensure only permitted network traffic is allowed. How would you configure access?


1. **Public and private networking options**

    Azure private link can be used to ensure that Azure services aren't accessible over a public IP address. AKS clusters can be configured as private clusters. The workloads in your cluster might access other services that are privately accessible.

    - What are the differences between a private AKS cluster and a public AKS cluster?
        - Explain that a private AKS cluster means that the control plane isn't accessible over a public IP address.
        - Explain the benefits and implications of private cluster.
        - Explain how DNS is used in a private cluster and how that works with existing DNS.
    - What are the considerations for your cluster when accessing other Azure services that use private link?

    **Knowledge check**
    - You've deployed a new application to your AKS cluster. The application needs access to Azure Key Vault to securely retrieve secrets. How would you configure secure access to Azure Key Vault?
    - You've deployed a new AKS cluster with private cluster enabled. When you attempt to run a kubectl command from your laptop, you get an error message. How can you fix this error?

1. **Configure your AKS cluster with Azure CNI**

    - Understand the network plug-in options available in AKS
        - Explain what the Kubenet and Azure CNI plug-ins are and the key differences
    - Selecting address ranges for the Azure CNI network plug-in.
        - Explain the options for virtual network and subnet design
        - Explain how the numbers of pods, nodes, and node pools affect the design
    - Selecting an address range for Kubernetes services
        - Explain the options for defining a service CIDR.
        - Select a DNS service IP
        - Understanding the Docker Bridge address.
    - Selecting an address range for
        - Explain how services such as ingress, firewalls, private link, bastions, and on-premises access may require separate subnets

    **Knowledge check**
    - When selecting the Kubernetes services address range, what do you need to consider?
    - You're deploying a new AKS cluster for a production environment. The cluster will consist of a single node pool with five nodes. The application follows the microservices architecture. The application consists of 10 individual services, each of which will be deployed with five replicas. Multiple replicas will ensure high performance and resilience. Which network design would be best for this scenario?


1. **Summary**

    To design a network for an Azure Kubernetes Service cluster, you need to understand the needs of the applications that will be running on the cluster. We've reviewed Kubernetes networking concepts so we understand which components require IP addresses. We've analyze the applications that will be running on the cluster. How that affects the number of nodes and node pools that your cluster requires. What the application's network connectivity requirements are. How all of that can affect your network design. We considered our security requirements. Finally we brought everything together to create a network design for an Azure Kubernetes Service cluster using the advanced networking option.


## Notes

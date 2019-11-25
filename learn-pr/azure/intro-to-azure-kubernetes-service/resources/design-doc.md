# Module Design

## Title

Introduction to Azure Kubernetes Service

## Role(s)

- Developer
- Administrator
- Solution Architect

## Level

- Beginner

## Product(s)

- Azure
- Azure Kubernetes Service

## Prerequisites

- A basic understanding of containers
- A basic understanding of microservices

## Summary

Azure Kubernetes Service (AKS) makes it simple to deploy a managed Kubernetes cluster in Azure. AKS reduces the complexity and operational overhead of managing Kubernetes by offloading much of that responsibility to Azure. As a hosted Kubernetes service, Azure handles critical tasks like health monitoring and maintenance for you.

## Learning objectives

1. Evaluate whether Azure Kubernetes Service is an appropriate Kubernetes orchestration platform for you
1. Describe how the components of Azure Kubernetes Service work to support compute container orchestration

## Chunk your content into subtasks

Follow the *Introduction to* module guidelines.

## Outline the units

1. **Introduction**

     A fleet management company provides an asset tracking solutions to customers worldwide. Their tracking solution is built and deployed as microservices. They're using containerized instances to quickly deploy into new customer regions and scale resources as needed to meet customer demands. They want to use a container orchestration platform that makes it simple to develop, deploy and manage containerized applications.

1. **What is Azure Kubernetes Service?**

    We're assuming the reader has a basic understanding of containers and container management. However, cover the following concepts for those readers that do not and to set context.

    - What is a container?
    - What is container management?
    - What is Kubernetes?
    - What is a Kubernetes pod?
    - What is Azure Kubernetes Service?
    - Azure Kubernetes Service features

        List the AKS features. These features sets AKS asside from other cloud Kubernetes offerings.

        - Identity and security management
        - Integrated logging and monitoring
        - Cluster node and pod scaling
        - Cluster node upgrades
        - GPU enabled nodes
        - Storage volume support
        - Virtual network support
        - Ingress with HTTP application routing support
        - Kubernetes certification and Regulatory compliance

1. **How Azure Kebernetes Service works**

    - Creating an AKS cluster.

        There is no sandbox experience for this module. The idea is to show the reader how easy it is to create a cluster with basic information required to complete the setup.

    - How workloads are developed and deployed to AKS

        AKS supports all the popular development and management tools such as Helm, Draft, Kubernetes extension for Visual Studio Code and Visual Studio Kubernetes Tools.

        - Deployment Tools

            - Helm
            - Draft

        - Development Tools

            Cover both

            - Kubernetes extension for Visual Studio Code, and
            - Visual Studio Kubernetes Tools

        - Azure Dev Spaces
        - Deployment Center

    - Azure Service Integration

1. **When to use Azure Kebernetes Service**

    - The decision to use AKS can be seen from two view points. Green fields or a lift-and-shift. A green fields project will allow you to evaluate AKS based on default features. A lift-and-shift project, will force you to look at which features are best suited to support your migration.

    Discuss the decision based around the AKS features.

1. **Knowledge check**

    - AKS cost. You only pay for the virtual machines instances, storage, and networking resources consumed by your Kubernetes cluster.
    - Storage volume support. AKS supports both static and dynamic storage volumes for containers that need persisted storage.
    - Azure Dev Spaces. Azure Dev Spaces allows for the development of code in isolation, and do end-to-end testing with other components without replicating or mocking up dependencies.

1. **Summary**

    - AKS manages your hosted Kubernetes environment and makes it simple to develop, deploy and managed containerized applications in Azure. It streamlines the installation process and takes care of most of the underlying cluster management tasks.
    - Supports existing tooling
    - Supports existing deployment workflows
    - Integrates with Azure Services

## Notes
# Module Design

## Title

Introduction to Azure Service Fabric

## Role(s)

- Developer
- Administrator
- Solution Architect

## Level

- Beginner

## Product(s)

- Azure
- Azure Service Fabric

## Prerequisites

- A basic understanding of containers
- A basic understanding of container orchestration
- A basic understanding of microservices
- A basic understanding of stateful and stateless services

## Summary

Azure Service Fabric makes it easy to package, deploy, and manage scalable and reliable microservices and containers. Azure Service Fabric also helps in the development and deployment of cloud-native applications. Azure Service Fabric supports both stateless and stateful microservices. Azure Service Fabric offers two cluster models: standard and managed. For standard clusters, all the resources that support your cluster must be configured and maintained by you. For managed clusters, the deployment and management processes are simplified by abstracting away the underlying resources.

## Learning objectives

1. Evaluate whether Azure Service Fabric is an appropriate container orchestration and microservice deployment platform for you
1. Describe how Azure Service Fabric differentiates itself through its focus on building stateful services
1. Describe how the components of Azure Service Fabric work to support compute container orchestration

## Chunk your content into subtasks

Follow the *Introduction to* module guidelines.

## Outline the units

1. **Introduction**

     Give a brief overview of containers/microservices.

     Give a brief overview of container orchestration.

     An energy company provides smart home thermostats to customers nationwide. The sensors in their metering devices are built and deployed as microservices. They're using containerized instances to quickly deploy into new customer regions and scale resources as needed to meet customer demands. They want to use a container orchestration platform that makes it simple to develop, deploy, and manage containerized applications. They need a platform that handles large scale and has low latency to help process data on millions of devices.

1. **What is Azure Service Fabric?**

    We're assuming the reader has a basic understanding of containers and container management. However, cover the following concepts for those readers that do not and to set context.

    - What is a container?
    - What is container management?
    - What is a microservice?
    - What is the difference between stateful and stateless microservices?
    - What is Azure Service Fabric?
    - Azure Service Fabric features

        List the Azure Service Fabric features.

        - Support for stateful and stateless microservices
        - Integrated with CI/CD tools
        - Windows and Linux support
        - Azure, on-premises, and public cloud compatibility
        - Identity and security management
        - Integrated logging and monitoring
        - Cluster node scaling
        - Cluster node upgrades
        - Storage volume support
        - Availability in all Azure regions
        - Compliance with Azure certification

1. **How Azure Service Fabric works**

    - Creating an SF cluster.

        There is no sandbox experience for this module. The idea is to show the reader how easy it is to create a cluster with basic information required to complete the setup.

    - How workloads are developed and deployed to Service Fabric

        Service Fabric supports a wide range of popular development tools and environments.

        - Development Tools

            - Service Fabric Tools included in Azure Development workload in Visual Studio
            - Support for Windows and Linux development environments through the Microsoft Azure Service Fabric SDK
            - Variety of productive programming models including guest executables, containers, and Reliable Services and Actors
            - Variety of languages including .NET Core 2.0, C#, and Java

        - Deployment Tools

            - PowerShell
            - Azure Resource Manager
            - Azure CLI
            - Azure portal
            - Docker Compose

    - Azure Service Integration

1. **When to use Azure Service Fabric**

    Discuss the decision based around the ASF features.

    Emphasis on stateful services.

1. **Knowledge check**

    - Stateful and stateless workloads. With Service Fabric, you can mix both services in processes and services in containers in the same application.
    - Suppose you work for an event management company. Your events website needs persisted storage. Which feature of Service Fabric will you use?
    - Any OS, any Cloud. Service Fabric offers Windows and Linux support, and it can be hosted on any cloud.

1. **Summary**

    - Azure Service Fabric makes it easy to package, deploy, and manage scalable and reliable microservices and containers.
    - Azure Service Fabric also helps in the development and deployment of cloud-native applications.
    - Azure Service Fabric supports both stateless and stateful microservices.
    - Supports existing tooling
    - Supports existing deployment workflows
    - Integrates with Azure Services

## Notes

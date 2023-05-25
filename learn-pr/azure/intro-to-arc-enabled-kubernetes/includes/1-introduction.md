Containerization is an important technological trend across public and private clouds and in on-premises datacenters. Running containers at scale requires an *orchestrator* such as Kubernetes, which automates container scheduling, deployment, networking, scaling, health monitoring, and management.

Many vendors support Kubernetes as a standard for containerized deployments, including Microsoft. Azure Arc helps provide a consistent, scalable management model for Kubernetes clusters and their workloads.

Imagine that you're the lead systems engineer for Contoso, a medium-size financial services company with headquarters in London and offices in New York and San Francisco. Contoso's computing environment is hosted in its on-premises datacenters. Most workloads are fully containerized on Kubernetes, running on a third-party virtualization platform.

Despite its modernized environment, Contoso faces challenges imposed by capacity and agility constraints that are inherent in on-premises infrastructure. It's also becoming harder to consistently manage a continually growing number of Kubernetes clusters.

To address these capacity and agility challenges, IT management has decided to migrate a significant portion of Contoso's containerized workloads to the cloud. Wary of developing a single-vendor dependency, Contoso wants to use multiple cloud providers, but Microsoft Azure is its main deployment target. This choice is due to the advantages of Azure Kubernetes Service (AKS) and the benefits of Azure Arc, especially its centralized, multiplatform management capabilities.

The Contoso IT Engineering team is tasked with exploring and evaluating Azure Arc capabilities for Kubernetes-based workloads. You must determine how Contoso can benefit from its hybrid management model by pursuing a multivendor strategy and maintaining some on-premises containerized workloads.

In this module, you learn how Azure Arc can help with Kubernetes cluster management and monitoring. You can then explain how these capabilities can help Contoso optimize and simplify their operations.

## Learning objectives

After you complete this module, you know how to:

- Describe Kubernetes, Azure Arc, and Azure Arc-enabled Kubernetes.
- Connect Kubernetes clusters to Azure Arc.
- Apply configurations to Azure Arc-enabled Kubernetes clusters by using GitOps.
- Integrate Azure Arc-enabled Kubernetes clusters with Azure services like Azure Monitor and Azure Policy.

## Prerequisites

For the best learning experience from this module, you need basic understanding and familiarity with the following technologies:

- Containerization and Kubernetes architecture
- Azure Resource Manager
- Azure command-line interface (Azure CLI)
- Azure Monitor and Azure Policy
- GitOps principles and processes

Some of the later units list more specific prerequisites.

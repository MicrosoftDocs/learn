Containerization is one of the current predominant technological trends not only across public and private clouds, but also in on-premises datacenters. Running containers at scale requires the use of an orchestrator, which automates scheduling, deployment, networking, scaling, health monitoring, and management of containers. Kubernetes has become a standard for new containerized deployments, embraced by a wide range of vendors, including Microsoft. While the number of Kubernetes deployment grows, Azure Arc aims to address the challenge to provide a consistent, scalable management model for Kubernetes clusters and their workloads. 

## Scenario

Contoso is a medium-size financial services company with its headquarters in London and offices in New York and San Francisco. Contoso computing environment is hosted exclusively in its on-premises data centers, with majority of workloads fully containerized on Kubernetes, running on a third-party virtualization platform. Despite its fully modernized environment, Contoso is facing challenges imposed by capacity and agility constraints inherent to on-premises infrastructure. In addition, it also becomes increasingly difficult to manage in a consistent manner continually growing number of Kubernetes clusters. 

To address the capacity and agility challenges, Contoso's IT management decided to migrate a significant portion of its containerized workloads to cloud. Wary of developing a single-vendor dependency, Contoso wants to leverage multiple cloud providers, although it is considering choosing Microsoft Azure as its main deployment target. This consideration is heavily influenced not only by the advantages of the Azure Kubernetes Service offering, but also by a wide range of hybrid benefits associated with Azure Arc, with its centralized, multi-platform management capabilities playing the primary role.

The Contoso IT Engineering team was tasked with exploring and evaluating Azure Arc capabilities in regard to Kubernetes-based workloads. It is your responsibility, as the lead systems engineer to determine how Contoso can benefit from its hybrid management model while pursuing a multi-vendor strategy and maintaining some on-premises containerized workloads.

Over the course of this module, you'll learn about Azure Arc capabilities targeting management and monitoring of Kubernetes clusters. You'll then be able to describe how these capabilities can help customers like Contoso to optimize and simplify their operations. 

## Learning objectives

After completing this module, you'll be able to:

- Describe Kubernetes, Azure Arc, and Azure Arc-enabled Kubernetes.
- Connect Kubernetes clusters to Azure Arc.
- Manage Azure Arc enabled Kubernetes clusters by using GitOps.
- Integrate Azure Arc enabled Kubernetes cluster with Azure services like Azure Monitor and Azure Policy.

## Prerequisites

For the best learning experience from this module, you should have knowledge of, and experience with, the following:

- Containerization and its concepts
- Kubernetes architecture and its concepts
- Azure Resource Manager
- Azure Policy
- Azure command-line interface (CLI)
- GitOps principles

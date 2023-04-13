Containerization is one of the predominant technological trends of today, not only across public and private clouds, but also in on-premises datacenters. Running containers at scale requires the use of an orchestrator, which automates scheduling, deployment, networking, scaling, health monitoring, and management of containers. Kubernetes has become a standard for new containerized deployments, embraced by a wide range of vendors, including Microsoft. As the number of Kubernetes deployments grows, Azure Arc helps to provide a consistent, scalable management model for Kubernetes clusters and their workloads.

## Scenario

Contoso is a medium-size financial services company with its headquarters in London and offices in New York and San Francisco. Contoso's computing environment is hosted exclusively in its on-premises datacenters. The majority of its workloads are fully containerized on Kubernetes, running on a third-party virtualization platform. Despite its fully modernized environment, Contoso is facing challenges imposed by capacity and agility constraints inherent to on-premises infrastructure. It's also becoming increasingly difficult to manage a continually growing number of Kubernetes clusters in a consistent manner.

To address these capacity and agility challenges, Contoso's IT management has decided to migrate a significant portion of its containerized workloads to the cloud. Wary of developing a single-vendor dependency, Contoso wants to use multiple cloud providers, although it's considering choosing Microsoft Azure as its main deployment target. This consideration is due not only to the advantages of the Azure Kubernetes Service offering, but also by a wide range of benefits associated with Azure Arc, especially its centralized, multi-platform management capabilities.

The Contoso IT Engineering team is tasked with exploring and evaluating Azure Arc capabilities in regard to Kubernetes-based workloads. As the lead systems engineer, you must determine how Contoso can benefit from its hybrid management model while pursuing a multi-vendor strategy and maintaining some on-premises containerized workloads.

Over the course of this module, you'll learn how Azure Arc can help with management and monitoring of Kubernetes clusters. You'll then be able to describe how these capabilities can help customers like Contoso to optimize and simplify their operations.

## Learning objectives

After completing this module, you'll be able to:

- Describe Kubernetes, Azure Arc, and Azure Arc-enabled Kubernetes.
- Connect Kubernetes clusters to Azure Arc.
- Apply configurations to Azure Arc-enabled Kubernetes clusters by using GitOps.
- Integrate Azure Arc-enabled Kubernetes clusters with Azure services like Azure Monitor and Azure Policy.

## Prerequisites

For the best learning experience from this module, you should have some familiarity and experience with the following:

- Containerization and its concepts
- Kubernetes architecture and its concepts
- Azure Resource Manager
- Azure Policy
- Azure command-line interface (CLI)
- GitOps principles

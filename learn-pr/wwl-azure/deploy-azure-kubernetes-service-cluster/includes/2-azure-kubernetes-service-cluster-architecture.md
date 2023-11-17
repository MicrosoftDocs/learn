This module provides a recommended baseline infrastructure architecture to deploy an Azure Kubernetes Service (AKS) cluster on Azure. The design principles are based on our [architectural best practices](/azure/architecture/framework/services/compute/azure-kubernetes-service/azure-kubernetes-service) from the [Azure Well-Architected Framework](/azure/architecture/framework/) to guide an interdisciplinary or multiple distinct teams.

This architecture is focused on the AKS cluster itself, and not workload specific. The information in this module is the minimum recommended baseline for most AKS clusters. It integrates with Azure services that deliver a network topology that supports multi-region growth and secures the in-cluster traffic.

The target architecture is based on business requirements, and as a result it can vary between different application contexts. It should be considered as your starting point for preproduction and production stages.

With Azure Kubernetes Service (AKS) on Azure Local, you deploy and manage Kubernetes clusters on your own infrastructure from Azure. In this module, you explore how to prepare, deploy, access, and operate those clusters.

## Scenario: Modernize Contoso's container platform

Contoso is a financial services company that runs Windows and Linux applications in its datacenter. Its developers are containerizing selected applications. The infrastructure team needs a repeatable way to deploy Kubernetes without moving all application processing to Azure.

As Contoso's lead system engineer, you evaluate AKS on Azure Local. You need to separate infrastructure preparation from workload-cluster creation, give administrators appropriate access, and verify that each application's operating system, storage, and authentication requirements fit the platform.

## Scope and learning objectives

This module covers **AKS on Azure Local for hyperconverged deployments**. It doesn't describe the separate AKS on Windows Server deployment workflow or Azure Local multi-rack deployments. The Azure Local infrastructure is already deployed; you prepare the environment for an AKS workload cluster and use Azure CLI from a management workstation.

In this module, you learn how to:

- Describe Kubernetes concepts and the AKS on Azure Local architecture.
- Identify infrastructure, networking, identity, and tool prerequisites.
- Deploy an AKS cluster and verify its automatic Azure Arc integration.
- Access the Kubernetes API using Microsoft Entra authentication.
- Place workloads on appropriate Linux and Windows node pools.
- Configure persistent storage for containerized applications.
- Evaluate Windows workload requirements and platform limitations.
- Troubleshoot deployment, access, scheduling, and storage issues.

## Prerequisites

To follow the examples, you need:

- Familiarity with Windows Server, virtualization, containers, and basic Kubernetes concepts.
- Familiarity with Azure Local and its Azure-connected management model.
- A supported hyperconverged Azure Local deployment prepared by an infrastructure administrator.
- Access to the Azure resources and Microsoft Entra group described in the deployment preparation unit.

The examples illustrate administrative workflows. Before you use them in production, review current release requirements, capacity, licensing, and application support.

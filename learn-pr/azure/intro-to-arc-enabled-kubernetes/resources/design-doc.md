# Introduction to Azure Arc enabled Kubernetes

## Learner roles

- administrator
- database administrator
- devOps engineer
- security engineer
- solution architect
- technology manager

## Learner level

- **Intermediate**: Material that assumes some knowledge but little in-depth understanding of the topic. Provides a detailed overview of a topic's sub-areas.

## Products taught

- Azure Arc
- Kubernetes
- Azure Policy

## Prerequisites

In order to get the best learning experience from this module, you should have knowledge of the following:

- Containerization and its concepts
- Kubernetes architecture and its concepts
- Azure Resource Manager
- Azure Policy
- Azure CLI
- GitOps principles

## Module summary description

This module introduces you to Azure Arc enabled Kubernetes, describes its core capabilities, its implementation process, and its basic management tasks.

## Subtasks in this module

What main subtasks would be addressed in this module? 

- What are architectural components of Azure Arc enabled Kubernetes clusters
- What are capabilities and use cases of Azure Arc enabled Kubernetes clusters
- How to implement Azure Arc enabled Kubernetes clusters
- How to assure configuration conformance of Azure Arc enabled Kubernetes clusters at scale by using Azure Policy
- How to assure run-time policy compliance with Azure Policy for Kubernetes
- How to manage and maintain Azure Arc enabled Kubernetes clusters and containerized applications by using GitOps
- How to monitor a Kubernetes cluster by using Azure Monitor

## Lab exercise

None

## Module learning objectives

- Describe Kubernetes, Azure Arc, and Azure Arc-enabled Kubernetes.
- Connect Kubernetes clusters to Azure Arc.
- Manage Azure Arc enabled Kubernetes clusters by using GitOps
- Integrate Azure Arc enabled Kubernetes cluster with Azure services like Azure Monitor and Azure Policy.

## Estimated module duration

50 minutes

## Module outline of units

### Number of units per module

10

## 1st unit: Introduction

**Type of unit:** Introduction unit

**Estimated unit duration:** 3 mins

### Module scenario

Contoso is a medium-size financial services company with its headquarters in London and offices in New York and San Francisco. Contoso computing environment is hosted exclusively in its on-premises data centers, with majority of workloads fully containerized on Kubernetes, running on a third-party virtualization platform. Despite its fully modernized environment, Contoso is facing challenges imposed by capacity and agility constraints inherent to on-premises infrastructure. In addition, it also becomes increasingly difficult to manage in a consistent manner continually growing number of Kubernetes clusters. 

To address the capacity and agility challenges, Contoso's IT management decided to migrate a significant portion of its containerized workloads to cloud. Wary of developing a single-vendor dependency, Contoso wants to leverage multiple cloud providers, although it is considering choosing Microsoft Azure as its main deployment target. This consideration is heavily influenced not only by the advantages of the Azure Kubernetes Service offering, but also by a wide range of hybrid benefits associated with Azure Arc, with its centralized, multi-platform management capabilities playing the primary role.

Since Azure Arc is still in preview, the Contoso IT Engineering team was tasked with exploring and evaluating its capabilities in regard to Kubernetes-based workloads. It is your responsibility, as the lead system engineer to determine how Contoso can benefit from its hybrid management model while pursuing a multi-vendor strategy and maintaining some on-premises containerized workloads.


## 2nd unit: What are Kubernetes and Azure Arc?

**Type of unit:** Learning content unit

**Estimated unit duration:** 9 mins

### Key content per learning objective

Describe basic characteristics and capabilities of Kubernetes and Azure Arc

- Describe basic characteristics and capabilities of Kubernetes in the context of Azure Arc-based management
- Describe basic characteristics and capabilities of Azure Arc in the context of Kubernetes-based workloads


## 3rd unit: What are the architecture, components, and characteristics of Azure Arc-enabled Kubernetes?

**Type of unit:** Learning content unit

**Estimated unit duration:** 4 mins

### Key content per learning objective

Describe architecture, components, and characteristics of Azure Arc enabled Kubernetes

- Describe architecture and components of Azure Arc enabled Kubernetes
- Describe characteristics of Azure Arc enabled Kubernetes

## 4th unit: Connect Kubernetes clusters to Azure Arc

**Type of unit:** Learning content unit

**Estimated unit duration:** 5 mins

### Learning objective(s) targeted

Connect Kubernetes clusters to Azure Arc

- Connect Kubernetes clusters to Azure Arc with Azure CLI

## 5th unit: Apply configuration of Azure Arc enabled Kubernetes clusters by using GitOps

**Type of unit:** Learning content unit

**Estimated unit duration:** 6 mins

### Learning objective(s) targeted

Apply configuration of Azure Arc enabled Kubernetes clusters by using GitOps

- Describe GitOps
- Concept video: demonstration of end-to-end GitOps flow on Azure Arc enabled Kubernetes clusters.
- Apply configuration of Azure Arc enabled Kubernetes clusters by using GitOps

## 6th unit: Integrate an Azure Arc enabled Kubernetes cluster with Azure Policy for Kubernetes

**Type of unit:** Learning content unit

**Estimated unit duration:** 9 mins

### Learning objective(s) targeted

Enforce and audit configuration of Azure Arc enabled Kubernetes clusters by using Azure Policy

- Describe Azure Policy in the context of Azure Arc enabled Kubernetes 
- Enforce and audit configuration of Azure Arc enabled Kubernetes clusters by using Azure Policy

## 7th unit: Integrate an Azure Arc enabled Kubernetes cluster with Azure Monitor

**Type of unit:** Learning content unit

**Estimated unit duration:** 5 mins

### Learning objective(s) targeted

Integrate an Azure Arc enabled Kubernetes cluster with Azure Monitor

- Describe Azure Monitor
- Integrate an Azure Arc enabled Kubernetes cluster with Azure Monitor

## 8th unit: Summary

**Type of unit:** Summary unit

**Estimated unit duration:** 3 mins

### Resolution of module problem

Azure Arc will allow Contoso to implement a hybrid management model while pursuing a multi-vendor strategy and maintaining some on-premises containerized workloads.
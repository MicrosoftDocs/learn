# Introduction to Azure Arc enabled Kubernetes

## Learner roles

- Administrator
- Database administrator
- DevOps engineer
- Security engineer
- Solution architect
- Technology manager

## Learner level

- **Intermediate**: Material that assumes some knowledge but little in-depth understanding of the topic. Provides a detailed overview of a topic's subareas. <!-- I'd delete this last sentence as it doesn't apply to the heading - it doesn't respond to the implied question," What is the learner level?" -->

## Products taught

- Microsoft Azure Arc
- Kubernetes
- Azure Policy

## Prerequisites

To get the best learning experience from this module, you should have knowledge of:

- Containerization and its concepts.
- Kubernetes architecture and its concepts.
- Azure Resource Manager.
- Azure Policy.
- Azure Command-Line Interface (Azure CLI)
- GitOps principles

## Module summary description

This module introduces you to Azure Arc enabled Kubernetes. It describes its core capabilities, implementation process, and basic management tasks you can perform with it.

## Subtasks in this module

This module addresses several main subtasks, including:

- What are the architectural components of Azure Arc enabled Kubernetes clusters? <!-- In the other mods, there is no intro sentence to this bulleted list, and the list items are imperative statements. Such as, "Architectural components of Azure Arc enabled Kubernetes clusters," and "Azure Arc enabled Kubernetes clusters capabilities and use cases." -->
- What are the capabilities and use cases of Azure Arc enabled Kubernetes clusters?
- How to implement Azure Arc enabled Kubernetes clusters
- How to use Azure Policy to assure configuration conformance of at-scale Azure Arc enabled Kubernetes clusters
- How to use Azure Policy for Kubernetes to ensure run-time policy compliance
- How to use GitOps to manage and maintain Azure Arc enabled Kubernetes clusters and containerized applications
- How to use Azure Monitor to oversee a Kubernetes cluster

## Lab exercise

None

## Module learning objectives

After completing this module, you&#39;ll be able to:

- Describe Kubernetes, Azure Arc, and Azure Arc enabled Kubernetes.
- Connect Kubernetes clusters to Azure Arc.
- Manage Azure Arc enabled Kubernetes clusters by using GitOps.
- Integrate Azure Arc enabled Kubernetes cluster with Azure services such as Azure Monitor and Azure Policy.

## Estimated module duration

50 minutes

## Module outline of units<!-- We are missing the outline of units. I'll add them so you know what other mods have. -->

1. Introduction
2. What are Kubernetes and Azure Arc?
3. What are the architecture, components, and characteristics of Azure Arc enabled Kubernetes?
4. Connect Kubernetes clusters to Azure Arc
5. Apply Azure Arc enabled Kubernetes cluster configurations by using GitOps <!-- I changed this below to "Apply Azure Arc enabled Kubernetes cluster configurations by using GitOps." If you agree, please change it here as well. -->
6. Integrate an Azure Arc enabled Kubernetes cluster with Azure Policy for Kubernetes
7. Deploy containerized applications to Azure Arc enabled Kubernetes clusters by using GitOps<!-- I changed this below to "Use GitOps to deploy containerized applications to Azure Arc enabled Kubernetes clusters." If you agree, please change it here as well. -->
8. Integrate an Azure Arc enabled Kubernetes cluster with Azure Monitor
9. Summary

### Number of units per module

10<!-- I only found 9. -->

## First unit: Introduction

**Type of unit:** Introduction unit

**Estimated unit duration:** 3 minutes

### Module scenario

<!-- FOR ID/SME: This initial scenario paragraph differs slightly from most of the other modules, in that it specifies there are offices in San Francisco, too. The other DDs specify a headquarters in London and office in New York. I wasn't sure whether you want strict consistency for this intro "scenario" paragraph across design docs, so wanted to point it out. I've left "San Francisco" in this one. And then here's the intro scenario paragraph that most of the other DDs are using, for your reference: "Contoso, Ltd. is a midsize financial services company in London with a New York branch office. Contoso uses Microsoft 365, Azure Active Directory (Azure AD), Azure AD Identity Protection, Cloud App Security, Microsoft Defender for Identity, Microsoft Defender for Endpoint, Microsoft Defender for Office 365, Endpoint Protection, and Azure Information Protection. Contoso uses the paid version of Azure Security Center as threat protection for resources that run on Azure and on-premises. The company also monitors and protects other non-Microsoft assets." --> Contoso, Ltd. is a midsize financial services company that has its headquarters in London and offices in New York and San Francisco.

Contoso hosts its computing environment exclusively in its on-premises data centers, and containerizes most of its workloads on Kubernetes running on a third-party virtualization platform. Despite its fully modernized environment, Contoso has capacity and agility constraints that are inherent to on-premises infrastructures. It's also become increasingly difficult to consistently manage the growing number of Kubernetes clusters.

Contoso is migrating a large amount of its containerized workloads to the cloud. It's considering Azure as its main deployment target, primarily because of the Azure Kubernetes Service<!-- This is the only place in this doc where we mention AKS. Should this be a different product name? --> advantages and Azure Arc's extensive hybrid benefits. This includes its centralized, multi-platform management capabilities. However, IT management wants to avoid single-vendor dependency by leveraging multiple cloud providers.

Azure Arc is in preview mode, so you are tasked with exploring and evaluating its capabilities with respect to Kubernetes-based workloads. You must determine how Contoso can benefit from its hybrid management model while pursuing a multi-vendor strategy and maintaining some on-premises containerized workloads.

## Second unit: What are Kubernetes and Azure Arc?

**Type of unit:** Learning content unit

**Estimated unit duration:** 9 minutes

### Key content per learning objective

After you complete this unit, you&#39;ll be able to describe the basic characteristics and capabilities of:

- Kubernetes, with respect to Azure Arc based management.
- Azure Arc, with respect to Kubernetes-based workloads.

## Third unit: What are the architecture, components, and characteristics of Azure Arc enabled Kubernetes?

**Type of unit:** Learning content unit

**Estimated unit duration:** 4 minutes

### Key content per learning objective

After you complete this unit, you&#39;ll be able to describe the architecture, components, and characteristics of Azure Arc enabled Kubernetes. Unit topics include:

- Azure Arc enabled Kubernetes architecture and components
- Azure Arc enabled Kubernetes characteristics

## Fourth unit: Connect Kubernetes clusters to Azure Arc<!-- If it's an Exercise, It's written in the other mods as "Fourth unit: Exercise&mdash;Connect Kubernetes clusters to Azure Arc." -->

**Type of unit:** Learning content unit

**Estimated unit duration:** 5 minutes

### Learning objective(s) targeted<!-- Should this be "Key content per learning objective," like the units above? If so, please search & replace the following instances as well.-->

After you complete this unit, you&#39;ll be able to connect Kubernetes clusters to Azure Arc by using Azure CLI.

## Fifth unit: Apply Azure Arc enabled Kubernetes cluster configurations by using GitOps

**Type of unit:** Learning content unit

**Estimated unit duration:** 6 minutes

### Learning objective(s) targeted

After you complete this unit, you&#39;ll be able to apply Azure Arc enabled Kubernetes cluster configurations by using GitOps. Unit topics include:

- GitOps
- Concept video: Demonstration, end-to-end GitOps flow on Azure Arc enabled Kubernetes clusters
- Apply Azure Arc enabled Kubernetes cluster configurations by using GitOps

## Sixth unit: Integrate an Azure Arc enabled Kubernetes cluster with Azure Policy for Kubernetes

**Type of unit:** Learning content unit

**Estimated unit duration:** 9 minutes

### Learning objective(s) targeted

After you complete this unit, you&#39;ll be able to use Azure Policy to enforce and audit Azure Arc enabled Kubernetes cluster configurations. Unit topics include:

- Azure Policy in the context of Azure Arc enabled Kubernetes<!-- "Azure Arc enabled Kubernetes with Azure Policy?" -->
- Enforce and audit Azure Arc enabled Kubernetes cluster configurations by using Azure Policy

## Seventh unit: Use GitOps to deploy containerized applications to Azure Arc enabled Kubernetes clusters

**Type of unit:** Learning content unit

**Estimated unit duration:** 6 minutes

### Learning objective(s) targeted

After you complete this unit, you&#39;ll be able to deploy containerized applications to Azure Arc enabled Kubernetes clusters by using GitOps. Unit topics include:

- Helm charts
- Deploy containerized applications to Azure Arc enabled Kubernetes clusters by using GitOps

## Eighth unit: Integrate an Azure Arc enabled Kubernetes cluster with Azure Monitor

**Type of unit:** Learning content unit

**Estimated unit duration:** 5 minutes

### Learning objective(s) targeted

After you complete this unit, you&#39;ll be able to integrate an Azure Arc enabled Kubernetes cluster with Azure Monitor. Unit topics include:

- Azure Monitor
- Integrate an Azure Arc enabled Kubernetes cluster with Azure Monitor

## Ninth unit: Summary

**Type of unit:** Summary unit

**Estimated unit duration:** 3 minutes

### Resolution of module problem

Contoso can now use Azure Arc to implement a hybrid management model while using a multi-vendor strategy and maintaining some on-premises containerized workloads.

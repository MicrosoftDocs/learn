---
title: Introduction to infrastructure threat modeling
description: Get started with threat modeling your infrastructure.
author: rodrigosantos
ms.author: rodsan
ms.date: 03/01/2021
ms.prod: non-product-specific
ms.topic: how-to
ms.custom: infrastructure-threat-modeling-security-guide
ms.customer.intent: As an IT professional, I need to learn how to secure my infrastructure by using threat modeling.
---

As we learned in the [Threat Modeling Security Fundamentals Learning Path](https://docs.microsoft.com/en-us/learn/modules/tm-introduction-to-threat-modeling), threat modeling is an effective technique to help secure your systems, applications, networks, and services. It can also help secure your company infrastructure.

Infrastructure threat modeling uses a data-flow diagram to show how data flows in the enterprise. It also shows how it's protected at each stage in the lifecycle.

The process uses security policies with the threat modeling framework to help you find and fix security infrastructure issues.

## Threat Modeling Framework

The threat modeling framework is flexible, and can be easily used for your infrastructure. Let's revisit the framework found in our [Threat Modeling Security Fundamentals Learning Path](https://docs.microsoft.com/en-us/learn/modules/tm-introduction-to-threat-modeling):

### Threats

#### Spoofing

- **What it means:** Pretend to be a part of the company to access enterprise data.
- **Affected elements:** Process and external entities.
- **How to eliminate this threat:** Use authentication to confirm each identity.

#### Tampering

- **What it means:** Change enterprise data without permission.
- **Affected elements:** Process, data store, and data-flow.
- **How to eliminate this threat:** Use integrity to prevent data modification.

#### Repudiation

- **What it means:** Hide sensitive actions to avoid repercussions.
- **Affected elements:** Process, external entity, and data store.
- **How to eliminate this threat:** Use non-repudiation to tie every action to their users.

#### Information disclosure

- **What it means:** Read enterprise data without permission.
- **Affected elements:** Process, data store, and data-flow.
- **How to eliminate this threat:** Use confidentiality to protect data against unintended disclosure.

#### Denial of service

- **What it means:** Bring the enterprise down.
- **Affected elements:** Process, data store, and data-flow
- **How to eliminate this threat:** Use availability to ensure the enterprise can handle each request.

#### Elevation of privilege

- **What it means:** Elevate permissions without authorization.
- **Affected elements:** Process.
- **How to eliminate this threat:** Use authorization to verify each user has permissions to carry out a request.

## Security Domains

The security domains discussed in this module are similar to the ones used by Microsoft.

They can also be mapped to requirements from well-known institutions, such as the International Organization of Standardization (ISO) and the U.S. National Institute of Standards and Technology (NIST):

|Security Domain|What it means|
|---------------|-------------|
|![Access Control domain](../media/AccessControl-small.svg)</br>Access control|Which employees have access to which resources? How do they get that type of access? What do they go through to access those resources?|
|![Secure Development domain](../media/SecureDevelopment-small.svg)</br>Secure development|How is engineering work protected? Where is it stored?|
|![Business Continuity domain](../media/BusinessContinuity-small.svg)</br>Business continuity|What happens during an outage? How can the impact be reduced?|
|![Cryptography domain](../media/Cryptography-small.svg)</br>Cryptography|How is data protected at-rest, in-transit, and in-use?|
|![Asset Management domain](../media/Asset-small.svg)</br>Asset management|How is data protected and managed?|
|![Legal domain](../media/Legal-small.svg)</br>Legal|What are the legal and regulatory obligations for both employees and the company?|
|![Incident Response domain](../media/IncidentResponse-small.svg)</br>Incident response|How are incidents handled for both the enterprise and product?|
|![Network domain](../media/Network-small.svg)</br>Network|How is the network protected?|
|![Operations domain](../media/Operations-small.svg)</br>Operations|How is security integrated with daily operations?|
|![Physical and environmental domain](../media/Physical-small.svg)</br>Physical and environmental|How are people, assets, and facilities protected?|
|![Governance domain](../media/Governance-small.svg)<br>Governance|What does the enterprise strategic direction look like? How is risk managed?|
|![Security architecture domain](../media/SecurityArchitecture-small.svg)|Security architecture</br>What are the enforced security baselines? How do platforms work securely together?|
|![Supplier risk domain](../media/Supplier-small.svg)</br>Supplier risk|How does the company know who to do business with? How do they enforce supplier security and support?|

## When should I threat model my infrastructure?

Infrastructure threat modeling is ideally done before the infrastructure goes live, and then again each time a component is added or changed. Examples include:

- A small, early stage tech start-up is building their infrastructure from scratch.
- A small brick-and-mortar retailer is expanding to their online customer base.
- A gaming studio is adding a domain controller to centralize access and manage assets.

## Who can threat model the infrastructure?

Any IT professional with a basic understanding of security can create an infrastructure threat model.

However, the breadth of the infrastructure threat modeling work requires input from professionals in the legal, human resources, and other departments.

When completed, this exercise will help you identify and incorporate missing security requirements and controls.

## Learning objectives

In this module, you'll explore the four steps in the infrastructure threat modeling process and be able to:

- Understand the importance of a well defined, open-ended questionnaire to get a better view of the infrastructure.
- Visualize how each component interacts with the other with a detailed data-flow diagram.
- Identify infrastructure security gaps using a combination of security policies and the threat modeling framework.
- Reduce or eliminate risk with known security requirements and controls.

## Prerequisites

- [Threat Modeling Security Fundamentals Learning Path](https://docs.microsoft.com/en-us/learn/modules/tm-introduction-to-threat-modeling)
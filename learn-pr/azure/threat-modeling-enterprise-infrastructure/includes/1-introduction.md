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

The process helps you find ways to reduce or eliminate risk using security policy-based assessment questions and the threat modeling framework.

## Threat Modeling Framework

The threat modeling framework is flexible, and can be easily used for your infrastructure. Let's revisit the framework, which is primarily found in our [Threat Modeling Security Fundamentals Learning Path](https://docs.microsoft.com/en-us/learn/modules/tm-introduction-to-threat-modeling):

### Threats

|Threat|Security control|Affected elements|
|------|----------------|-----------------|
|![Spoofing](../media/threats/spoofing50.png)</br>**Spoofing** is when you pretend to be someone in a company to access their data.|![Authentication](../media/threats/authn50.png)</br>**Authenticate** everyone using strong authentication methods, like multi-factor authentication.|![Process](../media/elements/process25.png)</br>Process</br></br>![External entity](../media/elements/external-entity25.png)</br>External entity|
|![Tampering](../media/threats/tampering50.png)</br>**Tampering** is when you change enterprise data without permission|![Integrity](../media/threats/integrity50.png)</br>Prevent data modification by using available **integrity** methods, like encryption.|![Process](../media/elements/process25.png)</br>Process</br></br>![Data store](../media/elements/data-store25.png)</br>Data store</br></br>![Data-flow](../media/elements/data-flow25.png)</br>Data-flow|
|![Repudiation](../media/threats/repudiation50.png)</br>**Repudiation** is when you hide sensitive actions from the enterprise to avoid repercussions.|![Non-repudiation](../media/threats/non-repudiation50.png)</br>Use **non-repudiation** methods to tie users to their actions, like security logging and monitoring.|![Process](../media/elements/process25.png)</br>Process</br></br>![External entity](../media/elements/external-entity25.png)</br>External entity</br></br>![Data store](../media/elements/data-store25.png)</br>Data store|
|![Information disclosure](../media/threats/info-disclosure50.png)</br>**Information disclosure** is when you read or share enterprise data without permission.|![Confidentiality](../media/threats/confidentiality50.png)</br>Enforce **confidentiality** to protect data against unintended disclosure, like Data Leakage Prevention (DLP) systems.|![Process](../media/elements/process25.png)</br>Process</br></br>![Data store](../media/elements/data-store25.png)</br>Data store</br></br>![Data-flow](../media/elements/data-flow25.png)</br>Data-flow|
|![Denial of service](../media/threats/dos50.png)</br>**Denial of service** is when you bring the enterprise down.|![Availability](../media/threats/availability50.png)</br>Use **availability** mechanisms to ensure the enterprise handles each request, like elastic resources and other resiliency strategies.|![Process](../media/elements/process25.png)</br>Process</br></br>![Data store](../media/elements/data-store25.png)</br>Data store</br></br>![Data-flow](../media/elements/data-flow25.png)</br>Data-flow|
|![Elevation of privilege](../media/threats/eop50.png)</br>**Elevation of privilege** is when you unlawfully access resources above your permission level.|![Authorization](../media/threats/authz50.png)</br>Use **authorization** mechanisms to ensure each user has the right permissions to carry out their requests, like Access Control Lists (ACL).|![Process](../media/elements/process25.png)</br>Process|

## Security Domains

The security domains discussed in this module are similar to the ones used by Microsoft.

They can also be mapped to requirements from well-known institutions, such as the International Organization of Standardization (ISO) and the U.S. National Institute of Standards and Technology (NIST):

|Security Domain|What it means|
|---------------|-------------|
|![Access Control domain](../media/policies/AccessControl-small.svg)</br>Access control|Learn how the enterprise grants, manages, and revokes access to resources. Also, understand the process employees go through to access those resources.|
|![Secure Development domain](../media/policies/SecureDevelopment-small.svg)</br>Secure development|Discover how engineering work is managed, secured, and stored.|
|![Business Continuity domain](../media/policies/BusinessContinuity-small.svg)</br>Business continuity|Learn what happens to the enterprise during an outage and what they do to reduce impact.|
|![Cryptography domain](../media/policies/Cryptography-small.svg)</br>Cryptography|Find out how data is protected at-rest, in-transit, and in-use.|
|![Asset Management domain](../media/policies/Asset-small.svg)</br>Asset management|Uncover how physical and logical assets are created, managed, and retired.|
|![Legal domain](../media/policies/Legal-small.svg)</br>Legal|Understand the legal and regulatory obligations for both employees and the company.|
|![Incident Response domain](../media/policies/IncidentResponse-small.svg)</br>Incident response|Learn how incidents are handled for both the enterprise and product.|
|![Network domain](../media/policies/Network-small.svg)</br>Network|Discover how the network is protected against security threats.|
|![Operations domain](../media/policies/Operations-small.svg)</br>Operations|Learn how well security is integrated with daily operations.|
|![Physical and environmental domain](../media/policies/Physical-small.svg)</br>Physical and environmental|Discover how people, assets, and facilities are protected against security or environmental threats.|
|![Governance domain](../media/policies/Governance-small.svg)<br>Governance|Find out what the strategic direction for the enterprise looks like. Also, learn how they manage security risks.|
|![Security architecture domain](../media/policies/SecurityArchitecture-small.svg)</br>Security architecture|Confirm how security baselines are created, managed, and enforced. Also, discover how different platforms securely work together.|
|![Supplier risk domain](../media/policies/Supplier-small.svg)</br>Supplier risk|Learn how does the company decides who to do business with. Also, find out how they enforce supplier security and support.|

## When should I threat model my infrastructure?

Infrastructure threat modeling is ideally done before the infrastructure goes live, and then again each time a component is added or changed. Examples include:

- A small, early stage tech start-up building their infrastructure from scratch.
- A small brick-and-mortar retailer expanding to their online customer base.
- A gaming studio adding a domain controller to centralize access and manage assets.

## Who can threat model the infrastructure?

Any IT professional with a basic understanding of security can create an infrastructure threat model.

They will work with people from other divisions, like legal, human resources, and finance, to get a better picture of the current state-of-security.

When completed, this exercise will help you identify and incorporate missing security requirements and controls across the enterprise.

## Learning objectives

In this module, you'll explore the four steps in the infrastructure threat modeling process and be able to:

- Understand the importance of a well defined, open-ended questionnaire to get a better view of the infrastructure.
- Visualize how each component interacts with the other with a detailed data-flow diagram.
- Identify infrastructure security gaps using a combination of security policies and the threat modeling framework.
- Reduce or eliminate risk with known security requirements and controls.

## Prerequisites

- [Threat Modeling Security Fundamentals Learning Path](https://docs.microsoft.com/en-us/learn/modules/tm-introduction-to-threat-modeling)
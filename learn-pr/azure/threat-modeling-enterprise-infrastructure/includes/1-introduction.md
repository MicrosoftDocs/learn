As we learned in the [Threat Modeling Security Fundamentals Learning Path](https://docs.microsoft.com/en-us/learn/modules/tm-introduction-to-threat-modeling), threat modeling is an effective technique to help secure your systems, applications, networks, and services. It can also help secure your company infrastructure.

Infrastructure threat modeling uses a data-flow diagram to show how data flows in the enterprise. It also shows how it's protected at each stage in the lifecycle.

The process uses security policies with the threat modeling framework to help you find and fix infrastructure issues.

## Threat Modeling Framework

The threat modeling framework is flexible. It can easily be used for your infrastructure. Here's a refresher from the first learning path:

|Category|What it means|
|--------|-------------|
|Spoofing|Who can I pretend to be to gain access to enterprise data?|
|Tampering|What changes can I make to enterprise data without permission?|
|Repudiation|How can I hide my actions to avoid repercussions?|
|Information disclosure|How can I read enterprise data without permission?|
|Denial of service|What can I do to bring the enterprise down?|
|Elevation of privilege|How do I elevate my permissions without being authorized to do so?|

## Security Domains

The security domains discussed in this module are similar to the ones used by Microsoft.

They can also be mapped to requirements from well-known institutions, such as the International Organization of Standardization (ISO) and the U.S. National Institute of Standards and Technology (NIST):

|Icon|Security Domain|What it means|
|----|---------------|-------------|
|![Access Control domain](../media/AccessControl-small.svg)|Access control|Which employees have access to which resources? How do they get that type of access? What do they go through to access those resources?|
|![Secure Development domain](../media/SecureDevelopment-small.svg)|Secure development|How is engineering work protected? Where is it stored?|
|![Business Continuity domain](../media/BusinessContinuity-small.svg)|Business continuity|What happens during an outage? How can the impact be reduced?|
|![Cryptography domain](../media/Cryptography-small.svg)|Cryptography|How is data protected at-rest, in-transit, and in-use?|
|![Asset Management domain](../media/Asset-small.svg)|Asset management|How is data protected and managed?|
|![Legal domain](../media/Legal-small.svg)|Legal|What are the legal and regulatory obligations for both employees and the company?|
|![Incident Response domain](../media/IncidentResponse-small.svg)|Incident response|How are incidents handled for both the enterprise and product?|
|![Network domain](../media/Network-small.svg)|Network|How is the network protected?|
|![Operations domain](../media/Operations-small.svg)|Operations|How is security integrated with daily operations?|
|![Physical and environmental domain](../media/Physical-small.svg)|Physical and environmental|How are people, assets, and facilities protected?|
|![Governance domain](../media/Governance-small.svg)|Governance|What does the enterprise strategic direction look like? How is risk managed?|
|![Security architecture domain](../media/SecurityArchitecture-small.svg)|Security architecture|What are the enforced security baselines? How do platforms work securely together?|
|![Supplier risk domain](../media/Supplier-small.svg)|Supplier risk|How does the company know who to do business with? How do they enforce supplier security and support?|

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
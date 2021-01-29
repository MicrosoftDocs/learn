As we learned in the [Threat Modeling Security Fundamentals Learning Path](https://docs.microsoft.com/en-us/learn/modules/tm-introduction-to-threat-modeling), threat modeling is an effective technique to help secure your systems, applications, networks, and services. It can also help secure your company infrastructure.

Infrastructure threat modeling uses a data-flow diagram to show how data flows in the enterprise. It also shows how it's protected at each stage in the lifecycle.

The threat model process uses a combination of security policies with the threat modeling framework to help you find and fix infrastructure issues.

## Threat Modeling Framework

As we learned in the first learning path, the threat modeling framework is flexible, and can easily be used for the infrastructure. Here's what it looks like:

|Category|What it means|
|--------|-------------|
|Spoofing|How can I pretend to be someone or something else to get access?|
|Tampering|What sensitive changes can I make to data without authorization?|
|Repudiation|How can I hide my actions to avoid repercussions?|
|Information disclosure|Where can I go to see data without permission?|
|Denial of service|What can I do to bring the infrastructure down?|
|Elevation of privilege|How do I get permissions I shouldn't have?|

## Security Domains

The security domains discussed in this module are similar to the ones used by Microsoft.

They can also be mapped to requirements from well-known institutions, such as the International Organization of Standardization (ISO) and the U.S. National Institute of Standards and Technology (NIST):

|Icon|Security Domain|What it means|
|----|---------------|-------------|
|![Access Control domain](../media/AccessControl-small.svg)|Access control|Who has access to what? How do they get access? What do they do to get access?|
|![Secure Development domain](../media/SecureDevelopment-small.svg)|Secure development|How is all engineering work protected? Where is it stored?|
|![Business Continuity domain](../media/BusinessContinuity-small.svg)|Business continuity|What happens during an outage? How is an outage impact reduced?|
|![Cryptography domain](../media/Cryptography-small.svg)|Cryptography|How is data protected at-rest, in-transit, and in-use?|
|![Asset Management domain](../media/Asset-small.svg)|Asset management|How is data protected and managed?|
|![Legal domain](../media/Legal-small.svg)|Legal|What are the legal and regulatory obligations for both employees and the company?|
|![Incident Response domain](../media/IncidentResponse-small.svg)|Incident response|How are incidents handled for both the enterprise and product?|
|![Network domain](../media/Network-small.svg)|Network|How is the network protected?|
|![Operations domain](../media/Operations-small.svg)|Operations|How is security integrated with the daily operations?|
|![Physical and environmental domain](../media/Physical-small.svg)|Physical and environmental|How are people, assets, and facilities protected?|
|![Governance domain](../media/Governance-small.svg)|Governance|What does the enterprise strategic direction look like? How is risk managed?|
|![Security architecture domain](../media/SecurityArchitecture-small.svg)|Security architecture|What are the enforced security baselines? How do platforms work securely together?|
|![Supplier risk domain](../media/Supplier-small.svg)|Supplier risk|Who to do business with? How to enforce security and support?|

## When should I threat model my infrastructure?

Infrastructure threat modeling is done before an infrastructure goes live, and again each time a component is added or changed. Examples include:

- A small, early stage tech start-up is building their infrastructure from scratch.
- A small brick-and-mortar retailer is expanding to their online customer base.
- A gaming studio is adding a domain controller to centralize access and manage assets.

## Who can threat model the infrastructure?

Any IT professional with a basic understanding of security can create an infrastructure threat model.

However, the breadth of the infrastructure threat modeling work requires input from professionals in the legal, human resources, and other departments.

When completed, this exercise will help you identify and incorporate security requirements that may be missing.

## Learning objectives

In this module, you'll explore the four steps in the infrastructure threat modeling process and be able to:

- Understand the importance of a well defined, open-ended questionnaire to get a better view of the infrastructure.
- Visualize how each component interacts with the other with a detailed data-flow diagram.
- Identify infrastructure security gaps using a combination of security policies and the threat modeling framework.
- Reduce or eliminate risk with known security controls.

## Prerequisites

- [Threat Modeling Security Fundamentals Learning Path](https://docs.microsoft.com/en-us/learn/modules/tm-introduction-to-threat-modeling)
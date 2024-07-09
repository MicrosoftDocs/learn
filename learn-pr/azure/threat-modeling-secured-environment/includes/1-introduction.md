As we learned in the [Threat Modeling Security Fundamentals Learning Path](/training/modules/tm-introduction-to-threat-modeling/), threat modeling is an effective technique to help secure your systems, applications, networks, and services. It also helps you assess applications to use across [Privileged Access Workstations (PAW)](/security/compass/privileged-access-devices).

PAW is a device used for administrative functions and critical asset management tasks, such as:

- Changes to a domain controller.
- Access to a highly sensitive database.
- Termination of a critical resource.

The sensitive nature of these tasks requires multiple layers of security controls to help prevent malicious attacks. Examples include:

- Exclusive use of alternate credentials and associated smart cards in the environment.
- Restrictive password policies.
- Prohibited use of local administrative accounts.
- Device configuration change restrictions.
- Blocked usage of applications not previously approved by the security team.

Before the application is installed in a PAW, it needs to go through a security review process. It helps to identify potential threats and find ways to reduce or eliminate risk.

## Threat Modeling Framework

The threat modeling framework is flexible and helps to identify how an application integrates with the secured environment. It relies on the STRIDE methodology to find potential risks.

|Threat|Security control|Affected elements|
|------|----------------|-----------------|
|![Spoofing.](../media/threats/spoofing-50.png)</br>**Spoofing** is when you pretend to be a person or process to gain access to the secured environment.|![Authentication](../media/threats/authentication-50.png)</br>**Authenticate** everyone using multi-factor authentication, and use only alternate accounts for administrative tasks.|![Process](../media/elements/process-25.png)</br>Process</br></br>![External entity](../media/elements/external-entity-25.png)</br>External entity|
|![Tampering.](../media/threats/tampering-50.png)</br>**Tampering** is when you change data without permission.|![Integrity](../media/threats/integrity-50.png)</br>Prevent data modification by using available **integrity** methods, like encryption.|![Process](../media/elements/process-25.png)</br>Process</br></br>![Data store](../media/elements/data-store-25.png)</br>Data store</br></br>![Data-flow](../media/elements/data-flow-25.png)</br>Data-flow|
|![Repudiation.](../media/threats/repudiation-50.png)</br>**Repudiation** is when you hide sensitive actions made on the device to avoid repercussions.|![Non-repudiation](../media/threats/non-repudiation-50.png)</br>Use **non-repudiation** methods to tie users to their actions, like security logging and monitoring.|![Process](../media/elements/process-25.png)</br>Process</br></br>![External entity](../media/elements/external-entity-25.png)</br>External entity</br></br>![Data store](../media/elements/data-store-25.png)</br>Data store|
|![Information disclosure.](../media/threats/info-disclosure-50.png)</br>**Information disclosure** is when the application is used as a way to read or share enterprise data without permission.|![Confidentiality](../media/threats/confidentiality-50.png)</br>Enforce **confidentiality** to protect data against unintended disclosure, like Data Leakage Prevention (DLP) systems, and detective or preventive mechanisms, like firewalls and anomalous monitoring systems.|![Process](../media/elements/process-25.png)</br>Process</br></br>![Data store](../media/elements/data-store-25.png)</br>Data store</br></br>![Data-flow](../media/elements/data-flow-25.png)</br>Data-flow|
|![Denial of service.](../media/threats/denial-of-service-50.png)</br>**Denial of service** is when you bring the application down.|![Availability](../media/threats/availability-50.png)</br>Use **availability** mechanisms to ensure the application handles each request using resiliency strategies.|![Process](../media/elements/process-25.png)</br>Process</br></br>![Data store](../media/elements/data-store-25.png)</br>Data store</br></br>![Data-flow](../media/elements/data-flow-25.png)</br>Data-flow|
|![Elevation of privilege.](../media/threats/elevation-of-privilege-50.png)</br>**Elevation of privilege** is when you unlawfully access resources above your permission level, often through a pre-existing flaw or attack vector in the application.|![Authorization](../media/threats/authorization-50.png)</br>Use **authorization** mechanisms to ensure each user has the right (and least) number of permissions to carry out their requests, like Access Control Lists (ACL) and least-privilege access.|![Process](../media/elements/process-25.png)</br>Process|

> [!TIP]
> Visit the [Threat Modeling Security Fundamentals learning path](/training/modules/tm-introduction-to-threat-modeling/) for more information on the framework.

## When should I threat model an application to be used in my secured environment?

You need to threat model an application before installing it in a secured environment.

> [!IMPORTANT]
> In addition to the initial review, don't forget to threat model the application before updating it to a new version, or if it has been associated with a vulnerability.

## Who can threat model an application to be used in a secured environment?

Any IT security professional or security engineer with a basic understanding of security.

Give priority to IT security professionals or the security team directly involved with managing the secured environment, as they may already be familiar with common security risks.

> [!TIP]
> If you can, try to keep those wanting to use the application (e.g., IT admins) separated from those assessing it (e.g., IT security professional or engineer).

## Why do I have to take an application through this process?

The secured environment holds the keys to your enterprise kingdom. In most cases, it's the only way to make changes to critical resources that affect both employees and customers.

A vulnerable application allows an attacker to access critical resources that can cause irreversible damages to customer data and the company. What seems to be harmless at first, like a browser plugin to help you keep track of visited web pages, can potentially be weaponized to capture and send every keystroke from your device to an attacker.

## Learning objectives

In this module, you explore the four steps in the threat modeling process for an application to be used in a secured environment. By the end of this module, you can:

- Understand the importance of a well defined, open-ended questionnaire to get a better view of the application.
- Visualize how the application interacts with the secured environment with a detailed data-flow diagram.
- Identify security gaps using the threat modeling framework.
- Reduce or eliminate risks with known security requirements and controls.

## Prerequisites

- [Threat Modeling Security Fundamentals Learning Path](/training/modules/tm-introduction-to-threat-modeling/)

## Application threat analysis

Do a comprehensive analysis to identify threats, attacks, vulnerabilities, and counter measures. Having this information can protect the application and threats it might pose to the system. Start with simple questions to gain insight into potential risks. Then, progress to advanced techniques using threat modeling.

## 1- Gather information about the basic security controls

A threat modeling tool produces a report of all threats identified. This report is typically uploaded into a tracking tool, or converted to work items that can be validated and addressed by the developers. As new features are added to the solution, the threat model should be updated and integrated into the code management process. If a security issue is found, there should be a process to triage issue severity and determine when and how to remediate (such as in the next release cycle, or a faster release).

Start by gathering information about each component of the application. The answers to these questions identify gaps in basic protection and clarify the attack vectors.

|Ask this question ...|To determine controls that ...|
|---|---|
|Are connections authenticated using Azure AD, TLS (with mutual authentication), or another modern security protocol approved by the security team?<br><br>- Between users and the application<br><br>- Between different application components and services|Prevent unauthorized access to the application component and data.|
|Are you limiting access to only those accounts that have the need to write or modify data in the application| Prevent unauthorized data tampering or alteration.|
|Is the application activity logged and fed into a Security Information and Event Management (SIEM) through Azure Monitor or a similar solution?|Detect and investigate attacks quickly.|
|Is critical data protected with encryption that has been approved by the security team?| Prevent unauthorized copying of data at rest.|
|Is inbound and outbound network traffic encrypted using TLS?|Prevent unauthorized copying of data in transit.|
|Is the application protected against Distributed Denial of Service (DDoS) attacks using services such as Azure DDoS protection?|Detect attacks designed to overload the application so it can't be used.|
|Does the application store any sign-in credentials or keys to access other applications, databases, or services?| Identify whether an attack can use your application to attack other systems.|
|Do the application controls allow you to fulfill regulatory requirements?| Protect user's private data and avoid compliance fines.|

**Suggested actions**

Assign tasks to the individual people who are responsible for a particular risk identified during threat modeling.

## 2- Evaluate the application design progressively

Analyze application components and connections and their relationships. Threat modeling is a crucial engineering exercise that includes defining security requirements, identifying and mitigating threats, and validating those mitigations. This technique can be used at any stage of application development or production, but it's most effective during the design stages of a new functionality.

Popular methodologies include:

-   [STRIDE](https://learn.microsoft.com/azure/security/develop/threat-modeling-tool-threats):
    -   Spoofing
    -   Tampering
    -   Repudiation
    -   Information Disclosure
    -   Denial of Service
    -   Elevation of Privilege

Microsoft Security Development Lifecycle uses STRIDE and provides a tool to assist with this process. For more information, see [Microsoft Threat Modeling Tool](https://www.microsoft.com/securityengineering/sdl/threatmodeling).

- [Open Web Application Security Project (OWASP)](https://owasp.org/www-community/Threat_Modeling_Process) has documented a threat modeling approach for applications.

Integrate threat modeling through automation using secure operations. Here are some resources:
- Toolkit for [Secure DevOps on Azure](https://azsk.azurewebsites.net/).
- [Guidance on DevOps pipeline security](https://owasp.org/www-project-devsecops-guideline/) by OWASP.

## 3- Mitigate the identified threats

The threat modeling tool produces a report of all the threats identified. After a potential threat is identified, determine how it can be detected and the response to that attack. Define a process and timeline that minimizes exposure to any identified vulnerabilities in the workload, so that those vulnerabilities can't be left unaddressed.

Use the _Defense-in-Depth_ approach. This can help identify controls needed in the design to mitigate risk if a primary security control fails. Evaluate how likely it is for the primary control to fail. If it does, what is the extent of the potential organizational risk? Also, what is the effectiveness of the other control (especially in cases that would cause the primary control to fail). Based on the evaluation apply Defense-in-Depth measures to address potential failures of security controls.

The principle of _least privilege_ is one way of implementing Defense-in-Depth. It limits the damage that can be done by a single account. Grant least number of privileges to accounts that allows them to accomplish with the required permissions within a time period. This helps mitigate the damage of an attacker who gains access to the account to compromise security assurances.

There's often a disconnect between organizational leadership and technical teams regarding business requirements for critical workloads. This can create undesired outcomes and is especially sensitive when it pertains to information security. Routinely reviewing business critical workload requirements with executive sponsors to define requirements provides an opportunity to align expectations and ensure operational resource allocation to the initiative.

**How are threats addressed once found?**

Here are some best practices:

- Make sure the results are communicated to the interested teams.
- Prioritize the vulnerabilities and fix the most important in a timely manner.
- Upload the threat modeling report to a tracking tool. Create work items that can be validated and addressed by the developers. Cyber security teams can also use the report to determine attack vectors during a penetration test.
- As new features are added to the application, update the threat model report and integrate it into the code management process. Triage security issues into the next release cycle or a faster release, depending on the severity.

For information about mitigation strategies, see [RapidAttack](https://learn.microsoft.com/security/compass/human-operated-ransomware).

## Overview of Microsoft Threat Modeling tool

The Threat Modeling Tool is a core element of the Microsoft Security Development Lifecycle (SDL). It allows software architects to identify and mitigate potential security issues early, when they're relatively easy and cost-effective to resolve. As a result, it greatly reduces the total cost of development. Also, we designed the tool with nonsecurity experts in mind, making threat modeling easier for all developers by providing clear guidance on creating and analyzing threat models.

The tool enables anyone to:

- Communicate about the security design of their systems
- Analyze those designs for potential security issues using a proven methodology
- Suggest and manage mitigations for security issues

Here are some tooling capabilities and innovations, just to name a few:

- Automation: Guidance and feedback in drawing a model
- STRIDE per Element: Guided analysis of threats and mitigations
- Reporting: Security activities and testing in the verification phase
- Unique Methodology: Enables users to better visualize and understand threats
- Designed for Developers and Centered on Software: many approaches are centered on assets or attackers. We're centered on software. We build on activities that all software developers and architects are familiar with, like drawing pictures for their software architecture
- Focused on Design Analysis: The term "threat modeling" can refer to either a requirements or a design analysis technique. Sometimes, it refers to a complex blend of the two. The Microsoft SDL approach to threat modeling is a focused design analysis technique

For more information on getting started with the tool, see [Getting started with the Threat Modeling Tool](https://learn.microsoft.com/azure/security/develop/threat-modeling-tool-getting-started).

There's no easy solution that solves all your problems from a security perspective. Let's imagine you work for an organization that has neglected security in its environment. The company has realized that it needs to put some major focus in this area. The company isn't sure where to start, or if it's possible to just buy a solution to make the environment secure. The company knows it needs a holistic approach but is unsure what fits into that. 

Here, we'll identify key concepts of defense in depth and identify key security technologies and approaches to support a defense-in-depth strategy. We'll also discuss how to apply these concepts when you're architecting your own Azure services.

## Zero Trust model

The analyst firm Forrester Research introduced the *Zero Trust model*, which states that you should never assume trust but instead continually validate trust. When users, devices, and data all resided inside the organization's firewall, they were assumed to be trusted. This assumed trust allowed for easy lateral movement after a malicious hacker compromised an endpoint device.

Most users now access applications and data from the internet, and many companies now allow users to use their own devices at work (*bring your own device*, or BYOD). Most components of the transactions--the users, network, and devices--are no longer completely under organizational control. The Zero Trust model relies on verifiable user and device trust claims to grant access to organizational resources. No longer is trust assumed based on the location inside an organization's perimeter.

This model has forced security researchers, engineers, and architects to rethink the approach applied to security and use a layered strategy to protect their resources.

## Defense in depth: A layered approach to security

*Defense in depth* is a strategy that employs a series of mechanisms to slow the advance of an attack that's aimed at acquiring unauthorized access to information. Each layer provides protection so that if one layer is breached, a subsequent layer is already in place to prevent further exposure. 

Microsoft applies a layered approach to security, both in its physical datacenters and across Azure services. The objective of defense in depth is to protect information and prevent it from being stolen by individuals who aren't authorized to access it. The common principles that help define a security posture are confidentiality, integrity, and availability, known collectively as CIA.

- **Confidentiality**: The principle of least privilege restricts access to information only to individuals explicitly granted access. This information includes protection of user passwords, remote access certificates, and email content.

- **Integrity**: The goal is to prevent unauthorized changes to information at rest or in transit. A common approach used in data transmission is for the sender to create a unique fingerprint of the data by using a one-way hashing algorithm. The hash is sent to the receiver along with the data. The receiver recalculates the data's hash and compares it to the original to ensure that the data wasn't lost or modified in transit.

- **Availability**: Ensure that services are available to authorized users. Denial-of-service attacks are a common cause of loss of availability to users. Natural disasters also drive system design to prevent single points of failure and deploy multiple instances of an application to geo-dispersed locations.

## Security layers

You can visualize defense in depth as a set of concentric rings, with the data to be secured at the center. Each ring adds a layer of security around the data. This approach removes reliance on any single layer of protection. It also acts to slow down an attack and provide alert telemetry that can be acted upon, either automatically or manually. 

Let's look at each of the layers.

![Illustration of defense in depth with data at the center. The rings of security around data are: application, compute, network, perimeter, identity and access, and physical security.](../media/2-defense-in-depth.png)

Each layer can implement one or more of the CIA concerns:

|#|Ring|Example|Principle
|---|---|---|---|
|1|Data|Data encryption at rest in Azure Blob Storage|Integrity|
|2|Application|SSL/TLS encrypted sessions|Integrity|
|3|Compute|Regular application of OS and layered software patches|Availability|
|4|Network|Network security rules|Confidentiality|
|5|Perimeter|DDoS protection|Availability|
|6|Identity and access|Azure Active Directory user authentication|Integrity|
|7|Physical security|Azure datacenter biometric access controls|Confidentiality|

### Data

In almost all cases, attackers are after data:

- Stored in a database.
- Stored on disk inside virtual machines.
- Stored on a software as a service (SaaS) application such as Microsoft 365.
- Stored in cloud storage.

The people who store and control access to data are responsible for ensuring that it's properly secured. Often, regulatory requirements dictate the controls and processes that must be in place to ensure the confidentiality, integrity, and availability of the data.

### Applications

- Ensure that applications are secure and free of vulnerabilities.
- Store sensitive application secrets in a secure storage medium.
- Make security a design requirement for all application development.

Integrating security into the application development life cycle will help reduce the number of vulnerabilities introduced in code. Encourage all development teams to make their applications secure by default. Make security requirements non-negotiable.

### Compute

- Secure access to virtual machines.
- Implement endpoint protection and keep systems patched and current.

Malware, unpatched systems, and improperly secured systems open your environment to attacks. The focus in this layer is on making sure that your compute resources are secure, and that you have the proper controls in place to minimize security issues.

### Networking

- Limit communication between resources through segmentation and access controls.
- Deny by default.
- Restrict inbound internet access and limit outbound where appropriate.
- Implement secure connectivity to on-premises networks.

At this layer, the focus is on limiting network connectivity across all your resources. Segment your resources and use network-level controls to restrict communication to only what's needed. By limiting this communication, you reduce the risk of lateral movement throughout your network.

### Perimeter

- Use distributed denial-of-service (DDoS) protection to filter large-scale attacks before they can cause a denial of service for users.
- Use perimeter firewalls to identify and alert on malicious attacks against your network.

At the network perimeter, it's about protecting from network-based attacks against your resources. Identifying these attacks, eliminating their impact, and alerting on them are important to keep your network secure.

### Identity and access

- Control access to infrastructure (change control).
- Use single sign-on and multifactor authentication.
- Audit events and changes.

The identity and access layer is all about ensuring that identities are secure, access granted is only what's needed, and changes are logged.

### Physical security

Physical building security and controlling access to computing hardware within the datacenter are the first line of defense.

With physical security, the intent is to provide physical safeguards against access to assets. This ensures that other layers can't be bypassed, and that loss or theft is handled appropriately.

## Shared responsibilities

As computing environments move from customer-controlled datacenters to cloud datacenters, the responsibility of security also shifts. Security is now a concern that both cloud providers and customers share.

![Illustration of how cloud providers and customers share security responsibilities under different types of compute service implementation: on-premises, infrastructure as a service, platform as a service, and software as a service.](../media/2-shared-responsibilities.png)

## Continuous improvement

The threat landscape is evolving in real time and at massive scale, so a security architecture is never complete. Microsoft and its customers need the ability to respond to these threats intelligently, quickly, and at scale.

Azure Security Center provides customers with unified security management and advanced threat protection to understand and respond to security events on-premises and in Azure. In turn, Azure customers have a responsibility to continually reevaluate and evolve their security architecture.

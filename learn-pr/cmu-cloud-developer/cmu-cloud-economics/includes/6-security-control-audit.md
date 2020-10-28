When you run an application on the cloud, different aspects of security must be controlled by different entities. For instance, the following figure (from Azure) shows the breakdown of security responsibilities between the provider and the customer. 

![Security responsibilities in Azure between provider and customer](../media/security-3.png)

_Figure 13: Security responsibilities in Azure_ ([Source](https://docs.microsoft.com/azure/security/fundamentals/shared-responsibility))

Many classes of applications require different infrastructure, process, and security certifications. Most cloud service providers will comply with a majority of the popular certifications and audit requirements followed in the US and Europe.

To develop an application that passes these compliance checks, both the cloud service providers and the application developers must apply a minimal set of security controls, which we will explore below. As with the rest of this course, we look at controls from a predominantly IaaS perspective. Obviously, as we move up the stack, the cloud service provider has to ensure the security of the resources it is responsible for. 

For an IaaS cloud, the following table gives an overview of some of the the security controls to be implemented by both parties: 

|Domain|Cloud service provider responsibility|Customer responsibility|
|--|--|--|
|**Identity and access management**|A cloud service provider must provide information to customers about who is using the service. This requires that they:<ul><li>Deliver and maintain an authentication service (so that users cannot access resources without explicit privileges).</li><li>Create a service that allows account management policy configuration. (Customers can add and remove users and roles.)</li><li>Adopt insider misuse protections (monitor employees and restrict access to sensitive server locations).</li></ul>|Using the authentication and access control service provided by the cloud provider, customers must:<ul><li>Define roles, groups, and permissions.</li><li>Create and disseminate credentials.</li><li>Use access control logging. (The customer will have a log of all sensitive user events.)</li><li>Use multi-factor authentication where appropriate.</li></ul>|
|**Availability and fault tolerance**|To ensure that the cloud is resilient to failure, cloud service providers must have:<ul><li>Tape backups and redundancy of storage and compute systems.</li><li>Geo-distributed datacenters.</li></ul>|The redundancy provided by the cloud service provider has to be leveraged by the customer, who should:<ul><li>Add redundant options for connectivity to all endpoints.</li><li>Use application-layer backups and snapshots of instances and storage state. (A snapshot of a VM instance, or a database, stores its state at a fixed moment in time, allowing a recovery to be performed from that point.)</li></ul>|
|**Patching and configuration management**|<ul><li>Ensure sandboxing of tenants using hypervisors and overlay networks. (This will be explained later.)</li><li>Regular vulnerability assessments and penetration testing (when an internal or external team of "hackers" systematically attempts to break into a system) of bare metal, hypervisor, and networks.</li></ul>|<ul><li>Patch OS and machine images with the latest security updates.</li><li>Use appropriate user roles with the least privilege for each application. (For example, when you run a web server on the cloud, ensure that it doesn't have access to any infrastructure keys, or even to local "root." This way, if your website is breached, the rest of your application is isolated.)</li><li>Restrict traffic to instances using firewalls and virtual private clouds, and segment the network into zones (block all network traffic from untrusted sources).</li></ul>|
|**Monitoring and detection**|Verify that customer resources are not being used for nefarious activities (either intentionally or unintentionally), and take appropriate actions.|<ul><li>Install host-based intrusion detection and anti-malware systems. (These detect any misuse of your cloud network or hosts.)</li><li>Define alerts and response strategies for incidents and breaches. (Be prepared for attacks and automate a recovery and logging protocol.)</li></ul>|
|**Data security**|<ul><li>Cross-tenant data access controls and privacy safeguards. (As described on the previous page, ensure that customers on the same physical infrastructure are isolated.)</li><li>Data integrity verification and repair from redundant data stores. (When storing data in several replicas, ensure their consistency and accuracy.)</li></ul>|<ul><li>Use secure protocols (like SSL/TLS and IPsec) for data in transit. (These ensure that your network traffic cannot be read.)</li><li>Encrypt data at rest. (Encrypt all the data you store on the cloud, such that even a rogue employee of the cloud service provider cannot disclose this information.)</li></ul>|
|**Cryptographic object security**|<ul><li>Support data encryption in all provided storage/file systems and DBs. (For example, Windows environments could allow BitLocker implementations.)</li><li>Securely manage customer account and access credentials.</li></ul>|<ul><li>Create and distribute access keys (for cloud service provider APIs) as well as remote connectivity (like SSH, VNC, RDP).</li><li>Do not store keys on the cloud where possible, so that a key will not be in the same place as the data.</li></ul>|


Providers will often build in services that simplify the process for customers to implement security controls. For example, Azure provides Azure Network Security Groups, which can act as external network firewalls.

The process of verifying the presence of these controls is known as a security audit. These audits can be done internally (by hiring a technical consultant) or externally (by a certifying agency). To host sensitive information on the cloud, both the provider and the customer must pass these audits.

### References

<!-- Reference #2 in original course not cited in unit. Remove from visibility. Update citation numbering.
2. _Winkler, Vic J.R.  (2011). [Securing the Cloud: Cloud Computer Security Techniques and Tactics](https://dl.acm.org/citation.cfm?id=1971980).  Elsevier_ -->

1. _Mather, Tim et. al. (2009). [Cloud security and privacy: an enterprise perspective on risks and compliance](https://dl.acm.org/citation.cfm?id=1594881). O'Reilly Media_
2. _Pucher, Alex et. al. (2012). [A Survey on Cloud Provider Security Measures](https://pdfs.semanticscholar.org/5dfb/286f90cbe73bc8bcca44598fea709b86a289.pdf). University of California Santa Barbara_

***

[^1]: <https://dl.acm.org/citation.cfm?id=1594881> "Mather, Tim et. al. (2009). *Cloud security and privacy: an enterprise perspective on risks and compliance* O'Reilly Media"
[^2]: <https://pdfs.semanticscholar.org/5dfb/286f90cbe73bc8bcca44598fea709b86a289.pdf> "Pucher, Alex et. al. (2012). *A Survey on Cloud Provider Security Measures* University of California Santa Barbara"

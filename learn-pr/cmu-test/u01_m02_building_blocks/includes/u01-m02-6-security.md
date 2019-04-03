<!-- Original file: C:\Users\Mark\Desktop\CMU-source\v_5_3\content\_u01_intro\_u01_m02_building_blocks\x-oli-workbook_page\_u01_m02_6_security.xml -->

When running an application on the cloud, different aspects of security must be controlled by different entities. For instance, Figure 1.12 (from AWS) shows the break up of security responsibilities between the provider and the customer. 
![Figure 1.12 Security Responsibilites in AWS. Source](../media/security_3.jpg)

_Figure 1.12 Security Responsibilites in AWS._ ([Source](http://media.amazonwebservices.com/AWS_Auditing_Security_Checklist.pdf))


Many classes of applications require different infrastructure, process and security certifications. Most cloud service providers will comply with a majority of the popular certifications and audit requirements followed in the US and Europe. The following table from Putcher et. al. compares the most popular providers (Figure 1.13): 
![Figure 1.13 Security Responsibilites in AWS. Source](../media/security_4.jpg)

_Figure 1.13 Security Responsibilites in AWS._ ([Source](http://www.cs.ucsb.edu/~koc/ns/projects/12Reports/PucherDimopoulos.pdf))


Understanding the details of these certifications is not a goal for this course, but Mather provides a good reference for those interested in digging deeper into these aspects. 

To develop an application that passes these compliance checks, both the cloud service providers as well as application developers must apply a minimal set of security controls, which we will explore below. As with the rest of this course, we look at controls from a predominantly IaaS perspective. Obviously, as we move up the stack, the cloud service provider has to ensure the security of the resources it is responsible for. 

For an IaaS cloud, the following table gives an overview of the security controls to be implemented by both parties: 
|Domain|Cloud Service Provider's Responsibility|Customer Responsiblity|
|--|--|--|
|Identity and Access Management|<br>A cloud service provider must provide information to customers about who is using the service. This requires that they: <br><br>- Deliver and maintain an authentication service (so that users cannot access resources without explicit privileges)<br>- Create a service that allows account management policy configuration (this means that customers can add/remove users, roles)<br>- Adopt insider misuse protections (monitor employees, restrict access to sensitive server locations)|<br>Using the authentication and access control service provided by the cloud provider, customers must:<br><br>- Define roles, groups and permissions <br>- Create and disseminate credentials <br>- Use access control logging (this means that the customer will have a log of all sensitive user events) <br>- Use Multifactor Authentication where appropriate |
|Availability and Fault-tolerance|<br>To ensure that the cloud is resilient to failure, cloud service providers must have:<br><br>- Tape backups and redundancy of storage, compute systems<br>- Geo-distributed datacenters |<br>The redundancy provided by the cloud service provider has to be leveraged by the customer, who should:<br><br>- Add redundant options for connectivity to all endpoints<br>- Use application-layer backups and snapshots of instances, storage state (a snapshot of a VM instance, or a database, stores its state at a fixed moment in time, allowing a recovery to be performed from that point) |
|Patching & Configuration Management|<br>- Ensure sandboxing of tenants using hypervisors, overlay networks (this will be explained later)<br>- Regular vulnerability assessments and penetration testing (when an internal or external team of “hackers” systematically attempts to break into a system) of bare metal, hypervisor and networks|<br>-  Patch OS, machine images with latest security updates<br>- Use appropriate user roles with the least privilege for each application (for e.g. when you are running a web server on the cloud, ensure that it does not have access to any infrastructure keys, or even to local “root”. This way, if your website is breached, the rest of your application is isolated)<br>- Restrict traffic to instances using firewalls, Virtual Private Clouds, and segment network into zones (block all network traffic from untrusted sources)|
|Monitoring & Detection|<br>- Verify that customer resources are not being used for nefarious activities (either intentionally or unintentionally), and take appropriate actions|<br>- Install host-based Intrusion Detection and Anti-Malware systems (these detect any misuse of your cloud network or hosts) <br>- Define alerts and response strategies for incidents and breaches (be prepared for attacks and automate a recovery and logging protocol)|
|Data Security|<br>- Cross-tenant data access controls and privacy safeguards (as described on the previous page, ensure that customers on the same physical infrastructure are isolated)<br>- Data integrity verification and repair from redundant data stores (when storing data in several replicas, ensure their consistency and accuracy) |<br>- Use secure protocols (like SSL/TLS, IPSec) for data in transit (these ensure that your network traffic cannot be read) <br>- Encrypt data-at-rest (encrypt all the data you store on the cloud, such that even a rogue employee of the cloud service provider cannot disclose this information) |
|Cryptographic Object Security|<br>- Support data encryption in all provided storage/file systems/DBs (for e.g. Windows environments could allow Bitlocker implementations) <br>- Securely manage customer’s account and access credentials |<br>- Create and distribute access keys (for cloud service provider APIs) as well as remote connectivity (like SSH, VNC, RDP)<br>- Do not store keys on cloud where possible, so that key will not be in the same place as the data.|


Most providers will often build in services simplifying the process for customers to implement security controls. For e.g. AWS provides Security Groups, which is simply an external network firewalls. 

The process of verifying the presence of these controls is known as a security audit. These can be done internally (by hiring a technical consultant) or externally (by a certifying agency). To host sensitive information on the cloud, both the provider and the customer must pass these audits. However, the lack of demarcation of responsibilities in case of a breach have meant that in most cases, applications using sensitive information like bank records or medical data cannot be hosted “on-the-cloud”.

### References

1. _Mather, Tim et. al. (2009). Cloud security and privacy: an enterprise perspective on risks and compliance. O'Reilly Media_
2. _Winkler, Vic J.R.  (2011). Securing the Cloud: Cloud Computer Security Techniques and Tactics  Elsevier_
3. _Pucher, Alex et. al. (2012). A Survey on Cloud Provider Security Measures . University of California Santa Barbara_
In this course so far, we've talked about the fundamental ideas behind cloud computing and some of the service models that have emerged under the cloud computing paradigm. Assuming an organization wants to move its infrastructure and services to a cloud provider, several questions arise. For example, how does an organization:
- Define its requirements in terms of the services that it requires from the cloud service provider?
- Identify the type and quantity of the services that it requires?
- Negotiate the level of service and support that it expects from a cloud provider?
- Monitor and validate the type and quality of service that was guaranteed by the cloud service provider?

## Service level agreements and objectives

When an organization needs to formally state its service requirements in business and legal terms, it defines these requirements in terms of **service level objectives (SLOs)**.

> [!div class="alert is-tip"]
> ### Service level objective
>
> _(definition)_ A key element that defines some aspect of the service that is expected from the service provider.


A common service level objective with cloud service providers, for example, is an uptime guarantee, wherein a service is guaranteed to be available and running within normal operational parameters for a certain percentage of the time. 

Service level objectives are typically defined and negotiated between the client and a service provider in a larger contract known as the **service level agreement (SLA)**.


> [!div class="alert is-tip"]
> ### Service level agreement
>
> _(definition)_ A contract between a service provider (either internal or external) and the client that defines the level of service expected from the service provider.

Service level agreements exist in many industries where a supplier-customer relationship exists for a service that is provided by the supplier to the customer periodically. Service level agreements in information technology, in their current form, have been used since the late 1980s by fixed-line telecom operators as part of their contracts with corporate customers. 

A typical SLA may consist of the following segments: 
- Definition of services to be provided by the service provider to the client
- Methods to measure performance
- Protocols to manage problems
- List of customer duties
- Warranties that need to be honored by the service provider 
- Procedures involved for disaster recovery
- Process and policies regarding the termination of the agreement

## SLAs in cloud computing

SLAs have evolved over the years to cater to different types of IT services. The evolution of shared infrastructure services such as clouds has necessitated the use of strong service level agreements. SLAs by definition can define any level of service, but a well-structured and negotiated SLA between a cloud service provider and a client will ideally<sup>[1][^1]</sup>:

- Codify the specific parameters and minimum levels required for each element of the service, as well as remedies for failure to meet those requirements. 
- Affirm the client's ownership of its data stored on the service provider's system, and specifies the client's rights to get it back. 
- Detail the system infrastructure and security standards to be maintained by the service provider, along with the client's rights to audit their compliance. 
- Specify the client's rights and cost to continue and discontinue using the cloud service provider's service. 

## Auditing in cloud computing

Although cloud computing provides numerous advantages, one of its main challenges continues to be the reliability of cloud services. A fast-evolving approach to address reliability is **cloud auditing**. Let's assume that a client has employed one or more cloud services from a cloud service provider. The cloud computing business model abstracts away many aspects of the infrastructure from the client, which now become the responsibility of the cloud service provider. The cloud services are managed by the cloud service provider to implement the services agreed upon in the SLA. 

Auditing evaluates whether the cloud services comply with the SLA through monitoring. A third-party auditor is requested and trusted by the client to assess the cloud service(s). Hence, public auditability of cloud services is necessary to allow clients to resort to an external auditor to check the integrity of the cloud services. The cloud service provider makes available resource usage and performance monitoring and takes measures to ensure the security of its services to its clients through providing physical security, isolation, authentication, firewalls, and APIs. A third-party auditor should be able to efficiently audit the cloud services without overloading the client and without adding vulnerabilities to the client's services. 

Given the nature of cloud services, near real-time auditability is becoming necessary. This requires real-time monitoring and evaluation in order to trigger a rapid response to safeguard the client's service and reputation. In public clouds, this has to be achieved while preventing the exposure of client data to other cloud clients. Near real-time auditing is rapidly evolving and becoming a requirement for reliable cloud computing services, which will require audit trails and monitoring of service, performance, and security metrics (among others). 
<br>
***
### References

1. _Thomas Trappler  (2010). [If It's in the Cloud, Get It on Paper: Cloud Computing Contract Issues](http://www.educause.edu/ero/article/if-its-cloud-get-it-paper-cloud-computing-contract-issues)_

***

[^1]: <http://www.educause.edu/ero/article/if-its-cloud-get-it-paper-cloud-computing-contract-issues> "Thomas Trappler  (2010). *If It's in the Cloud, Get It on Paper: Cloud Computing Contract Issues*"

In this course so far, we have talked about the fundamental ideas behind cloud computing and some of the service models that have emerged under the cloud-computing paradigm. Assuming an organization wants to move their infrastructure and services to a cloud provider, several questions arise. For example, how does an organization:

- Define its requirements in terms of the services that they require from the cloud service provider?
- Identify the type and quantity of the services that it requires?
- Determine the level of service and support that it expects from a cloud provider?
- Monitor and validate the type and quality of service that was guaranteed by the cloud service provider?

When an organization needs to formally state its service requirements in business and legal terms, it defines these requirements in terms of **service-level objectives**, which are defined as follows:

> [!div class="alert is-tip"]
> ### Service-Level Objective
>
> _(definition)_ A service-level objective is defined as a key element that defines some aspect of the service which is expected from the service provider

A common service-level objective with cloud service providers, for example, is an up-time guarantee, wherein a service is guaranteed to be available and running within normal operational parameters a specified percentage of the time.

Service-level objectives are typically agreed upon between the client and a service provider in a larger contract known as a **service-level agreement**, or SLA, which is defined as follows:

> [!div class="alert is-tip"]
> ### Service-Level Agreement
>
> _(definition)_ A service-level agreement (SLA) is a contract between a service provider (either internal or external) and the client that defines the level of service expected from the service provider

Service-level agreements exist in many industries where a supplier-customer relationship exists for a service that is provided by the supplier to the customer periodically. SLAs in information technology, in their current form, have been used since late 1980s by fixed-line telecom operators as part of their contracts with corporate customers.

A typical SLA may consist of the following components:

- A definition of the services to be provided by the service provider to the client
- Methods to measure performance
- Protocols to manage problems
- A list of customer duties
- Warranties that need to be honored by the service provider
- Procedures involved for disaster recovery
- Process and policies regarding the termination of the agreement

The principles that have governed SLAs for decades are especially pertinent in the cloud-computing industry. It is important that organizations understand what a cloud service provider guarantees, as well as what they do not.

# SLAs in Cloud Computing

SLAs have evolved over the years to cater to different types of IT services. The evolution of shared infrastructure services such as clouds have necessitated the use of strong service-level agreements. SLAs by definition can define any level of service, but a well-structured SLA will ideally<sup>[1][^1]</sup>:

- Codify the specific parameters and minimum levels required for each element of the service, as well as remedies for failure to meet those requirements.
- Affirm the client's ownership of its data stored in the service provider's system and specify the client's rights to get it back.
- Detail the system infrastructure and security standards to be maintained by the service provider, along with the client's rights to audit their compliance.
- Specify the client's rights and cost to continue and discontinue using the cloud service provider's service.

For cloud users, the most important element of an SLA is typically the guaranteed up-time, which varies by service and by provider. Up-time is usually measured in "nines," where three 9s, for example, means 99.9%, four 9s means 99.99%, and so on. Providers frequently offer service credits when SLAs are not met. Amazon, for example, provides customers with a 10% service credit if the monthly up-time for an Elastic Beanstalk instance falls below 99.99%, and a 30% credit if it falls below 99%. A figure such as 99% sounds high, but it means that a service could be unavailable for about 3.5 days per year. That's a long time for a company like Amazon or Expedia whose primary interface to its customers (and means of generating revenue) is via the web.

Up-time guarantees can also vary by configuration and by service tier. Microsoft, for example, guarantees that you will have connectivity to an Azure virtual machine at least 99.99% of the time, but only if two or more instances of the virtual machine are deployed across two or more availability zones in the same Azure region. In addition, some cloud services allow you to select from several service tiers, with higher tiers offering higher guaranteed up-times. In general, the higher the guaranteed up-time, the higher the cost.

# Auditing in Cloud Computing

Although cloud computing provides numerous advantages, one of the main challenges is ensuring and verifying the reliability of cloud services. If a customer signs a service contract guaranteeing a certain level of availability, how does the customer know whether the provider is living up to the terms of the contract? For that matter, how does the cloud provider know?

Major cloud providers including Amazon, Microsoft, and Google hire third-party auditors to monitor their platforms for availability and other factors, including data security and confidentiality. The auditors produce *SOC reports* that comply with the American Institute of Certified Public Accountants (AICPA) Service Organization Controls (SOC) standard. SOC reports fall into three categories:

- SOC 1 reports, which cover financial reporting
- SOC 2 reports, which cover security, availability, and privacy
- SOC 3 reports, which also cover security, availability, and privacy

SOC 1 and SOC 2 reports are generally private and are only made available to customers who have signed non-disclosure agreements (NDAs) with the cloud provider. SOC 3 reports are available to the public.

Major cloud providers also offer monitoring services to their clients. These services can be deployed along with IaaS, PaaS, and SaaS services to alert clients in near real-time if, for example, a web site goes down or a VM becomes unavailable. While the responsibility for meeting the terms of the SLA rests largely with the cloud provider, customers, too, can architect the solutions that they deploy to maximize availability -- for example, by employing failover mechanisms offered by the cloud provider to make sure that traffic to a database or VM that has become unavailable is redirected to a copy of that database or VM in another region.

Given the nature of cloud services, auditing and monitoring is necessary. This requires real-time monitoring and evaluation in order to trigger a rapid response to safeguard the client\'s service and reputation. In public clouds, this must be achieved while preventing the exposure of client data to other cloud clients. Near real-time auditing is rapidly evolving and becoming a requirement for reliable cloud computing services which will require audit trails and monitoring of service, performance, and security metrics among others.

### References

1. _Thomas Trappler. *If It\'s in the Cloud, Get It on Paper: Cloud Computing Contract Issues*. <https://www.educause.edu/ero/article/if-its-cloud-get-it-paper-cloud-computing-contract-issues>_

[^1]: <https://www.educause.edu/ero/article/if-its-cloud-get-it-paper-cloud-computing-contract-issues>  "Thomas Trappler. *If It\'s in the Cloud, Get It on Paper: Cloud Computing Contract Issues*."

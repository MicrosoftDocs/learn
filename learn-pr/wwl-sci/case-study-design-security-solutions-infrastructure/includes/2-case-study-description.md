This unit presents the case study scenario, design requirements, conceptual and technical questions.

## Background scenario

Contoso is a large, US-based financial-services conglomerate with several subsidiaries, including the recently acquired Tailwind Traders. A successful business strategy combined with corporate acquisitions contributed to a dramatic growth of Contoso, expanding its presence to all major financial hubs in the United States. However, the rapid growth also exposed a number of issues with its information technology landscape. Some of these issues were related to the on-premises datacenter infrastructure reaching its end-of-life. Others resulted from business-driven changes circumventing existing governance and security controls for the sake of expediency. The lax approach to enforcing company-wide standards, along with a number of business acquisitions, led to a fragmented operational environment, with a wide variety of third-party hardware and software, challenging and time consuming to maintain. 

Effectively, due to the focus on business growth, the parent company failed to sufficiently modernize and optimize its computing environment. There are, however, some exceptions. In particular, the IT team within Tailwind Traders has already transitioned its business-critical applications to the microservices architecture and deployed them in Amazon Web Services (AWS) on the Elastic Kubernetes Service (EKS) platform. It also migrated some of its server-based workloads to AWS Elastic Compute Cloud (EC2) instances. The subsidiary also maintains a number of newly deployed Kubernetes clusters in its own datacenter. Container images are stored in a private Docker registry. They are manually, periodically scanned and updated to address any newly discovered vulnerabilities in its open source software components.

Another challenge facing Contoso is the state of its remote workforce. Due to a pandemic, Contoso switched to the work-from-home model for all of its middle and back-office employees. To accommodate the new work model, the company expanded significantly its virtual desktop infrastructure (VDI) running on the Windows Server 2019 platform. The VDI environment consists of a mix of personal and pooled, non-persistent virtual desktops. Remote employees connect via virtual private network (VPN) from their home Windows-based computers, which frequently are not properly secured. This makes them an easy target for malware and cyber-attacks, which represent a potential threat to Contoso's internal network. Non-persistent virtual desktops are particularly vulnerable due to the lack of a proper malware protection.

Lastly, the current fragmentation of its IT environment makes it challenging for Contoso to obtain a comprehensive assessment of the company-wide security posture and provide a sufficient threat protection. The company's security operations team has been relying primarily on an on-premises Security Information and Event Management (SIEM) system for their monitoring, auditing, and reporting.

As part of a recently drafted modernization strategy intended to address the current issues, the company's new CIO decided to migrate a substantial portion of existing workloads to the public cloud. The workloads will include both Windows and Linux server hosted services, including hundreds of Microsoft SQL Server instances, .NET websites running on the Internet Information Services (IIS) platform, PHP and Ruby websites running on Apache web servers, as well as dozens of open-source relational and non-relational databases, including MySQL, PostgreSQL, MariaDB, and Apache Cassandra. In addition, the intention is to decommission aging file servers and use the cloud for long-term data storage. To minimize administrative overhead, managed services should be used whenever possible. Due to a long-standing partnership between Contoso and Microsoft, Azure became the primary migration target. Before the migration strategy is finalized, the technology team reporting to the CIO must identify the optimal approach to address the need to properly secure the on-premises and cloud-based infrastructure.

## Design requirements

The CIO of Contoso defined the following set of requirements that the technology team must address in its design of the Azure-based solution for securing the company's infrastructure: 

- Implement a comprehensive, continuous assessment of the company-wide security posture for on-premises and cloud infrastructure.
- Implement a comprehensive, continuous threat protection of the company's technology environment for on-premises and cloud infrastructure.
- Provide a solution to address the vulnerabilities of client devices used for the remote access to the on-premises VDI environment.
- Provide a tactical and strategic solution to address the vulnerabilities of the on-premises VDI environment.
- Recommend the approach to securing Tailwind Traders on-premises and cloud computing resources. 
- Recommend a solution for the on-premises SIEM instance that would provide a single-pane of glass for the company's security operations team.
- Identify security-related benefits resulting from the integration of on-premises and third-party cloud resources with Azure.

## High-level conceptual questions

Before you start designing the solution based on Contoso's requirements, consider the following high-level conceptual questions:

- What are the primary Microsoft Defender products and services that offer security solutions for infrastructure?
- How does Microsoft Defender for Cloud benefit Azure customers?
- How and to what extent the Microsoft Defender for Cloud benefits can be extended to hybrid and multicloud scenarios?
- What are the integration capabilities of Microsoft Defender for Cloud with other security-focused Microsoft cloud-based services?
- How do the Microsoft Defender for Cloud native and integration capabilities help minimize the impact of cyberthreats?
- What are the considerations and requirements that should be taken into account when onboarding to Microsoft Defender for Cloud resources residing in Azure, on-premises, and in third-party cloud environments?
- What security measures provided by Microsoft help secure Azure Virtual Desktop deployments?

## Design questions

As you are architecting the solution based on the requirements of Contoso, answer the following design questions:

- How would you leverage the primary capabilities of Microsoft Defender for Cloud to address the company's needs?
- Which plans and components of Microsoft Defender for Cloud are most significant to consider in the context of the case study?
- Which benefits of enhanced security features of Microsoft Defender for Cloud would help the company to optimize its security stance and protect its infrastructure?
- What are the main considerations and requirements that you would include in your design of onboarding the company's resources onto Microsoft Defender for Cloud?
- How would you minimize the effort and time involved in implementing your solution?
- What additional security-focused Microsoft cloud-based services would you consider including in your design?
- Which elements of your design should be implemented as soon as possible and which ones are suitable as part of a longer-term solution?
This module covers the topic of Zero Trust and best practice frameworks for Microsoft cybersecurity capabilities.

Imagine you are a cybersecurity architect in a large organization. You have been tasked with modernizing the organization's cybersecurity. You know that best practices are essential to achieve this goal, but you are not sure which framework to use. You have heard about Zero Trust and its potential benefits, but you are not sure how to get started. This module will help you understand best practices and how to use them as a cybersecurity architect. You will also learn about the concept of Zero Trust and how to get started with it in an organization.

The module is divided into five units: Introduction to Best Practices, Introduction to Zero Trust, Zero Trust Initiatives, Zero Trust Technology Pillars Part 1, and Zero Trust Technology Pillars Part 2.

By the end of this module, you will be able to understand how to use best practices as a cybersecurity architect, understand the concept of Zero Trust and how it can be used to modernize an organization's cybersecurity, and understand when to use different best practice frameworks like MCRA, CAF, and WAF.

## Learning objectives

Upon completion of this module, the learner will be able to:

- Understand how to use best practices as a cybersecurity architect.
- Understand the concept of Zero Trust and how it can be used to modernize an organizations cybersecurity.
- Understand when to use different best practice frameworks like MCRA, CAF and WAF.

The content in the module will help you prepare for the certification exam SC-100: Microsoft Cybersecurity Architect.

## Prerequisites

- Conceptual knowledge of security policies, requirements, zero trust architecture, and management of hybrid environments
- Working experience with zero trust strategies, applying security policies, and developing security requirements based on business goals

## Best practices

**Best practices** are recommended ways to do things that have been found to be most effective or efficient. Best practices help you avoid mistakes and ensure that your resources and effort aren't wasted.

Best practices come in many forms:

- exact instructions on what to do, why to do it, who should do it, and how to do it
- high level principles to help with different types of decisions and actions
- guidelines that are part of a reference architecture that describes components that should be included in a solution and how to integrate them together

Microsoft has embedded security best practices in various forms of guidance including:

- Microsoft Cybersecurity Reference Architectures
- Microsoft cloud security benchmark
- the Cloud Adoption Framework (CAF)
- the Azure Well-Architected Framework (WAF)
- Microsoft security best practices

## Antipatterns

An **antipattern** is a common mistake that lead to negative outcomes. It is the opposite of a best practice. Many best practices are designed to help you avoid antipatterns.

An example of a best practice that helps you overcome numerous antipatterns is applying security patches regularly. Microsoft has observed multiple antipatterns that get in the way of regularly applying this basic and critically important security best practice:

- **We don't patch (unless it's critical)** - This antipattern avoids patch installation because of an implicit assumption that patches aren't important. Another version of this is that 'It won't happen to us', a belief that unpatched vulnerabilities won't be exploited because it hasn't happened before (or hasn't been detected).

- **Waiting for patch perfection instead of building resilience** - This antipattern avoids patching because of a fear that something could go wrong with the patches. This antipattern also increases likelihood of downtime from attackers.

- **Broken accountability model** - This antipattern holds security accountable for the negative outcomes of patches. This accountability model leads to other teams de-prioritize security maintenance

- **Over-customizing patch selection** - This antipattern uses unique criteria for patching instead of applying all manufacturer recommended patches. This customization effectively creates custom builds of Windows, Linux, and applications which have never been tested in that exact configuration.

- **Focusing only on operating systems** - This antipattern patches only servers and workstations without also addressing containers, applications, firmware, and IoT/OT devices

### How architects use best practices

Security best practices must be integrated into people's skills and habits, organizational processes, and technology architecture and implementation.

Cybersecurity architects help integrate security best practices and make them actionable by doing the following:

- Integrating best practices into security architecture and policy
- Advising security leaders on how to integrate best practices into business processes, technical processes, and culture.
- Advising technical teams on implementing best practices, and which technology capabilities make best practices easier to implement.
- Advising others in the organization such as Enterprise Architects, IT Architects, application owners, developers, and more on how to integrate security best practices in their areas of ownership.

**Follow best practices unless you have a reason to avoid them.** Organizations should follow well-defined and well-reasoned best practices unless there is a specific reason to avoid them. While some organizations can ignore certain best practices for good reasons, organizations should be cautious before ignoring high quality best practices like those provided by Microsoft. Best practices aren't perfectly applicable to all situations, but they've been proven to work elsewhere so you shouldn't ignore or alter them without good reason.

**Adapt but don't over-customize** - Best practices are general guidance that work across most organizations. You may need to adapt best practices to the unique circumstances of your organization. You should be careful not to customize them to the point where the original value is lost. An example of this is adopting passwordless and multi-factor authentication, but making exceptions for the highest impact business and IT accounts that attackers value most.

Adopting best practices will reduce common mistakes and improve overall security effectiveness and efficiency.

## Which framework should I choose?
<!--
- Note: Add elements about an organization, roles, audiences and what kind of documents, libraries, frameworks and initiatives align with those target groups.
- Out of RaMP, ZT deployment guidance, MCRA, MCSB, CAF and WAF what should I use when?
-->

| Framework | Summary | When to use | Audience | Organizations | Materials |
|---|---|---|---|---|---|
| [Zero Trust RaMP initiatives](/security/zero-trust/zero-trust-ramp-overview) | Zero Trust guide based on initiatives designed to provide quick wins in high-impact areas. Plans organized chronologically and identify key stakeholders. | When you want to get started with Zero Trust and make progress quickly. | Cloud architects, IT professionals, and Business decision makers | Early stage cloud and Zero Trust adopters | Project plans with checklists |
| [Zero Trust deployment objectives](/security/zero-trust/deploy/overview) | Zero Trust guide with detailed configuration steps for each of the technology pillars. More comprehensive than RaMP initiatives. | When you want a more comprehensive guide on rolling out Zero Trust. | Cloud architects, IT professionals | Organizations who have made some progress with Zero Trust and want detailed guidance to make the most out of the technology. | Deployment plans with primary and secondary objectives. |
| [MCRA](/security/cybersecurity-reference-architecture/mcra)  | The MCRA is a set of diagrams that includes many best practices related to the access control modernization initiative in Zero Trust RaMP | When you want: a starting template for a security architecture, a comparison reference for security capabilities, to learn about Microsoft capabilities, to learn about Microsoft's integration investments | Cloud architects, IT professionals | Early stage cloud and zero trust adopters | Powerpoint slides with diagrams |
| [MCSB](/security/benchmark/azure/introduction)  | A framework for assessing the security posture of an organization's cloud environment against industry standards and best practices. | Looking for guidance on how to implement security controls and monitor them for compliance.  | Cloud architects, IT professionals | All | Detailed specifications of controls and service baselines |
| [CAF](/azure/cloud-adoption-framework/overview) | A documentation and implementation framework for best practices throughout the cloud adoption lifecycle, providing a step-by-step approach to cloud migration and management using Azure. | When you are looking to create and implement business and technology strategies for the cloud. | Cloud architects, IT professionals, and Business decision makers | Organizations who need technical guidance for Microsoft Azure | Best practices, documentation, and tools |
| [WAF](/azure/architecture/framework/) | A framework designed to help customers build secure, high-performing, resilient, and efficient infrastructure for their applications and workloads in Azure, using five pillars: cost optimization, operational excellence, performance efficiency, reliability, and security. | When you are looking to improve the quality of a cloud workload. | Cloud architects, IT professionals | All | Azure Well-Architected Review, Azure Advisor, Documentation, Partners, Support, and Services Offers, Reference architectures, Design principles |
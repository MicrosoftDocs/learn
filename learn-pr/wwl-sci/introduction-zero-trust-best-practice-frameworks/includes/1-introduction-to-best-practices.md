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

- Note: Add elements about an organization, roles, audiences and what kind of documents, libraries, frameworks and initiatives align with those target groups.
- Out of RaMP, ZT deployment guidance, MCRA, MCSB, CAF and WAF what should I use when?

| Framework | When to use |
|---|---|
| [Zero Trust RaMP initiatives](https://learn.microsoft.com/security/zero-trust/zero-trust-ramp-overview) | If you're in the early stages in your Zero Trust journey, the RaMP guide is a good place to start.<br><br>Designed to deliver quick wins, the RaMP guide is organized by initiatives with checklists that identify critical layers of protection to get you up to speed in identifying fundamental deployment paths.<br><br> The plan identifies key stakeholders and roles so you can put together a project plan. It is presented in a chronological order with leeway for multiple teams to tackle some tasks concurrently. |
| [Zero Trust deployment objectives](https://learn.microsoft.com/security/zero-trust/deploy/overview) | For a more comprehensive guide on rolling out Zero Trust, the deployment plans provide in-depth guidance.<br><br>Unlike the checklist format of the RaMP, deployment solutions weave together resources across products and services. <br><br>Work is broken into units of work that can be configured together, helping you create a good foundation that you can build up from. |
| [MCRA](https://learn.microsoft.com/security/cybersecurity-reference-architecture/mcra)  |  The MCRA is a set of diagrams that includes many best practices related to the access control modernization initiative in Zero Trust RaMP. MCRA diagrams can be used for reasons such as the following:<br>-**Starting template for a security architecture** - help define a target state for cybersecurity capabilities. <br>-**Comparison reference for security capabilities** - compare Microsoft's recommendations with what is already implemented in an organization. <br>-**Learn about Microsoft capabilities** - in presentation mode, each capability has a "ScreenTip" with a short description of each capability + a link to documentation to learn more.<br>-**Learn about Microsoft's integration investments** - can help architects and technical teams identify how to take advantage of integration points within Microsoft capabilities and with existing security capabilities.<br>-**Learn about Cybersecurity** |
| [MCSB](https://learn.microsoft.com/security/benchmark/azure/introduction)  | The Microsoft cloud security benchmark (MCSB) includes a collection of high-impact security recommendations you can use to help secure your cloud services in a single or multi-cloud environment.   |
| [CAF](https://learn.microsoft.com/azure/cloud-adoption-framework/overview) | The Microsoft Cloud Adoption Framework for Azure is a full lifecycle framework that enables cloud architects, IT professionals, and business decision makers to achieve their cloud adoption goals. It provides best practices, documentation, and tools that help you create and implement business and technology strategies for the cloud. |
| [WAF](https://learn.microsoft.com/azure/architecture/framework/) | The Azure Well-Architected Framework is a set of guiding tenets that can be used to improve the quality of a workload. The framework consists of five pillars of architectural excellence:<br>[Reliability](https://learn.microsoft.com/azure/architecture/framework/#reliability), [Security](https://learn.microsoft.com/azure/architecture/framework/#security), [Cost Optimization](https://learn.microsoft.com/azure/architecture/framework/#cost-optimization), [Operational Excellence](https://learn.microsoft.com/azure/architecture/framework/#operational-excellence), [Performance Efficiency](https://learn.microsoft.com/azure/architecture/framework/#performance-efficiency) |



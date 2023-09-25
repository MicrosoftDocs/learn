
In this module, you'll learn how to:

- Use the Microsoft Cybersecurity Reference Architecture (MCRA) to recommend security best practices
- Use Microsoft Cloud Security Benchmarks to recommend security best practices
- Use the Zero Trust Rapid Modernization Plan (RaMP) to recommend a strategy for updating organizational security

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
- Microsoft security best practices

## Antipatterns

An **antipattern** is a common mistake that lead to negative outcomes. It is the opposite of a best practice. Many best practices are
designed to help you avoid antipatterns.

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

**Adapt but don't over-customize** - Best practices are general guidance that work across most organizations. You may need to adapt best practices to the unique circumstances of your organization. You should be careful not to customize them to the point where the original value
is lost. An example of this is adopting passwordless and multi-factor authentication, but making exceptions for the highest impact business and IT accounts that attackers value most.

Adopting best practices will reduce common mistakes and improve overall security effectiveness and efficiency.
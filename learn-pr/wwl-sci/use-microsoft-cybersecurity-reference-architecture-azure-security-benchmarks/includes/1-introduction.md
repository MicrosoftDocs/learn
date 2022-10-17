
In this module, you'll learn how to:

- Use the Microsoft Cybersecurity Reference Architecture (MCRA) to recommend security best practices
- Use Microsoft Cloud Security Benchmarks to recommend security best practices
- Use the Zero Trust Rapid Modernization Plan (RaMP) to recommend a strategy for updating organizational security

The content in the module will help you prepare for the certification exam SC-100: Microsoft Cybersecurity Architect.

## Prerequisites

- Conceptual knowledge of security policies, requirements, zero trust architecture, and management of hybrid environments
- Working experience with zero trust strategies, applying security policies, and developing security requirements based on business goals

## Best practices

**Best practices** are recommended ways to do things that have been found to be most effective or
efficient. Best practices help you avoid mistakes and ensure that your resources and effort aren't wasted.

Best practices come in many forms:

- exact instructions on what to do, why to do it, who should do it, and how to do it
- high level principles to help with different types of decisions and actions
- guidelines that are part of a reference architecture that describes components that
should be included in a solution and how to integrate them together

Microsoft has embedded security best practices in various forms of guidance including:

- Microsoft Cybersecurity Reference Architectures
- Azure Security Benchmark
- the Cloud Adoption Framework (CAF)
- Microsoft security best practices

## Antipatterns

An **antipattern** is the opposite of a best practice.

Antipatterns are common mistakes that lead to negative outcomes, which
are effectively the opposite of a best practice. Many best practices are
designed to help you avoid one or more antipatterns, for
example the best practice of "going beyond VPN for remote access helps you avoid the
antipattern of "use VPN for all remote access" that causes user
frustration, security issues from weak authentication, and also causes
users to work around security in order to get their work done.

An example of a best practice that helps you overcome numerous
antipatterns is applying security patches regularly. Microsoft has
observed multiple antipatterns that get in the way of regularly applying
this basic and critically important security best practice:

-   **We don't patch (unless its critical)** -- Avoiding patch
    installation because of an implicit assumption that patches aren't
    important - e.g. 'if it ain't broke, don't touch it'\
    Another version of this is that 'It won't happen to us', a belief
    that unpatched vulnerabilities won't be exploited because it hasn't
    happened before (or hasn't been detected)

-   Waiting for patch perfection instead of building resilience --
    Avoiding patching because something could go wrong with the patches
    (which then increases likelihood of downtime from attackers)

-   **Broken accountability model** -- Holding security accountable for
    negative outcomes of patches, which leads to other teams
    deprioritizing security maintenance

-   **Over-customizing patch selection** -- Using unique criteria for
    patching instead of applying all manufacturer recommended patches.
    This effectively creates unique custom builds of Windows, Linux,
    Applications, etc. which have never been tested in that exact
    configuration.

-   **Focusing only on operating systems** -- Patching only servers and
    workstations without also addressing containers, applications,
    firmware, and IoT/OT devices

### How architects use best practices

Like any guidance or advice, best practices only have value if they are
applied in practice. Security best practices must be integrated into
people's skills and habits, repeatable processes of your organization,
and technology architecture and implementation.

Cybersecurity architects help integrate security best practices and make
them actionable via

-   Integrating best practices into security architecture and policy

-   Advising security leaders on how to integrate best practices into
    business processes, technical processes, culture, and more.

-   Advising technical teams on implementing best practices, which
    technology capabilities help make doing so easier and more
    effective, and more.

-   Advising others in the organization such as Enterprise Architects,
    IT Architects, application owners, developers, and more on how to
    integrate security best practices into their architecture,
    processes, and more.

**Follow best practices unless you have a reason not to.** Organizations
should follow well-defined and well-reasoned best practices unless there
is a specific reason not to. While some organizations should ignore some
best practices for good reasons, organizations should be very cautious
before ignoring high quality best practices like those provided by
Microsoft. Best practices are not unquestionably perfect and applicable
to all situations, but they have been proven to work elsewhere so you
should not ignore or alter them without good reason.

**Adapt but don't over-customize** - Best practices are general guidance
that work across most organizations, so you must always adapt best
practices to the unique circumstances of your organization. You should
be careful not to customize them to the point where the original value
is lost (e.g. adopt passwordless and multi-factor authentication but
provide exceptions for the highest impact business and IT accounts that
attackers value most).

Adopting best practices will improve your security posture, reduce
business process friction, and make everyone's jobs easier by reducing
common mistakes and improving security effectiveness and efficiency.
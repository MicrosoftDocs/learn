In this module, you'll learn how to:

- Understand privileged access and the Enterprise Access Model
- Design identity governance solutions
- Design a solution for securing administration of cloud tenants
- Design for cloud infrastructure entitlement management

The content in the module will help you prepare for the certification exam SC-100: Microsoft Cybersecurity Architect.

## Prerequisites

- Advanced experience and knowledge in identity and access, platform protection, security operations, securing data, and securing applications.
- Experience with hybrid and cloud implementations.

## Securing privileged access

Organizations should make securing privileged access the top security priority because of the significant potential business impact (and high likelihood) of attackers compromising this level of access.

Privileged access includes IT administrators with control of large portions of the enterprise estate and other users with access to business critical assets.

Attackers frequently exploit weaknesses in privileged access security during [human operated ransomware attacks](https://www.microsoft.com/security/blog/2020/03/05/human-operated-ransomware-attacks-a-preventable-disaster/) and targeted data theft. Privileged access accounts and workstations are so attractive to attackers because these targets allow them to rapidly gain broad access to the business assets in the enterprise, often resulting in rapid and significant business impact.

The following diagram summarizes the recommended privileged access strategy to create an isolated virtual zone that these sensitive accounts can operate in with low risk.

![Diagram that shows an end to end approach is required for meaningful security.](../media/end-to-end-approach.png)

Securing privileged access effectively seals off unauthorized pathways completely and leaves a select few authorized access pathways that are protected and closely monitored. This diagram is discussed in more detail in the article, [Privileged Access Strategy](https://learn.microsoft.com/security/privileged-access-workstations/privileged-access-strategy).

Building this strategy requires a holistic approach combining multiple technologies to protect and monitor those authorized escalation paths using Zero Trust principles including explicit validation, least privilege, and assume breach. This strategy requires multiple complementary initiatives that establish a holistic technology approach, clear processes, and rigorous operational execution to build and sustain assurances over time.
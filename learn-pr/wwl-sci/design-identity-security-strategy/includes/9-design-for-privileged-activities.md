---
uid: learn.wwl.design-identity-security-strategy.design-for-privileged-activities
title: Design a security strategy for privileged activities
description: Design a security strategy for privileged activities
durationInMinutes: 10
---
Organizations should make securing privileged access the top security
priority because of the significant potential business impact (and high
likelihood) of attackers compromising this level of access. Privileged
access includes IT administrators controlling large portions of the
enterprise estate and other users with access to business-critical
assets.

Attackers frequently exploit weaknesses in privileged access security
during [human operated ransomware attacks](https://www.microsoft.com/security/blog/2020/03/05/human-operated-ransomware-attacks-a-preventable-disaster/) and
targeted data theft. Privileged access accounts and workstations are so
attractive to attackers because these targets allow them to rapidly gain
broad access to the business assets in the enterprise, often resulting
in a rapid and significant business impact.

## Privileged Access should be the top security priority

Any compromise of these users has a high likelihood of a significant
negative impact to the organization. Privileged users have access to
business-critical assets in an organization, nearly always causing a
major impact when attackers compromise their accounts.

This strategy is built on Zero Trust principles of explicit validation,
least privilege, and assumption of breach. Microsoft has
provided [implementation guidance](/security/compass/security-rapid-modernization-plan) to
help you rapidly deploy protections based on this strategy.

This graphic describes how this extortion-based attack is growing in
impact and likelihood using privileged access:

![Diagram showing human operated ransomware.](../media/human-operated-ransomware.png) 

-   **High business impact:** It is difficult to overstate the potential
    business impact and damage of a loss of privileged access. Attackers
    with privileged access effectively have full control of all
    enterprise assets and resources, allowing them to disclose any
    confidential data, stop all business processes, or subvert business
    processes and machines to damage property, hurt people, or worse.

-   **High likelihood of occurrence:** The prevalence of privileged
    access attacks has grown since the advent of modern credential theft
    attacks starting with [pass the hash
    techniques](https://en.wikipedia.org/wiki/Pass_the_hash). These
    techniques first jumped in popularity with criminals starting with
    the 2008 release of the attack tool "Pass-the-Hash Toolkit" and
    have grown into a suite of reliable attack techniques (mostly based
    on the [Mimikatz](https://github.com/gentilkiwi/mimikatz) toolkit).
    This weaponization and automation of techniques allowed the attacks
    (and their subsequent impact) to grow rapidly, limited only by the
    target organization's vulnerability to the attacks and the
    attacker's monetization/incentive models.

## Building your privileged access strategy

A privileged access strategy is a journey that must be composed of quick
wins and incremental progress. Each step in a privileged access strategy
must take you closer to "seal" out persistent and flexible attackers
from privileged access, who are like water trying to seep into
environments through any available weakness.

### Holistic practical strategy

Reducing the risk from privileged access requires a thoughtful,
holistic, and prioritized combination of risk mitigations spanning
multiple technologies. Building this strategy requires recognition that
attackers are like water as they have numerous options they can exploit
(some of which can appear insignificant at first), attackers are
flexible in which ones they use, and they generally take the path of
least resistance to achieving their objectives.

![Diagram of attackers are like water and can appear insignificant at first but flood over time.](../media/attackers-are-like-water.png) 

### Building the recommended strategy

#### Understand strategic goals

Microsoft's recommended strategy is to incrementally build a 'closed
loop' system for privileged access that ensures only
trustworthy ['clean'](/security/compass/privileged-access-success-criteria#clean-source-principle) devices,
accounts, and intermediary systems can be used for privileged access to
business sensitive systems.

Securing Privileged Access has two simple goals:

* Strictly limit the ability to perform privileged actions to a few authorized pathways
* Protect and closely monitor those pathways

:::image type="content" source="../media/two-paths-protected-known-entry-points.png" alt-text="Diagram showing two access paths: one for normal user activities and one for privileged activities." lightbox="../media/two-paths-protected-known-entry-points.png":::

There are two types of pathways to accessing the systems, **user access** (to use the capability) and **privileged access** (to manage
the capability or access a sensitive capability):

-   **User Access** - the lighter blue path on the bottom of the diagram
    depicts a standard user account performing general productivity
    tasks like email, collaboration, web browsing, and line-of-business
    applications or websites. This path includes an account logging on
    to a device or workstations, sometimes passing through an
    intermediary like a remote access solution, and interacting with
    enterprise systems.

-   **Privileged Access** - the darker blue path on the top of the
    diagram depicts privileged access, where privileged accounts like IT
    Administrators or other sensitive accounts access business critical
    systems and data or perform administrative tasks on enterprise
    systems. While the technical components may be similar in nature,
    the damage an adversary can inflict with privileged access is much
    higher.

These components collectively comprise the privileged access attack
surface that an adversary may target to attempt to gain elevated access
to your enterprise.

#### Lay foundations for successful privileged identity strategy

This strategy requires a combination of:

- **Zero Trust access control** is described throughout this guidance, including the rapid modernization plan (RAMP).
- **Asset protection** protects against direct asset attacks by applying good security hygiene practices to these systems. Asset protection for resources (beyond access control components) is out of the scope of this guidance but typically includes rapid application of security updates/patches, configuring operating systems using manufacturer/industry security baselines, protecting data at rest and in transit, and integrating security best practices to development / DevOps processes.

#### Security rapid modernization plan

The privileged identity strategy is enabled by the Rapid modernization plan (RAMP). At a high level, RAMP contains the following steps:

1. **Separate and manage privileged accounts**

    1. Emergency access accounts ensure that organizations are not accidentally locked out of their Azure Active Directory (Azure AD) in an emergency. These accounts should be rarely used due to the possibility of risk due to a compromise.
    1. Enable Azure AD Privileged Identity Management (PIM) to discover and secure privileged accounts. PIM provides time-based and approval-based role activation to mitigate the risks of excessive, unnecessary, or misused access permissions.
    1. Identify and categorize privileged accounts (Azure AD) with a high business impact requiring a privileged security level (immediately or over time). The process identifies and minimizes the number of people that require separate accounts and privileged access protection.
    1. Use separate accounts (On-premises AD accounts) to ensure administrative functions are isolated from user account activities. All administrator accounts should have mail disabled, and no personal Microsoft accounts should be allowed.
    1. Deploy Microsoft Defender for Identity and review any open alerts. All open alerts should be reviewed and mitigated by the appropriate teams.

2. **Improve credential management experience**

    1. Implement and document self-service password reset and combined security information registration by enforcing self-service password reset (SSPR) in your organization.
    1. Protect admin accounts by enforcing MFA / Passwordless for Azure AD privileged users. Require Azure Active Directory Multi-Factor Authentication at sign-in for all individual users who are permanently assigned to one or more of the Azure AD admin roles.
    1. Block legacy authentication protocols for privileged user accounts. Leaving legacy authentication protocols enabled can create an entry point for attackers.
    1. Ensure the application consent process disables the end user's consent to Azure AD applications. Enforcing the process establishes a centralized consent process to maintain centralized visibility and control of the applications that have access to data.
    1. Clean up accounts and sign-in risks by utilizing Azure AD Identity Protection and remediate any discovered risks. Ensure to create a process that monitors and manages user and sign-in risk.

### Execute critical strategic initiatives for privileged activity management

The final step of building the recommended strategy for privileged activities is to execute strategic initiatives, such as:

* **End-to-end Session Security** establishes explicit Zero Trust validation for privileged sessions, user sessions, and authorized elevation paths. **Success Criteria** Each session will validate that users' accounts and devices are trusted at a sufficient level before allowing access.
* **Protect & Monitor Identity Systems**, including Directories, Identity Management, Admin Accounts, Consent grants, etc. **Success Criteria:** Each of these systems will be protected at a level appropriate for the potential business impact of accounts hosted in it.
* **Mitigate Lateral Traversal** to protect against lateral traversal with local account passwords, service account passwords, or other secrets. **Success Criteria**: Compromising a single device will not immediately lead to controlling many or all other devices in the environment.
* **Rapid Threat Response** to limit adversary access and time in the environment. **Success Criteria** Incident response processes impede adversaries from reliably conducting a multi-stage attack in the environment that would result in loss of privileged access.
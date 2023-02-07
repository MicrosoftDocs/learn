---
uid: learn.wwl.design-identity-security-strategy.design-for-privileged-role-access-to-infrastructure
title: Design a security strategy for privileged role access to infrastructure
description: Design a security strategy for privileged role access to infrastructure
durationInMinutes: 10
---
The security of business assets depends on the integrity of the
privileged accounts that administer your IT systems. Cyber-attackers use
credential theft attacks to target administrator accounts and other
privileged access to try to gain access to sensitive data.

For cloud services, prevention and response are the joint
responsibilities of the cloud service provider and the customer. For
more information about the latest threats to endpoints and the cloud,
see the [Microsoft Security Intelligence Report](https://www.microsoft.com/security/operations/security-intelligence-report).

Traditionally, organizational security was focused on the entry and exit
points of a network as the security perimeter. However, SaaS apps and
personal devices on the Internet have made this approach less effective.
In Azure AD, we replace the network security perimeter with
authentication in your organization's identity layer, with users
assigned to privileged administrative roles in control. Their access
must be protected, whether the environment is on-premises, cloud, or a
hybrid.

## End to end security

:::image type="content" source="../media/end-to-end-security.png" alt-text="Diagram showing an end to end security approach for managing access." lightbox="../media/end-to-end-security.png":::

Microsoft recommends a simple three-level strategy which provides clear guidance, flexibility, enables progressive security improvement over time.

These security levels are applied consistently across device, account, intermediary, and interfaces. 

### Enterprise security

Enterprise security is suitable for all enterprise users and productivity scenarios. In the progression of the rapid modernization plan, enterprise also serves as the starting point for specialized and privileged access as they progressively build on the security controls in enterprise security.

### Specialized security 

Specialized security provides increased security controls for roles with an elevated business impact (if compromised by an attacker or malicious insider). This level allows standard general productivity tasks like email and web browsing, but includes higher security rigor on those productivity tasks for higher business impact roles such as:

* Developers of business critical systems
* Sensitive business roles (such as users of SWIFT terminals, researchers with access to sensitive data, personnel with access to financial reporting prior to public release, payroll administrators, approvers for sensitive business processes)
* Executives and personal assistants / administrative assistants that that regularly handle sensitive information.
* High impact social media accounts that could damage the company reputation.
* Sensitive IT Admins with a significant privileges and impact, but aren't enterprise-wide. This group typically includes administrators of individual high impact workloads. (for example, enterprise resource planning administrators, banking administrators, help desk /tech support roles, etc.)

Specialized Account security also serves as an interim step for privileged security, which further builds on these controls.

### Privileged Security

Privileged security is the highest level of security designed for roles that could easily cause a major incident and potential material damage to the organization in the hands of an attacker or malicious insider. This level typically includes technical roles with administrative permissions on most or all enterprise systems (and sometimes includes a select few business critical roles). Privileged accounts are focused on security first, with productivity defined as the ability to easily and securely perform a fixed set of sensitive job tasks securely (not general productivity). 

## Just in time access - PIM, PAM and CIEM

:::image type="content" source="../media/just-in-time-pam-pim-ciem.png" alt-text="Diagram showing an enterprise access model with privileged access, control plane, management plane and user access." lightbox="../media/just-in-time-pam-pim-ciem.png":::

There are three related concepts that all provide some form of just in time permissioning:

* Privileged Account Management - a workflow grants access to an account with permanent privileges
* Privileged Identity Management - a workflow grants access to privileges for authenticated accounts
* Cloud Infrastructure Entitlement Management - a workflow grants access to infrastructure entitlements

## Securing privileged access

Securing privileged access requires changes to:

- Processes, administrative practices, and knowledge management
- Technical components such as host defenses, account protections, and identity management

Secure your privileged access in a managed and reported way in the
Microsoft services you care about. If you have on-premises administrator
accounts, see the guidance for on-premises and hybrid privileged access
in Active Directory at [Securing Privileged Access](/windows-server/identity/securing-privileged-access/securing-privileged-access).

### Develop a roadmap

Microsoft recommends that you develop and follow a roadmap to secure
privileged access against cyber attackers. You can always adjust your
roadmap to accommodate your existing capabilities and specific
requirements within your organization. Each stage of the roadmap should
raise the cost and difficulty for adversaries to attack privileged
access for your on-premises, cloud, and hybrid assets. Microsoft
recommends the following four roadmap stages. Schedule the most
effective and the quickest implementations first. This article can be
your guide based on Microsoft's experiences with cyber-attack incidents
and response implementation. The timelines for this roadmap are
approximations.

![Diagram of stages of the roadmap to secure privileged access with time lines.](../media/stages.png) 

- **Stage 1 (24-48 hours):** Critical items that we recommend you do
    right away
- **Stage 2 (2-4 weeks):** Mitigate the most frequently used attack
    techniques
- **Stage 3 (1-3 months):** Build visibility and build full control of
    administrator activity
- **Stage 4 (six months and beyond):** Continue building defenses to
    further harden your security platform

This roadmap framework is designed to maximize the use of Microsoft
technologies that you may have already deployed. Consider tying into any
security tools from other vendors that you have already deployed or are
considering deploying.

### Stage 1: Critical items to do right now

![Diagram of stage 1 critical items to do first.](../media/stage-1.png) 

Stage 1 of the roadmap is focused on critical tasks that are fast and
easy to implement. We recommend that you do these few items right away
within the first 24-48 hours to ensure a basic level of secure
privileged access. This stage of the Secured Privileged Access roadmap
includes the following actions:

-   Use Azure AD Privileged Identity Management

-   Identify and categorize accounts that are in highly privileged roles

-   Define at least two emergency access accounts

### Stage 2: Mitigate frequently used attacks

![Diagram of stage 2 mitigate frequently used attacks.](../media/stage-2.png) 

Stage 2 of the roadmap focuses on mitigating the most frequently used
attack techniques of credential theft and abuse and can be implemented
in approximately 2-4 weeks. This stage of the Secured Privileged Access
roadmap includes the following actions:

-   Conduct an inventory of services, owners, and administrators

-   Identify Microsoft accounts in administrative roles that need to be
    switched to work or school accounts


-   Ensure separate user accounts and mail forwarding for Global
    Administrator accounts

-   Ensure the passwords of administrative accounts have recently
    changed

-   Turn on password hash synchronization

-   Require multifactor authentication for users in privileged roles and exposed users

-   Configure Identity Protection

-   Establish incident/emergency response plan owners

-   Secure on-premises privileged administrative accounts

### Stage 3: Take control of administrator activity

![Diagram of stage 3 take control of administrator activity.](../media/stage-3.png) 

Stage 3 builds on the mitigations from Stage 2 and should be implemented
in approximately 1-3 months. This stage of the Secured Privileged Access
roadmap includes the following components.

- Complete an access review of users in administrator roles
- Continue rollout of stronger authentication for all users
- Use dedicated workstations for administration for Azure AD
- Review National Institute of Standards and Technology
    recommendations for handling incidents
- Implement Privileged Identity Management (PIM) for JIT in additional
    administrative roles
- Determine exposure to password-based sign-in protocols (if using
    Exchange Online)
- Inventory your privileged accounts within hosted Virtual Machines

- Implement PIM for Azure AD administrator roles

Use Privileged identity Management with Azure AD administrator roles to
manage, control, and monitor access to Azure resources. Using PIM
protects by lowering the exposure time of privileges and increasing your
visibility into their use through reports and alerts. For more
information, see [What is Azure AD Privileged Identity Management](/azure/active-directory/privileged-identity-management/pim-configure).

### Stage 4: Continue building defenses

![Diagram of stage 4 adopt an active security posture.](../media/stage-4.png) 

Stage 4 of the roadmap should be implemented within six months and
beyond. Complete your roadmap to strengthen your privileged access
protections from potential attacks that are known today. For tomorrow's
security threats, we recommend viewing security as an ongoing process to
raise the costs and reduce the success rate of adversaries targeting
your environment. This stage of the Secured Privileged Access roadmap
includes the following components:

- Review administrator roles in Azure AD
- Review users who have the administration of Azure AD joined devices
- Validate incident response plan

### Additional information on roadmap framework

For more information on entitlement, see [Secure Access Practices for Administrators in Azure AD](/azure/active-directory/roles/security-planning).
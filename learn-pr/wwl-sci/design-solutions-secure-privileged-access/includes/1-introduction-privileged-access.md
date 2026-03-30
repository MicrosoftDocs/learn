Adopting a privileged access strategy enables organizations to rapidly lower the risks to their organization from high impact and high likelihood attacks on privileged access.

## Why is privileged access important?

Security of privileged access is critically important because it's foundational to all other security assurances, an attacker in control of your privileged accounts can undermine all other security assurances. From a risk perspective, loss of privileged access is a **high impact** event with a **high likelihood** of happening that's growing at an alarming rate across industries.

For these reasons, privileged access should be the top security priority at every organization.

## Building your privileged access strategy

Privileged access strategy is a journey that must be composed of quick wins and incremental progress. Each step in your privileged access strategy must take you closer to "seal" out persistent and flexible attackers from privileged access, who are like water trying to seep into your environment through any available weakness.

### Zero Trust principles for privileged access

The [Zero Trust](/security/zero-trust/zero-trust-overview) security model provides the foundation for modern privileged access strategies. When designing privileged access solutions, apply these core principles:

- **Verify explicitly**: Always authenticate and authorize based on all available data points, including user identity, location, device health, service or workload, data classification, and anomalies.
- **Use least privilege access**: Limit user access with just-in-time (JIT) and just-enough-access (JEA), risk-based adaptive policies, and data protection.
- **Assume breach**: Minimize blast radius and segment access. Verify end-to-end encryption and use analytics to get visibility, drive threat detection, and improve defenses.

### Strategic assumption - Cloud is a source of security

This strategy uses cloud services as the primary source of security and management capabilities rather than on-premises isolation techniques for several reasons:

- **Cloud has better capabilities** - The most powerful security and management capabilities available today come from cloud services, including sophisticated tooling, native integration, and massive amounts of security intelligence like the 8+ trillion security signals a day Microsoft uses for our security tools.
- **Cloud is easier and faster** - Adopting cloud services requires little to no infrastructure for implementing and scaling up, enabling your teams to focus on their security mission rather than technology integration.  
- **Cloud requires less maintenance** - The cloud is also managed, maintained, and secured consistently by vendor organizations with teams dedicated to that single purpose for thousands of customer organizations, reducing the time and effort for your team to rigorously maintain capabilities.
- **Cloud keeps improving** - Features and functionality in cloud services are constantly being updated without a need for your organization to invest ongoing.

### Building the recommended strategy

Microsoft's recommended strategy is to incrementally build a 'closed loop' system for privileged access that ensures only trustworthy devices, accounts, and intermediary systems can be used for privileged access to business sensitive systems.

You need to design this strategy with an intentional outcome, establish and follow standards carefully, and continually monitor and audit the outcomes so that you remediate any leaks.

Securing Privileged Access has two simple goals

1. Strictly limit the ability to perform privileged actions to a few authorized pathways
1. Protect and closely monitor those pathways

There are two types of pathways to accessing the systems, user access (to use the capability) and privileged access (to manage the capability or access a sensitive capability)

:::image type="content" source="../media/privileged-access-strategy-step-1.png" alt-text="Diagram showing Two pathways to systems user and privileged access." lightbox="../media/privileged-access-strategy-step-1.png":::

- User Access - the lighter blue path on the bottom of the diagram depicts a standard user account performing general productivity tasks like email, collaboration, web browsing, and use of line-of-business applications or websites. This path includes an account logging on to a device or workstation, sometimes passing through an intermediary like a remote access solution, and interacting with enterprise systems. 
- Privileged Access - the darker blue path on the top of the diagram depicts privileged access, where privileged accounts like IT Administrators or other sensitive accounts access business-critical systems and data or perform administrative tasks on enterprise systems. While the technical components may be similar in nature, the damage an adversary can inflict with privileged access is much higher.

The full access management system also includes identity systems and authorized elevation paths.

:::image type="content" source="../media/privileged-access-strategy-step-2.png" alt-text="Diagram showing Two pathways plus identity systems and elevation paths." lightbox="../media/privileged-access-strategy-step-2.png":::

- Identity Systems - provide identity directories that host the accounts and administrative groups, synchronization and federation capabilities, and other identity support functions for standard and privileged users.
- Authorized Elevation Paths - provide means for standard users to interact with privileged workflows, such as managers or peers approving requests for administrative rights to a sensitive system through a just-in-time (JIT) process in a Privileged Access Management / Privileged Identity management system.  

These components collectively comprise the privileged access attack surface that an adversary may target to attempt to gain elevated access to your enterprise: 

:::image type="content" source="../media/privileged-access-strategy-step-3.png" alt-text="Diagram showing the attack surface unprotected." lightbox="../media/privileged-access-strategy-step-3.png":::

> [!NOTE]
> For on-premises and infrastructure as a service (IaaS) systems hosted on a customer-managed operating system, the attack surface dramatically increases with management and security agents, service accounts, and potential configuration issues.

Creating a sustainable and manageable privileged access strategy requires closing off all unauthorized vectors to create the virtual equivalent of a control console physically attached to a secure system that represents the only way to access it.  

:::image type="content" source="../media/privileged-access-strategy-step-4.png" alt-text="Diagram showing the protected attack surface." lightbox="../media/privileged-access-strategy-step-4.png":::

### Strategic initiatives in the journey

Implementing this strategy requires four complementary initiatives that each have clear outcomes and success criteria

1. End-to-end Session Security - Establish explicit Zero Trust validation for privileged sessions, user sessions, and authorized elevation paths.
   1. Success Criteria: Each session validates that each user account and device are trusted at a sufficient level before allowing access.
1. Protect & Monitor Identity Systems including Directories, Identity Management, Admin Accounts, Consent grants, and more
   1. Success Criteria: Each of these systems is protected at a level appropriate for the potential business impact of  accounts hosted in it.
1. Mitigate Lateral Traversal to protect against lateral traversal with local account passwords, service account passwords, or other secrets
   1. Success Criteria: Compromising a single device won't immediately lead to control of many or all other devices in the environment
1. Rapid Threat Response to limit adversary access and time in the environment
   1. Success Criteria: Incident response processes impede adversaries from reliably conducting a multi-stage attack in the environment that would result in loss of privileged access. (Measured by reducing the mean time to remediate (MTTR) of incidents involving privileged access to near zero and reducing MTTR of all incidents to a few minutes so adversaries don't have time to target privileged access.)

## AI and privileged access considerations

As organizations adopt AI services and agents, privileged access management must extend to AI workloads. Consider these security architect design considerations:

- **AI model administration**: Users who manage, train, or fine-tune AI models may require privileged access to sensitive training data and model parameters.
- **AI agent identities**: Autonomous AI agents that perform tasks on behalf of users require carefully scoped permissions following least privilege principles.
- **Prompt injection risks**: AI systems processing untrusted inputs could be manipulated to escalate privileges or access unauthorized resources.
- **Monitoring AI activities**: AI agents performing privileged operations should be subject to the same logging, monitoring, and access review requirements as human administrators.

The [Microsoft Cloud Adoption Framework](/azure/cloud-adoption-framework/) provides guidance on governing AI workloads as part of your broader privileged access strategy.
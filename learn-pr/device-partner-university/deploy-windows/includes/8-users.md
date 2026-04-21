| Tasks | Deliverables |
|-------|--------------|
| - Implement user communication plan.<br>- Review user identity.<br>- Sign off and update procedural documentation. | • Communications plan completed<br>• Updated list of identity components and configurations<br>• Procedural documentation of testing, remediation, and results |

## Implement user communication plan

In the Prepare phase, you created a communications schedule and a set of draft emails that you'll now use to inform your users of the upcoming changes that they can expect to see as they're migrated to Windows 11, and how they can reach out for help if necessary.  

Now is the time to send those communications and ensure that your users are informed and prepared.

> [!TIP]
>
> ***Recommended deliverable:***
>
> Communications delivered to users.

## Review user identity requirements

In the Plan phase, you identified any changes to user identity that were needed to support your security and resource access requirements. As the deployment phases progress, you should regularly review and validate that identity controls are correctly configured and actively enforced for users.

Use [Microsoft Entra monitoring and health](/entra/identity/monitoring-health/overview-monitoring-health) to review identity related activity, sign-in behavior, and tenant health signals, and to help detect issues that could affect access or user experience.
 
Review your [Identity Secure Score](/entra/identity/monitoring-health/concept-identity-secure-score) to assess how closely your identity configuration aligns with Microsoft’s recommended security practices and to track improvements over time.
 
Validate that authentication behavior aligns with your design by reviewing the [Microsoft Entra authentication overview](/entra/identity/authentication/overview-authentication), including configured authentication methods and sign in flows.
 
You might also consider reviewing key identity and device controls, such as:

**Authentication/identity controls:**
- [Windows Hello for Business:](/windows/security/identity-protection/windows-hello-for-business/) secure passwordless authentication
- [FIDO2 Security Keys:](/entra/identity/authentication/howto-authentication-passwordless-security-key-windows) passwordless, hardware-based authentication
- [Microsoft Entra Conditional Access policies:](/entra/identity/conditional-access/overview) enforce device and identity access requirements
- [Authentication Strength Policies:](/entra/identity/authentication/concept-authentication-strengths) configure and enforce strong authentication
- [Protected Users Security Group:](/windows-server/security/credentials-protection-and-management/protected-users-security-group) enforce enhanced protections for high-risk accounts

**Device/platform security controls:**

- [Local Security Authority (LSA) Protection:](/windows/security/book/identity-protection-advanced-credential-protection#local-security-authority-lsa-protection) protects credentials in memory
- [Windows Defender Credential Guard:](/windows/security/book/identity-protection-advanced-credential-protection#credential-guard) hardware-isolated credential protection
- [Remote Credential Guard:](/windows/security/book/identity-protection-advanced-credential-protection#remote-credential-guard) protects credentials during remote desktop sessions
- [Trusted Platform Module (TPM) 2.0:](/windows/security/hardware-security/tpm/trusted-platform-module-overview) hardware root of trust
- [Secure Boot:](/windows/security/operating-system-security/system-security/secure-the-windows-10-boot-process) ensures only trusted OS loads
- [Virtualization-Based Security (VBS):](/windows/security/identity-protection/virtualization-based-security) isolates sensitive parts of the OS
- [Memory Integrity (HVCI):](/windows/security/identity-protection/memory-integrity) protects kernel memory from tampering

Implement and document any changes that are required. Check whether stakeholder approval is needed before applying identity-related changes.

> [!TIP]
>
> ***Recommended deliverable:***
>
> Updated list of identity components and configurations.

## Sign off and update procedural documentation

As you make decisions throughout this stage, document them in an easily shareable format for tracking, reporting, and continuity purposes. Get approvals of these deliverables from all the people identified in your RACI matrix connected to user readiness. Seek help and address any gaps before moving to the next deployment phase.

| Tasks | Deliverables |
|-------|--------------|
| - Implement user communication plan.<br>- Review user identity.<br>- Sign off and update procedural documentation. | • Communications plan completed<br>• Updated list of identity components and configurations<br>• Procedural documentation of testing, remediation, and results |
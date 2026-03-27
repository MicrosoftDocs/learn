
Microsoft best practices for ransomware protection are based on a three-step approach that prioritizes business continuity and disaster recovery (BCDR) alongside privileged access protection:

1. Prepare your recovery plan
2. Limit the scope of the damage
3. Make it hard to get in

### Phase 1. Prepare your recovery plan

This phase is designed to minimize the monetary incentive from ransomware attackers by making it:

- Harder to access and disrupt systems or encrypt or damage key organization data.
- Easier for your organization to recover from an attack without paying the ransom.

> [!Note]
> While restoring many or all enterprise systems is a difficult endeavor, the alternative is paying an attacker for a recovery key they may or may not deliver, and using tools written by the attackers to try to recover systems and data. Don't fall into that trap.

#### Prioritize BCDR for ransomware resilience

The most immediate and effective action is to ensure your organization can restore your entire enterprise from immutable storage that neither the cybercriminal nor you can modify. Identify the most sensitive assets and protect them at a higher level of assurance.

Your prioritized backup list also becomes your prioritized restore list. Identify business-critical systems in this priority order, based on technical restoration dependencies (for example, identity systems must be restored first because all other systems depend on them for authentication and access):

1. **Identity systems**: Active Directory, Microsoft Entra Connect, domain controllers
2. **Human life systems**: Medical, safety, and life support systems
3. **Financial systems**: Payment processing, financial reporting databases
4. **Product or service enablement**: Factory controls, delivery systems
5. **Security systems**: Minimum security monitoring to prevent reattack

#### Secure backups against ransomware

Ensure critical systems are backed up and backups are protected against deliberate erasure or encryption by a threat actor. Attacks on backups focus on crippling your organization's ability to respond without paying. Apply these practices:

- Back up all critical data automatically on a regular schedule.
- Regularly exercise your business continuity/disaster recovery (BC/DR) plan, treating ransomware attacks with the same importance as natural disasters.
- Protect backups against deliberate erasure and encryption using strong protection (require out-of-band steps like MFA or PIN before modifying online backups) and strongest protection (store backups in immutable storage or fully offline/off-site).
- Protect supporting documents required for recovery such as restoration procedures, configuration management databases (CMDB), and network diagrams.

### Phase 2. Limit the scope of damage

Make the attackers work much harder to gain access to multiple business-critical systems through privileged access roles. Limiting the attacker's ability to get privileged access makes it much harder to profit off of an attack on your organization.

#### Prioritize privileged access protection

Any other security control you apply can easily be invalidated by a threat actor with privileged access. Ransomware threat actors use privileged access as a quick path to control all critical assets for attack and extortion. A comprehensive privileged access strategy must include:

- **End-to-end session security**: Explicitly validate trust of users and devices before allowing access to administrative interfaces using Microsoft Entra Conditional Access.
- **Protect and monitor identity systems**: Prevent privilege escalation attacks including against directories, identity management, administrator accounts, and consent grant configuration.
- **Mitigate lateral traversal**: Ensure compromising a single device doesn't immediately lead to control of many others. Randomize local account passwords and implement service account isolation.
- **Secure privileged accounts** with strong multifactor authentication (MFA), passwordless authentication, and risk-based conditional access policies.
- **Implement Just-In-Time (JIT) and Just-Enough-Access (JEA)** using Microsoft Entra Privileged Identity Management (PIM) to provide time-limited, approval-based access.
- **Use Privileged Access Workstations (PAWs)** for administrative tasks to isolate privileged activities from standard user operations.

#### Detection and response

Your organization needs responsive detection and remediation of common attacks on endpoints, email, and identities. Minutes matter. Quickly remediate common attack entry points to limit the threat actor's time to laterally traverse your organization:

- Prioritize common entry points using integrated Extended Detection and Response (XDR) tools like Microsoft Defender XDR.
- Monitor for adversary disabling of security controls, such as event log clearing and disabling of security tools.
- Don't ignore commodity malware--ransomware operators regularly purchase access from dark markets.
- Use Microsoft Defender for Endpoint to rapidly isolate impacted devices.

### Phase 3. Make it hard to get in

This phase raises friction for entry but takes time as part of a larger security journey. The goal is to make attackers' work *much* harder as they try to obtain access to your on-premises or cloud infrastructures at common points of entry. Prioritize based on how fast you can accomplish tasks with your current resources.

It's critically important that ***your work on phase 3 should not slow down your progress on phases 1 and 2.***

Key areas to harden include:

- **Email security**: Deploy advanced anti-phishing, safe attachments, and safe links capabilities.
- **Endpoint protection**: Ensure all endpoints run current security agents with up-to-date signatures and behavioral detection.
- **Identity protection**: Enforce MFA for all users, implement risk-based conditional access, and enable password protection.
- **Remote access**: Secure RDP and other remote access protocols. Require VPN with MFA or implement Zero Trust network access.
- **Patch management**: Rapidly deploy security updates, prioritizing internet-facing systems and critical vulnerabilities.

## AI considerations for ransomware protection

AI technologies affect ransomware attack and defense strategies:

- **AI-enhanced attacks**: Attackers use AI to generate convincing phishing emails, automate vulnerability scanning, create polymorphic malware, and identify high-value targets through automated reconnaissance.
- **AI-powered defense**: Machine learning-based anomaly detection in backup systems can identify unusual patterns indicating ransomware. AI-assisted security operations through Microsoft Security Copilot and Microsoft Sentinel accelerate incident investigation and response.
- **Protecting AI systems**: Include AI infrastructure, model weights, training data, and inference endpoints in your backup and recovery scope. Ensure AI models can be validated for integrity after restoration.

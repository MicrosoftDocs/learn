By default, Azure Active Directory Domain Services (Azure AD DS) enables the use of ciphers such as NTLM v1 and TLS v1. These ciphers may be required for some legacy applications, but are considered weak and can be disabled if you don't need them. If you have on-premises hybrid connectivity using Azure AD Connect, you can also disable the synchronization of NTLM password hashes.

This article shows you how to harden a managed domain by using setting setting such as:

-   Disable NTLM v1 and TLS v1 ciphers
-   Disable NTLM password hash synchronization
-   Disable the ability to change passwords with RC4 encryption
-   Enable Kerberos armoring
-   LDAP signing
-   LDAP channel binding

## Prerequisites

To complete this article, you need the following resources:

-   An active Azure subscription.
    -   If you don't have an Azure subscription, [create an account](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
-   An Azure Active Directory tenant associated with your subscription, either synchronized with an on-premises directory or a cloud-only directory.
    -   If needed, [create an Azure Active Directory tenant](https://learn.microsoft.com/azure/active-directory/fundamentals/sign-up-organization) or [associate an Azure subscription with your account](https://learn.microsoft.com/azure/active-directory/fundamentals/active-directory-how-subscriptions-associated-directory).
-   An Azure Active Directory Domain Services managed domain enabled and configured in your Azure AD tenant.
    -   If needed, [create and configure an Azure Active Directory Domain Services managed domain](https://learn.microsoft.com/azure/active-directory-domain-services/tutorial-create-instance).

## Use Security settings to harden your domain

1.  Sign in to the [Azure portal](https://portal.azure.com/).
    
2.  Search for and select **Azure AD Domain Services**.
    
3.  Choose your managed domain, such as _aaddscontoso.com_.
    
4.  On the left-hand side, select **Security settings**.
    
5.  Click **Enable** or **Disable** for the following settings:
    
    -   **TLS 1.2 Only Mode**
    -   **NTLM v1 Authentication**
    -   **NTLM Password Synchronization**
    -   **Kerberos RC4 Encryption**
    -   **Kerberos Armoring**
    -   **LDAP Signing**
    -   **LDAP Channel Binding**
    
    :::image type="content" source="../media/security-settings.png" alt-text="Screenshot of Security settings to disable weak ciphers and NTLM password hash sync." lightbox="../media/security-settings.png":::    

## Assign Azure Policy compliance for TLS 1.2 usage

In addition to **Security settings**, Microsoft Azure Policy has a **Compliance** setting to enforce TLS 1.2 usage. The policy has no impact until it is assigned. When the policy is assigned, it appears in **Compliance**:

-   If the assignment is **Audit**, the compliance will report if the Azure AD DS instance is compliant.
-   If the assignment is **Deny**, the compliance will prevent an Azure AD DS instance from being created if TLS 1.2 is not required and prevent any update to an Azure AD DS instance until TLS 1.2 is required.

:::image type="content" source="../media/policy-transport-layer-security.png" alt-text="Screenshot of compliance settings." lightbox="../media/policy-transport-layer-security.png":::

## Audit NTLM failures

While disabling NTLM password synchronization will improve security, many applications and services are not designed to work without it. For example, connecting to any resource by its IP address, such as DNS Server management or RDP, will fail with Access Denied. If you disable NTLM password synchronization and your application or service isn’t working as expected, you can check for NTLM authentication failures by enabling security auditing for the **Logon/Logoff** > **Audit Logon** event category, where NTLM is specified as the **Authentication Package** in the event details. For more information, see [Enable security audits for Azure Active Directory Domain Services](https://learn.microsoft.com/azure/active-directory-domain-services/security-audit-events).

## Reference Architecture - Security considerations

AD DS servers provide authentication services and are an attractive target for attacks. To secure them, prevent direct Internet connectivity by placing the AD DS servers in a separate subnet with an NSG acting as a firewall. Close all ports on the AD DS servers except those necessary for authentication, authorization, and server synchronization. For more information, see [Active Directory and Active Directory Domain Services Port Requirements](https://learn.microsoft.com/troubleshoot/windows-server/identity/config-firewall-for-ad-domains-and-trusts).

Use either BitLocker or Azure disk encryption to encrypt the disk hosting the AD DS database.

[Azure DDoS Protection Standard](https://learn.microsoft.com/azure/ddos-protection/ddos-protection-overview), combined with application-design best practices, provides enhanced DDoS mitigation features to provide more defense against DDoS attacks. You should enable [Azure DDOS Protection Standard](https://learn.microsoft.com/azure/ddos-protection/ddos-protection-overview) on any perimeter virtual network.

<!--[](https://learn.microsoft.com/azure/architecture/reference-architectures/identity/adds-extend-domain#devops-considerations)-->

## Active Directory attack surface reduction
<!--
https://learn.microsoft.com/windows-server/identity/ad-ds/plan/security-best-practices/reducing-the-active-directory-attack-surface
https://learn.microsoft.com/windows-server/identity/ad-ds/plan/security-best-practices/implementing-least-privilege-administrative-models
https://learn.microsoft.com/windows-server/identity/ad-ds/plan/security-best-practices/implementing-secure-administrative-hosts
https://learn.microsoft.com/windows-server/identity/ad-ds/plan/security-best-practices/securing-domain-controllers-against-attack
-->
This section focuses on technical controls to implement to reduce the attack surface of the Active Directory installation. The section contains the following information:

### Implementing Least-Privilege Administrative Models

The crux of the problem is twofold:

- It is usually easy for an attacker to obtain deep privilege on a single computer and then propagate that privilege broadly to other computers.
- There are usually too many permanent accounts with high levels of privilege across the computing landscape.

### Implementing Secure Administrative Hosts

To effectively secure systems against attacks, a few general principles should be kept in mind:

- You should never administer a trusted system (that is, a secure server such as a domain controller) from a less-trusted host (that is, a workstation that is not secured to the same degree as the systems it manages).
- You should not rely on a single authentication factor when performing privileged activities; that is, user name and password combinations should not be considered acceptable authentication because only a single factor (something you know) is represented. You should consider where credentials are generated and cached or stored in administrative scenarios.
- Although most attacks in the current threat landscape leverage malware and malicious hacking, do not omit physical security when designing and implementing secure administrative hosts.

### Securing Domain Controllers Against Attack 

There are three primary aspects for securing Domain controllers:

1. Physical Security for Domain Controllers - In datacenters, physical domain controllers should be installed in dedicated secure racks or cages that are separate from the general server population. If you implement virtual domain controllers, you should ensure that domain controllers also run on separate physical hosts than other virtual machines in the environment. 
2. Domain Controller Operating Systems - You should run all domain controllers on the newest version of Windows Server that is supported within your organization. Organizations should prioritize decommissioning legacy operating systems in the domain controller population. 
3. Secure Configuration of Domain Controllers - Tools can be used to create an initial security configuration baseline for domain controllers that can later be enforced by GPOs. These baselines should include things like:
    - RDP Restrictions
    - Patch and Configuration Management for Domain Controllers
    - Blocking Internet Access for Domain Controllers
    - Perimeter Firewall Restrictions
    - Preventing Web Browsing from Domain Controllers
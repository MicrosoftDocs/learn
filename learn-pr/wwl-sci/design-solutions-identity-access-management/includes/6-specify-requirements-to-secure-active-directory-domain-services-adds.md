By default, Azure Active Directory Domain Services (Azure AD DS) enables the use of ciphers such as NTLM v1 and TLS v1. These ciphers may be required for some legacy applications, but are considered weak and can be disabled if you don't need them. If you have on-premises hybrid connectivity using Azure AD Connect, you can also disable the synchronization of NTLM password hashes.

This article shows you how to harden a managed domain by using setting setting such as:

-   Disable NTLM v1 and TLS v1 ciphers
-   Disable NTLM password hash synchronization
-   Disable the ability to change passwords with RC4 encryption
-   Enable Kerberos armoring
-   LDAP signing
-   LDAP channel binding

<!--[](https://learn.microsoft.com//azure/active-directory-domain-services/secure-your-domain#prerequisites)-->

## Prerequisites

To complete this article, you need the following resources:

-   An active Azure subscription.
    -   If you don't have an Azure subscription, [create an account](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
-   An Azure Active Directory tenant associated with your subscription, either synchronized with an on-premises directory or a cloud-only directory.
    -   If needed, [create an Azure Active Directory tenant](https://learn.microsoft.com//azure/active-directory/fundamentals/sign-up-organization) or [associate an Azure subscription with your account](https://learn.microsoft.com//azure/active-directory/fundamentals/active-directory-how-subscriptions-associated-directory).
-   An Azure Active Directory Domain Services managed domain enabled and configured in your Azure AD tenant.
    -   If needed, [create and configure an Azure Active Directory Domain Services managed domain](https://learn.microsoft.com//azure/active-directory-domain-services/tutorial-create-instance).

<!--[](https://learn.microsoft.com//azure/active-directory-domain-services/secure-your-domain#use-security-settings-to-harden-your-domain)-->

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
    
    ![Screenshot of Security settings to disable weak ciphers and NTLM password hash sync](https://learn.microsoft.com//azure/active-directory-domain-services/media/secure-your-domain/security-settings.png)
    

<!--[](https://learn.microsoft.com//azure/active-directory-domain-services/secure-your-domain#assign-azure-policy-compliance-for-tls-12-usage)-->

## Assign Azure Policy compliance for TLS 1.2 usage

In addition to **Security settings**, Microsoft Azure Policy has a **Compliance** setting to enforce TLS 1.2 usage. The policy has no impact until it is assigned. When the policy is assigned, it appears in **Compliance**:

-   If the assignment is **Audit**, the compliance will report if the Azure AD DS instance is compliant.
-   If the assignment is **Deny**, the compliance will prevent an Azure AD DS instance from being created if TLS 1.2 is not required and prevent any update to an Azure AD DS instance until TLS 1.2 is required.

![Screenshot of Compliance settings](https://learn.microsoft.com//azure/active-directory-domain-services/media/secure-your-domain/policy-tls.png)

<!--[](https://learn.microsoft.com//azure/active-directory-domain-services/secure-your-domain#audit-ntlm-failures)-->

## Audit NTLM failures

While disabling NTLM password synchronization will improve security, many applications and services are not designed to work without it. For example, connecting to any resource by its IP address, such as DNS Server management or RDP, will fail with Access Denied. If you disable NTLM password synchronization and your application or service isn’t working as expected, you can check for NTLM authentication failures by enabling security auditing for the **Logon/Logoff** > **Audit Logon** event category, where NTLM is specified as the **Authentication Package** in the event details. For more information, see [Enable security audits for Azure Active Directory Domain Services](https://learn.microsoft.com//azure/active-directory-domain-services/security-audit-events).

## Reference Architecture - Security considerations

AD DS servers provide authentication services and are an attractive target for attacks. To secure them, prevent direct Internet connectivity by placing the AD DS servers in a separate subnet with an NSG acting as a firewall. Close all ports on the AD DS servers except those necessary for authentication, authorization, and server synchronization. For more information, see [Active Directory and Active Directory Domain Services Port Requirements](https://learn.microsoft.com//troubleshoot/windows-server/identity/config-firewall-for-ad-domains-and-trusts).

Use either BitLocker or Azure disk encryption to encrypt the disk hosting the AD DS database.

[Azure DDoS Protection Standard](https://learn.microsoft.com//azure/ddos-protection/ddos-protection-overview), combined with application-design best practices, provides enhanced DDoS mitigation features to provide more defense against DDoS attacks. You should enable [Azure DDOS Protection Standard](https://learn.microsoft.com//azure/ddos-protection/ddos-protection-overview) on any perimeter virtual network.

<!--[](https://learn.microsoft.com//azure/architecture/reference-architectures/identity/adds-extend-domain#devops-considerations)-->


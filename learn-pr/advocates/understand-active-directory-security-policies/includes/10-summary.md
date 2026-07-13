In this module, you learned how the security policies in Active Directory Group Policy define and enforce the security posture of a Windows Server 2025 estate. You followed a clear path:

- **Account Policies** set the domain's password, lockout, and Kerberos rules, with fine-grained password policies for accounts that need different requirements.
- **User Rights Assignment** enforces least privilege and, through deny logon rights, underpins a tiered administration model.
- **Security Options** close legacy authentication gaps: remove LM and NTLMv1, reduce NTLMv2 dependency in favor of Negotiate/Kerberos, require SMB signing, require LDAP signing and channel binding, remove Kerberos RC4 after auditing usage, restrict anonymous access, and keep User Account Control protecting administrators.
- **Advanced Audit Policy Configuration** produces precise, actionable security logs, including object access auditing with SACLs.
- **Restricted Groups, System Services, Registry, File System, and Event Log** harden the system and protect your audit data.
- **Windows Firewall** (labeled **Windows Defender Firewall with Advanced Security** in Group Policy), IPsec, AppLocker, and Public Key Policies control network access and which applications can run.
- **GPO design and the OSConfig baseline** apply and continuously enforce that posture at scale.

Each of these policy choices closed a finding in the Contoso security audit: strong credentials, restricted sign-in, meaningful auditing, hardened authentication, application allowlisting, and firewall isolation, applied consistently and kept from drifting.

## Further reading

Use the following resources to learn more:

- [Security policy settings reference](/windows/security/threat-protection/security-policy-settings/security-policy-settings)
- [Password Policy](/windows/security/threat-protection/security-policy-settings/password-policy)
- [Account Lockout Policy](/windows/security/threat-protection/security-policy-settings/account-lockout-policy)
- [Kerberos Policy](/windows/security/threat-protection/security-policy-settings/kerberos-policy)
- [User Rights Assignment](/windows/security/threat-protection/security-policy-settings/user-rights-assignment)
- [Security Options](/windows/security/threat-protection/security-policy-settings/security-options)
- [Advanced audit policy configuration](/windows-server/identity/ad-ds/plan/security-best-practices/advanced-audit-policy-configuration)
- [AppLocker overview](/windows/security/application-security/application-control/app-control-for-business/applocker/applocker-overview)
- [OSConfig security configuration for Windows Server](/windows-server/security/osconfig/osconfig-overview)
- [Deploy Windows Server 2025 security baselines locally with OSConfig](/windows-server/security/osconfig/osconfig-how-to-configure-security-baselines)
- [Windows Server Inside Out (Microsoft Press)](https://aka.ms/WSInsideOut)

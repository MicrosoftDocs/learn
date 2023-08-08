## Access control

![Access Control category.](../media/policies/access-control.png)

### Why ask these questions

These questions allow you to:

- Come up with a complete list of user types, like employees, administrators, and vendors.
- Know who is authorized to access resources.
- Learn which security controls are used to restrict access, like Role-based Access Control (RBAC), Access Control Lists (ACL), or least-privilege access.
- Find out which identity management system is used by the enterprise, like Azure Active Directory (Azure AD).
- Learn which security controls are used to authenticate users, like Multi-Factor Authentication (MFA) or Single-Sign-On (SSO).

### What questions to ask

|Question|Areas to cover|
|--------|--------------|
|**Describe how you restrict access to physical and logical enterprise resources.**|<ul><li>Domain controller type and configuration, like Active Directory.</li><li>Federations used for SSO experiences.</li><li>Trusts between two or more separate domains.</li><li>Process to provision and deprovision access to resources.</li><li>Who manages the domain controller, federations, trusts, and resource access control?</li></ul>|
|**How do you establish and verify the identity of each person?**|<ul><li>Process to create and manage aliases for each user type.</li><li>Authentication methods like MFA or SSO.</li><li>Authentication factors like biometric scanning, phone authentication, smart cards, and Trusted Platform Modules (TPM).</li><li>Who manages aliases, authentication methods, and factors?</li></ul>|
|**How do you know who can access enterprise resources?**|<ul><li>Access restriction mechanisms used. Examples include least-privilege, segregation of duties, RBAC, glass-break scenarios, vendor access restrictions, and group memberships.</li><li>Who manages access restriction mechanisms?</li></ul>|
|**Describe the password policy for each user type.**|<ul><li>Password requirements for each user type.</li><li>Password requirement differences between users, elevated users, smart cards, shared accounts, and service accounts.</li><li>Password guidelines for creation, modification, and reset.</li><li>Logging and monitoring mechanisms used to track password actions.</li><li>Password expiration policies for each user type.</li><li>Unsuccessful password attempt limits.</li><li>Password sharing restrictions.</li><li>Who manages passwords in the enterprise?</li></ul>|
|**How do you manage access to your online social presence?**|<ul><li>Prefix requirements used for social media branding.</li><li>Social media access guidelines.</li><li>Access audit cadence.</li><li>Who manages social media accounts?</li></ul>|
|**How do you manage elevated, shared, alternate, and system accounts?**|<ul><li>Approval process for each account type.</li><li>Expiration or deactivation dates.</li><li>Process used to monitor, log, and handle suspicious activity.</li><li>Accounts used for remote access.</li><li>Access restriction mechanisms like just-in-time access.</li><li>Local administrative account usage and security.</li><li>Administrative account restrictions, like using them only in secured environments.</li><li>Who manages these types of accounts and access restriction mechanisms?</li></ul>|
|**Describe the process used to approve, audit, and manage resource access requests.**|<ul><li>Initial request handling, the review process, initial training requirements, and audits.</li><li>Who manages resource access request process?</li></ul>|

> [!TIP]
> Check out [Azure identity fundamentals](/azure/security/fundamentals/identity-management-best-practices) for tips on securing your identity infrastructure.
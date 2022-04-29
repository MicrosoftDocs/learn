**Microsoft Identity Manager** or MIM helps organizations manage the users, credentials, policies, and access within their organizations and hybrid environments. With MIM, organizations can simplify identity lifecycle management with automated workflows, business rules, and easy integration with heterogenous platforms across the datacenter. MIM enables Active Directory Domain Services to have the right users and access rights for on-premises apps. Azure AD Connect can then make those users and permissions available in Azure AD for Microsoft 365 and cloud-hosted apps.

On-premises Active Directory Domain Services, Azure Active Directory (Azure AD), or a hybrid combination of the two all offer services for user and device authentication, identity and role management, and provisioning.

:::image type="content" source="../media/az500-hybrid-identities-e604f6fb.png" alt-text="Hybrid identities include multiple user identities including Windows Server Active Directory.":::


Identity has become the common factor among many services, like Microsoft 365 and Xbox Live, where the person is the center of the services. Identity is now the security boundary, the new firewall, the control plane—whichever comparison you prefer. Your digital identity is the combination of who you are and what you’re allowed to do. That is:

**Credentials + privileges = digital identity**

First step, you need to help protect your privileged accounts.

These identities have more than the normal user rights and, if compromised, allow a malicious hacker to access sensitive corporate assets. Helping secure these privileged identities is a critical step to establishing security assurances for business assets in a modern organization. Cybercriminals target these accounts and other privileged services in their kill chain to carry out their objectives.

## Evolution of identities

Identity management approaches have evolved from traditional, to advanced, to optimal.

**Traditional identity approaches**

 -  On-premises identity providers.
 -  No single sign-on is present between on-premises and cloud apps.
 -  Visibility into identity risk is very limited.

**Advanced identity approaches**

 -  Cloud identity federates with cloud identity systems.
 -  Conditional access policies gate access and provide remediation actions.
 -  Analytics improve visibility into identity risk.

**Optimal identity approaches**

 -  Passwordless authentication is enabled.
 -  User, location, devices, and behavior are analyzed in real time.
 -  Continuous protection to identity risk.

## Steps for a passwordless world

 -  **Enforce MFA** — Conform to the fast identity online (FIDO) 2.0 standard, so you can require a PIN and a biometric for authentication rather than a password. Windows Hello is one good example, but choose the MFA method that works for your organization.
 -  **Reduce legacy authentication workflows** — Place apps that require passwords into a separate user access portal and migrate users to modern authentication flows most of the time. At Microsoft only 10 percent of our users enter a password on a given day.
 -  **Remove passwords** — Create consistency across Active Directory Domain Services and Azure Active Directory (Azure AD) to enable administrators to remove passwords from identity directory.

> [!IMPORTANT]
> We recommend **Azure AD Privileged Identity Management** as the service to help protect your privileged accounts.

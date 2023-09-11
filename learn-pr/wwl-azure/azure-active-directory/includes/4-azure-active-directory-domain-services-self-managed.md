If you have applications and services that need access to traditional authentication mechanisms such as Kerberos or NTLM, there are **two ways** to provide Active Directory Domain Services in the cloud:

 -  A ***managed domain*** that you create using Azure Active Directory Domain Services (Azure AD DS). Microsoft creates and manages the required resources.
 -  A ***self-managed*** domain that you create and configure using traditional resources such as virtual machines (VMs), Windows Server guest OS, and Active Directory Domain Services (AD DS). You then continue to administer these resources.

With Azure AD DS, the core service components are deployed and maintained for you by Microsoft as a ***managed*** domain experience. You don't deploy, manage, patch, and secure the AD DS infrastructure for components like the VMs, Windows Server OS, or domain controllers (DCs).

Azure AD DS provides a smaller subset of features to traditional self-managed AD DS environment, which reduces some of the design and management complexity. For example, there are no AD forests, domains, sites, and replication links to design and maintain.

For applications and services that run in the cloud and need access to traditional authentication mechanisms such as Kerberos or NTLM, Azure AD DS provides a managed domain experience with a minimal amount of administrative overhead.

When you deploy and run a self-managed AD DS environment, you must maintain all of the associated infrastructure and directory components. There's additional maintenance overhead with a self-managed AD DS environment, but you're then able to do additional tasks, such as extending the schema or create forest trusts.

Common deployment models for a self-managed AD DS environment that provides identity to applications and services in the cloud include the following:

 -  **Standalone cloud-only AD DS** \- Azure VMs are configured as domain controllers, and a separate, cloud-only AD DS environment is created. This AD DS environment doesn't integrate with an on-premises AD DS environment. A different set of credentials is used to sign in and administer VMs in the cloud.
 -  **Resource forest deployment** \- Azure VMs are configured as domain controllers, and an AD DS domain that's part of an existing forest is created. A trust relationship is then configured to an on-premises AD DS environment. Other Azure VMs can domain-join this resource forest in the cloud. User authentication runs over a VPN / ExpressRoute connection to the on-premises AD DS environment.
 -  **Extend on-premises domain to Azure** \- An Azure virtual network connects to an on-premises network using a VPN / ExpressRoute connection. Azure VMs connect to this Azure virtual network, which lets them domain-join to the on-premises AD DS environment.
     -  An alternative is to create Azure VMs and promote them as replica domain controllers from the on-premises AD DS domain. These domain controllers replicate over a VPN / ExpressRoute connection to the on-premises AD DS environment. The on-premises AD DS domain is effectively extended into Azure.

The following table outlines some of the features you may need for your organization and the differences between a managed Azure AD DS domain or a self-managed AD DS domain:

| **Feature**                                                                | **Azure Active Directory Services (Azure AD DS)** | **Self-managed AD DS**                     |
| -------------------------------------------------------------------------- | ------------------------------------------------- | ------------------------------------------ |
| Managed service                                                            | ✓                                                 | ✕                                          |
| Secure deployments                                                         | ✓                                                 | The administrator secures the deployment   |
| Domain Name System (DNS) server                                            | ✓ (managed service)                               | ✓                                          |
| Domain or Enterprise administrator privileges<br>                          | ✕                                                 | ✓                                          |
| Domain join                                                                | ✓                                                 | ✓                                          |
| Domain authentication using New Technology LAN Manager (NTLM) and Kerberos | ✓                                                 | ✓                                          |
| Kerberos constrained delegation                                            | Resource-based                                    | Resource-based & account-based |
| Custom organizational unit (OU) structure                                  | ✓                                                 | ✓                                          |
| Group Policy                                                               | ✓                                                 | ✓                                          |
| Schema extensions                                                          | ✕                                                 | ✓                                          |
| Active Directory domain/forest trusts                                      | ✓ (one-way outbound forest trusts only)           | ✓                                          |
| Secure Lightweight Directory Access Protocols (LDAPs)                      | ✓                                                 | ✓                                          |
| Lightweight Directory Access Protocol (LDAP) read                          | ✓                                                 | ✓                                          |
| Lightweight Directory Access Protocol (LDAP) write                         | ✓ (within the managed domain)                     | ✓                                          |
| Geographical-distributed (Geo-distributed) deployments                     | ✓                                                 | ✓                                          |

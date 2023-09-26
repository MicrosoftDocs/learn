


AD DS offers a wide range of business-related and technological benefits. By design, its primary purpose is to serve as an identity and access management solution for on-premises, independently managed, isolated environments, and most of its characteristics reflect this underlying premise.

The authentication mechanisms of AD DS rely largely on having domain-member computers permanently joined to the domain. The communication with domain controllers involves protocols such as Lightweight Directory Access Protocol (LDAP) for directory services lookups, Kerberos for authentication, and Server Message Block (SMB) for Group Policy–based interaction with AD DS domain controllers. protocols are suitable for Internet environments.

If you want to provide equivalent functionality in Azure, you can deploy AD DS domain controllers as Azure VMs. Some of the more common reasons for placing domain controllers in Azure include:

- Providing authentication to AD DS–dependent applications and services within the Azure environment.
- Extending the scope of the on-premises AD DS to one or more Azure regions for disaster recovery purposes.
- Implementing additional AD DS domain controllers in Azure to enhance the resiliency of the directory synchronization with Azure AD and Azure AD-federated deployments.

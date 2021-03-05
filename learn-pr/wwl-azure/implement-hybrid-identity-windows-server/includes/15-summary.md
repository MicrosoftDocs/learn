

With more services available online and in the cloud, Contoso IT staff needs to define and manage its users’ cloud identities. As with on-premises identities, Contoso can use cloud identities to authenticate and authorize their users when they try to access company resources. 

Microsoft provides a cloud-based directory service in the Azure platform called Azure AD, which Contoso can utilize to meet its needs. Azure AD has many similarities to AD DS in terms of providing a solution for SSO access to thousands of cloud SaaS applications. 

In addition to—or instead of—Azure AD, Contoso could choose to use Azure AD DS. Azure AD DS provides managed domain services such as domain join, group policy, LDAP, and Kerberos authentication or NTLM authentication that is fully compatible with Windows Server AD DS. 

Contoso could use these domain services without needing to deploy, manage, and patch domain controllers in the cloud. Azure AD DS can integrate with Contoso's existing Azure AD tenant, which makes it possible for their users to sign in using their existing credentials. Contoso can also use existing groups and user accounts to secure access to resources, which provides a smoother lift-and-shift of on-premises resources to Azure. 

In this module, you learned how to select an Azure AD integration model and plan for integration. Also, you learned to prepare and install AD DS synchronization, in addition to implement SSO and enable Azure AD login for an Azure VM. Finally, you learned to plan and implement Azure AD DS. 

Equipped with this knowledge, you are prepared to guide Contoso’s IT team as it decides how to define and manage its users’ cloud identities.


## Learn more

You can learn more by reviewing the following documents.

- [Sign in to Windows virtual machine in Azure using Azure Active Directory authentication](https://aka.ms/vm-sign-in-azure-ad-windows?azure-portal=true)
- [Azure AD Domain Services documentation](https://aka.ms/active-directory-domain-services?azure-portal=true)
- [Tutorial: Create and configure an Azure Active Directory Domain Services managed domain with advanced configuration options](https://aka.ms/tutorial-create-instance-advanced?azure-portal=true)
- [Configure the certificate authorities](https://aka.ms/step-2-configure-certificate-authorities?azure-portal=true)
- [Certificates overview for Azure Cloud Services](https://aka.ms/cloud-services-certs-create?azure-portal=true)
- [Choose a solution for integrating on-premises Active Directory with Azure](https://aka.ms/reference-architectures-identity?azure-portal=true)
- [Hybrid Identity](https://aka.ms/hybrid-identity?azure-portal=true)
- [Tutorial: Enable password synchronization in Azure Active Directory Domain Services for hybrid environments](https://aka.ms/configure-password-hash-sync?azure-portal=true)

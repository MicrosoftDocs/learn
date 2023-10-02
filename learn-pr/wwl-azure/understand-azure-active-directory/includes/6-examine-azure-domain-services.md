

In most organizations today, line-of-business (LOB) applications are deployed on computers and devices that are domain members. These organizations use AD DS–based credentials for authentication, and Group Policy manages them. When you consider moving these apps to run in Azure, one key issue is how to provide authentication services to these apps. To satisfy this need, you can choose to implement a site-to-site virtual private network (VPN) between your local infrastructure and the Azure IaaS, or you can deploy replica domain controllers from your local AD DS as virtual machines (VMs) in Azure. These approaches can entail additional costs and administrative effort. Additionally, the difference between these two approaches is that with the first option, authentication traffic will cross the VPN, while in the second option, replication traffic will cross the VPN and authentication traffic stays in the cloud.

Microsoft provides Azure AD Domain Services as an alternative to these approaches. This service, which runs as part of the Azure AD Premium tier, provides domain services such as Group Policy management, domain joining, and Kerberos authentication to your Azure AD tenant. These services are fully compatible with locally deployed AD DS, so you can use them without deploying and managing additional domain controllers in the cloud.

:::image type="content" source="../media/azure-active-directory-virtual-network-340081c4.png" alt-text="Diagram that shows the Azure AD Domain Services Overview.":::


Because Azure AD can integrate with your local AD DS, when you implement Azure AD Connect, users can utilize organizational credentials in both on-premises AD DS and in Azure AD Domain Services. Even if you don’t have AD DS deployed locally, you can choose to use Azure AD Domain Services as a cloud-only service. This enables you to have similar functionality of locally deployed AD DS without having to deploy a single domain controller on-premises or in the cloud. For example, an organization can choose to create an Azure AD tenant and enable Azure AD Domain Services, and then deploy a virtual network between its on-premises resources and the Azure AD tenant. You can enable Azure AD Domain Services for this virtual network so that all on-premises users and services can use domain services from Azure AD.

Azure AD Domain Services provides several benefits for organizations, such as:

 -  Administrators don't need to manage, update, and monitor domain controllers.
 -  Administrators don't need to deploy and manage Active Directory replication.
 -  There’s no need to have Domain Admins or Enterprise Admins groups for domains that Azure AD manages.

If you choose to implement Azure AD Domain Services, you need to be aware of the service's current limitations. These include:

 -  Only the base computer Active Directory object is supported.
 -  It’s not possible to extend the schema for the Azure AD Domain Services domain.
 -  The organizational unit (OU) structure is flat and nested OUs aren't currently supported.
 -  There’s a built-in Group Policy Object (GPO), and it exists for computer and user accounts.
 -  It’s not possible to target OUs with built-in GPOs. Additionally, you can't use Windows Management Instrumentation filters or security-group filtering.

By using Azure AD Domain Services, you can freely migrate applications that use LDAP, NTLM, or the Kerberos protocols from your on-premises infrastructure to the cloud. You can also use applications such as Microsoft SQL Server or Microsoft SharePoint Server on VMs or deploy them in the Azure IaaS, without needing domain controllers in the cloud or a VPN to local infrastructure.

You can enable Azure AD Domain Services by using the Azure portal. This service charges per hour based on the size of your directory.
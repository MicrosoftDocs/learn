

The Contoso IT team deploys a number of line-of-business (LOB) applications on computers and devices that are domain members. Contoso uses AD DS–based credentials for authentication, and GPOs to manage those devices and apps. Now they are considering moving these apps to run in Azure. A key issue for you is how to provide authentication services to these apps.

To satisfy this need, the Contoso IT team can choose to:

- Implement a site-to-site virtual private network (VPN) between your local infrastructure and the Azure IaaS.
- Deploy replica domain controllers from your local AD DS as VMs in Azure.

However, these approaches can entail additional costs and administrative effort. Also, the difference between these two approaches is that with the first option, authentication traffic will cross the VPN; in the second option, replication traffic will cross the VPN and authentication traffic remains in the cloud. Microsoft provides Azure AD DS as an alternative to these approaches.

## What is Azure AD DS?

Azure AD DS, which runs as part of the Azure AD Premium tier, provides domain services such as Group Policy management, domain joining, and Kerberos authentication to your Azure AD tenant. These services are fully compatible with on-premises AD DS, so you can use them without deploying and managing additional domain controllers in the cloud.

Because Azure AD can integrate with your on-premises AD DS, when you implement Azure AD Connect, users can utilize organizational credentials in both on-premises AD DS and in Azure AD DS. Even if you don't have AD DS deployed locally, you can choose to use Azure AD DS as a cloud-only service. This enables you to have similar functionality of locally deployed AD DS without having to deploy a single domain controller on-premises or in the cloud.

For example, Contoso IT staff can choose to create an Azure AD tenant and enable Azure AD DS, and then deploy a virtual network (VNet) between its on-premises resources and the Azure AD tenant. Contoso IT staff can enable Azure AD DS for this VNet so that all on-premises users and services can use domain services from Azure AD.

Azure AD DS provides several benefits for organizations, such as:

- Administrators not needing to manage, update, and monitor domain controllers.
- Administrators not needing to deploy and manage Active Directory replication.
- There's no need to have Domain Admins or Enterprise Admins groups for domains that Azure AD DS manages.

If you choose to implement Azure AD DS, you must understand the service's current limitations. These include:

- Only the base computer Active Directory object is supported.
- It's not possible to extend the schema for the Azure AD DS domain.
- The OU structure is flat, and nested OUs are not currently supported.
- There is a built-in GPO, which exists for computer and user accounts.
- It's not possible to target OUs with built-in GPOs. Additionally, you cannot use Windows Management Instrumentation (WMI) filters or security-group filtering.

By using Azure AD DS, you can freely migrate applications that use LDAP, NT LAN Manager (NTLM), or the Kerberos protocols from your on-premises infrastructure to the cloud. You can also use applications such as Microsoft SQL Server or SharePoint Server on VMs, or deploy them in Azure IaaS. All this without needing domain controllers in the cloud or a VPN to local infrastructure.
The following table identifies some common scenarios that utilize Azure AD DS.

|Advantage|Description|
|---------|-----------|
|Secure administration of Azure VMs|You can join Azure VMs to an Azure AD DS–managed domain, which allows you to use a single set of Active Directory credentials. This approach reduces credential management issues such as maintaining local administrator accounts on each VM or separate accounts and passwords between environments. You can manage and secure VMs that you join to an Azure AD DS–managed domain. You can also apply required security baselines to VMs to lock them down in accordance with corporate security guidelines. For example, you can use Group Policy Management capabilities to restrict the types of applications that can be launched on the VM.|
|On-premises applications that use LDAP bind authentication|In this scenario, Azure AD DS lets applications perform LDAP binds as part of the authentication process. Legacy on-premises applications can lift-and-shift into Azure and continue to seamlessly authenticate users without any change in configuration or user experience.|
|On-premises applications that use LDAP read to access the directory|In this scenario, Azure AD DS lets applications perform LDAP reads against the managed domain to retrieve the attribute information it needs. The application doesn't need to be rewritten, so a lift-and-shift into Azure lets users continue to use the app without realizing there's a change in where it runs.|
|On-premises service or daemon application|Some applications include multiple tiers, where one of the tiers needs to perform authenticated calls to a backend tier, such as a database. Active Directory service accounts are commonly used in these scenarios. When you lift-and-shift applications into Azure, Azure AD DS lets you continue to use service accounts in the same way. You can choose to use the same service account that is synchronized from your on-premises directory to Azure AD, or create a custom OU and then create a separate service account in that OU. With either approach, applications continue to function the same way to make authenticated calls to other tiers and services.|
|Remote desktop services in Azure| You can also use Azure AD DS to provide managed domain services to remote desktop servers deployed in Azure.|

### Considerations

When implementing the previous scenarios, the following deployment considerations apply:

- Azure AD DS–managed domains use a single, flat OU structure by default. All domain-joined VMs are in a single OU. If desired, you can create custom OUs.
- Azure AD DS uses a built-in GPO each for the users and computers containers. For additional control, you can create custom GPOs and target them to custom OUs.
- Azure AD DS supports the base Active Directory computer object schema. However, you can't extend the computer object's schema.
- You can't change passwords directly in an Azure AD DS–managed domain. End users can change their password either using Azure AD's self-service password change mechanism or against the on-premises directory. These changes are then automatically synchronized and available in the Azure AD DS–managed domain.

Also, make sure that:

- Any applications don't need to modify/write to the LDAP directory. LDAP write access to an Azure AD DS–managed domain isn't supported.
- The application doesn't need a custom/extended Active Directory schema. Schema extensions aren't supported in Azure AD DS.
- The applications use a username and password for authentication. Certificate or smart card–based authentication isn't supported by Azure AD DS.

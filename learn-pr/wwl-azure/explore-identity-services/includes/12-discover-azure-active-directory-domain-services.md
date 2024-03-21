If you need to deploy AD DS–dependent workloads in Azure, but you want to minimize the overhead associated with deploying and managing Active Directory domain controllers hosted on Azure Virtual Machines, you should consider implementing Microsoft Entra Domain Services instead. Microsoft Entra Domain Services is a Microsoft-managed AD DS service that provides the standard Active Directory features such as Group Policy, domain join, and support for protocols such as Kerberos, NTLM, and LDAP.

The service consists of two Active Directory domain controllers in a new, single-domain forest. When you provision the service, the Azure platform automatically deploys these two domain controllers to an Azure virtual network that you designate. In addition, the managed AD DS automatically synchronizes its users and groups from the Microsoft Entra tenant associated with the Azure subscription hosting the virtual network. Effectively, the Microsoft Entra Domain Services domain will contain the same users and groups as its Microsoft Entra counterpart. This provides the following capabilities:

- You can join Azure Virtual Machines to the managed AD DS domain if they reside on the same virtual network or another virtual network connected to it.
- Microsoft Entra users can use their existing credentials to sign in to these Azure Virtual Machines.

If you have an on-premises AD DS domain that synchronizes with the same Microsoft Entra tenant, your on-premises AD DS users will be able to sign in to the Microsoft Entra Domain Services domain by using their existing credentials.

However, in this scenario, the on-premises Active Directory domain is separate from the Active Directory domain that Microsoft Entra Domain Services implements. The two Active Directory domains have different domain names and separate sets of user, group, and computer objects, although the user and group objects within the scope of Microsoft Entra Connect synchronization have matching attributes.

Microsoft Entra Domain Services offers support for the same set of protocols as on-premises AD DS. With Microsoft Entra Domain Services, you can migrate applications that depend on AD DS to Azure Virtual Machines without having to deploy and maintain extra domain controllers or establish connectivity with the on-premises infrastructure.

There are some important differences between AD DS and Microsoft Entra Domain Services. For example, Microsoft Entra Domain Services doesn't allow you to create trust relationships or extend the schema. Depending on their origin, user and group objects might have to be managed on-premises or in the corresponding Microsoft Entra tenant. Support for Group Policy is limited, with only two previously created Group Policy Objects—one containing computer settings and another containing user settings. In addition, while it's possible to perform LDAP binds and LDAP reads against Microsoft Entra Domain Services, there's no support for LDAP writes.


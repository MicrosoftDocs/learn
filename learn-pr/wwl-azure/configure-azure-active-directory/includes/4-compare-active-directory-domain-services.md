Active Directory Domain Services (AD DS) is the traditional deployment of Windows Server-based Active Directory on a physical or virtual server. Active Directory Domain Services (AD DS) also includes Active Directory Certificate Services (AD CS), Active Directory Lightweight Directory Services (AD LDS), Active Directory Federation Services (AD FS), and Active Directory Rights Management Services (AD RMS).

> [!Important]
> Although you can deploy and manage AD DS in Azure Virtual Machines, we recommend you use Microsoft Entra ID, unless your configuration targets IaaS workloads that depend specifically on AD DS.

### Things to consider when using Microsoft Entra rather than AD DS

Microsoft Entra ID is similar to AD DS, but there are significant differences. It's important to understand that using Microsoft Entra ID for your configuration is different from deploying an Active Directory domain controller on an Azure virtual machine and then adding it to your on-premises domain.

As you plan your identity strategy, consider the following characteristics that distinguish Microsoft Entra ID from AD DS.

- **Identity solution**: AD DS is primarily a directory service, while Microsoft Entra ID is a full identity solution. Microsoft Entra ID is designed for internet-based applications that use HTTP and HTTPS communications. The features and capabilities of Microsoft Entra ID support target strong identity management.

- **Communication protocols**: Because Microsoft Entra ID is based on HTTP and HTTPS, it doesn't use Kerberos authentication. Microsoft Entra ID implements HTTP and HTTPS protocols, such as SAML, WS-Federation, and OpenID Connect for authentication (and OAuth for authorization).

- **Federation services**: Microsoft Entra ID includes federation services, and many third-party services like Facebook.

- **Flat structure**: Microsoft Entra users and groups are created in a flat structure. There are no organizational units (OUs) or group policy objects (GPOs).

- **Managed service**: Microsoft Entra ID is a managed service. You manage only users, groups, and policies. If you deploy AD DS with virtual machines by using Azure, you manage many other tasks, including deployment, configuration, virtual machines, patching, and other backend processes.


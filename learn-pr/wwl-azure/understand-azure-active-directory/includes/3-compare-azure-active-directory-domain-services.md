

You could view Azure AD simply as the cloud-based counterpart of AD DS; however, while Azure AD and AD DS share some common characteristics, there are several significant differences between them.

### Characteristics of AD DS

AD DS is the traditional deployment of Windows Server-based Active Directory on a physical or virtual server. Although AD DS is commonly considered being primarily a directory service, it’s only one component of the Windows Active Directory suite of technologies, which also includes Active Directory Certificate Services (AD CS), Active Directory Lightweight Directory Services (AD LDS), Active Directory Federation Services (AD FS), and Active Directory Rights Management Services (AD RMS).

When comparing AD DS with Azure AD, it’s important to note the following characteristics of AD DS:

 -  AD DS is a true directory service, with a hierarchical X.500-based structure.
 -  AD DS uses Domain Name System (DNS) for locating resources such as domain controllers.
 -  You can query and manage AD DS by using Lightweight Directory Access Protocol (LDAP) calls.
 -  AD DS primarily uses the Kerberos protocol for authentication.
 -  AD DS uses OUs and GPOs for management.
 -  AD DS includes computer objects, representing computers that join an Active Directory domain.
 -  AD DS uses trusts between domains for delegated management.

You can deploy AD DS on an Azure virtual machine to enable scalability and availability for an on-premises AD DS. However, deploying AD DS on an Azure virtual machine doesn't make any use of Azure AD. 

> [!NOTE] 
> Deploying AD DS on an Azure virtual machine requires one or more extra Azure data disks because you shouldn't use drive C for AD DS storage. These disks are needed to store the AD DS database, logs, and the sysvol folder. The Host Cache Preference setting for these disks must be set to None.

### Characteristics of Azure AD

Although Azure AD has many similarities to AD DS, there are also many differences. It’s important to realize that using Azure AD isn’t the same as deploying an Active Directory domain controller on an Azure virtual machine and adding it to your on-premises domain.

When comparing Azure AD with AD DS, it’s important to note the following characteristics of Azure AD:

 -  Azure AD is primarily an identity solution, and it’s designed for internet-based applications by using HTTP (port 80) and HTTPS (port 443) communications.
 -  Azure AD is a multi-tenant directory service.
 -  Azure AD users and groups are created in a flat structure, and there are no OUs or GPOs.
 -  You can't query Azure AD by using LDAP; instead, Azure AD uses the REST API over HTTP and HTTPS.
 -  Azure AD doesn't use Kerberos authentication; instead, it uses HTTP and HTTPS protocols such as SAML, WS-Federation, and OpenID Connect for authentication, and uses OAuth for authorization.
 -  Azure AD includes federation services, and many third-party services such as Facebook are federated with and trust Azure AD.

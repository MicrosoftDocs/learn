When companies like yours transition their workloads from the traditional, on-premises operational model to the hybrid and cloud-based environments,  security is one of the fundamental concerns. The open nature of modern technologies warrants additional diligence and a multi-layered approach to protecting data assets. However, those extra considerations do not imply that you need to discard and replace your existing security practices. Instead, you should enhance them to adhere to the defense-in-depth and least privilege principles. 
When you deploy Azure Arc-enabled SQL Server Managed Instance, you should be able to continue using the existing Active Directory environment for authentication and apply the same data encryption methods as those available on the SQL Server platform to protect your data in use, in transit, and at rest. At the same time, you should also take into account that your workloads will be running on the Kubernetes platform, which includes its own set of security features.

## Implement Active Directory authentication
Azure Arc-enabled SQL Managed Instance supports two types of authentication:

- SQL Authentication
- Active Directory (AD) Authentication

SQL authentication relies on local SQL identities. Although SQL authentication accommodates an initial sign in, in general, you should limit its usage to configuring Active Directory authentication. This includes setting up Active Directory identities that will be allowed to access the local instance and granting them appropriate permissions. 

To implement support for Active Directory authentication in Azure Arc-enabled SQL Managed Instance, Azure Arc-enabled data services leverage a Kubernetes-native [Custom Resource Definition (CRD)](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) referred to as an Active Directory Connector. This connector uses [keytab](/sql/linux/sql-server-linux-ad-auth-understanding#what-is-a-keytab-file) files to store authentication information with enhanced security. These keytab files support the authentication of the managed instance to the Active Directory environment and the  authentication of connection requests originating from Active Directory users and Active Directory-integrated applications to the managed instance.

There are two keytab modes, which determine the process to generate, manage, and use Kerberos keytab files:

- Customer-managed keytab (CMK)
- System-managed keytab (SMK)

In the CMK mode, you create a new Active Directory user account or use an existing one that will impersonate the identity of the managed instance, configure it and store the corresponding information in the keytab file that you manage, and then reference it by using Kubernetes secrets. In the SMK mode, the Active Directory user account that impersonates the identity of the managed instance is Active Directory Connector-managed. This means that the Active Directory Connector creates an Active Directory user account for each managed instance and automatically configures it. The Active Directory Connector also generates a keytab file, populates its content, and delivers it to the managed instance. In both modes, you need to deploy an Active Directory Connector. However, with SMK, its deployment directly follows installation of a data controller, while with CMK, you typically wait with its deployment until you complete the set up of a data controller, keytab files, and the corresponding Kubernetes secrets.

The primary benefit that the CMK mode offers is the complete control of credentials used for authentication of individual managed instances. The SMK mode offers minimized administrative overhead by eliminating the need to create and manage user accounts and keytab files, including their rotation. In this case, you provide the Active Directory controller with the name of an Active Directory organizational unit (OU) and a domain service account that has sufficient privileges to create user accounts in that OU. 

> [!NOTE]
> To further explore the difference between the two modes, refer to the Microosft Learn article [Azure Arc-enabled SQL Managed Instance with Active Directory authentication](/azure/azure-arc/data/active-directory-introduction#compare-ad-integration-modes). 

> [!NOTE]
> To review the deployment process, refer to [Tutorial – Deploy Active Directory (AD) connector in customer-managed keytab mode](/azure/azure-arc/data/deploy-customer-managed-keytab-active-directory-connector) and [Tutorial – Deploy Active Directory connector in system-managed keytab mode](/azure/azure-arc/data/deploy-system-managed-keytab-active-directory-connector).

## Encrypt data at rest
Azure Arc-enabled SQL Managed Instance supports Transparent Data Encryption (TDE) in the CMK mode for encryption of user databases. TDE applies the Advanced Encryption Standard (AES) 256 algorithm to help protect data at rest from unauthorized offline access to database files or backups. Encryption at rest does not impact online data access and eliminates the need for any encryption-related changes to data-bound applications. 

To enable TDE on Azure Arc-enabled SQL Managed Instance-hosted databases, follow the same sequence of steps as those applicable to on-premises SQL Server instances. However, you must perform an additional step of backing up TDE keys and certificates. In particular, make sure to store the keys and certificates on a persistent volume via a mount path in the pod running the managed instance. For details regarding this process, refer to the Microsoft Learn article [Enable transparent data encryption on Azure Arc-enabled SQL Managed Instance](/azure/azure-arc/data/configure-transparent-data-encryption-manually?tabs=windows).

## Apply the principle of least privileges
Because Kubernetes workloads share the underlying cluster and a hardware platform, operating Azure Arc-enabled data services in compliance with the principle of least privilege is one of the important security best practices. Both Azure and Kubernetes support a role-based access control model, which facilitates granting granular permissions required to perform specific tasks. Deploying an Azure Arc data controller requires relatively high privileges, such as creating a Kubernetes namespace or a cluster role. However, even in such instances, you can mitigate the associated risk by separating the deployment into multiple steps that either a user or a service account with required permissions performs.

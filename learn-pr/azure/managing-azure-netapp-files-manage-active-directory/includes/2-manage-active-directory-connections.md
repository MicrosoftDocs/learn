**Requirements and considerations for Active Directory connections are follows:**

- An Azure NetApp Files account must be created in the region where the Azure NetApp Files volumes are to be deployed.
- By default, Azure NetApp Files allows only one Active Directory (AD) connection per subscription.

> [!NOTE]
> You can [create one Active Directory connection per NetApp account](https://learn.microsoft.com/azure/azure-netapp-files/create-active-directory-connections#multi-ad).

- Before enrolling in this feature, check the Active Directory type (NA/Multi AD/Shared AD) field in your account page.
- The Azure NetApp Files AD connection admin account must have the following properties:
    - It must be an AD DS domain user account in the same domain where the Azure NetApp Files computer accounts are created.
    - It must have the permission to create computer accounts (for example, AD domain join) in the AD DS organizational unit path specified in the Organizational unit path option of the AD connection.
    - It can't be a [Group Managed Service Account](https://learn.microsoft.com/windows-server/identity/ad-ds/manage/group-managed-service-accounts/group-managed-service-accounts/group-managed-service-accounts-overview).
- The AD connection admin account supports Kerberos AES-128 and Kerberos AES-256 encryption types for authentication with AD DS for Azure NetApp Files computer account creation.
- To enable the AES encryption on the Azure NetApp Files AD connection admin account, you must use an AD domain user account that is a member of one of the following AD DS groups:
    - Domain Admins
    - Enterprise Admins
    - Administrators
    - Account Operators
    - Microsoft Entra Domain Services Administrators (Microsoft Entra Domain Services Only)
    - Alternatively, an AD domain user account with msDS-SupportedEncryptionTypes write permission on the AD connection admin account can also be used to set the Kerberos encryption type property on the AD connection admin account.
- LDAP queries take effect only in the domain specified in the Active Directory connections (the AD DNS Domain Name field). This behavior applies to NFS, SMB, and dual-protocol volumes.

### Create an Active Directory connection

You can add an Active Directory from your NetApp account. Under Azure NetApp Files menu, select **Active Directory connections** then **Join**.

[![Screenshot of the Azure NetApp Files showing the highlighted Active Directory connections blade. The main content area displays highlighted Join button.](../media/active-directory-connections.png)](../media/active-directory-connections.png#lightbox)

In the Join Active Directory window that opens, you need to provide the following information, based on the Domain Services you want to use.

|  |  |
| --- | --- |
| Primary DNS (required) | This is the IP address of the primary DNS server that is required for Active Directory domain join operations, SMB authentication, Kerberos, and LDAP operations.|
| Secondary DNS | This is the IP address of the secondary DNS server that is required for Active Directory domain join operations, SMB authentication, Kerberos, and LDAP operations.|
| AD DNS Domain Name (required) | This is the fully qualified domain name of the AD DS used with Azure NetApp Files (for example, contoso.com).|
| AD Site Name (required) | This is the AD DS site name that Azure NetApp Files USES for domain controller discovery. The default site name for both AD DS and Microsoft Entra Domain Services is Default-First-Site-Name.|
| SMB server (computer account) prefix (required) | This is the naming prefix for new computer accounts created in AD DS for Azure NetApp Files SMB, dual protocol, and NFSv4.1 Kerberos volumes. For example, if the naming standard that your organization uses for file services is NAS-01, NAS-02, and so on, then you would use NAS for the prefix.|
| Organizational unit path | This is the LDAP path for the organizational unit (OU) where SMB server computer accounts are created. That is, OU=second level, OU=first level. If no value is provided, Azure NetApp Files use the CN=Computers container.|

|  |  |
| --- | --- |
| AES Encryption | This option enables AES encryption authentication support for the admin account of the AD connection. See [Requirements for Active Directory connections](https://learn.microsoft.com/azure/azure-netapp-files/create-active-directory-connections#requirements-for-active-directory-connections) for requirements. |
| LDAP Signing | This option enables LDAP signing. This functionality enables integrity verification for Simple Authentication and Security Layer (SASL) LDAP binds from Azure NetApp Files and the user-specified Active Directory Domain Services domain controllers. |

|  |  |
| --- | --- |
| Allow local NFS users with LDAP | This option enables local NFS client users to access NFS volumes. Note: Setting this option disables extended groups for NFS volumes, which limit the number of supported groups for a user to 16. |
| LDAP over TLS | This option enables LDAP over TLS for secure communication between an Azure NetApp Files volume and the Active Directory LDAP server. |
| Server root CA Certificate | This option uploads the CA certificate used with LDAP over TLS. For more information, see [Enable Active Directory Domain Services (AD DS) LDAP authentication for NFS volumes](https://learn.microsoft.com/azure/azure-netapp-files/configure-ldap-over-tls). |
| LDAP Search Scope, User DN, Group DN, and Group Membership Filter | The **LDAP search scope** option optimizes Azure NetApp Files storage LDAP queries for use with large AD DS topologies and LDAP with extended groups or Unix security style with an Azure NetApp Files dual-protocol volume. The **User DN** and **Group DN** options allow you to set the search base in AD DS LDAP. The **Group Membership Filter** option allows you to create a custom search filter for users who are members of specific AD DS groups.|

|  |  |
| --- | --- |
| Preferred server for LDAP client | The Preferred server for LDAP client option allows you to submit the IP addresses of up to two AD servers as a comma-separated list. |
| Encrypted SMB connections to Domain Controller | This specifies whether encryption should be used for communication between an SMB server and domain controller. When enabled, only SMB3 is used for encrypted domain controller connections. **Note**: If this is your first time using Encrypted SMB connections to domain controller, you must register it. |
| Backup policy users | This option grants addition security privileges to AD DS domain users or groups that require elevated backup privileges to support backup, restore, and migration workflows in Azure NetApp Files. The following privileges apply when you use the Backup policy users setting: `SeBackupPrivilege` - Back up files and directories, overriding any ACLs. `SeRestorePrivilege` - Restore files and directories, overriding any ACLs. Set any valid user or group SID as the file owner. * `SeChangeNotifyPrivilege` - Bypass traverse checking. Users with this privilege don't require traversed (x) permissions to traverse folders or symlinks. |

|  |  |
| --- | --- |
| Security privilege users | This option grants security privilege (`SeSecurityPrivilege`) to AD DS domain users or groups that require elevated privileges to access Azure NetApp Files volumes. The following privilege applies when you use the Security privilege users setting:   `SeSecurityPrivilege` - Manage log operations. |

|  |  |
| --- | --- |
| Administrators privilege users | This option grants extra security privileges to AD DS domain users or groups that require elevated privileges to access the Azure NetApp Files volumes. The specified accounts have elevated permissions at the file or folder level. `SeBackupPrivilege` - Back up files and directories, overriding any ACLs. `SeRestorePrivilege` - Restore files and directories, overriding any ACLs. Set any valid user or group SID as the file owner. `SeChangeNotifyPrivilege` - Bypass traverse checking. Users with this privilege aren't required to have traversed (x) permissions to traverse folders or symlinks. `SeTakeOwnershipPrivilege` - Take ownership of files or other objects. `SeSecurityPrivilege` - Manage log operations. `SeChangeNotifyPrivilege` - Bypass traverse checking. Users with this privilege aren't required to have traversed (x) permissions to traverse folders or symlinks. |

At the end, enter the credentials, including your username and password. Select Join.

The Active Directory connection you created appears.

[![Screenshot showing the Active Directory connections blade. The main area is showing one AD connection with columns DNS, Domain, NETBIOS, USERNAME.](../media/ad-created-connections.png)](../media/ad-created-connections.png#lightbox)

#### Resources

- [Create and manage Active Directory connections for Azure NetApp Files](https://learn.microsoft.com/azure/azure-netapp-files/create-active-directory-connections#multi-ad).
- [Map multiple NetApp accounts in the same subscription and region to one AD connection](https://learn.microsoft.com/azure/azure-netapp-files/create-active-directory-connections#shared_ad).
- [Reset Active Directory computer account password](https://learn.microsoft.com/azure/azure-netapp-files/create-active-directory-connections#reset-active-directory).

### Modify Active Directory connections

Once an Active Directory connection is created in Azure NetApp Files, you can modify it anytime. When you're modifying an Active Directory connection, note that not all configurations are modifiable.

To modify a created Active Directory connection in the system, you need to right-click the **Active Directory connection** from the portal and select **Edit** to make changes to it.

[![Screenshot showing Active Directory connections blade. The main area is showing a context menu with Edit option highlighted.](../media/modify-ad-connections.png)](../media/modify-ad-connections.png#lightbox)

In the **Edit Active Directory** window that appears, modify Active Directory connection configurations as needed. Note that you can't modify all the configurations of an Active Directory connection.

For an explanation of what fields you can modify, see [Options for Active Directory connections](https://learn.microsoft.com/azure/azure-netapp-files/modify-active-directory-connections#options-for-active-directory-connections).

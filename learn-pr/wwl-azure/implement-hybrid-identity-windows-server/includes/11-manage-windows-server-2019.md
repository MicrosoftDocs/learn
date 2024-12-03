

Microsoft Entra Domain Services provides a managed domain for users, applications, and services to consume. This approach changes some of the available management tasks you can do, and what privileges you have within the managed domain. These tasks and permissions might differ from what you experience with a regular on-premises AD DS environment.

> [!NOTE]
> You cannot connect to domain controllers on the Microsoft Entra Domain Services–managed domain using Microsoft Remote Desktop.

## Overview

Members of the AAD DC Administrators group are granted privileges on the Microsoft Entra Domain Services–managed domain. As a result, these administrators can perform the following tasks on the domain:

- Configure the built-in GPO for the containers AADDC Computers and AADDC Users, in the managed domain.
- Administer DNS on the managed domain.
- Create and administer custom OUs on the managed domain.
- Gain administrative access to computers joined to the managed domain.

However, because the Microsoft Entra Domain Services–managed domain is locked down, you don't have privileges to complete certain administrative tasks on the domain. Some of the following examples are tasks you *cannot* perform:

- Extend the schema of the managed domain.
- Connect to domain controllers for the managed domain using Remote Desktop.
- Add domain controllers to the managed domain.
- Employ Domain Administrator or Enterprise Administrator privileges for the managed domain.

After creating a Microsoft Entra Domain Services instance, you must join a computer to a Microsoft Entra Domain Services–managed domain. This computer is connected to an Azure VNet that provides connectivity to the Microsoft Entra Domain Services–managed domain. The process to join a Microsoft Entra Domain Services–managed domain is the same as joining a regular on-premises AD DS domain. After the computer is joined, you must install the tools to manage the Microsoft Entra Domain Services instance.

> [!TIP]
> To securely connect to the computer, you might consider using an Azure Bastion host. With Azure Bastion, a managed host is deployed into your VNet and provides web-based Remote Desktop Protocol (RDP) or Secure Shell (SSH) connections to VMs. No public IP addresses are required for the VMs, and you don't need to open network security group rules for external remote traffic. You connect to VMs using the Azure portal.

You manage Microsoft Entra Domain Services domains using the same administrative tools as on-premises AD DS environments, such as the Active Directory Administrative Center (ADAC) or Active Directory PowerShell. You can install these tools as part of the Remote Server Administration Tools (RSAT) feature on Windows Server and client computers. Members of the AAD DC Administrators group can then administer Microsoft Entra Domain Services–managed domains remotely using these Active Directory administrative tools from a computer that is joined to the managed domain.

Common ADAC actions, such as resetting a user account password or managing group membership, are available. However, these actions only work for users and groups created directly in the Microsoft Entra Domain Services–managed domain. Identity information only synchronizes from Microsoft Entra ID to Microsoft Entra Domain Services; there's no writeback from Microsoft Entra Domain Services to Microsoft Entra ID. As a result, you can't change passwords or managed group membership for users synchronized from Microsoft Entra ID and have those changes synchronized back.

You can also use the Active Directory module for Windows PowerShell, which is installed as part of the administrative tools, to manage common actions in your Microsoft Entra Domain Services managed domain.

<a name='enable-user-accounts-for-azure-ad-ds'></a>

## Enable user accounts for Microsoft Entra Domain Services

To authenticate users on the managed domain, Microsoft Entra Domain Services needs password hashes in a format that's suitable for NTLM and Kerberos authentication. Microsoft Entra ID doesn't generate or store password hashes in the format that's required for NTLM or Kerberos authentication until you enable Microsoft Entra Domain Services for your tenant. For security reasons, Microsoft Entra ID also doesn't store any password credentials in clear-text form. Therefore, Microsoft Entra ID can't automatically generate these NTLM or Kerberos password hashes based on users' existing credentials.

Once appropriately configured, the usable password hashes are stored in the Microsoft Entra Domain Services–managed domain. 

> [!CAUTION]
> If you delete this domain, any password hashes stored at that point are also deleted. 

Synchronized credential information in Microsoft Entra ID can't be re-used if you later create a Microsoft Entra Domain Services–managed domain. As a result, you must reconfigure the password hash synchronization to store the password hashes again. Even then, previously domain-joined VMs or users won't be able to immediately authenticate because Microsoft Entra ID needs to generate and store the password hashes in the new Microsoft Entra Domain Services managed domain.

The steps to generate and store these password hashes are different for cloud-only user accounts created in Microsoft Entra ID versus user accounts that are synchronized from your on-premises directory using Microsoft Entra Connect. A *cloud-only* user account is an account that is created in your Microsoft Entra directory using either the Azure portal or [Microsoft Graph PowerShell](/powershell/microsoftgraph/overview) cmdlets. These user accounts aren't synchronized from an on-premises directory.

For cloud-only user accounts, users must change their passwords before they can use Microsoft Entra Domain Services. This password change process causes the password hashes for both Kerberos and NTLM authentication to be generated and stored in Microsoft Entra ID. The account isn't synchronized from Microsoft Entra ID to Microsoft Entra Domain Services until the password is changed. As a result, you should either expire the passwords for all cloud users in the tenant who need to use Microsoft Entra Domain Services, which forces a password change on next sign-in, or instruct cloud users to manually change their passwords. However, you might need to enable self-service password reset for cloud users to reset their password.

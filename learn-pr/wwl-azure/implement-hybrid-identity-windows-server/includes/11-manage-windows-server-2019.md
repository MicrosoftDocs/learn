

Azure AD DS provides a managed domain for users, applications, and services to consume. This approach changes some of the available management tasks you can do, and what privileges you have within the managed domain. These tasks and permissions might differ from what you experience with a regular on-premises AD DS environment.

> [!NOTE]
> You cannot connect to domain controllers on the Azure AD DS–managed domain using Microsoft Remote Desktop.

## Overview

Members of the AAD DC Administrators group are granted privileges on the Azure AD DS–managed domain. As a result, these administrators can perform the following tasks on the domain:

- Configure the built-in GPO for the containers AADDC Computers and AADDC Users, in the managed domain.
- Administer DNS on the managed domain.
- Create and administer custom OUs on the managed domain.
- Gain administrative access to computers joined to the managed domain.

However, because the Azure AD DS–managed domain is locked down, you don't have privileges to complete certain administrative tasks on the domain. Some of the following examples are tasks you *cannot* perform:

- Extend the schema of the managed domain.
- Connect to domain controllers for the managed domain using Remote Desktop.
- Add domain controllers to the managed domain.
- Employ Domain Administrator or Enterprise Administrator privileges for the managed domain.

After creating an Azure AD DS instance, you must join a computer to an Azure AD DS–managed domain. This computer is connected to an Azure VNet that provides connectivity to the Azure AD DS–managed domain. The process to join an Azure AD DS–managed domain is the same as joining a regular on-premises AD DS domain. After the computer is joined, you must install the tools to manage the Azure AD DS instance.

> [!TIP]
> To securely connect to the computer, you might consider using an Azure Bastion host. With Azure Bastion, a managed host is deployed into your VNet and provides web-based Remote Desktop Protocol (RDP) or Secure Shell (SSH) connections to VMs. No public IP addresses are required for the VMs, and you don't need to open network security group rules for external remote traffic. You connect to VMs using the Azure portal.

You manage Azure AD DS domains using the same administrative tools as on-premises AD DS environments, such as the Active Directory Administrative Center (ADAC) or Active Directory PowerShell. You can install these tools as part of the Remote Server Administration Tools (RSAT) feature on Windows Server and client computers. Members of the AAD DC Administrators group can then administer Azure AD DS–managed domains remotely using these Active Directory administrative tools from a computer that is joined to the managed domain.

Common ADAC actions, such as resetting a user account password or managing group membership, are available. However, these actions only work for users and groups created directly in the Azure AD DS–managed domain. Identity information only synchronizes from Azure AD to Azure AD DS; there's no writeback from Azure AD DS to Azure AD. As a result, you can't change passwords or managed group membership for users synchronized from Azure AD and have those changes synchronized back.

You can also use the Active Directory module for Windows PowerShell, which is installed as part of the administrative tools, to manage common actions in your Azure AD DS managed domain.

## Enable user accounts for Azure AD DS

To authenticate users on the managed domain, Azure AD DS needs password hashes in a format that's suitable for NTLM and Kerberos authentication. Azure AD doesn't generate or store password hashes in the format that's required for NTLM or Kerberos authentication until you enable Azure AD DS for your tenant. For security reasons, Azure AD also doesn't store any password credentials in clear-text form. Therefore, Azure AD can't automatically generate these NTLM or Kerberos password hashes based on users' existing credentials.

Once appropriately configured, the usable password hashes are stored in the Azure AD DS–managed domain. 

> [!CAUTION]
> If you delete this domain, any password hashes stored at that point are also deleted. 

Synchronized credential information in Azure AD can't be re-used if you later create an Azure AD DS–managed domain. As a result, you must reconfigure the password hash synchronization to store the password hashes again. Even then, previously domain-joined VMs or users won't be able to immediately authenticate because Azure AD needs to generate and store the password hashes in the new Azure AD DS managed domain.

The steps to generate and store these password hashes are different for cloud-only user accounts created in Azure AD versus user accounts that are synchronized from your on-premises directory using Azure AD Connect. A *cloud-only* user account is an account that is created in your Azure AD directory using either the Azure portal or Azure AD PowerShell cmdlets. These user accounts aren't synchronized from an on-premises directory.

For cloud-only user accounts, users must change their passwords before they can use Azure AD DS. This password change process causes the password hashes for both Kerberos and NTLM authentication to be generated and stored in Azure AD. The account isn't synchronized from Azure AD to Azure AD DS until the password is changed. As a result, you should either expire the passwords for all cloud users in the tenant who need to use Azure AD DS, which forces a password change on next sign-in, or instruct cloud users to manually change their passwords. However, you might need to enable self-service password reset for cloud users to reset their password.

There are a few things you need to start using Azure Virtual Desktop. Here you can find what prerequisites you need to complete to successfully provide your users with desktops and applications.

At a high level, you need:

 -  An Azure account with an active subscription
 -  A supported identity provider
 -  A supported operating system for session host virtual machines

## Azure account with an active subscription

You need an Azure account with an active subscription to deploy Azure Virtual Desktop. If you don't have one already, you can [create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).

To deploy Azure Virtual Desktop, you need to assign the relevant Azure role-based access control (RBAC) roles. The specific role requirements are covered in each of the related articles for deploying Azure Virtual Desktop, which are listed in the [Next steps](/azure/virtual-desktop/prerequisites?tabs=portal#next-steps) section.

Also make sure you've registered the *Microsoft.DesktopVirtualization* resource provider for your subscription. To check the status of the resource provider and register if needed, select the relevant tab for your scenario and follow the steps.

> [!IMPORTANT]
> You must have permission to register a resource provider, which requires the \*/register/action operation. This is included if your account is assigned the [contributor or owner role](/azure/role-based-access-control/built-in-roles) on your subscription.

1.  Sign in to the [Azure portal](https://portal.azure.com/).
2.  Select Subscriptions.
3.  Select the name of your subscription.
4.  Select Resource providers.
5.  Search for Microsoft.DesktopVirtualization.
6.  If the status is *NotRegistered*, select Microsoft.DesktopVirtualization, and then select Register.
7.  Verify that the status of Microsoft.DesktopVirtualization is *Registered*.

## Identity

To access desktops and applications from your session hosts, your users need to be able to authenticate. [Microsoft Entra ID](/azure/active-directory/fundamentals/active-directory-whatis) is Microsoft's centralized cloud identity service that enables this capability. Microsoft Entra ID is always used to authenticate users for Azure Virtual Desktop. Session hosts can be joined to the same Microsoft Entra tenant, or to an Active Directory domain using [Active Directory Domain Services](/windows-server/identity/ad-ds/get-started/virtual-dc/active-directory-domain-services-overview) (AD DS) or [Microsoft Entra Domain Services](/azure/active-directory-domain-services/overview), providing you with a choice of flexible configuration options.

### Session hosts

You need to join session hosts that provide desktops and applications to the same Microsoft Entra tenant as your users, or an Active Directory domain (either AD DS or Microsoft Entra Domain Services).

For Azure Stack HCI, you can only join session hosts to an Active Directory Domain Services domain.

To join session hosts to Microsoft Entra ID or an Active Directory domain, you need the following permissions:

 -  For Microsoft Entra ID, you need an account that can join computers to your tenant. For more information, see [Manage device identities](/azure/active-directory/devices/manage-device-identities#configure-device-settings). To learn more about joining session hosts to Microsoft Entra ID, see [Microsoft Entra joined session hosts](/azure/virtual-desktop/azure-ad-joined-session-hosts).
 -  For an Active Directory domain, you need a domain account that can join computers to your domain. For Microsoft Entra Domain Services, you would need to be a member of the [*AAD DC Administrators* group](/azure/active-directory-domain-services/tutorial-create-instance-advanced#configure-an-administrative-group).

### Users

Your users need accounts that are in Microsoft Entra ID. If you're also using AD DS or Microsoft Entra Domain Services in your deployment of Azure Virtual Desktop, these accounts need to be [hybrid identities](/azure/active-directory/hybrid/whatis-hybrid-identity), which means the user accounts are synchronized. You need to keep the following things in mind based on which identity provider you use:

 -  If you're using Microsoft Entra ID with AD DS, you need to configure [Microsoft Entra Connect](/azure/active-directory/hybrid/whatis-azure-ad-connect) to synchronize user identity data between AD DS and Microsoft Entra ID.
 -  If you're using Microsoft Entra ID with Microsoft Entra Domain Services, user accounts are synchronized one way from Microsoft Entra ID to Microsoft Entra Domain Services. This synchronization process is automatic.

> [!IMPORTANT]
> The user account must exist in the Microsoft Entra tenant you use for Azure Virtual Desktop. Azure Virtual Desktop doesn't support [B2B](/azure/active-directory/external-identities/what-is-b2b), [B2C](/azure/active-directory-b2c/overview), or personal Microsoft accounts.

When using hybrid identities, either the UserPrincipalName (UPN) or the Security Identifier (SID) must match across Active Directory Domain Services and Microsoft Entra ID. For more information, see [Supported identities and authentication methods](/azure/virtual-desktop/authentication#hybrid-identity).

### Supported identity scenarios

The table summarizes identity scenarios that Azure Virtual Desktop currently supports:

| **Identity scenario**                                        | **Session hosts**                         | **User accounts**                                                       |
| ------------------------------------------------------------ | ----------------------------------------- | ----------------------------------------------------------------------- |
| Microsoft Entra ID + AD DS                                   | Joined to AD DS                           | In Microsoft Entra ID and AD DS, synchronized                           |
| Microsoft Entra ID + AD DS                                   | Joined to Microsoft Entra ID              | In Microsoft Entra ID and AD DS, synchronized                           |
| Microsoft Entra ID + Microsoft Entra Domain Services         | Joined to Microsoft Entra Domain Services | In Microsoft Entra ID and Microsoft Entra Domain Services, synchronized |
| Microsoft Entra ID + Microsoft Entra Domain Services + AD DS | Joined to Microsoft Entra Domain Services | In Microsoft Entra ID and AD DS, synchronized                           |
| Microsoft Entra ID + Microsoft Entra Domain Services         | Joined to Microsoft Entra ID              | In Microsoft Entra ID and Microsoft Entra Domain Services, synchronized |
| Microsoft Entra-only                                         | Joined to Microsoft Entra ID              | In Microsoft Entra ID                                                   |

For more detailed information about supported identity scenarios, including single sign-on and multifactor authentication, see [Supported identities and authentication methods](/azure/virtual-desktop/authentication).

### FSLogix Profile Container

To use [FSLogix Profile Container](/fslogix/configure-profile-container-tutorial) when joining your session hosts to Microsoft Entra ID, you need to [store profiles on Azure Files](/azure/virtual-desktop/create-profile-container-azure-ad) or [Azure NetApp Files](/azure/virtual-desktop/create-fslogix-profile-container) and your user accounts must be [hybrid identities](/azure/active-directory/hybrid/whatis-hybrid-identity). You must create these accounts in AD DS and synchronize them to Microsoft Entra ID.

### Deployment parameters

You need to enter the following identity parameters when deploying session hosts:

 -  Domain name, if using AD DS or Microsoft Entra Domain Services.
 -  Credentials to join session hosts to the domain.
 -  Organizational Unit (OU), which is an optional parameter that lets you place session hosts in the desired OU at deployment time.

> [!IMPORTANT]
> The account you use for joining a domain can't have multifactor authentication (MFA) enabled.

In this unit, we'll give you a brief overview of what kinds of identities and authentication methods you can use in Azure Virtual Desktop.

## Identities

Azure Virtual Desktop supports different types of identities depending on which configuration you choose. This section explains which identities you can use for each configuration.

> [!IMPORTANT]
> Azure Virtual Desktop doesn't support signing in to Microsoft Entra ID with one user account, then signing in to Windows with a separate user account. Signing in with two different accounts at the same time can lead to users reconnecting to the wrong session host, incorrect or missing information in the Azure portal, and error messages appearing while using app attach or MSIX app attach.

### On-premises identity

Since users must be discoverable through Microsoft Entra ID to access the Azure Virtual Desktop, user identities that exist only in Active Directory Domain Services (AD DS) aren't supported. This includes standalone Active Directory deployments with Active Directory Federation Services (AD FS).

### Hybrid identity

Azure Virtual Desktop supports [hybrid identities](/entra/identity/hybrid/whatis-hybrid-identity) through Microsoft Entra ID, including those federated using AD FS. You can manage these user identities in AD DS and sync them to Microsoft Entra ID using [Microsoft Entra Connect](/entra/identity/hybrid/connect/whatis-azure-ad-connect). You can also use Microsoft Entra ID to manage these identities and sync them to [Microsoft Entra Domain Services](/azure/active-directory-domain-services/overview).

When accessing Azure Virtual Desktop using hybrid identities, sometimes the User Principal Name (UPN) or Security Identifier (SID) for the user in Active Directory (AD) and Microsoft Entra ID don't match. For example, the AD account user@contoso.local may correspond to user@contoso.com in Microsoft Entra ID. Azure Virtual Desktop only supports this type of configuration if either the UPN or SID for both your AD and Microsoft Entra ID accounts match. SID refers to the user object property "ObjectSID" in AD and "OnPremisesSecurityIdentifier" in Microsoft Entra ID.

### Cloud-only identity

Azure Virtual Desktop supports cloud-only identities when using [Microsoft Entra joined VMs](/azure/virtual-desktop/deploy-azure-ad-joined-vm). These users are created and managed directly in Microsoft Entra ID.

> [!NOTE]
> You can also assign hybrid identities to Azure Virtual Desktop Application groups that host Session hosts of join type Microsoft Entra joined.

### Third-party identity providers

If you're using an Identity Provider (IdP) other than Microsoft Entra ID to manage your user accounts, you must ensure that:

 -  Your IdP is [federated with Microsoft Entra ID](/azure/active-directory/devices/azureadjoin-plan#federated-environment).
 -  Your session hosts are Microsoft Entra joined or [Microsoft Entra hybrid joined](/azure/active-directory/devices/hybrid-join-plan).
 -  You enable [Microsoft Entra authentication](/azure/virtual-desktop/configure-single-sign-on) to the session host.

### External identity

Azure Virtual Desktop currently doesn't support [external identities](/azure/active-directory/external-identities/).

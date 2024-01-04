Azure Stack Hub uses a single-tenant topolog. When choosing an identity provider to use with Azure Stack Hub, you should understand the important differences between the options of Microsoft Entra ID and Active Directory Federation Services (AD FS).

## Capabilities and limitations

The identity provider that you choose can limit your options, including support for multi-tenancy.

:::row:::
  :::column:::
    **Capability or scenario**
  :::column-end:::
  :::column:::
    **Microsoft Entra ID**
  :::column-end:::
  :::column:::
    **AD FS**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Connected to the internet.
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Optional
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Support for multi-tenancy.
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    No
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Offer items in the Marketplace.
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes (requires use of the offline Marketplace Syndication tool)
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Support for Active Directory Authentication Library (ADAL)
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Support for tools such as Azure CLI, Visual Studio, and PowerShell
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Create service principals through the Azure portal.
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    No
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Create service principals with certificates.
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Create service principals with secrets (keys).
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Applications can use the Graph service.
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    No
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Applications can use identity provider for sign-in.
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
  :::column:::
    Yes (requires apps to federate with on-premises AD FS instances)
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Managed System Identities.
  :::column-end:::
  :::column:::
    No
  :::column-end:::
  :::column:::
    No
  :::column-end:::
:::row-end:::


## Topologies

The following sections discuss the different identity topologies that you can use.

<a name='azure-ad-single-tenant-topology'></a>

### Microsoft Entra ID: single-tenant topology

By default, when you install Azure Stack Hub and use Microsoft Entra ID, Azure Stack Hub uses a single-tenant topology.

A single-tenant topology is useful when:

 -  All users are part of the same tenant.
 -  A service provider hosts an Azure Stack Hub instance for an organization.

:::image type="content" source="../media/azure-ad-single-tenant-topology-57c870bf.png" alt-text="Image showing Azure Stack Hub uses a single-tenant topology.":::


This topology features the following characteristics:

 -  Azure Stack Hub registers all apps and services to the same Microsoft Entra tenant directory.
 -  Azure Stack Hub authenticates only the users and apps from that directory, including tokens.
 -  Identities for administrators (cloud operators) and tenant users are in the same directory tenant.
 -  To enable a user from another directory to access this Azure Stack Hub environment, you must invite the user as a guest to the tenant directory.

<a name='azure-ad-multi-tenant-topology'></a>

### Microsoft Entra ID: multi-tenant topology

Cloud operators can configure Azure Stack Hub to allow access to apps by tenants from one or more organizations. Users access apps through the Azure Stack Hub user portal. In this configuration, the administrator portal (used by the cloud operator) is limited to users from a single directory.

A multi-tenant topology is useful when:

 -  A service provider wants to allow users from multiple organizations to access Azure Stack Hub.

:::image type="content" source="../media/azure-ad-multi-tenant-topology-a37080d0.png" alt-text="Image showing users from multiple organizations to access Azure Stack Hub.":::


This topology features the following characteristics:

 -  Access to resources should be on a per-organization basis.
 -  Users from one organization should be unable to grant access to resources to users who are outside their organization.
 -  Identities for administrators (cloud operators) can be in a separate directory tenant from the identities for users. This separation provides account isolation at the identity provider level.

### AD FS

The AD FS topology is required when either of the following conditions is true:

 -  Azure Stack Hub doesn't connect to the internet.
 -  Azure Stack Hub can connect to the internet, but you choose to use AD FS for your identity provider.

:::image type="content" source="../media/active-directory-ferderation-services-azure-stack-c6591266.png" alt-text="Image showing choices for using identity providers.":::


This topology features the following characteristics:

 -  To support the use of this topology in production, you must integrate the built-in Azure Stack Hub AD FS instance with an existing AD FS instance that's backed by Active Directory, through a federation trust.
 -  You can integrate the Graph service in Azure Stack Hub with your existing Active Directory instance. You can also use the OData-based Graph API service that supports APIs that are consistent with the Azure AD Graph API.

To interact with your Active Directory instance, the Graph API requires user credentials from your Active Directory instance that have read-only permissions.

 -  The built-in AD FS instance is based on Windows Server 2016.
 -  Your AD FS and Active Directory instances must be based on Windows Server 2012 or later.

Between your Active Directory instance and the built-in AD FS instance, interactions aren't restricted to OpenID Connect, and they can use any mutually supported protocol.

 -  User accounts are created and managed in your on-premises Active Directory instance.
 -  Service principals and registrations for apps are managed in the built-in Active Directory instance.

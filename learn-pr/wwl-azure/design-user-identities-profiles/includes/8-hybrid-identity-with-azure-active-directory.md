
Organizations are a mixture of on-premises and cloud applications. Users require access to those applications both on-premises and in the cloud.

Microsoft identity spans on-premises and cloud-based capabilities. These solutions create a common user identity for authentication and authorization to all resources, regardless of location.

To achieve hybrid identity with Azure AD, one of three authentication methods can be used, depending on your scenarios. The three methods are:

 -  [Password hash synchronization (PHS)](/azure/active-directory/hybrid/whatis-phs)
 -  [Pass-through authentication (PTA)](/azure/active-directory/hybrid/how-to-connect-pta)
 -  [Federation (AD FS)](/azure/active-directory/hybrid/whatis-fed)

These authentication methods also provide single-sign on capabilities. Single-sign on automatically signs your users in when they are on their corporate devices, connected to your corporate network.

## Common scenarios and recommendations

Below are common hybrid identity and access management scenarios with recommendations as to which hybrid identity option (or options) might be appropriate for each.

:::row:::
  :::column:::
    **I need to:**
  :::column-end:::
  :::column:::
    PHS and SSO1<sup>1</sup>
  :::column-end:::
  :::column:::
    PTA and SSO2<sup>2</sup>
  :::column-end:::
  :::column:::
    AD FS3<sup>3</sup>
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Sync new user, contact, and group accounts created in my on-premises Active Directory to the cloud automatically.
  :::column-end:::
  :::column:::
    Yes
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
    Set up my tenant for Office 365 hybrid scenarios.
  :::column-end:::
  :::column:::
    Yes
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
    Enable my users to sign in and access cloud services using their on-premises password.
  :::column-end:::
  :::column:::
    Yes
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
    Implement single sign-on using corporate credentials.
  :::column-end:::
  :::column:::
    Yes
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
    Ensure no password hashes are stored in the cloud.
  :::column-end:::
  :::column:::
    
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
    Enable cloud-based multifactor authentication solutions.
  :::column-end:::
  :::column:::
    Yes
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
    Enable on-premises multifactor authentication solutions.
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Support smartcard authentication for my users.<sup>4</sup>
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Display password expiry notifications in the Office Portal and on the Windows 10 desktop.
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    
  :::column-end:::
  :::column:::
    Yes
  :::column-end:::
:::row-end:::


<sup>1</sup> Password hash synchronization with single sign-on.

<sup>2</sup> Pass-through authentication and single sign-on.

<sup>3</sup> Federated single sign-on with AD FS.

<sup>4</sup> AD FS can be integrated with your enterprise PKI to allow sign-in using certificates. These certificates can be soft-certificates deployed via trusted provisioning channels such as MDM or GPO or smartcard certificates (including PIV/CAC cards) or Hello for Business.

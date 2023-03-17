
## Azure AD DS and Azure AD

Azure AD lets you manage the identity of devices used by the organization and control access to corporate resources from those devices. Users can also register their personal device (a bring-your-own (BYO) model) with Azure AD, which provides the device with an identity. Azure AD then authenticates the device when a user signs in to Azure AD and uses the device to access secured resources. The device can be managed using Mobile Device Management (MDM) software like Microsoft Intune. This management ability lets you restrict access to sensitive resources to managed and policy-compliant devices.

Traditional computers and laptops can also join Azure AD. This mechanism offers the same benefits of registering a personal device with Azure AD, such as allowing users to sign in to the device using their corporate credentials.

Azure AD joined devices give you the following benefits:

 -  Single sign-on (SSO) to applications secured by Azure AD.
 -  Enterprise policy-compliant roaming of user settings across devices.
 -  Access to the Windows Store for Business using corporate credentials.
 -  Windows Hello for Business.
 -  Restricted access to apps and resources from devices compliant with corporate policy.

Devices can be joined to Azure AD with or without a hybrid deployment that includes an on-premises AD DS environment. The following table outlines common device ownership models and how they would typically be joined to a domain:

:::row:::
  :::column:::
    **Type of device**
  :::column-end:::
  :::column:::
    **Device platforms**
  :::column-end:::
  :::column:::
    **Mechanism**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Personal devices
  :::column-end:::
  :::column:::
    Windows 10, iOS, Android, macOS
  :::column-end:::
  :::column:::
    Azure AD registered
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Organization-owned device not joined to on-premises AD DS
  :::column-end:::
  :::column:::
    Windows 10
  :::column-end:::
  :::column:::
    Azure AD joined
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Organization-owned device joined to an on-premises AD DS
  :::column-end:::
  :::column:::
    Windows 10
  :::column-end:::
  :::column:::
    Hybrid Azure AD joined
  :::column-end:::
:::row-end:::


On an Azure AD-joined or registered device, user authentication happens using modern OAuth / OpenID Connect-based protocols. These protocols are designed to work over the internet, so are great for mobile scenarios where users access corporate resources from anywhere.

With Azure AD DS-joined devices, applications can use the Kerberos and New Technology LAN Manager (NTLM) protocols for authentication, so can support legacy applications migrated to run on Azure VMs as part of a lift-and-shift strategy. The following table outlines differences in how the devices are represented and can authenticate themselves against the directory:

:::row:::
  :::column:::
    **Aspect**
  :::column-end:::
  :::column:::
    **Azure AD-joined**
  :::column-end:::
  :::column:::
    **Azure AD-joined**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Device controlled by
  :::column-end:::
  :::column:::
    Azure AD
  :::column-end:::
  :::column:::
    Azure AD Domain Services managed domain
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Representation in the directory
  :::column-end:::
  :::column:::
    Device objects in the Azure AD directory
  :::column-end:::
  :::column:::
    Computer objects in the Azure AD DS managed domain
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Authentication
  :::column-end:::
  :::column:::
    Open Authorization OAuth / OpenID Connect-based protocols
  :::column-end:::
  :::column:::
    Kerberos and NTLM protocols
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Management
  :::column-end:::
  :::column:::
    Mobile Device Management (MDM) software like Intune
  :::column-end:::
  :::column:::
    Group Policy
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Networking
  :::column-end:::
  :::column:::
    Works over the internet
  :::column-end:::
  :::column:::
    Must be connected to, or peered with, the virtual network where the managed domain is deployed
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Great for...
  :::column-end:::
  :::column:::
    End-user mobile or desktop devices
  :::column-end:::
  :::column:::
    Server VMs deployed in Azure
  :::column-end:::
:::row-end:::


If on-premises AD DS and Azure AD are configured for federated authentication using Active Directory Federation Services (ADFS), then there's no (current/valid) password hash available in Azure DS. Azure AD user accounts created before fed auth was implemented might have an old password hash that doesn't match a hash of their on-premises password. Hence Azure AD DS won't validate the user's credentials.

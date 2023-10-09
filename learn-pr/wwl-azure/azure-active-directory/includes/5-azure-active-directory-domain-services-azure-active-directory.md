Azure AD lets you manage the identity of devices used by the organization and control access to corporate resources from those devices. Users can also register their personal device (a bring-your-own (BYO) model) with Azure AD, which provides the device with an identity. Azure AD then authenticates the device when a user signs in to Azure AD and uses the device to access secured resources. The device can be managed using Mobile Device Management (MDM) software like Microsoft Intune. This management ability lets you restrict access to sensitive resources to managed and policy-compliant devices.

Traditional computers and laptops can also join Azure AD. This mechanism offers the same benefits of registering a personal device with Azure AD, such as allowing users to sign in to the device using their corporate credentials.

Azure AD joined devices give you the following benefits:

 -  Single sign-on (SSO) to applications secured by Azure AD.
 -  Enterprise policy-compliant roaming of user settings across devices.
 -  Access to the Windows Store for Business using corporate credentials.
 -  Windows Hello for Business.
 -  Restricted access to apps and resources from devices compliant with corporate policy.

Devices can be joined to Azure AD with or without a hybrid deployment that includes an on-premises AD DS environment. The following table outlines common device ownership models and how they would typically be joined to a domain:

| **Type of device**                                        | **Device platforms**            | **Mechanism**          |
| --------------------------------------------------------- | ------------------------------- | ---------------------- |
| Personal devices                                          | Windows 10, iOS, Android, macOS | Azure AD registered    |
| Organization-owned device not joined to on-premises AD DS | Windows 10                      | Azure AD joined        |
| Organization-owned device joined to an on-premises AD DS  | Windows 10                      | Hybrid Azure AD joined |

On an Azure AD-joined or registered device, user authentication happens using modern OAuth / OpenID Connect-based protocols. These protocols are designed to work over the internet, so are great for mobile scenarios where users access corporate resources from anywhere.

With Azure AD DS-joined devices, applications can use the Kerberos and New Technology LAN Manager (NTLM) protocols for authentication, so can support legacy applications migrated to run on Azure VMs as part of a lift-and-shift strategy. The following table outlines differences in how the devices are represented and can authenticate themselves against the directory:

| **Aspect**                      | **Azure AD-joined**                                       | **Azure AD DS-joined**                                                                         |
| ------------------------------- | --------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| Device controlled by            | Azure AD                                                  | Azure AD Domain Services managed domain                                                        |
| Representation in the directory | Device objects in the Azure AD directory                  | Computer objects in the Azure AD DS managed domain                                             |
| Authentication                  | Open Authorization OAuth / OpenID Connect-based protocols | Kerberos and NTLM protocols                                                                    |
| Management                      | Mobile Device Management (MDM) software like Intune       | Group Policy                                                                                   |
| Networking                      | Works over the internet                                   | Must be connected to, or peered with, the virtual network where the managed domain is deployed |
| Great for...                    | End-user mobile or desktop devices                        | Server VMs deployed in Azure                                                                   |

If on-premises AD DS and Azure AD are configured for federated authentication using Active Directory Federation Services (ADFS), then there's no (current/valid) password hash available in Azure DS. Azure AD user accounts created before fed auth was implemented might have an old password hash that doesn't match a hash of their on-premises password. Hence Azure AD DS won't validate the user's credentials.

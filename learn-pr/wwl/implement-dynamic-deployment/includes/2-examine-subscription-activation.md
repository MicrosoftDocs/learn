
Activating a Windows subscription is necessary to comply with licensing requirements. Activation links the Windows product key to a particular installation of Windows on a device. It assures software integrity and provides you with access to Microsoft support and a full range of updates. There are three main methods for activation:

 -  Retail
 -  OEM
 -  Microsoft Volume Licensing (volume activation)

Microsoft Volume Licensing customers use Volume Activation Services to assist with activation tasks, which consist of Active Directory–based activation, Key Management Service (KMS), and multiple activation key (MAK) models.

### Current volume activation methods

Enterprise environments use three main types of volume activation models and a service that runs on Windows Server 2016. You can use any or all of the options that are associated with these models, depending on your organization’s needs and network infrastructure, including:

 -  **Key Management Service (KMS)**. This is a role service that you can use to activate systems within your network from a computer where a KMS host has been installed. By default, volume editions of Windows connect to a system that hosts the KMS service to request activation. No action is required from users.
 -  **Multiple Activation Key (MAK)**. This method of activation uses product keys that can activate a specific number of computers. You can use MAKs to activate any Windows volume edition.
 -  **Active Directory-based activation**. This is a role service that allows you to use AD DS to store activation objects, which can help simplify the maintenance of volume activation services for a network. When you use Active Directory-based activation, you don't need a host server, as in KMS, and activation requests process during client computer startup.

### Subscription Activation

Frequently, devices are purchased with Windows Pro already installed with a firmware embedded key. Traditionally, the machine needed to be re-imaged with the correct edition, typically Enterprise edition. Subscription activation removes the need for this, transforming a Windows Pro device into a Windows Enterprise device, without the need to re-image and reboot the device.

You can deploy Windows Enterprise E3/E5/A3/A5 licenses within your organization by using Windows Enterprise Subscription Activation or Windows Enterprise E3 in CSP and Azure AD. You can deploy Windows Enterprise licenses in the following ways:

 -  **Enabling Subscription Activation with an existing Enterprise Agreement (EA)**. If you're an existing EA customer, you can get Windows Enterprise E3 or E5 licenses for free, depending on your EA.
 -  **Enabling Subscription Activation without an existing EA**. You must purchase the licenses from a cloud solution provider (CSP) before you can assign them.

#### Subscription Activation requirements

To implement Subscription Activation, your organization must meet the following requirements:

 -  Windows Pro/Pro Education/Enterprise/Education is installed and activated on the devices you want to upgrade.
 -  An instance of Azure AD is available for identity management.
 -  Devices to upgrade are either Azure AD-joined or Hybrid Azure AD-joined.
 -  For education, the Education tenant must have an active subscription to Microsoft 365 with a Windows Enterprise license or a Windows Enterprise or Education subscription.

#### How Subscription Activation works

With Subscription Activation users can upgrade their devices from Windows Pro to Windows Enterprise without entering a product key, and without requiring the users to restart their computers. Subscription Activation is possible with Windows Pro or Windows Enterprise. Your organization requires either:

 -  **An EA or a Microsoft Products and Services Agreement (MPSA)**. When a licensed user signs in using Azure AD credentials that are associated with a Windows 11 Enterprise E3/E5 or A3/A5 license on a device, which meets the above requirements, the operating system switches from Windows Pro to Windows Enterprise. All the appropriate Windows Enterprise features are available. When a user’s Azure AD subscription expires, or you transfer the subscription to another user, the Windows Enterprise device reverts back to Windows Pro edition. This occurs after a grace period of up to 90 days.
 -  **An Enterprise E3 subscription via a CSP**. Windows Enterprise E3 in CSP delivers, by subscription, exclusive features reserved for Windows Enterprise edition. Windows Enterprise E3 is available through a subscription-based model and delivers Windows Enterprise edition features. In a subscription-based model you pay a monthly fee for using Windows, and you don’t need to buy them before you can start using them. This offering is available through the CSP channel through the Partner Center as an online service. Windows Enterprise E3 in CSP provides a flexible, per-user subscription for small- and medium-sized companies, ranging from one to hundreds of users. As with the previous scenario, when a user signs in with Azure AD credentials that are associated with a Windows Enterprise E3 license, the operating system switches from Windows Pro to Windows Enterprise.

### VDA Subscription Activation

You can also take advantage of subscriptions to Windows Enterprise for virtualized clients. Windows Enterprise E3 and E5 are available for Virtual Desktop Access (VDA) in Microsoft Azure or in another appropriate hosting platform. To support this, you must configure your VMs to enable Windows Enterprise subscriptions for VDA. Both AD DS-joined and Azure AD-joined clients are supported.

VDA Subscription Activation also supports Inherited Activation starting with Windows 10, version 1803. It enables a Windows VM to inherit its activation state from the Windows host. When a user with Windows E3 or E5 license creates a Windows VM on their Windows host, the VM inherits the activation state from a host machine.

#### VDA Subscription Activation requirements

To enable Windows Subscription Activation, your VMs must:

 -  Run Windows 11 Pro
 -  Be a member of an AD DS domain or Azure AD-joined
 -  Be generation 1
 -  Be hosted by a Qualified Multitenant Hoster (QMTH), such as Microsoft Azure

#### Inherited activation

Windows virtual machines to inherit activation state from their Windows host. When a Windows user with an E3/E5/A3/A5 license creates a new Windows VM on the Windows host, the VM inherits the activation state.

For further details, visit [Windows Subscription Activation](/windows/deployment/windows-10-enterprise-subscription-activation).

Passwords are a primary attack vector. Bad actors use social engineering, phishing, and spray attacks to compromise passwords. A passwordless authentication strategy mitigates the risk of these attacks.

Microsoft offers the following three passwordless authentication options that integrate with Microsoft Entra ID:

1.  Microsoft Authenticator - turns any iOS or Android phone into a strong, passwordless credential by allowing users to sign into any platform or browser.
2.  FIDO2-compliant security keys - useful for users who sign in to shared machines like kiosks, in situations where use of phones is restricted, and for highly privileged identities.
3.  Windows Hello for Business - best for users on their dedicated Windows computers.

## Use the passwordless methods wizard

The [Microsoft Entra admin center](https://entra.microsoft.com/) has a passwordless methods wizard that will help you to select the appropriate method for each of your audiences.

## Passwordless authentication scenarios

Microsoft's passwordless authentication methods enable many scenarios. Consider your organizational needs, prerequisites, and the capabilities of each authentication method to select your passwordless authentication strategy.

The following table lists the passwordless authentication methods by device types.

| **Device types**                                        | **Passwordless authentication method**                    |
| ------------------------------------------------------- | --------------------------------------------------------- |
| Dedicated non-windows devices                           | *Microsoft Authenticator*  Security keys                  |
| Dedicated Windows 10 computers (version 1703 and later) | *Windows Hello for Business*  Security keys               |
| Dedicated Windows 10 computers (before version 1703)    | *Windows Hello for Business*  Microsoft Authenticator app |
| Shared devices: tablets, and mobile devices             | *Microsoft Authenticator*  One-time password sign-in      |
| Kiosks (Legacy)                                         | *Microsoft Authenticator*                                 |
| Kiosks and shared computers ‎(Windows 10)               | *Security keys*  Microsoft Authenticator app              |

## Prerequisites

Ensure you meet the prerequisites before starting your passwordless deployment.

### Required roles

Here are the least privileged roles required for this deployment

| **Microsoft Entra role**                   | **Description**                                                                                           |
| ------------------------------------------ | --------------------------------------------------------------------------------------------------------- |
| User Administrator or Global Administrator | To implement combined registration experience.                                                            |
| Authentication Administrator               | To implement and manage authentication methods.                                                           |
| User                                       | To configure Authenticator app on device, or to enroll security key device for web or Windows 10 sign-in. |

As part of this deployment plan, we recommend that passwordless authentication be enabled for all privileged accounts.

### Microsoft Authenticator app and security keys

The prerequisites are determined by your selected passwordless authentication methods.

| **Prerequisite**                                                                                                                                                                                                                                | **Microsoft Authenticator** | **FIDO2 Security Keys** |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------- | ----------------------- |
| [Combined registration for Microsoft Entra multifactor authentication and self-service password reset (SSPR)](/entra/identity/authentication/howto-registration-mfa-sspr-combined) is enabled                        | √                           | √                       |
| [Users can perform Microsoft Entra multifactor authentication](/entra/identity/authentication/howto-mfa-getstarted)                                                                                                  | √                           | √                       |
| [Users have registered for Microsoft Entra multifactor authentication and SSPR](/entra/identity/authentication/howto-registration-mfa-sspr-combined)                                                                 | √                           | √                       |
| [Users have registered their mobile devices to Microsoft Entra ID](/entra/identity/devices/overview)                                                                                                                 | √                           |                         |
| Windows 10 version 1809 or higher using a supported browser like Microsoft Edge or Mozilla Firefox (version 67 or higher). Microsoft recommends version 1903 or higher for native support.                                                      |                             | √                       |
| Compatible security keys. Ensure that you're using a [Microsoft-tested and verified FIDO2 security key](/entra/identity/authentication/concept-authentication-passwordless), or other compatible FIDO2 security key. |                             | √                       |

|

### Windows Hello for Business

The prerequisites and deployment paths for Windows Hello for Business are highly dependent on whether you're deploying in an on-premises, hybrid, or cloud-only configuration. It's also dependent on your device join strategy.

Select Windows Hello for Business and complete the wizard to determine the prerequisites and deployment appropriate for your organization.<br>

:::image type="content" source="../media/passwordless-wizard-select-52e6cad2.png" alt-text="Screenshot showing the Windows Hello for Business configuration page.":::


The wizard will use your inputs to craft a step-by-step plan for you to follow.

## Plan the project

When technology projects fail, it's typically because of mismatched expectations on impact, outcomes, and responsibilities. To avoid these pitfalls, ensure that you're engaging the right stakeholders and that stakeholder roles in the project are well understood.

### Plan a pilot

When you deploy passwordless authentication, you should first enable one or more pilot groups. You can create groups specifically for this purpose. Add the users who will participate in the pilot to the groups. Then, enable new passwordless authentication methods for the selected groups.

### Plan communications

Your communications to end users should include the following information:

 -  Guidance on combined registration for both Microsoft Entra multifactor authentication and self-service password reset (SSPR)
 -  Downloading Microsoft Authenticator
 -  Registering in Microsoft Authenticator
 -  Signing in with your phone

Microsoft provides communication templates for end users. Download the authentication rollout material to help draft your communications. The rollout materials include customizable posters and email templates that you can use to inform your users about upcoming passwordless authentication options in your organization.

### Plan user registration

Users register their passwordless method as a part of the combined security information workflow at [https://aka.ms/mysecurityinfo](https://aka.ms/mysecurityinfo). Microsoft Entra logs registration of security keys and the Authenticator app, and any other changes to the authentication methods.

For the first-time user who doesn't have a password, admins can provide a [Temporary Access Passcode](/entra/identity/authentication/howto-authentication-temporary-access-pass) to register their security information in [https://aka.ms/mysecurityinfo](https://aka.ms/mysecurityinfo) . This is a time-limited passcode and satisfies strong authentication requirements. Temporary Access Pass is a per-user process.

This method can also be used for easy recovery when the user has lost or forgotten their authentication factor such as security key or the Authenticator app but needs to sign in to register a new strong authentication method.

> [!NOTE]
> If you can't use the security key or the Authenticator app for some scenarios, multifactor authentication with a username and password along with another registered method can be used as a fallback option.

## Plan for and deploy Microsoft Authenticator

Microsoft Authenticator turns any iOS or Android phone into a strong, passwordless credential. It's a free download from Google Play or the Apple App Store. Have users download Microsoft Authenticator and follow the directions to enable phone sign-in.

### Technical considerations

Active Directory Federation Services (AD FS) Integration - When a user enables the Authenticator passwordless credential, authentication for that user defaults to sending a notification for approval. Users in a hybrid tenant are prevented from being directed to AD FS for sign-in unless they select "Use your password instead." This process also bypasses any on-premises Conditional Access policies, and pass-through authentication (PTA) flows. However, if a login\_hint is specified, the user is forwarded to AD FS and bypasses the option to use the passwordless credential. For non-Microsoft 365 applications which use AD FS for authentication, Microsoft Entra Conditional Access policies will not be applied and you will need to set up access control policies within AD FS.

MFA server - End users enabled for multifactor authentication through an organization's on-premises MFA server can create and use a single passwordless phone sign-in credential. If the user attempts to upgrade multiple installations (5 or more) of the Authenticator app with the credential, this change may result in an error.<br>

Device registration - To use the Authenticator app for passwordless authentication, the device must be registered in the Microsoft Entra tenant and can't be a shared device. A device can only be registered in a single tenant. This limit means that only one work or school account is supported for phone sign-in using the Authenticator app.

### Deploy phone sign-in with the Authenticator app

Follow the steps in the article, Enable passwordless sign-in with Microsoft Authenticator to enable the Authenticator app as a passwordless authentication method in your organization.

### Testing Authenticator app

The following are sample test cases for passwordless authentication with the Authenticator app:

| **Scenario**                                                                                                                                                                                                                    | **Expected results**                                                                       |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| User can register the Authenticator app.                                                                                                                                                                                        | User can register app from [https://aka.ms/mysecurityinfo](https://aka.ms/mysecurityinfo). |
| User can enable phone sign-in                                                                                                                                                                                                   | Phone sign-in configured for work account.                                                 |
| User can access an app with phone sign-in.                                                                                                                                                                                      | User goes through phone sign-in flow and reaches application.                              |
| Test rolling back phone sign-in registration by turning off passwordless sign-in in the Authenticator app. Do this within the Authentication methods screen in the [Microsoft Entra admin center](https://entra.microsoft.com/) | Previously enabled users unable to use passwordless sign-in from the Authenticator app.    |
| Removing phone sign-in from the Authenticator app                                                                                                                                                                               | Work account no longer available on the Authenticator app.                                 |

### Troubleshoot phone sign-in

| **Scenario**                                                                                                                         | **Solution**                                                                                                                                                                                                                                                          |
| ------------------------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| User cannot perform combined registration.                                                                                           | Ensure [combined registration](/entra/identity/authentication/concept-registration-mfa-sspr-combined) is enabled.                                                                                                                          |
| User cannot enable phone sign-in authenticator app.                                                                                  | Ensure user is in scope for deployment.                                                                                                                                                                                                                               |
| User is NOT in scope for passwordless authentication, but is presented with passwordless sign-in option, which they cannot complete. | Occurs when user has enabled phone sign in in the application prior to the policy being created. To enable sign in, add the user to a group of users enabled for passwordless sign-in. To block sign in: have the user remove their credential from that application. |

## Plan for and deploy FIDO2-compliant security keys

Enable compatible security keys. Here is a list of FIDO2 security key providers that provide keys known to be compatible with the passwordless experience.

### Plan security key lifecycle

Prepare for and plan the key lifecycle.

Key distribution- Plan how to provision keys to your organization. You may have a centralized provisioning process or allow end users to purchase FIDO 2.0-compatible keys.

Key activation - End users must self-activate the security key. End users register their security keys and enable the second factor (PIN or biometric) at first use. For first-time users, they can use TAP to register their security information.

Disabling a key - If an administrator wishes to remove a FIDO2 key associated with a User Account, they can do so by deleting the key from the user's authentication method as shown below. For more information, see Disable a key

Issue a new key: User can register the new FIDO2 key

### Technical considerations

There are three types of passwordless sign-in deployments available with security keys:

1.  Microsoft Entra web apps on a supported browser
2.  Microsoft Entra joined Windows 10 devices
3.  Microsoft Entra hybrid joined Windows 10 devices
    
    
     -  Provides access to both cloud-based and on premises resources. For more information about access to on-premises resources, see [SSO to on-premises resources using FIDO2 keys](/entra/identity/authentication/howto-authentication-passwordless-security-key-on-premises)

#### For Microsoft Entra web apps and Microsoft Entra joined Windows devices, use:

 -  Windows 10 version 1809 or higher using a supported browser like Microsoft Edge or Mozilla Firefox (version 67 or higher).
 -  Windows 10 version 1809 supports FIDO2 sign-in and may require software from the FIDO2 key manufacturer to be deployed. We recommend you use version 1903 or later.

#### For hybrid Microsoft Entra domain joined devices, **use:**

 -  Windows 10 version 2004 or later.
 -  Fully patched domain servers running Windows Server 2016 or 2019.
 -  Latest version of Microsoft Entra Connect.

### Enable Windows 10 support

Enabling Windows 10 sign-in using FIDO2 security keys requires you to enable the credential provider functionality in Windows 10. Choose one of the following:

 -  Enable credential provider with Microsoft Intune
     -  We recommend Microsoft Intune deployment.
 -  Enable credential provider with a provisioning package
     -  If Microsoft Intune deployment isn't possible, administrators must deploy a package on each machine to enable the credential provider functionality. The package installation can be carried out by one of the following options:
         -  Group Policy or Configuration Manager
         -  Local installation on a Windows 10 machine
 -  Enable credential provider with Group Policy
     -  Only supported for Microsoft Entra hybrid joined devices.

### Key restrictions policy

When you deploy the security key, you can optionally restrict the use of FIDO2 keys only to specific manufacturers that have been approved by your organization. Restricting keys requires the Authenticator Attestation GUID (AAGUID). There are two ways to get your AAGUID.

:::image type="content" source="../media/security-key-enforce-key-restriction-6dd07803.png" alt-text="Screenshot showing the Authenticator Attestation user interface settings page.":::


1. If the security key is restricted, and the user tries to register the FIDO2 security key, they receive the following error:

:::image type="content" source="../media/security-key-restricted-error-c11372d7.png" alt-text="Screenshot showing the security key restricted error notification.":::


2. If the security key is restricted, and the user tries to register the FIDO2 security key, they receive the following error:

:::image type="content" source="../media/security-key-block-user-window-792f70f3.png" alt-text="Screenshot showing the security key block user notification.":::


\*FIDO2 key blocked by Key Restriction Policy

## Deploy FIDO2 security key sign-in

Follow the steps in the article [Enable passwordless security key sign-in](/entra/identity/authentication/howto-authentication-passwordless-security-key) to enable FIDO2 security key as a passwordless authentication method in your organization.

### Testing security keys

Here are the sample test cases for passwordless authentication with security keys

### Passwordless FIDO sign in to Microsoft Entra joined Windows 10 devices

| **Scenario (Windows build)**                  | **Expected results**                                                                                                                   |
| --------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| The user can register FIDO2 device (1809)     | User can register FIDO2 device using at Settings &gt; Accounts &gt; sign in options &gt; Security Key |
| The user can reset FIDO2 device (1809)        | User can reset FIDO2 device using manufacturer software                                                                                |
| The user can sign in with FIDO2 device (1809) | User can select Security Key from the sign-in window, and successfully sign in.                                                        |
| The user can register FIDO2 device (1903)     | User can register FIDO2 device at Settings &gt; Accounts &gt; sign in options &gt; Security Key       |
| The user can reset FIDO2 device (1903)        | User can reset FIDO2 device at Settings &gt; Accounts &gt; sign in options &gt; Security Key          |
| The user can sign in with FIDO2 device (1903) | User can select Security Key from the sign-in window, and successfully sign in.                                                        |

### Passwordless FIDO sign-in to Microsoft Entra web apps

| **Scenario**                                                                                                                                               | **Expected results**                                                                                                                                                                                                                                                                                                                 |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| The user can register FIDO2 device at aka.ms/mysecurityinfo using Microsoft Edge                                                                           | Registration should succeed                                                                                                                                                                                                                                                                                                          |
| The user can register FIDO2 device at aka.ms/mysecurityinfo using Firefox                                                                                  | Registration should succeed                                                                                                                                                                                                                                                                                                          |
| The user can sign in to OneDrive online using FIDO2 device using Microsoft Edge                                                                            | Sign-in should succeed                                                                                                                                                                                                                                                                                                               |
| The user can sign in to OneDrive online using FIDO2 device using Firefox                                                                                   | Sign-in should succeed                                                                                                                                                                                                                                                                                                               |
| Test rolling back FIDO2 device registration by turning off FIDO2 Security Keys within the Authentication method window in the Microsoft Entra admin center | Users will:  be prompted to sign in using their security key  successfully sign in and see an error: "Your company policy requires that you use a different method to sign in".  be able to select a different method and successfully sign in. Close the window and sign in again to verify they do not see the same error message. |

### Troubleshoot security key sign-in

| **Scenario**                                                                               | **Solution**                                                                                                                                                                                                                                                                                                                          |
| ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| User can't perform combined registration.                                                  | Ensure [combined registration](/entra/identity/authentication/concept-registration-mfa-sspr-combined) is enabled.                                                                                                                                                                                          |
| User can't add a security key in their [security settings](https://aka.ms/mysecurityinfo). | Ensure that [security keys](/entra/identity/authentication/howto-authentication-passwordless-security-key) are enabled.                                                                                                                                                                                    |
| User can't add security key in Windows 10 sign-in options.                                 | [Ensure that security keys for Windows sign in](/entra/identity/authentication/concept-authentication-passwordless) are enabled                                                                                                                                                                            |
| Error message: We detected that this browser or OS doesn't support FIDO2 security keys.    | Passwordless FIDO2 security devices can only be registered in supported browsers (Microsoft Edge, Firefox version 67) on Windows 10 version 1809 or higher.                                                                                                                                                                           |
| Error message: Your company policy requires that you use a different method to sign in.    | Ensure security keys are enabled in the tenant.                                                                                                                                                                                                                                                                                       |
| User unable to manage my security key on Windows 10 version 1809                           | Version 1809 requires that you use the security key management software provided by the FIDO2 key vendor. Contact the vendor for support.                                                                                                                                                                                             |
| I think my FIDO2 security key may be defective—how can I test it.                          | Navigate to [https://webauthntest.azurewebsites.net/](https://webauthntest.azurewebsites.net/), enter credentials for a test account, plug in the suspect security key, select the + button at the top right of the screen, select create, and go through the creation process. If this scenario fails, your device may be defective. |

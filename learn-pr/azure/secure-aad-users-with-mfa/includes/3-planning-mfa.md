Before you start deploying Microsoft Entra multifactor authentication, there are several things you should decide.

First, consider rolling out MFA in waves. Start with a small group of pilot users to evaluate the complexity of your environment and identify any setup issues or unsupported apps or devices. Then, broaden that group over time and evaluate the results with each pass until your entire company is enrolled.

Next, make sure to create a full communication plan. Microsoft Entra multifactor authentication has several user-interaction requirements, including a registration process. Keep users informed every step of the way. Let them know what they're required to do, important dates, and how to get answers to questions if they have trouble. Microsoft provides [communication templates](https://www.microsoft.com/download/details.aspx?id=57600&WT.mc_id=rss_alldownloads_all) to help draft your communications, including posters and email templates.

<a name='azure-ad-mfa-policies'></a>

## Microsoft Entra multifactor authentication policies

Microsoft Entra multifactor authentication is enforced with *Conditional Access* policies. Conditional Access policies are `IF-THEN` statements. *IF* a user wants to access a resource, *THEN* they must complete an action. For example, a payroll manager wants to access the payroll application and is required to perform multifactor authentication to access it. Other common access requests that might require MFA include:

- IF a specific cloud application is accessed
- IF a user is accessing a specific network
- IF a user is accessing a specific client application
- IF a user is registering a new device

## Deciding supported authentication methods

When you turn on Microsoft Entra multifactor authentication, you can choose the authentication methods that you want to make available. You should always support more than one method so users have a backup option in case their primary method is unavailable. You can choose from the following methods:

| Method | Description |
|--------|-------------|
| **Mobile App Verification code** | A mobile authentication app such as the Microsoft Authenticator app can be used to retrieve an OATH verification code, which is then entered into the sign-in interface. This code is changed every 30 seconds and the app works even if connectivity is limited. This approach doesn't work in China on Android devices. |
| **Mobile app notification** | Azure can send a push notification to a mobile authentication app such as Microsoft Authenticator. The user can select the push notification and verify the sign-in. |
| **Call to a phone** | Azure can call a supplied phone number. The user then approves the authentication using the keypad. This method is preferred for backups. |
| **FIDO2 security key** | FIDO2 security keys are an unphishable standards-based passwordless authentication method. These keys are typically USB devices, but could also use Bluetooth or NFC. |
| **Windows Hello for Business** | Windows Hello for Business replaces passwords with strong two-factor authentication on devices. This authentication consists of a type of user credential that is tied to a device and uses a biometric or PIN. |
| **OATH tokens** | OATH tokens can be software applications such as the Microsoft Authenticator app and other authenticator apps, or hardware-based tokens that customers can purchase from different vendors. |

Administrators can enable one or more of these options, then users can opt in to each support authentication method they want to use.

## Selecting an authentication method

Finally, you must decide how users register their selected methods. The easiest approach is to use *Microsoft Entra ID Protection*. If your organization has a license for Identity Protection, you can configure it to prompt users to register for MFA the next time they sign in.

You can also prompt users to register for MFA when they try to use an application or service that requires multifactor authentication. Finally, you can enforce registration using a Conditional Access policy applied to an Azure group containing all users in your organization. This approach requires some manual work to periodically review the group to remove registered users. For some useful scripts to automate some of this process, see [Plan a Microsoft Entra multifactor authentication deployment](/azure/active-directory/authentication/howto-mfa-getstarted#enforcing-registration).

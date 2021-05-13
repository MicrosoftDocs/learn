Before starting a deployment of Azure AD Multi-Factor Authentication, there are several things you should decide.

First, consider rolling out MFA in waves. Start with a small group of pilot users to evaluate the complexity of your environment and identify any setup issues or unsupported apps or devices. Then broaden that group over time and evaluating the results with each pass until your entire company is enrolled.

Next, make sure to create a full communication plan. Azure AD MFA has several user interaction requirements including a registration process. Keep users informed every step of the way and let them know what they are required to do, important dates, and how to get answers to questions if they have trouble. Microsoft provides [communication templates](https://www.microsoft.com/download/details.aspx?id=57600&WT.mc_id=rss_alldownloads_all) including posters, and email templates to help draft your communications.

## Azure AD MFA policies

Azure AD Multi-factor Authentication is enforced with **Conditional Access** policies. Conditional Access policies are `IF-THEN` statements. **IF** a user wants to access a resource, **THEN** they must complete an action. For example, a payroll manager wants to access the payroll application and is required to perform multi-factor authentication to access it. Other common access requests that might require MFA include:

- IF a specific cloud application is accessed
- IF a user is accessing a specific network
- IF a user is accessing a specific client application
- IF a user is registering a new device

## Deciding supported authentication methods

When you turn on Azure AD MFA, you can choose the authentication methods you want to make available. You should always support more than one method so users have a backup option in case their primary method is unavailable. You can choose from the following methods:

| Method | Description |
|--------|-------------|
| **Mobile App Verification code** | A mobile authentication app such as the Microsoft Authenticator app can be used to retrieve an OATH verification code which is then entered into the sign-in interface. This code is changed every 30 seconds and the app works even if connectivity is limited. Note that this approach doesn't work in China on Android devices. |
| **Call to a phone** | Azure can call a supplied phone number. The user then approves the authentication using the keypad. This is a preferred backup method. |
| **Text message to a phone** | A text message with a verification code can be sent to a mobile phone. The user then enters the verification code into the sign-in interface to complete the authentication. |

Administrators can enable one or more of the options above and then users can opt-in to each support authentication method they want to use.

## Selecting an authentication method

Finally, you must decide how users will register their selected methods. The easiest approach is to use **Azure Active Directory Identity Protection**. If your organization has licenses for Identity Protection, you can configure it to prompt users to register for MFA the next time they sign in.

Users can also be prompted to register for MFA when they try to use an application or service that requires multi-factor authentication. Finally, you can enforce registration using a Conditional Access policy applied to an Azure group containing all users in your organization. This approach requires some manual work to periodically review the group to remove registered users. There are some [useful scripts in the documentation](https://docs.microsoft.com/azure/active-directory/authentication/howto-mfa-getstarted#enforcing-registration) to automate some of this process.


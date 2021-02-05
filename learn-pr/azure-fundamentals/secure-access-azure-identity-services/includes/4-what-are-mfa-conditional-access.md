
Tailwind Traders allows delivery drivers to use their own mobile devices to access scheduling and logistics applications. Some delivery drivers are permanent employees of Tailwind Traders. Others work on short-term contract. How can the IT department ensure that an access attempt is really from a valid Tailwind Traders worker? 

In this part, you'll learn about two processes that enable secure authentication: Azure AD Multi-Factor Authentication and Conditional Access. Let's start with a brief look at what multifactor authentication is in general.

## What's multifactor authentication?

_Multifactor authentication_ is a process where a user is prompted during the sign-in process for an additional form of identification. Examples include a code on their mobile phone or a fingerprint scan.

Think about how you sign in to websites, email, or online gaming services. In addition to your username and password, have you ever needed to enter a code that was sent to your phone? If so, you've used multifactor authentication to sign in.

Multifactor authentication provides additional security for your identities by requiring two or more elements to fully authenticate.

These elements fall into three categories:

* **Something the user knows**

    This might be an email address and password.
* **Something the user has**

    This might be a code that's sent to the user's mobile phone.
* **Something the user is**

    This is typically some sort of biometric property, such as a fingerprint or face scan that's used on many mobile devices.

:::image type="content" source="../media/4-multi-factor-authentication.png" alt-text="Various ways to authenticate over multifactor authentication, including a username and password, keys, smart cards, and certificates." border="false":::

Multifactor authentication increases identity security by limiting the impact of credential exposure (for example, stolen usernames and passwords). With multifactor authentication enabled, an attacker who has a user's password would also need to have possession of their phone or their fingerprint to fully authenticate.

Compare multifactor authentication with single-factor authentication. Under single-factor authentication, an attacker would need only a username and password to authenticate. Multifactor authentication should be enabled wherever possible because it adds enormous benefits to security.

## What's Azure AD Multi-Factor Authentication?

Azure AD Multi-Factor Authentication is a Microsoft service that provides multifactor authentication capabilities. Azure AD Multi-Factor Authentication enables users to choose an additional form of authentication during sign-in, such as a phone call or mobile app notification.

These services provide Azure AD Multi-Factor Authentication capabilities:

* **Azure Active Directory**

    The Azure Active Directory free edition enables Azure AD Multi-Factor Authentication for administrators with the *global admin* level of access, via the Microsoft Authenticator app, phone call, or SMS code. You can also enforce Azure AD Multi-Factor Authentication for all users via the Microsoft Authenticator app only, by enabling *security defaults* in your Azure AD tenant.

    Azure Active Directory Premium (P1 or P2 licenses) allows for comprehensive and granular configuration of Azure AD Multi-Factor Authentication through Conditional Access policies (explained shortly).
* **Multifactor authentication for Office 365**

    A subset of Azure AD Multi-Factor Authentication capabilities is part of your Office 365 subscription.

For more information on licenses and Azure AD Multi-Factor Authentication capabilities, see [Available versions of Azure AD Multi-Factor Authentication](https://docs.microsoft.com/azure/active-directory/authentication/concept-mfa-licensing#available-versions-of-azure-multi-factor-authentication?azure-portal=true).

## What's Conditional Access?

Conditional Access is a tool that Azure Active Directory uses to allow (or deny) access to resources based on identity _signals_. These signals include who the user is, where the user is, and what device the user is requesting access from.

Conditional Access helps IT administrators:

* Empower users to be productive wherever and whenever.
* Protect the organization's assets.

Conditional Access also provides a more granular multifactor authentication experience for users. For example, a user might not be challenged for second authentication factor if they're at a known location. However, they might be challenged for a second authentication factor if their sign-in signals are unusual or they're at an unexpected location.

During sign-in, Conditional Access collects signals from the user, makes decisions based on those signals, and then enforces that decision by allowing or denying the access request or challenging for a multifactor authentication response.

Here's a diagram that illustrates this flow:

:::image type="content" source="../media/4-conditional-access-signal-decision-enforcement.png" alt-text="A flow diagram that shows how signals inform decisions, which become enforcement policies." border="false":::

Here, the signal might be the user's location, the user's device, or the application that the user is trying to access.

Based on these signals, the decision might be to allow full access if the user is signing in from their usual location. If the user is signing in from an unusual location or a location that's marked as high risk, then access might be blocked entirely or possibly granted after the user provides a second form of authentication.

Enforcement is the action that carries out the decision. For example, the action is to allow access or require the user to provide a second form of authentication.

### When can I use Conditional Access?

Conditional Access is useful when you need to:

* Require multifactor authentication to access an application.

    You can configure whether all users require multifactor authentication or only certain users, such as administrators.

    You can also configure whether multifactor authentication applies to access from all networks or only untrusted networks.
* Require access to services only through approved client applications.

    For example, you might want to allow users to access Office 365 services from a mobile device as long as they use approved client apps, like the Outlook mobile app.
* Require users to access your application only from managed devices.

    A _managed device_ is a device that meets your standards for security and compliance.
* Block access from untrusted sources, such as access from unknown or unexpected locations.

Conditional Access comes with a *What If* tool, which helps you plan and troubleshoot your Conditional Access policies. You can use this tool to model your proposed Conditional Access policies across recent sign-in attempts from your users to see what the impact would have been if those policies had been enabled. The What If tool enables you to test your proposed Conditional Access policies before you implement them.

### Where is Conditional Access available?

To use Conditional Access, you need an Azure AD Premium P1 or P2 license. If you have a Microsoft 365 Business Premium license, you also have access to Conditional Access features.

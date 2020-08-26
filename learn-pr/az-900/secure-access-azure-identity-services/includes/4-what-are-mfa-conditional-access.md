
Tailwind Traders allows delivery drivers to use their own mobile devices to access scheduling and logistics applications. Some delivery drivers are permanent employees of Tailwind Traders; others work on short-term contract. How can the IT department ensure that an access attempt is really from a valid Tailwind Traders worker? 

In this part, you'll learn about two processes that enable secure authentication: Azure Multi-Factor Authentication and Conditional Access. Let's start with a brief look at what multi-factor authentication is in general.

## What's multi-factor authentication (MFA)?

_Multi-factor authentication_ is a process where a user is prompted during the sign-in process for an additional form of identification, such as to enter a code on their cellphone or to provide a fingerprint scan.

Think about how you sign in to websites, email, or online gaming services. In addition to your username and password, have you ever needed to enter an additional code that was sent to your phone? If so, you've used MFA to sign in.

 MFA provides additional security for your identities by requiring two or more elements to fully authenticate.

These elements fall into three categories:

* **Something you know**

    This could be a password or the answer to a security question.
* **Something you have**

    This might be a code that's sent to your mobile phone.
* **Something you are**

    This is typically some sort of biometric property, such as a fingerprint or face scan that's used on many mobile devices.

:::image type="content" source="../media/4-multi-factor-authentication.png" alt-text="Some various ways to authenticate over MFA, including a username and password, keys, smart cards, and certificates." border="false":::

MFA increases identity security by limiting the impact of credential exposure (for example, stolen usernames and passwords). With MFA enabled, an attacker who has a user's password would also need to have possession of their phone or their fingerprint to fully authenticate.

Compare MFA with single-factor authentication. Under single-factor authentication, an attacker would only need  your username and password to authenticate. Therefore, MFA should be enabled wherever possible as MFA adds enormous benefits to security.

## What's Azure Multi-Factor Authentication?

Azure Multi-Factor Authentication is a Microsoft service that provides MFA capabilities. Azure Multi-Factor Authentication enables users to choose an additional form of authentication during sign-in, such as a phone call or mobile app notification.

### Which Microsoft services provide Azure Multi-Factor Authentication?

These services provide Azure Multi-Factor Authentication capabilities:

* **Azure Active Directory**

    The Azure Active Directory free edition enables Azure Multi-Factor Authentication for administrators with the *Global Admin* level of access, via the Microsoft Authenticator app, phone call, or SMS code. Azure Multi-Factor Authentication can also be enforced for all users via the Microsoft Authenticator app only, by enabling *security defaults* in your Azure AD tenant.

    Azure Active Directory Premium (P1 or P2 licenses) allows for comprehensive and granular configuration of Azure Multi-Factor Authentication through Conditional Access policies (explained below).
* **Multi-factor authentication for Office 365**

    A subset of Azure Multi-Factor Authentication capabilities is part of your Office 365 subscription.

For more information on licenses and Azure Multi-Factor Authentication capabilities, see [Available versions of Azure Multi-Factor Authentication](https://docs.microsoft.com/azure/active-directory/authentication/concept-mfa-licensing#available-versions-of-azure-multi-factor-authentication?azure-portal=true).

## What's Conditional Access?

Conditional Access is a tool that's used by Azure Active Directory to allow (or deny) access to resources based on identity _signals_. These signals include who the user is, the user's location, and what device the user is requesting access from.

Conditional Access helps IT administrators:

* Empower users to be productive wherever and whenever.
* Protect the organization's assets.

Conditional Access also provides a more granular MFA experience for end users. For example, end users might not be challenged for second authentication factor if they are at a known location. However, they might be challenged for a second authentication factor if their sign-in signals are unusual or the user is at an unexpected location.

During sign-in, Conditional Access collects signals from the user (such as location, device, and application being accessed), makes decisions based on those signals, and then enforces that decision by allowing or denying the access request or challenging for an MFA response.

Here's a diagram that illustrates this flow:

:::image type="content" source="../media/4-conditional-access-signal-decision-enforcement.png" alt-text="A flow diagram that shows how signals inform decisions, which become enforcement policies." border="false":::

### When can I use Conditional Access?

Conditional Access is useful when you need to:

* Require MFA to access an application.

    You can configure whether all users require MFA or only certain users, such as administrators.

    You can also configure whether MFA applies to access from all networks or only untrusted networks.
* Require access to services only through approved client applications.

    For example, you might want to allow users to access Office 365 services from a mobile device as long as they use approved client apps, like Outlook mobile.
* Require the user to access your application only from managed devices.

    A _managed device_ is a device that meets your standards for security and compliance.
* Block access from untrusted sources, such as access from unknown or unexpected locations.

Conditional Access comes with a *What If* tool, which helps you plan and troubleshoot your Conditional Access policies. You can use this tool to model your proposed conditional access policies across recent sign-in attempts from your users to see what the impact would have been if those policies had been enabled. The *What If* tool enables you to test your proposed conditional access policies before you implement them.

### Where is Conditional Access available?

To use Conditional Access, you need an Azure AD Premium P1 or P2 license. If you have a Microsoft 365 Business Premium license, you also have access to Conditional Access features.

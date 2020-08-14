
Tailwind Traders allows delivery drivers to use their own mobile devices to access scheduling and logistics applications. Some delivery drivers are permanent employees of Tailwind Traders; others work on short-term contract. How can the IT department ensure that an access attempt is really from a valid Tailwind Traders worker? 

In this part, you'll learn about two processes that enable secure authentication: Azure Multi-Factor Authentication and Conditional Access.

## What is Azure Multi-Factor Authentication?

Azure Multi-Factor Authentication (MFA) provides additional security for your identities by requiring two or more elements to fully authenticate.

These elements fall into three categories:

* **Something you know**

    This could be a password or the answer to a security question.
* **Something you possess**

    This might be a mobile app that receives a notification or it might be a token-generating device.
* **Something you are**

    This is typically some sort of biometric property, such as a fingerprint or face scan that's used on many mobile devices.

:::image type="content" source="../media/4-multi-factor-authentication.png" alt-text="An image of a username and password entry screen, mobile phone, USB key, smart card, image representing various types of biometric authentication, and certificate all in a line, representing how they can all be tied together to provide MFA." border="false":::

MFA increases identity security by limiting the impact of credential exposure (for example, stolen usernames and passwords). With MFA enabled, an attacker who has a user's password would also need to have possession of their phone or their fingerprint to fully authenticate. Authentication with only a single factor is insufficient and, without MFA, an attacker would be unable to use those credentials to authenticate. MFA should be enabled wherever possible as MFA adds enormous benefits to security.

### Which Azure services provide MFA?

These services provide MFA capabilities:

* **Azure Active Directory**

    The Azure Active Directory free edition allows MFA for administrators with the *Global Admin* level of access, via the Microsoft Authenticator app, phone call or SMS code. MFA can also be enforced for all users via the Microsoft Authenticator app only, by enabling *security defaults* in your Azure AD tenant.

    Azure Active Directory Premium (P1 or P2 licenses) allow for comprehensive and granular configuration of MFA via Conditional Access policies (explained below). 
* **Multi-factor authentication for Office 365**

    A subset of Azure Multi-Factor Authentication capabilities is available as a part of your Office 365 subscription.

For more information on licenses and MFA capabilities, see [Available versions of Azure Multi-Factor Authentication](https://docs.microsoft.com/azure/active-directory/authentication/concept-mfa-licensing#available-versions-of-azure-multi-factor-authentication?azure-portal=true).

## What is Conditional Access?

Conditional Access is a tool that's used by Azure Active Directory to allow (or deny) access to resources based on identity _signals_. These signals include who the user is, the user's location, and what device the user is requesting access from.

Conditional Access helps IT administrators:

* Empower users to be productive wherever and whenever.
* Protect the organization's assets.

Conditional Access also provides a more granular MFA experience for end users, allowing them to not be challenged for another authentication factor if for example they are at a known location, but enforcing an MFA request if their log in attempt signals are unusual or from a known, banned location.  

At the time of the log in attempt, Conditional Access collects signals from the user (such as location, device and application being accessed), makes decisions based on those signals, and then enforces that decision by allowing or denying the access request or challenging for an MFA response.

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

Conditional Access comes with a *What If* tool, which helps you plan and troubleshoot your Conditional Access policies. You can use this tool to model your proposed conditional access policies across recent log in attempts from your users, to see what the impact would have been if those policies had been enabled. This lets you test your proposed conditional access policies before implementing them.

### Where is Conditional Access available?

To use Conditional Access, you need an Azure AD Premium P1 or P2 license. If you have a Microsoft 365 Business Premium license, you also have access to Conditional Access features.

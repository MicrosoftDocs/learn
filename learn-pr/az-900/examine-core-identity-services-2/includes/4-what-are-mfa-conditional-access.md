With people increasingly being able to work from anywhere, identity has become the new primary security boundary.

Tailwind Traders allows delivery drivers to use their own mobile devices to access scheduling and logistics applications. Some delivery drivers are permanent employees of Tailwind Traders; others work on short-term contract. How can the IT department ensure that access from a driver's mobile device is really made from that driver?

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

MFA increases identity security by limiting the impact of credential exposure. For example, to fully authenticate, an attacker who has a user's password would also need to have possession of their phone or their fingerprint. Authentication with only a single factor is insufficient and, without MFA, an attacker would be unable to use those credentials to authenticate. MFA should be enabled wherever possible as MFA adds enormous benefits to security.

### Which Azure services provide MFA?

These services provide MFA capabilities:

* **Azure Active Directory premium licenses**

    These licenses provide full use of Azure Multi-Factor Authentication Service (cloud) or Azure Multi-Factor Authentication Server (on-premises).
* **Multi-factor authentication for Office 365**

    A subset of Azure Multi-Factor Authentication capabilities is available as a part of your Office 365 subscription.
* **Azure Active Directory global administrators**

    Because global administrator accounts are highly sensitive, a subset of Azure Multi-Factor Authentication capabilities are available to protect these accounts.

## What is Conditional Access?

Conditional Access is a tool that's used by Azure Active Directory to allow (or deny) access to resources based on identity _signals_. These signals include who the user is, the user's location, and what device the user is requesting access from.

Conditional Access helps IT administrators:

* Empower users to be productive wherever and whenever.
* Protect the organization's assets.

Conditional Access collects signals from the user, makes decisions based on those signals, and then enforces that decision by allowing or denying access to the requested resource or application.

Here's a diagram that illustrates this flow:

:::image type="content" source="../media/4-conditional-access-signal-decision-enforcement.png" alt-text="A flow diagram that shows how signals inform decisions, which become enforcement policies." border="false":::

### When can I use Conditional Access?

Conditional Access is useful when you need to:

* Get consent from the user in the form of accepting your terms of use (ToU) before the user can access the resource or application.
* Require MFA to access an application.

    You can configure whether all users require MFA or only certain users, such as administrators.

    You can also configure whether MFA applies to access from all networks or only untrusted networks.
* Require access to services only through approved client applications.

    For example, you might want to allow users to access Office 365 services from a mobile device as long as they use approved client apps, like Outlook mobile.
* Require the user to access your application only from managed devices.

    A _managed device_ is a device that meets your standards for security and compliance.
* Block access to untrusted sources, such as access from unknown or unexpected locations.

Conditional Access provides the *What If* tool, which helps you plan and troubleshoot your Conditional Access policies. You can use this tool to simulate the sign-in of a user.

### Where is Conditional Access available?

To use Conditional Access, you need an Azure AD Premium P1 license. If you have a Microsoft 365 Business Premium license, you also have access to Conditional Access features.

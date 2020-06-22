[Azure Multi-Factor Authentication](https://docs.microsoft.com/azure/active-directory/authentication/concept-mfa-howitworks?azure-portal=true) provides additional security for your identities by requiring two or more elements for full authentication. These elements fall into three categories:

+ **Something you know** could be a password or the answer to a security question.
+ **Something you possess** might be a mobile app that receives a notification, or a token-generating device.
+ **Something you are** is typically some sort of biometric property, such as a fingerprint or face scan used on many mobile devices.

![Image of a username and password entry screen, mobile phone, USB key, smart card, image representing various types of biometric authentication, and certificate all in a line, representing how they can all be tied together to provide MFA.](../media/multi-factor-authentication.png)

Using multi-factor authentication (MFA) increases identity security by limiting the impact of credential exposure. To fully authenticate, an attacker who has a user's password would also need to have possession of their phone or their fingerprint, for example. Authentication with only a single factor is insufficient and, without MFA, an attacker would be unable to use those credentials to authenticate. MFA should be enabled wherever possible as MFA adds enormous benefits to security.

Multi-factor authentication (MFA) comes as part of the following Azure service offerings:

+ **Azure Active Directory premium licenses**. These licenses provide full-featured use of Azure Multi-Factor Authentication Service (cloud) or Azure Multi-Factor Authentication Server (on-premises).
+ **Multi-factor authentication for Office 365**. A subset of Azure Multi-Factor Authentication capabilities is available as a part of your Office 365 subscription.
+ **Azure Active Directory global administrators**. Because global administrator accounts are highly sensitive, a subset of Azure Multi-Factor Authentication capabilities are available to protect these accounts.


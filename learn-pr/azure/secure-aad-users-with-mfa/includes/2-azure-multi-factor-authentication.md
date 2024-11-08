Protecting your cloud assets is one of the main goals for security groups. One of the primary ways unauthorized users get access to systems is by obtaining a valid username and password. Azure can help mitigate this risk with several features of Microsoft Entra ID, including:

* **Password complexity rules**: These rules force users to generate harder-to-guess passwords.

* **Password expiration rules**: You can force users to change their passwords on a periodic basis and avoid using previously used passwords.

* **Self-service password reset (SSPR)**: This approach allows users to self-serve and reset their password if they forget it without involving an IT department.

* **Microsoft Entra ID Protection**: To help protect your organization's identities, you can configure risk-based policies that automatically respond to risky behaviors. These policies can either automatically block the behaviors or initiate remediation, including requiring password changes.

* **Microsoft Entra password protection**: You can block commonly used and compromised passwords by using a global banned-password list.

* **Microsoft Entra smart lockout**: Smart lockout helps to lock out malicious hackers who are trying to guess your user passwords or use brute-force methods to get in. It recognizes sign-ins coming from valid users and treats them differently than the sign-ins of malicious hackers and other unknown sources.

* **Microsoft Entra application proxy**: You can provision security-enhanced remote access to on-premises web applications.

* **Single sign-on (SSO)**: You can enable SSO access to your applications, including thousands of preintegrated SaaS apps.

* **Microsoft Entra Connect**: Create and manage a single identity for each user across your hybrid enterprise, keeping users, groups, and devices in sync.

These approaches are all great options that deter someone *guessing* or brute-forcing a password. However, sometimes passwords are obtained through social engineering or poor physical security practices, like putting your password on a sticky note under your keyboard! In these cases, these features don't stop an intrusion. Instead, security administrators want to turn to *Microsoft Entra multifactor authentication*.

<a name='what-is-azure-ad-mfa'></a>

## What is Microsoft Entra multifactor authentication?

Microsoft Entra multifactor authentication (MFA) supplies added security for your identities by requiring two or more elements for full authentication.

These elements fall into three categories:

* **Something you know**, which might be a password or the answer to a security question.
* **Something you possess**, which might be a mobile app that receives a notification or a token-generating device.
* **Something you are**, which is typically a biometric property, such as a fingerprint or face scan used on many mobile devices.

:::image type="content" source="../media/2-mfa-example.png" alt-text="Conceptual art showing the pieces of MFA.":::

Using Microsoft Entra multifactor authentication improves identity security by limiting the impact of password exposure. To fully authenticate, a malicious hacker also needs a second factor such as the user's phone, fingerprint, or face. Multifactor authentication should always be enabled because it's the most effective way to prevent unauthorized sign-in.

Microsoft Entra multifactor authentication is the Microsoft two-step verification solution. Microsoft Entra multifactor authentication helps safeguard access to data and applications while meeting user demand for a simple sign-in process. It delivers strong authentication for a range of verification methods, including phone call, text message, or mobile app verification.

The security of Microsoft Entra multifactor authentication lies in its layered approach. Requiring multiple authentication factors presents a significant challenge for malicious hackers. Even if a malicious hacker manages to learn the user's password, it's useless without also possessing the trusted device. If the user loses the device, a person who finds it can't use it without the user's password.

<a name='how-to-get-multi-factor-authentication'></a>

## How to get multifactor authentication?

Multifactor authentication comes as part of the following offerings:

* **Microsoft Entra ID P1 or P2** or **Microsoft 365 Business**: Both of these offerings support Microsoft Entra multifactor authentication using [security defaults](/azure/active-directory/fundamentals/concept-fundamentals-security-defaults) to require multifactor authentication.

* **Microsoft Entra ID Free** or standalone **Microsoft 365** licenses: Both use [security defaults](/azure/active-directory/fundamentals/concept-fundamentals-security-defaults) that require multifactor authentication for your users and administrators.

* **Microsoft Entra Global Administrators**: A subset of Microsoft Entra multifactor authentication capabilities are available as a means to protect global administrator accounts.

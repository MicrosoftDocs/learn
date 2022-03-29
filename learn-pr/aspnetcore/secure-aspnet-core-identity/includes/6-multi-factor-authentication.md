In the previous unit, you customized and extended ASP.NET Core Identity. In this unit, you'll learn about multi-factor authentication and how it's implemented in Identity.

## Multi-factor authentication

Multi-factor authentication (MFA) is a process in which a user is requested during a sign-in event for additional forms of identification. This prompt could be for a code from an app, a hardware token value, or a biometric scan. When you require a second type of authentication, security is enhanced. The additional factor isn't easily obtained or duplicated by an attacker.

When talking about multi-factor authentication, the proof required for authentication is categorized into three types:

* Something you know, like a password or security question.
* Something you have, like a hardware token or an app on your phone.
* Something you are, like a fingerprint or face scan.

Much of the effectiveness of MFA comes from using different *types* of authentication. An adversary might be able to get access to multiple things you know (like your password and your childhood nickname), but it's much harder to compromise something you *know* **and** something you *have* or *are*.

## Time-based One-Time Password

Time-based One-Time Password (TOTP) is a well-known algorithm that generates unique numerical codes that expire after 30 seconds. The algorithm takes two inputs, the current time and a unique key.

The user enters the key into a TOTP-compliant app, such as:

* Microsoft Authenticator
* Google Authenticator
* LastPass Authenticator

Entering the key into the app can be streamlined with a QR code. The app uses the key and time to generate and display unique codes every 30 seconds. If the code the app generates matches what the server expects, the authentication succeeds. The algorithm is designed to be forgiving of slight differences between client and server clocks.

As a form of MFA, the user is prompted for a TOTP often in combination with a password. The password is *something you know*, and the code is *something you have*. The only way to generate it is with the key stored in the app.

By default, the ASP.NET Core project templates using Identity include multi-factor authentication support for TOTP authenticator apps. The Razor Pages template's **Configure authenticator app** form provides a 32-character registration key to seed the token value. However, the template doesn't generate a QR code by default.

> [!NOTE]
> Codes sent by SMS text messages are a common alternative to TOTP. After all, the phone receiving the SMS message is *something you have*. However, SMS as MFA is relatively easy for an adversary to defeat. Consequently, SMS codes are no longer considered a secure form of MFA.

## Summary

In this unit, you learned what multi-factor authentication is and how it's implemented in ASP.NET Core Identity by default. In the next unit, you'll customize the existing **Configure authenticator app** form to provide a QR code containing the registration key.

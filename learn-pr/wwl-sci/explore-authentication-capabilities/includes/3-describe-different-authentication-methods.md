In the previous unit, you learned about multi-factor authentication, and why it improves security. In this unit, we consider the different authentication methods that can be used with Azure AD Multi-Factor Authentication.

:::image type="content" source="../media/3-passwords-supplemented-replaced.png" alt-text="Passwords should be supplemented or replaced":::

## Passwordless authentication

Passwordless authentication is based on “something you are” rather than “something you know”. A biometric facial scan used in Windows Hello for Business is an example of “something you are”. A fingerprint scan used by the Microsoft Authenticator app or a FIDO2 security device, is also “something you are”.

Passwordless authentication with Azure AD includes the following methods

- Windows Hello for Business
- Microsoft Authenticator app
- FIDO2 security keys

## Microsoft Authenticator app

The Microsoft Authenticator phone app allows you to securely verify your identity. The Authenticator app is used to provide the additional information required for two-step or multi-factor authentication. Microsoft Authenticator can also be configured to use biometrics, such as a fingerprint or facial scan.

To use Microsoft Authenticator, you must download the phone app from the Microsoft store, and register your account. Microsoft Authenticator is available for Android and iOS. When a user chooses Authenticator as their extra authentication method, a notification is pushed to the phone or tablet. if the notification is legitimate, the user selects **Approve**, otherwise, they select **Deny**.

:::image type="content" source="../media/3-microsoft-authenticator-app-approval-request.png" alt-text="Microsoft authenticator app approval request":::

## Windows Hello for Business

Biometric sign-in uses human characteristics, such as a hand, iris, face, or fingerprint. Windows Hello for Business uses facial or fingerprint biometric data to authenticate a user. You'll learn more about Windows Hello for Business in the next unit. 

## FIDO2

FIDO is an abbreviation for Fast Identity Online, an alliance that promotes open authentication standards and aims to reduce the reliance on passwords as a form of authentication.

Azure AD supports FIDO2, a passwordless authentication method that can come in different forms. FIDO2 allows users to sign in with an external security key. The external key may be a USB device, lightning connector, Bluetooth, or NFC. In whichever form FIDO2 is implemented, the user never has to enter a password.

Users can also register and select a FIDO2 security key as their main means of authentication.

## OATH

OATH (Open Authentication) is an open standard that specifies how time-based, one-time password (TOTP) codes are generated. One-time password codes can be used to authenticate a user. OATH TOTP is implemented using either software or hardware to generate the codes.

Software OATH tokens are typically applications such as the Microsoft Authenticator app and other authenticator apps.

OATH TOTP hardware tokens typically come with a secret key, preprogrammed in the token, which must be input into Azure AD.  Users are associated with a specific hardware token. The hardware token does a refresh of the code every 30 or 60 seconds.

## Phone

You can also use your phone, configured for either calls or text messages, as an extra means of authentication.

If you set up your extra security verification to receive a phone call, you'll get a call from Microsoft asking you to press a key on your mobile device to verify your identity.

If you set up your additional security verification to receive a text message, you'll be sent a code by text. You then enter the code to verify your identity.


## Password and additional verification

With modern authentication and security features in Azure AD, passwords are supplemented or replaced with more secure authentication methods.

## Passwords

Passwords have many problems. If they're easy enough to remember, they're easy for a hacker to compromise. Strong passwords that aren't easily hacked are difficult to remember, and affect user productivity when forgotten.


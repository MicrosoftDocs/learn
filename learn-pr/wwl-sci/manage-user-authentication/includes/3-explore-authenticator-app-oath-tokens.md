The Microsoft Entra Authenticator app provides an additional level of security to your Azure AD work or school account or your Microsoft account and is available for Android and iOS. With the Microsoft Authenticator app, users can authenticate in a passwordless way during sign-in, or as an additional verification option during self-service password reset (SSPR) or multifactor authentication events.

Users may receive a notification through the mobile app for them to approve or deny, or use the Authenticator app to generate an OATH verification code that can be entered in a sign-in interface. If you enable both a notification and verification code, users who register the Authenticator app can use either method to verify their identity.

## Microsoft Authenticator app

:::image type="content" source="../media/authenticator-app-5fef414f.png" alt-text="Screenshot of the sign-in verification screen the user sees when verifying authentication with the app.":::


The Authenticator app provides a high level of security, and removes the need for the user to provide a password at sign-in. The Authenticator app can help prevent unauthorized access to accounts and stop fraudulent transactions. A push notification is sent to your smartphone or tablet for extra security. Users view the notification, and if it's legitimate, select Verify. Otherwise, they can select Deny.

The Authenticator app can be used as a software token to generate an OATH verification code. After entering your username and password, you enter the code provided by the Authenticator app into the sign-in interface. The verification code provides a second form of authentication. Users may have a combination of up to five OATH hardware tokens or authenticator applications, such as the Authenticator app, configured for use at any time.

## Open Authentication (OATH) tokens

:::image type="content" source="../media/oath-token-menu-685caa6f.png" alt-text="Screenshot of the O A T H (Open Authentication) token setup screen inside of multifactor authentication. Configure tokens using software or hardware.":::


OATH TOTP (Time-based One Time Password) is an open standard that specifies how one-time password (OTP) codes are generated. OATH TOTP can be implemented using either software or hardware to generate the codes. Azure AD doesn't support OATH HOTP, a different code generation standard. Software OATH tokens are typically applications such as the Microsoft Authenticator app and other authenticator apps. Azure AD generates the secret key, or seed, that's input into the app and used to generate each OTP.

The Authenticator app automatically generates codes when set up to do push notifications so a user has a backup even if their device doesn't have connectivity. Third-party applications that use OATH TOTP to generate codes can also be used.

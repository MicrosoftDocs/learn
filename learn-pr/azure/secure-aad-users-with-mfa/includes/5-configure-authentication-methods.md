As we mentioned earlier in the module, we recommend that administrators enable users to be able to select more than one authentication method in case their primary method is unavailable.

When a user signs into a service that requires MFA the first time, they'll be asked to register their preferred multifactor authentication method as shown in the following screenshot:

![Screenshot showing the registration info.](../media/5-setup-user.png)

> [!TIP]
> If you followed the previous exercise and turned on MFA for an account and app, you can try accessing that app with the given user account, and you should see the preceding flow.

Once they've registered, each time users sign into a service or app that requires MFA, the Azure login process will prompt for the additional authentication information as shown in the following image:

![Screenshot that depicts asking for additional authentication information via one of four methods.](../media/5-identity-options.png)

## Azure Authentication Methods

As we learned earlier, there are several possible authentication methods that an administrator can set up. Some of these also support Self-Service Password Reset (SSPR), which allows users to reset their password by supplying a secondary form of authentication. You can couple this service with Azure AD MFA to ease the burden on IT staff.

The following table lists the authentication methods and the services that can use them.

| Authentication method  | Services    |
|------------------------|-------------|
| **Password** | Azure AD MFA and SSPR |
| **Security questions** | SSPR |
| **Email address** | SSPR |
| **Windows Hello for Business** |Azure AD MFA and SSPR |
| **FIDO2 Security Key** |Azure AD MFA and SSPR |
| **Microsoft Authenticator app** |Azure AD MFA and SSPR |
| **OATH hardware token** | Azure AD MFA and SSPR |
| **OATH software token** | Azure AD MFA and SSPR |
| **Text message** | Azure AD MFA and SSPR |
| **Voice call** | Azure AD MFA and SSPR |
| **App passwords** | Azure AD MFA in certain cases |

Let's explore these in a bit more detail.

### Password

This is the only method that you can’t disable.

### Security questions

This method is available only for non-administrative accounts that use Self-Service Password Reset.

* Azure stores security questions privately and in a security-enhanced manner on a user object in the directory. Only users can answer the questions, and only during registration. An administrator can’t read or change a user’s questions or answers.

* Azure provides 35 predefined questions, all translated and localized based on the browser locale.

* You can customize the questions by using the administrative interface; however, Azure displays them in the language entered. The maximum length is 200 characters.

### Email address

This method is available only in SSPR. We recommend that you avoid the use of an email account that doesn’t require the user’s Azure AD password to access it.

### Windows Hello for Business

Windows Hello for Business provides reliable, fully integrated biometric authentication based on facial recognition or fingerprint matching. Windows Hello for Business, FIDO2 security keys, and Microsoft Authenticator are passwordless solutions.

### FIDO2 security keys

FIDO2 security keys are an unphishable, standards-based passwordless authentication method that can come in any form factor. Fast Identity Online (FIDO) is an open standard for passwordless authentication.

Users can register and then select a FIDO2 security key at the sign-in interface as their main means of authentication. These FIDO2 security keys are typically USB devices, but could also use Bluetooth or NFC.

FIDO2 security keys can be used to sign in to their Azure AD or hybrid Azure AD joined Windows 10 devices and get single-sign on to their cloud and on-premises resources. Users can also sign in to supported browsers.

### Microsoft Authenticator app

This method is available for Android and iOS. Users can register their mobile app at <https://aka.ms/mfasetup>

* The Microsoft Authenticator app helps prevent unauthorized access to accounts and helps stop fraudulent transactions by pushing a notification to your smartphone or tablet. Users view the notification and confirm or deny the request.

* Users can use the Microsoft Authenticator app or a third-party app as a software token to generate an OATH verification code. After entering the username and password, the users enter the code provided by the app on the sign-in screen. The verification code provides a second form of authentication. Users can also set the Microsoft Authenticator app to deliver a push notification that they'll select and approve to sign in.

### OATH hardware tokens

**OATH** is an open standard that specifies how to generate one-time password codes. Azure AD supports the use of OATH-TOTP `SHA-1` tokens of the 30-second or 60-second variety. Customers can get these tokens from the vendor of their choice. Note that secret keys are limited to 128 characters, which might not be compatible with all tokens.

### OATH software tokens

Software OATH tokens are typically applications such as the Microsoft Authenticator app and other authenticator apps. Azure AD generates the secret key, or seed, that's input into the app and used to generate each OTP.

### Text message

Azure sends a verification code to a mobile phone using SMS. The user must enter the code into the browser within a specific time period to continue.

### Voice call

Azure uses an automated voice system to call the number and the owner uses the keypad to confirm the authentication. Note that this option is not available to the free/trial Azure AD tier.

### App password

Certain non-browser apps don’t support Azure AD MFA. If users are enabled for Azure AD MFA and try to use non-browser apps, they’ll be unable to authenticate. The app password allows users to continue to authenticate.

## Monitoring adoption

Azure AD includes a **Usage & insights** view in the **Monitoring** section where you can monitor the authentication methods activity. From here you can view the adoption of MFA and SSPR:

![Screenshot showing the metrics view for MFA.](../media/5-monitor-auth-methods.png)

In addition to the overall registration numbers, you can also see the success and failure of registrations per authentication method. This allows you to understand which authentication methods your users most commonly registered and which ones are easy for them to register. This data is calculated using the last 30 days of audit logs from the combined security info registration and SSPR registration experiences.

You can drill down and see the latest registration audit information for each user by clicking the chart.

![Screenshot showing the registration details.](../media/5-auth-registration-details.png)

You can also learn more about SSPR usage in your organization through the **Usage** tab on the main view, as shown in the following image:

![Screenshot showing the SSPR usage metrics.](../media/5-sspr-usage.png)

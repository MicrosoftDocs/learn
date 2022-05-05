Azure Active Directory Multi-Factor Authentication (MFA) helps safeguard access to data and applications while maintaining simplicity for users. It provides additional security by requiring a second form of authentication and delivers strong authentication through a range of easy to use authentication methods.

For organizations that need to be compliant with industry standards, such as the Payment Card Industry (PCI) Data Security Standard (DSS) version 3.2, MFA is a must have capability to authenticate users. Beyond being compliant with industry standards, enforcing MFA to authenticate users can also help organizations to mitigate credential theft attacks.

:::image type="content" source="../media/az500-multifactor-authentication-concepts-48fe7123.png" alt-text="MFA is monitoring signals and allowing or denying access to resources.":::


The security of MFA two-step verification lies in its layered approach. Compromising multiple authentication factors presents a significant challenge for attackers. Even if an attacker manages to learn the user's password, it is useless without also having possession of the additional authentication method. Authentication methods include:

 -  Something you know (typically a password)
 -  Something you have (a trusted device that is not easily duplicated, like a phone)
 -  Something you are (biometrics)

## MFA Features

 -  **Get more security with less complexity**. Azure MFA helps safeguard access to data and applications and helps to meet customer demand for a simple sign-in process. Get strong authentication with a range of easy verification options—phone call, text message, or mobile app notification—and allow customers to choose the method they prefer.
 -  **Mitigate threats with real-time monitoring and alerts**. MFA helps protect your business with security monitoring and machine-learning-based reports that identify inconsistent sign-in patterns. To help mitigate potential threats, real-time alerts notify your IT department of suspicious account credentials.
 -  **Use with Microsoft 365, Salesforce, and more**. MFA for Microsoft 365 helps secure access to Microsoft 365 applications at no additional cost. Multifactor authentication is also available with Azure Active Directory Premium and thousands of software-as-a-service (SaaS) applications, including Salesforce, Dropbox, and other popular services.<br>
 -  **Add protection for Azure administrator accounts**. MFA adds a layer of security to your Azure administrator account at no additional cost. When it's turned on, you need to confirm your identity to create a virtual machine, manage storage, or use other Azure services.

## MFA authentication options

:::image type="content" source="../media/az500-multifactor-authentication-options-f2dcc5c6.png" alt-text="Screenshot of MFA users settings page with options to allow or disallow users to create app passwords to sign in to non-browser apps. Also different verification options that can be selected by users, and a checkbox to enable users to remember MFA on devices they trust.":::


:::row:::
  :::column:::
    **Method**
  :::column-end:::
  :::column:::
    **Description**
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Call to phone
  :::column-end:::
  :::column:::
    Places an automated voice call. The user answers the call and presses \# in the phone keypad to authenticate. The phone number is not synchronized to on-premises Active Directory. A voice call to phone is important because it persists through a phone handset upgrade, allowing the user to register the mobile app on the new device.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Text message to phone
  :::column-end:::
  :::column:::
    Sends a text message that contains a verification code. The user is prompted to enter the verification code into the sign-in interface. This process is called one-way SMS. Two-way SMS means that the user must text back a particular code. Two-way SMS is deprecated and not supported after November 14, 2018. Users who are configured for two-way SMS are automatically switched to call to phone verification at that time.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Notification through mobile app
  :::column-end:::
  :::column:::
    Sends a push notification to your phone or registered device. The user views the notification and selects Approve to complete verification. The Microsoft Authenticator app is available for Windows Phone, Android, and iOS. Push notifications through the mobile app provide the best user experience.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Verification code from mobile app
  :::column-end:::
  :::column:::
    The Microsoft Authenticator app generates a new OAUTH verification code every 30 seconds. The user enters the verification code into the sign-in interface. The Microsoft Authenticator app is available for Windows Phone, Android, and iOS. Verification code from mobile app can be used when the phone has no data connection or cellular signal.
  :::column-end:::
:::row-end:::


> [!IMPORTANT]
> There is also a selection to cache passwords so that users do not have to authenticate on trusted devices. The number of days before a user must re-authenticate on trusted devices can also be configured with the value from 1 to 60 days. The default is 14 days.

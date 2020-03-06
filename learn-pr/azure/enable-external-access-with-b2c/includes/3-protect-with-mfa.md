It's important to secure your healthcare application as much as possible. The application deals with sensitive information about patients and their health. Make sure this sensitive data is never wrongfully exposed. You'll add a second layer of security to the healthcare application by enabling multi-factor authentication for users.

In this unit, you'll learn about multi-factor authentication. You'll also see how to enable and disable multi-factor authentication for your Azure AD B2C application.

## Multi-factor authentication

You can add an additional authentication layer to secure your data and applications.

Before you allow access to the application, use multi-factor authentication to ensure the user completes additional challenges. These challenges fit into three general categories:

  ![MFA challenges](../media/3-mfa-challenges.png)


- Something the user knows

- Something the user owns

- Something the user is


A secret password or a secret answer to a security question should be something that only the user knows. Users also have devices that can be classified as something they own. For example, a user with a mobile phone would receive a text message with a secret one-time-use code. You could also make successful authentication contingent on the user, through biometrics. This biometric information is classified as something the user is. For example, as an additional step, you could make authentication rely on the user's fingerprints or voice.

Different forms of second factor methods are supported in Azure. These methods include:

- A mobile application, such as Microsoft Authenticator, where the user receives a uniquely generated one-time code on a phone app
- A phone call, where the user receives a one-time code
- A text message, where the user receives a one-time code

Use these different methods to cater for your users' needs. For example, for accessibility reasons, some users might prefer to receive a phone call rather than a text message.

## Enable multi-factor authentication

You enable multi-factor authentication for your Azure AD B2C application through the Azure portal. When you create user sign-in and sign-up flows, you enable multi-factor authentication with a toggle. If necessary, use the same toggle in your user flow to disable multi-factor authentication for your application.

![Enable MFA in user flow](../media/3-enable-mfa-user-flow.png)

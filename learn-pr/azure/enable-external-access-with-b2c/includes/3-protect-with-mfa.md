It's important for you to secure the healthcare application as much as possible. The application deals with sensitive information on patients and their health. Make sure this sensitive data is never wrongfully exposed. You'll add a second layer of security to the healthcare application by enabling multi-factor authentication for users.

In this unit, you'll learn about multi-factor authentication. You'll also see how to enable and disable multi-factor authentication for your Azure AD B2C application.

## Multi-factor authentication

You can add an additional authentication layer to secure your data and applications.

Before you allow access to the application, use multi-factor authentication to ensure the user completes additional challenges. Multi-factor authentication challenges can be put into three general categories:

- something the user knows

- something the user owns

- something the user is

  ![MFA challenges](../media/3-mfa-challenges.png)

<!--- Original image: https://docs.microsoft.com/en-us/azure/active-directory/authentication/media/concept-mfa-howitworks/methods.png --->

A secret password or a secret answer to a security question should be something that only the user knows. Users also have devices that can be classified as something they own. For example, a user who has a mobile phone would receive a text message with a secret one-time-use code. You could also make successful authentication contingent on the user themselves, through biometrics collected from them. This biometric information is classified as something the user is. For example, you could make authentication rely on the user's fingerprints or voice as an additional step.

Different forms of second factor methods are supported in Azure. These methods include:

- a mobile application, such as Microsoft Authenticator where users receive a uniquely generated one-time code on the phone app
- a phone call, where the user receives a one-time code
- a text message, where the user receives a one-time code

Use these different methods to cater to your users' needs. For example, for accessibility reasons, some users might prefer to receive a phone call rather than a text message.

## Enable multi-factor authentication

You enable multi-factor authentication for your Azure AD B2C application through the Azure portal. When you create user sign-in and sign-up flows, you enable multi-factor authentication with a toggle.  If necessary, use the same toggle in your user flow to disable multi-factor authentication for your application.

![Enable MFA in user flow](../media/3-enable-mfa-user-flow.png)

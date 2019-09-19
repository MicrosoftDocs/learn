
It's important for your organization to secure the application as much as possible. You'll add an additional layer of security with Azure AD B2B, when you enable multi-factor authentication for guest B2B users.

The clinicians need to be able to collaborate in a secure way. You can enforce multi-factor authentication at the application level to ensure that everyone who uses the application must pass an additional authentication challenge before they can access the application.

Here, you'll learn about multi-factor authentication. And you'll learn how Conditional Access policies can be used to enforce multi-factor authentication for Azure AD B2B guest users.

## Multi-factor authentication

You can add an additional authentication layer to secure your data and applications.

Before allowing access, multi-factor authentication asks the user to successfully complete challenges that can be put into three general categories:

- Something the user knows.
- Something the user possesses.
- Something the user is.

![MFA challenges](../media/5-mfa.png)

<!--- Original image: https://docs.microsoft.com/en-us/azure/active-directory/authentication/media/concept-mfa-howitworks/methods.png --->

A secret password or a secrete answer to a security question should be something that only the user knows. Users also possess devices, and these devices can be classified as something the user possesses. For example, a user would have a mobile phone and would be able to receive a text message with a secret one-time-use code. You could also make successful authentication contingent on the user themselves, through biometrics collected from the user. This biometric information is classified as "something the user is". For example, you would be able to make authentication rely on the user's fingerprints or voice as an additional step.

## Conditional Access policies

You can use Conditional Access policies in Azure AD B2B to require users that are outside of your organization to go through a multi-factor authentication process, before they're allowed access to applications.

Conditional Access policies have two key parts:

- Conditions – specified criteria that need to be met.
- Actions – steps to take once the conditions have been met.

You can configure enforcement of multi-factor authentication by creating a Conditional Access policy in the Azure portal. But you must be either a Conditional Access administrator, or a security administrator.

You can implement multi-factor authentication policies at different scopes. You set multi-factor authentication at a specific individual user level, or application level where anyone trying to access the application is required to go through a multi-factor authentication process. You could also set multi-factor authentication at tenant level where everyone who is a member of a tenant is expected to successfully complete the process.

Different forms of second factor methods are supported in Azure. These methods include:

- A mobile application, such as Microsoft Authenticator where users can receive a uniquely generated one-time code on the phone app.
- A phone call, where the user receives a call with a one-time code.
- A text message, where the user receives a text-message with a one-time code.

When you create your Conditional Access policy, you'll have to specify which users or groups the policy should apply to, the conditions that must be met, along with which applications the policy should be enforced on. You can then set multi-factor authentication to be a required control in this policy. You can then enable the policy if you are happy with the configuration.

![Configuring a Conditional Access policy](../media/5-conditional-access.png)

Once your policy is configured and enabled, you test it. You first test the policy by using the **What If** tool in the Azure portal.

![What if test](../media/5-whatif.png)This tool will help you simulate a user signing in and show you which policies would be applied based on your test simulation. If successful, you'll see your policy in the list of policies that will apply based on your simulation.

![What if result](../media/5-whatif-result.png)

You can then perform a final test by attempting to sign in as the user for the application, and test the Conditional Access policy by verifying whether multi-factor authentication is enforced correctly.

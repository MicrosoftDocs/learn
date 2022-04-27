
It's important for your organization to secure the application as much as possible. You'll add an additional layer of security with Azure Active Directory B2B (Azure AD B2B), by enabling multi-factor authentication for guest B2B users.

The clinicians need to be able to collaborate securely. You can enforce multi-factor authentication at the application level. This action ensures that everyone who uses the application must pass an additional authentication challenge before accessing it.

## Multi-factor authentication

You can add an extra authentication layer to secure data and applications.

Before allowing access, multi-factor authentication asks the user to complete challenges that can be put into three general categories:

- Something the user knows
- Something the user has
- Something the user is

![Graphic showing multi-factor authentication challenges.](../media/5-mfa.png)

A secret password or answer to a security question should be something that only the user knows. Users also have devices that can be classified as something they have. For example, a user might have a cell phone and be able to receive a text message with a secret, one-time-use code. You might also make successful authentication contingent on the user, through biometrics collected from them. This biometric information is classified as something the user is. For example, you might make authentication rely on the user's fingerprints or voice as an additional step.

## Conditional Access policies

You use Conditional Access policies in Azure AD B2B to require users outside the organization to go through a multi-factor authentication process, before they can access applications.

Conditional Access policies have two key parts:

- Conditions – specified criteria that need to be met
- Actions – steps to take when the conditions have been met

You configure enforcement of multi-factor authentication by creating a Conditional Access policy in the Azure portal. To do so, you must be either a Conditional Access administrator or a security administrator.

You implement multi-factor authentication policies at different scopes. You set multi-factor authentication at a specific individual user level, or application level. Anyone trying to access the application must go through a multi-factor authentication process. Also, you can set multi-factor authentication at a tenant level, where everyone who's a member of a tenant is expected to complete the process.

Azure supports different forms of second factor methods, including:

- A mobile application, such as Microsoft Authenticator, where users receive a uniquely generated, one-time code.
- A phone call, where the user receives a one-time code.
- A text message, where the user receives a one-time code.

When you create a Conditional Access policy, you specify which users or groups the policy should apply to, the conditions that must be met, and which applications the policy should be enforced on. You can then set multi-factor authentication to be a required control in this policy. If you're happy with the configuration, you then enable the policy.

![Screenshot of configuring a Conditional Access policy.](../media/5-conditional-access.png)

When your policy is configured and enabled, you test it by using the **What If** tool in the Azure portal.

![Screenshot of the What If tool test.](../media/5-what-if.png)

This tool helps simulate a user signing in, and shows you which policies are applied, based on your test simulation. If successful, the test shows your policy in the list that will apply, based on your simulation.

![Screenshot of the What If tool result.](../media/5-what-if-result.png)

You then do a final test by attempting to sign in as the user for the application. Test the Conditional Access policy by verifying whether multi-factor authentication is enforced correctly.

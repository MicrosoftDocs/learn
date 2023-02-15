Employees are typically expected to use many applications to accomplish tasks. When the employee is required to sign in to each of the applications individually, frustration rises and productivity declines. When an administrator sets up single sign-on for applications, the employee only has to sign in once to access all the applications they need.

An administrator can search for applications configured for single sign-on from the Azure AD application gallery and configure these applications for SSO. With single sign-on enabled, the employees will not be required to sign in with different credentials for each application.

## Example scenario

Suppose you’re an IT administrator at a commercial bank that offers finance and investment solutions to its clients. The company depends on many applications for employees to complete tasks such as marketing, sales, and operations. A team asked for a new application to be added to help with company promotion. The application needs to be made available to team members as appropriate.

You realize that this addition causes users to sign in to yet another application with specific credentials. Users become frustrated, because they have to sign in many times a day. You want to make it so that a user can sign in once and get access to all the applications that they need.

## What will we be doing?

Single sign-on is a trust relationship between an identity provider and a service provider. In this scenario, the Azure AD tenant that the company uses is known as the *identity provider*. The organization that makes the application available is known as the *service provider*.

For single sign-on, a combination of tasks is required both at the identity provider and at the service provider.

:::image type="content" source="../media/sso-process.png" alt-text="Diagram showing the tasks in single sign-on configuration." border="false":::

In this module, you'll use the Azure AD SAML Toolkit application to configure and test the single sign-on configuration. The Azure AD SAML Toolkit is a sample application that is available on the Azure AD application gallery.

You'll first add the application from the gallery and configure user assignment. You'll then configure single sign-on both at the identity provider and service provider, then you'll test the single sign-on configuration using the sample application and the test user account assigned to it.

## What's the main goal?

Upon completion of this module, you'll be able to create a trust relationship between the identity provider and the service provider. This relationship allows users to sign in once to access all the applications they need.

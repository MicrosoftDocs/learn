Employees are typically expected to use many applications to accomplish tasks. When the employee is required to sign in to each of the applications individually, frustration rises and productivity declines. When an administrator sets up single sign-on for applications, the employee only has to sign in once to access all the applications they need.

## Example scenario

Suppose you’re an IT administrator at a retail company. The company depends on many applications for users to complete tasks such as marketing, sales, and operations. A team asked for a new application to be added to help with company promotion. The application needs to be made available to team members as appropriate.

You realize that this addition causes users to sign in to yet another application with specific credentials. Users become frustrated, because they have to sign in many times a day. You want to make it so that a user can sign in once and get access to all the applications that they need.

## What will we be doing?

Single sign-on is a trust relationship between an identity provider and a service provider. In this scenario, the Azure AD tenant that the company uses is known as the *identity provider*. The organization that makes the application available is known as the *service provider*.

For single sign-on, a combination of tasks is required both at the identity provider and at the service provider.

:::image type="content" source="../media/sso-process.png" alt-text="Diagram showing the tasks in single sign-on configuration." border="false":::

- **Select your application from the gallery**: Locate the application in the Azure AD application gallery and add it to the Azure AD tenant.
- **Configure user and group assignments**: Create a user account and assign it to the application for testing single sign-on before making the application available to all employees.
- **Set up single sign-on Azure AD**: Define URLs in the basic SAML configuration for the application and record them to help with setting up single sign-on at the service provider. Add a claim to the SAML token that is exchanged with the application to help with controlling access to information. Set up the trust relationship between the identity provider and the service provider by downloading and then uploading a SAML certificate.
- **Set up application for single sign-on**: Register a user account at the service provider that matches the user account that was created at the identity provider. Configure single sign-on at the service provider using the URLs that were recorded at the identity provider.
- **Test single sign-on**: Update the URLs at the identity provider using the URLs that were recorded from the service provider. Test the single sign-on configuration using the test user account that was created.

## What's the main goal?

Upon completion of this module, you'll be able to create a trust relationship between the identity provider and the service provider. This relationship allows users to sign in once to access all the applications they need.

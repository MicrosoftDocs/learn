Employees in a company who are expected to use many applications to do their job have made complaints to the administrator about the number of times they have to sign in to all the applications. The administrator of the company wants to make it as easy as possible for them to do their work.

When an administrator sets up single sign-on, employees can sign in once using their Azure AD credentials, then not have to sign in again when accessing other applications. To configure single sign-on for an application, settings had to be defined at the identity provider and at the service provider.

To set up single sign-on for the new application, you completed the following tasks:

- Located the application in the Azure AD application gallery and added it to the tenant
- Accessed the integration documentation for the application to identify the supported single sign-on flows and any particular single sign-on requirements
- Created a user account and assigned it to the application for testing single sign-on before rolling the feature out to all employees
- Defined URLs in the basic SAML configuration for the application and recorded them to help with setting up single sign-on at the service provider
- Added a claim to the SAML token that is exchanged with the application to help with controlling access to information
- Set up the trust relationship between the identity provider and the service provider by downloading and then uploading a SAML certificate
- Registered a user account at the service provider that matches the user account that was created at the identity provider
- Configured single sign-on at the service provider using the URLs that were recorded at the identity provider
- Updated the URLs at the identity provider using the URLs that were recorded from the service provider
- Finally, tested the single sign-on configuration using the test user account that was created

The productivity level of the employees is much higher and the frustration level is much lower without having to sign in many times a day.

## References

- [Application integration guides](/azure/active-directory/saas-apps/tutorial-list)
- [Single Sign-on SAML protocol](/azure/active-directory/develop/single-sign-on-saml-protocol)
- [Overview of the Azure Active Directory application gallery](/azure/active-directory/manage-apps/overview-application-gallery)
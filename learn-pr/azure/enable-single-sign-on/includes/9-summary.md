As an administrator at a company where employees are expected to use several applications to do their job, complaints have been made about the number of times that they have to sign in when starting applications. The administrator of the company wants to make it as easy as possible for them to do their work.

By using single sign-on, employees are enabled to sign in once using once and then not have to sign in again when accessing other applications that have been configured for single sign-on. To configure single sign-on for an application, settings had to be defined in the Azure AD tenant and at the application host.

To set up single sign-on for the new application, the administrator completed the following tasks:

- Knowing that it's best to use applications that have already been tested with Azure AD, the application is located in the Azure AD application gallery and added it to the tenant.
- Accessed the integration documentation for the application to identify the supported single sign-on flows and any particular single sign-on requirements.
- Created a user account and assigned it to the application for testing single sign-on before rolling the feature out to all employees.
- URLs in the basic SAML configuration for the application were defined and recorded to help with setting up single sign-on at the application host.
- By adding a department claim to the SAML token that is exchanged with the application, access to information can be controlled.
- To set up the trust relationship between the Azure AD tenant (identity provider) and the application host (service provider), a SAML certificate was downloaded and uploaded.
- The user in the Azure AD tenant requires a matching account at the application host for successful single sign-on. An account was registered at the application host.
- Single sign-on URLs that were recorded in the Azure AD tenant were used to configure single sign-on at the application host.
- URLs that were provided in the single sign-on configuration at the application host were then used to update values in the Azure AD tenant.
- Finally, the single sign-on configuration was tested using the test user account that was created.

The productivity level of the employees is much higher and the frustration level is much lower without having to sign in many times a day.

## References

- [Application integration guides](https://docs.microsoft.com/azure/active-directory/saas-apps/tutorial-list)
- [Single Sign-On SAML protocol](https://docs.microsoft.com/azure/active-directory/develop/single-sign-on-saml-protocol)
- [Overview of the Azure Active Directory application gallery](https://docs.microsoft.com/azure/active-directory/manage-apps/overview-application-gallery)
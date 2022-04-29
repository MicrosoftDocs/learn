The application that the team asked for requires user accounts to be registered and single sign-on to be configured for them where the application is hosted.

Application hosts may allow the configuration of user accounts and single sign-on directly. Many may require you to gather the identifying information and URLs, the signing certificate, or the Federation Metadata XML, and then send them to the administration team at the application host who will configure single sign-on and create user accounts.

Depending on the application, a combination of some or all of the following values can be required:

- **Identifier (Entity ID)** - The unique ID that identifies your application to Azure Active Directory.
- **Reply URL (Assertion Consumer Service URL)** - The location where the application expects to receive the authentication token.
- **Sign on URL** - Used to perform service provider-initiated single sign-on.

For the Azure AD SAML Toolkit application, these values are not needed at the application host.

Depending on the application, you may need one of the following certificate related values:

- Base-64 certificate
- Raw formatted certificate
- Federation Metadata XML

For the Azure AD SAML Toolkit application, the raw formatted certificate is needed.

Depending on the application, a combination of some or all of the following application URLs are needed:

- **Login URL** - The URL that is used to sign in to the application in Azure AD.
- **Azure AD Identifier** - The identifier of the application in Azure AD.
- **Logout URL** - The URL that is used to sign out of the application.

For the Azure AD SAML Toolkit application, all three of these values are needed.

In the integration guides for the gallery applications, these common paragraphs may be shown:

- To configure single sign-on on {application} side, you need to send the downloaded Federation Metadata XML and appropriate copied URLs from Azure portal to {application} support team. They set this setting to have the SAML SSO connection set properly on both sides.
- To configure single sign-on on {application} side, you need to send the downloaded Certificate (Base64) and appropriate copied URLs from Azure portal to {application} support team. They set this setting to have the SAML SSO connection set properly on both sides.
- To configure single sign-on on {application} side, you need to send the downloaded Certificate (RAW) and appropriate copied URLs from Azure portal to {application} support team. They set this setting to have the SAML SSO connection set properly on both sides.

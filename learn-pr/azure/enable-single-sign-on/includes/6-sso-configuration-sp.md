The application that the team requested requires user accounts to be registered at the service provider. After an administrator registers the user account, they can configure single sign-on for the account.

Service providers may allow the configuration of user accounts and single sign-on directly. Many service providers require the information to be collected and sent to them to configure single sign-on. Information that is sent includes URLs, the signing certificate, or the Federation Metadata XML.

## Identity provider settings

Depending on the application, a combination of some or all of the following values can be required:

- **Identifier (Entity ID)**: The unique ID that identifies the application to the identity provider.
- **Reply URL (Assertion Consumer Service URL)**: The location where the application expects to receive the authentication token.
- **Sign on URL**: The sign-in page URL for the application.

For the Azure AD SAML Toolkit application, these values aren't needed at the service provider.

## Certificates

Depending on the application, you may need one of the following certificate related values:

- Base-64 certificate
- Raw formatted certificate
- Federation Metadata XML

In the integration guides for the gallery applications, these common paragraphs may be shown:

- To configure single sign-on on {application} side, you need to send the downloaded Federation Metadata XML and appropriate copied URLs from Azure portal to {application} support team. They configure this setting to have the SAML SSO connection set properly on both sides.
- To configure single sign-on on {application} side, you need to send the downloaded Certificate (Base64) and appropriate copied URLs from Azure portal to {application} support team. They configure this setting to have the SAML SSO connection set properly on both sides.
- To configure single sign-on on {application} side, you need to send the downloaded Certificate (RAW) and appropriate copied URLs from Azure portal to {application} support team. They configure this setting to have the SAML SSO connection set properly on both sides.

For the Azure AD SAML Toolkit application, the raw formatted certificate is needed.

## Service provider settings

Depending on the application, a combination of some or all of the following values are needed:

- **Login URL**: The URL that is used to sign in to the application at the identity provider
- **Azure AD Identifier**: The identifier of the application at the identity provider
- **Logout URL**: The URL that is used to sign out of the application

The **Azure AD SAML Toolkit** application needs all three of these values.

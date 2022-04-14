After successfully adding an application that supports single sign-on, properties must be configured for the it.

Choose SAML single sign-on whenever possible for existing applications that do not use OpenID Connect or OAuth. The Azure AD SAML Toolkit application that was added supports both Linked and SAML based single sign-on methods.

To configure single sign-on for the application in the Azure portal:

- Define the identifier and URLs that are used to identify the application in Azure AD
- Define any attributes or claims that are needed by the application
- Download a SAML signing certificate
- Register a user account and configure single sign-on at the application host

## Define URLs

The basic configuration for SAML-based single sign-on for an application requires these properties:

- **Identifier (Entity ID)** - The unique ID that identifies your application to Azure Active Directory. This value must be unique across all applications in your Azure Active Directory tenant. It should follow the pattern of `https://{application-name}.azurewebsites.net`.
- **Reply URL (Assertion Consumer Service URL)** - The location where the application expects to receive the authentication token. This is also referred to as the "Assertion Consumer Service" (ACS) in SAML. It should follow the pattern of `https://{application-name}.azurewebsites.net/SAML/Consume`.
- **Sign on URL** - Sign on URL is used if you would like to perform service provider-initiated single sign-on. This value is the sign-in page URL for your application. This field is unnecessary if you want to perform identity provider-initiated single sign-on.

:::image type="content" source="../media/saml-urls.png" alt-text="Screenshot showing the URLs that need to be defined for SAML single sign-on." border="false":::

Optional URLs that can be defined are:

- **Relay State** - Instructs the application where to redirect users after authentication is completed. The value is typically a URL or URL path that takes users to a specific location within the application.
- **Logout URL** - Used to send the SAML logout response back to the application.

## Add attributes or claims

When a user authenticates to an application using the SAML 2.0 protocol, a token is sent to the application by using an HTTP POST. And then, the application validates and uses the token to sign the user in instead of prompting for a username and password. These SAML tokens contain pieces of information about the user known as claims.

A claim is information that an identity provider states about a user inside the token they issue for that user. In SAML token, this data is typically contained in the SAML Attribute Statement.

:::image type="content" source="../media/saml-claims.png" alt-text="Screenshot showing the claims that can be defined for SAML single sign-on." border="false":::

There are two possible reasons why you might need to edit the claims issued in the SAML token:

- The application requires the NameIdentifier or NameID claim to be something other than the username (or user principal name) stored in Azure AD.
- The application has been written to require a different set of claim URIs or claim values.

Default claims in the token include:

- **Unique User Identifier (Name ID)**
- **emailaddress**
- **givenname**
- **name**
- **surname**

Attributes define the source of the claim. Many source attributes are provided for the user including identifying information, location information, and contact information.

## Download a SAML certificate

When you add a new application from the gallery and configure SAML-based sign-on, Azure AD generates a certificate for the application that is valid for three years.

:::image type="content" source="../media/saml-cert.png" alt-text="Screenshot showing the certificate created for SAML single sign-on." border="false":::

The certificate can be used as a raw (binary) certificate or a Base64 (base 64-encoded text) certificate. For gallery applications, the certificate might also be downloaded as federation metadata XML (an .xml file), depending on the requirement of the application.

## Configure single sign-on at the application host

All applications that have been added to the application gallery have their own way of registering user accounts and configuring single sign-on. To make single sign on work, an account must exist for the user both in Azure AD and at the application host. For all applications, the following URLs and identifier are defined at the application host:

- **Login URL** - The URL that is used to sign in to the application in Azure AD. For example, `https://login.microsoftonline.com/8ff45583-0000-0000-0000-2edcc572b1c8/saml2`.
- **Azure AD Identifier** - The identifier of the application in Azure AD. For example, `https://sts.windows.net/8ff45583-0000-0000-0000-2edcc572b1c8/`.
- **Logout URL** - The URL that is used to sign out of the application. For example, `https://login.microsoftonline.com/8ff45583-0000-0000-0000-2edcc572b1c8/saml2`.

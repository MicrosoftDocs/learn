After successfully adding an application that supports single sign-on, properties must be configured for it in the identity provider to enable the trust relationship with the service provider.

Choose SAML single sign-on whenever possible for existing applications that don't use OpenID Connect or OAuth. In this module, the **Azure AD SAML Toolkit** application represents the application that was requested by the team in the organization to help with company promotion. This application supports both Linked and SAML based single sign-on methods.

To configure single sign-on for the application:

- Identify the single sign-on flow that the application supports
- Define the identifier and URLs that are needed for the application in the supported flow
- Define any attributes or claims that are needed by the application
- Download a SAML signing certificate or record the **App Federation Metadata Url**
- Record values to be used at the service provider to configure single sign-on

## Single sign-on flows

An application can be accessed in different ways:

- An application can be started by signing in directly to the service provider. This is the service provider initiated single sign-on (SP initiated SSO) flow.
- An application can be started from the identity provider, such as the Azure portal or a launcher such as the My Apps portal. This is the identity provider initiated single sign-on (IDP initiated SSO) flow.

:::image type="content" source="../media/sso-flows.png" alt-text="Diagram showing the flows of single sign-on." border="false":::

All applications that have been integrated into the Azure AD application gallery have associated documentation that identifies which single sign-on flows it supports. For example, for the **Azure AD SAML Toolkit** application, the scenario description section states that the SP initiated SSO flow is supported. For non-gallery applications, the administrator needs to contact the application developer or possibly test to discover the supported flows.

### IDP initiated SSO

In the IDP initiated SSO flow, the user signs in to the identity provider, and then is redirected back to the application using the SAML response. In Azure AD, this would occur when a signed-in user starts an application in a launcher such as the My Apps portal, and then is redirected to that application. For configuration, it is important to have **Relay State URL** included when setting up single sign-on for the application so that the identity provider knows where to send users after they have successfully authenticated.

### SP initiated SSO

In SP-initiated SSO, the application initiates the request to sign in. When the user attempts to sign in to the service provider, they are redirected to the identity provider to be authenticated. The user is authenticated and are sent back to the application using the SAML response. To configure this process, the **Sign on URL** must be defined which tells the identity provider where to locate the sign-in page of the application.

:::image type="content" source="../media/sp-initiated-sso.png" alt-text="Diagram showing the flow of service provider initiated single sign-on." border="false":::

## Define URLs

The basic configuration for SAML-based single sign-on requires properties that are unique to the application. Refer to the integration documentation for the application to identify the appropriate values. Properties can be required or unnecessary depending on the application. The following are required and optional properties:

:::image type="content" source="../media/saml-urls.png" alt-text="Screenshot showing the URLs that need to be defined for SAML single sign-on." border="false":::

- **Identifier (Entity ID)** - The unique ID that identifies your application to Azure Active Directory. The identifier is used as a way to signal who is sending the SAML request. When using service provider-initiated single sign-on, Azure AD is not the initiator, so no audience field value is necessary in the token, but it is necessary when using identity provider-initiated single sign-on as the “audience” claim. This value must be unique across all applications in your Azure Active Directory tenant.
- **Reply URL (Assertion Consumer Service URL)** - The location where the application expects to receive the authentication token. This is also referred to as the "Assertion Consumer Service" (ACS) in SAML. This is the destination where requests or responses are sent back and forth to. For IdP-initiated SSO, The value is sent as the “destination” claim, and that’s also where the initial request is sent. For SP-initiated SSO, the response is sent to after the initial request, but the “destination” claim isn’t necessary for this flow.
- **Sign on URL** - Used if you would like to perform SP-initiated SSO. This value is the sign-in page URL for your application. This field is unnecessary if you want to perform IdP-initiated SSO.
- **Relay State** - Instructs the application where to redirect users after authentication is completed. The value is typically a URL or URL path that takes users to a specific location within the application. This value only takes effect in an IdP-initiated SSO flow. If your application uses SP-initiated SSO, then the service provider needs to send the Relay State as a parameter in the SAML request.
- **Logout URL** - Used to send the SAML logout response back to the application.

Properties that are required for an application are identified with a red asterisk.

## Add attributes or claims

When a user authenticates to an application using the SAML 2.0 protocol, a token is sent to the application by using an HTTP POST. And then, the application validates and uses the token to sign the user in instead of prompting for a username and password. These SAML tokens contain pieces of information about the user known as claims.

A claim is information that an identity provider states about a user inside the token they issue for that user. In a SAML token, this data is typically contained in the SAML Attribute Statement.

There are two possible reasons why you might need to edit the claims issued in the SAML token:

- The application requires the NameIdentifier or NameID claim to be something other than the username (or user principal name) stored in Azure AD.
- The application has been written to require a different set of claim URIs or claim values.

Default claims in the token include:

:::image type="content" source="../media/saml-claims.png" alt-text="Screenshot showing the claims that can be defined for SAML single sign-on." border="false":::

Attributes define the source of the claim. Many source attributes are provided for the user including identifying information, location information, and contact information.

## Download a SAML certificate

When you add a new application from the gallery and configure SAML-based single sign-on, Azure AD generates a certificate for the application that is valid for three years.

:::image type="content" source="../media/saml-cert.png" alt-text="Screenshot showing the certificate created for SAML single sign-on." border="false":::

The certificate can be used as a raw (binary) certificate or a Base64 (base 64-encoded text) certificate. For gallery applications, the certificate might also be downloaded as federation metadata XML (an .xml file), depending on the requirement of the application.  In some instances, the **App Federation Metadata Url** may be required.

## Record values

All applications that have been added to the application gallery have their own way of registering user accounts and configuring single sign-on. To make single sign on work, an account must exist for the user both in Azure AD and at the application host. For most applications, the following URLs and identifier are defined at the application host:

- **Login URL** - The URL that is used to sign in to the application in Azure AD. For example, `https://login.microsoftonline.com/8ff45583-0000-0000-0000-2edcc572b1c8/saml2`.
- **Azure AD Identifier** - The identifier of the application in Azure AD. For example, `https://sts.windows.net/8ff45583-0000-0000-0000-2edcc572b1c8/`.
- **Logout URL** - The URL that is used to sign out of the application. For example, `https://login.microsoftonline.com/8ff45583-0000-0000-0000-2edcc572b1c8/saml2`.

>[!NOTE]
>In some instances, the basic SAML configuration values may also need to be recorded to be provided at the application host.

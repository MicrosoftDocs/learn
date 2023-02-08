After the administrator successfully adds an application that supports single sign-on, they configure its properties at the identity provider to enable the trust relationship with the service provider.

Administrators should choose SAML single sign-on whenever possible for applications that don't use OpenID Connect or OAuth. In this module, the **Azure AD SAML Toolkit** application represents the application that was requested by the team to help with company promotion. This application supports both Linked and SAML-based single sign-on types.

To configure single sign-on for the application:

- Identify the single sign-on flow that the application supports.
- Define the identifier and URLs that are needed for the application in the supported flow.
- Define any attributes or claims that are needed by the application.
- Download a SAML signing certificate or record the **App Federation Metadata Url**.
- Record values to be used at the service provider to configure single sign-on.

## Single sign-on flows

An application can be accessed in different ways:

- An application can be started by signing in directly to the service provider. This process is known as the *service provider initiated single sign-on (SP-initiated SSO)* flow.
- An application can be started from the identity provider, such as the Azure portal or a launcher such as the My Apps portal. This process is known as the *identity provider initiated single sign-on (IdP-initiated SSO)* flow.

:::image type="content" source="../media/sso-flows.png" alt-text="Diagram showing the flows of single sign-on." border="true":::

All applications that have been integrated into the Azure AD application gallery have associated documentation that identifies the single sign-on flows that they support. For example, the **Azure AD SAML Toolkit** application scenario description section states that the SP initiated SSO flow is supported. For non-gallery applications, the administrator needs to contact the application developer or possibly test to discover the supported flows.

To access the integration guide for an application, select the **configuration guide** link on the **Set up single sign-on** pane.

:::image type="content" source="../media/guide-link.png" alt-text="Screenshot showing where to find the link to the integration guide." border="true":::

### IdP-initiated SSO

In the IdP-initiated SSO flow, the user signs in to the identity provider, then is redirected back to the application using the SAML response. Redirection occurs when a signed-in user starts an application in a launcher such as the My Apps portal. For configuration, it's important to have **Relay State URL** included when setting up single sign-on for the application so that the identity provider knows where to send users after they've successfully authenticated.

### SP-initiated SSO

In the SP-initiated SSO flow, the application initiates the request to sign in. When the user attempts to sign in to the service provider, they're redirected to the identity provider to be authenticated. The user is authenticated and then sent back to the application using the SAML response. To configure this process, define the **Sign on URL**, which tells the identity provider where to locate the sign-in page of the application.

:::image type="content" source="../media/sp-initiated-sso.png" alt-text="Diagram showing the flow of service provider initiated single sign-on." border="true":::

## SAML URLs

The basic configuration for SAML-based single sign-on requires properties that are unique to the application. Refer to the integration documentation for the application to identify the appropriate values. Properties can be required or optional depending on the application.

:::image type="content" source="../media/saml-urls.png" alt-text="Screenshot showing the URLs that need to be defined for SAML single sign-on." border="false":::

- **Identifier (Entity ID)**: The unique ID that identifies the application to the identity provider. The identifier is used as a way to signal who's sending the SAML request. In the SP-initiated SSO flow, the identity provider isn't the initiator, so no `audience` claim is necessary in the token, but it's necessary when using IdP-initiated SSO. This value must be unique across all applications in the identity provider.
- **Reply URL (Assertion Consumer Service URL)**: The location where the application expects to receive the authentication token. This property is also referred to as the **Assertion Consumer Service (ACS)** in SAML. This property value is the destination where requests or responses are sent. For IdP-initiated SSO, the value is sent as the `destination` claim, and that’s also where the initial request is sent. For SP-initiated SSO, it's where the response is sent after the initial request, but the `destination` claim isn’t necessary for this flow.
- **Index**: This is an additional field under the **Reply URL (Assertion Consumer Service URL)**. The index value specifies the index of the URLs where user tokens are sent for sign-in. This is only valid for SAML applications.
- **Sign on URL**: This value is the sign-in page URL for the application in the SP-initiated SSO flow. This field isn't needed for the IdP-initiated SSO flow.
- **Relay State**: Instructs the application where to redirect users after authentication is completed. The value is typically a URL that takes users to a specific location within the application. This value only takes effect in an IdP-initiated SSO flow. If the application uses SP-initiated SSO, then the service provider needs to send the **Relay State** as a parameter in the SAML request.
- **Logout URL**: Used to send the SAML logout response back to the application.

For some applications, you can download a metadata file from the service provider that contains the single sign-on configuration, and then upload it the identity provider.

:::image type="content" source="../media/metadata-link.png" alt-text="Screenshot showing where to upload a metadata file." border="true":::

## Attributes and claims

When a user authenticates to an application using the SAML 2.0 protocol, a token is sent to the application by using an HTTP POST. The application then validates and uses the token to sign the user in instead of prompting for a username and password. These SAML tokens contain pieces of information about the user known as *claims*.

A claim is information that an identity provider states about a user inside the token they issue for that user. In a SAML token, this data is typically contained in the SAML Attribute Statement.

There are two possible reasons for editing the claims issued in the SAML token:

- The application requires the NameIdentifier or NameID claim to be something other than the username (or user principal name) stored in Azure AD.
- The application has been written to require a different set of claim URIs or claim values.

Default claims in the token are shown in the following diagram:

:::image type="content" source="../media/saml-claims.png" alt-text="Screenshot showing the claims that can be defined for SAML single sign-on." border="false":::

Attributes define the source of the claim. Many source attributes are provided for the user, including identifying information, location information, and contact information.

## SAML certificate

A new application added from the gallery and configured for SAML-based single sign-on automatically has a certificate generated automatically for it. The certificate is valid for three years. This certificate is shared between the identity provider and the service provider.

:::image type="content" source="../media/saml-cert.png" alt-text="Screenshot showing the certificate created for SAML single sign-on." border="false":::

The certificate can be used as a raw (binary) certificate or a Base64 (base 64-encoded text) certificate. For gallery applications, the certificate might also be downloaded as federation metadata XML (an .xml file), depending on the requirement of the application. In some instances, the **App Federation Metadata Url** may be required.

## Service provider settings

All applications that have been added to the application gallery have their own way of registering user accounts and configuring single sign-on. In most cases, to make single sign-on work, an account must exist for the user both at the identity provider and at the service provider. For most applications, the following URLs and identifier are defined at the service provider:

- **Login URL**: The URL that's used to sign in to the application at the identity provider.
- **Azure AD Identifier**: The identifier of the application at the identity provider.
- **Logout URL**: The URL that's used to sign out of the application.

:::image type="content" source="../media/saml-add-urls-sp.png" alt-text="Screenshot showing the URLs needed at the service provider." border="false":::

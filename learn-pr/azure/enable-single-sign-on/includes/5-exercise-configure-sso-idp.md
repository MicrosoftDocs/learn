In this exercise, you'll configure single sign-on properties for the application at the identity provider.

To configure single sign-on for the application:

- Define the URLs used to access the application
- Define any attributes or claims the application needs
- Download a SAML signing certificate
- Record the single sign-on settings to use at the service provider

## Define URLs

In this module, we're using Azure AD as the identity provider in the single sign-on flow. To set up the trust relationship between the identity provider and the service provider, URLs must be defined.

1. Sign in to the [Azure portal](https://portal.azure.com/) using one of the roles listed in the prerequisites and select **All services**.
1. Select **Identity**, and then select **Azure Active Directory**.

    :::image type="content" source="../media/select-azure-ad.png" alt-text="Screenshot showing where to find Azure Active Directory in the Azure portal." border="false":::

1. On the **Azure Active Directory** pane, under **Manage**, select **Enterprise applications**.
1. In the **Search application** box, enter **Azure AD SAML Toolkit**, then select the application in the list.

    :::image type="content" source="../media/search-applications.png" alt-text="Screenshot showing the addition of a new enterprise application." border="true":::

1. On the application overview pane, under **Manage**, select **Single sign-on**, then select **SAML**.

    :::image type="content" source="../media/saml-selection.png" alt-text="Screenshot showing the selection of SAML as the single sign-on method." border="true":::

1. In the **Basic SAML Configuration** box, select **Edit**.
1. Specify the **Identifier (Entity ID)**. The provided value follows a suggested pattern. Each application in the gallery has a unique set of suggested patterns for URLs. For this application, accept the default value of `https://samltoolkit.azurewebsites.net`.
1. Specify the **Reply URL (Assertion Consumer Service URL)** (where the application expects to receive the authentication token) and the **Sign on URL** (the sign-in page for the application). For gallery applications, these values are defined by the service provider. For this application, to get the values from the service provider, you need a certificate. To download a certificate and get values from the service provider, enter temporary values for now; the values are updated later in the module. This configuration can vary from application to application.
1. Select **Save**.

    :::image type="content" source="../media/saml-url-temp.png" alt-text="Screenshot showing the temporary U R L's that are defined for the application." border="true":::

## Add a claim

The administrator at the commercial bank knows that the application relies on the department of the employee to appropriately share information. To add a `department` claim to the token:

1. On the **Single sign-on** page, select **Edit** in the **Attributes & Claims** box.
1. On the **Attributes & Claims** pane, select **Add new claim**.

    :::image type="content" source="../media/saml-add-claim.png" alt-text="Screenshot showing how to add a claim to a SAML token." border="true":::

1. Enter the name of the claim. For this exercise, enter `department`.
1. Enter the namespace for the claim. For example: `http://schemas.xmlsoap.org/ws/2005/05/identity/claims`.
1. Select the **Source** where the claim is going to retrieve its value. You can select a user attribute from the source attribute dropdown or apply a transformation to the user attribute before emitting it as a claim. For this exercise, select `user.department`.

    :::image type="content" source="../media/saml-dept-claim.png" alt-text="Screenshot showing the addition of a department claim." border="true":::

1. Select **Save**.

## Download the certificate

For the **Azure AD SAML Toolkit** application, a certificate is downloaded from the identity provider that is then uploaded at the service provider. In some instances, other certificate formats or the **App Federation Metadata Url** may be required.

1. On the **Single sign-on** page, select **Download** next to **Certificate (Raw)** in the **SAML Signing Certificate** box to download the SAML signing certificate and save it to be used later.

    :::image type="content" source="../media/saml-cert-download.png" alt-text="Screenshot showing where to download the signing certificate." border="false":::

1. You may be asked to verify the download; if so, select **Keep**.

## Record single sign-on properties

Applications in the gallery can require different URLs and identifiers. Refer to the integration guide for an application to know which values are required.

1. For this exercise, you don't need the values in the **Set up Azure AD SAML Toolkit** box for configuration at the service provider, but for other applications in the gallery, the **Identifier (Entity ID)**, **Reply URL (Assertion Consumer Service URL)**, and **Sign on URL** may be needed when configuring single sign-on at the service provider.
1. For this exercise, you need the values of **Login URL**, **Azure AD Identifier**, and **Logout URL**. Other applications in the gallery may require any combination of properties to configure single sign-on at the service provider.

>[!NOTE]
>In some instances, the basic SAML configuration values may also need to be recorded to be provided at the service provider.

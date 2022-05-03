In this exercise, single sign-on properties are configured for the application at the identity provider.

To configure single sign-on for the application:

- Define the URLs that are used to access the application
- Define any attributes or claims that are needed by the application
- Download a SAML signing certificate
- Record the single sign-on settings to use at the service provider

## Define URLs

In this module, Azure AD is being used as the identity provider in the single sign-on flow to configure single sign-on for the application. To set up the trust relationship between the identity provider and the service provider, URLs must be defined.

1. Sign in to the [Azure portal](https://portal.azure.com/) using one of the roles listed in the prerequisites.
1. Select **Identity**, and then select **Azure Active Directory**.

    :::image type="content" source="../media/select-azure-ad.png" alt-text="Screenshot showing where to find Azure Active Directory in the Azure portal." border="false":::

1. On the **Azure Active Directory** pane, under **Manage**, select **Enterprise applications**.
1. In the **Search application** box, enter **Azure AD SAML Toolkit**, and then select the application in the list.

    :::image type="content" source="../media/add-application.png" alt-text="Screenshot showing the addition of a new enterprise application." border="true":::

1. On the application overview pane, under **Manage**, select **Single sign-on**, and then select **SAML**.

    :::image type="content" source="../media/saml-selection.png" alt-text="Screenshot showing the selection of SAML as the single sign-on method." border="true":::

1. In the **Basic SAML Configuration** box, select **Edit**.
1. Specify the **Identifier (Entity ID)**. The provided value follows a suggested pattern. Each application in the gallery has a unique set of suggested patterns for URLs. For this application, accept the default value of `https://samltoolkit.azurewebsites.net`.
1. Specify the **Reply URL (Assertion Consumer Service URL)**. The value entered at this point in the configuration process is only temporary, you'll come back to this property and revise the value. Select **Add reply URL** and enter the suggested pattern of `https://samltoolkit.azurewebsites.net/SAML/Consume`.
1. Specify the **Sign on URL** - Used to perform service provider-initiated single sign-on. This value is the sign-in page URL for your application. The value entered at this point in the configuration process is only temporary, you'll come back to this property and revise the value. This field is unnecessary if you want to perform identity provider-initiated single sign-on. Enter the default pattern of `https://samltoolkit.azurewebsites.net/`.

    :::image type="content" source="../media/saml-url-temp.png" alt-text="Screenshot showing the temporary URLs that are defined for the application." border="true":::

## Add a claim to the SAML token

As the administrator of the application, you want to control access based on the department in which the employees are members. To add a `department` claim to the token:

1. On the **Attributes & Claims** pane, select **Add new claim**.

    :::image type="content" source="../media/saml-add-claim.png" alt-text="Screenshot showing how to add a claim to a SAML token." border="true":::

1. Enter the name of the claim. The value doesn't strictly need to follow a URI pattern. If you need a URI pattern, you can put that in the Namespace field. For this exercise, enter `department`.
1. Enter the namespace for the claim. For example, `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/`.
1. Select the **Source** where the claim is going to retrieve its value. You can select a user attribute from the source attribute dropdown or apply a transformation to the user attribute before emitting it as a claim. For this exercise, select `user.department`.

    :::image type="content" source="../media/saml-dept-claim.png" alt-text="Screenshot showing the addition of a department claim." border="true":::

1. Select **Save**.

## Download the certificate

For this exercise, a certificate is being downloaded that is then uploaded at the service provider. In some instances, other certificate formats or the **App Federation Metadata Url** may be required.

1. In the **SAML Signing Certificate** box, select **Download for Certificate (Raw)** to download the SAML signing certificate and save it to be used later.

    :::image type="content" source="../media/saml-cert-download.png" alt-text="Screenshot showing where to download the signing certificate." border="false":::

1. You may be asked to verify the download, if so, select **Keep**.

## Record the single sign-on properties

Applications in the gallery can require different URLs and identifiers. Refer to the integration guide for an application to know which values are required.

1. For this exercise, you don't need the values in the **Set up Azure AD SAML Toolkit** box for configuration at the service provider. But, for other applications in the gallery, the **Identifier (Entity ID)**,
**Reply URL (Assertion Consumer Service URL)**, and **Sign on URL** may be needed when configuring single sign-on at the service provider.
1. For this exercise, you need the values of **Login URL**, **Azure AD Identifier**, and **Logout URL**. Other applications in the gallery may require any combination of properties to configure single sign-on at the service provider.

>[!NOTE]
>In some instances, the basic SAML configuration values may also need to be recorded to be provided at the service provider.

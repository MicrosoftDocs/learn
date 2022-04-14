In this exercise, you’ll learn how to configure single sign-on properties for an application in the Azure portal.

To configure single sign-on for the application in the Azure portal:

- Define the URLs that are used to access the application
- Define any attributes or claims that are needed by the application
- Download a SAML signing certificate

## Define URLS

Define values for the following single sign-on properties in the Azure portal.

1. Sign in to the [Azure portal](https://portal.azure.com/) using one of the roles listed in the prerequisites.
1. Select **Identity**, and then select **Azure Active Directory**.

    :::image type="content" source="../media/select-azure-ad.png" alt-text="Screenshot showing where to find Azure Active Directory in the Azure portal." border="false":::

### Search for the application

Search for the application that you added in the previous unit.

1. On the **Azure Active Directory** pane, under **Manage**, select **Enterprise applications**.
1. In the **Search application** box, enter **Azure AD SAML Toolkit**, and then select the application in the list.

    :::image type="content" source="../media/add-application.png" alt-text="Screenshot showing the addition of a new enterprise application." border="true":::

### Configure single sign-on

1. On the application overview pane, under **Manage**, select **Single sign-on**, and then select **SAML**.

    :::image type="content" source="../media/saml-selection.png" alt-text="Screenshot showing the selection of SAML as the single sign-on method." border="false":::

1. In the **Basic SAML Configuration** box, select **Edit**.
1. Specify the **Identifier (Entity ID)**. For this application the identifier is `https://samltoolkit.azurewebsites.net`.

    :::image type="content" source="../media/saml-identifier.png" alt-text="Screenshot showing the SAML identifier." border="false":::

    A value is provided that follows a suggested pattern. Each application in the gallery has a unique set of suggested patterns for URLs.

1. Specify the **Reply URL (Assertion Consumer Service URL)**. The value entered at this point in the configuration process is only temporary, you will come back to this property and revise the value. For this application, the URL is `https://samltoolkit.azurewebsites.net/SAML/Consume`.
1. Specify the **Sign on URL** - Used to perform service provider-initiated single sign-on. This value is the sign-in page URL for your application. This field is unnecessary if you want to perform identity provider-initiated single sign-on.

    :::image type="content" source="../media/saml-urls-temp.png" alt-text="Screenshot showing the temporary URLs that are defined for the application." border="true":::

## Download the certificate

1. In the **SAML Signing Certificate** box, select **Download for Certificate (Raw)** to download the SAML signing certificate and save it to be used later.

    :::image type="content" source="../media/saml-cert-download.png" alt-text="Screenshot showing where to download the signing certificate." border="false":::

1. You may be asked to verify the download, if so, select **Keep**.

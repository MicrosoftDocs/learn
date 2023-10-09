


Integrating SAP Cloud Platform Identity Authentication with Azure AD gives you the following benefits:

- You can control in Azure AD who has access to SAP Cloud Platform Identity Authentication.
- It enables your users to be automatically signed-in to SAP Cloud Platform Identity Authentication with their Azure AD accounts.
- You can manage your accounts in one central location - the Azure portal.

## Add SAP Cloud Platform Identity Authentication from the gallery

To configure the integration of SAP Cloud Platform Identity Authentication into Azure AD, first add SAP Cloud Platform Identity Authentication from the Azure AD application gallery to your list of managed SaaS apps.

## Configure and test Azure Active Directory-based single sign-on

Next, you need to configure and test Azure AD-based SSO by using the following sequence of steps:

1. Configure Azure AD single sign-on - to enable your users to use this feature.
2. Configure SAP Cloud Platform Identity Authentication single sign-on - to configure the single sign-on settings on application side.
3. Assign Azure AD users to SAP Cloud Platform Identity Authentication.

### Configure Azure AD single sign-on

1. In the Azure portal, on the **SAP Cloud Platform Identity Authentication application integration** page, select **Single sign-on**.
2. On the **Select a Single sign-on method** page, select **SAML/WS-Fed** mode to enable single sign-on.
3. On the **Set up Single Sign-On with SAML** page, select the **Edit** icon to open the **Basic SAML Configuration** dialog.
4. On the **Basic SAML Configuration** section:

     - To configure IDP initiated mode, specify the SAP Cloud Platform IAS tenant identifier (Entity ID) and the corresponding Reply URL (Assertion Consumer Service URL).
     - To configure the application in SP initiated mode, select **Set additional URLs** and provide the Sign-on URL.

To obtain these values, you can contact the [SAP Cloud Platform Identity Authentication Client support team](https://cloudplatform.sap.com/capabilities/security/trustcenter.html).

SAP Cloud Platform Identity Authentication application expects the SAML assertions in a specific format. Configure the relevant claims for this application, including givenname, surname, emailaddress, name, and Unique User Identifier. You can manage the values of these attributes from the User Attributes section on the application integration page.

### Configure SAP Cloud Platform Identity Authentication single sign-on

To configure SSO for your application, navigate to the SAP Cloud Platform Identity Authentication administration console. Under Identity Providers, choose the Corporate Identity Providers tile. Choose the Add button to create an Azure AD corporate identity provider. Under SAML 2.0, choose SAML 2.0 Configuration.

Upload Azure AD metadata XML file or configure manually the following fields:

- **Name**: The entity ID of the corporate identity provider.
- **Single Sign-On Endpoint URL**: The URL of the identity provider single sign-on endpoint that receives authentication requests. For Binding, choose the one that corresponds to a respective single sign-on endpoint.
- **Single Logout Endpoint URL**: The URL of the identity provider's single logout endpoint that receives logout messages. For Binding, choose the one that corresponds to respective single logout endpoint.
- **Signing Certificate**: The base64-encoded certificate used by the identity provider to digitally sign SAML protocol messages sent to Identity Authentication.

### Assign Azure AD users

1. In the Azure portal, select **Enterprise Applications**, select **All applications**, then select **SAP Cloud Platform Identity Authentication**.
2. In the applications list, select **SAP Cloud Platform Identity Authentication**.
3. In the Azure portal, select **Users and groups**.
4. Select the **Add user** button, then select users and groups you intend to assign to the application in the **Add Assignment** dialog.
5. If you are expecting any role value in the SAML assertion then in the **Select Role** dialog select the appropriate role for the user from the list, then click the **Select** button at the bottom of the screen. In the Add Assignment dialog, select the **Assign** button.

    > [!NOTE]
    > You don't need to create a user in SAP Cloud Platform Identity Authentication. Users who are in the Azure AD user store can use the SSO functionality. SAP Cloud Platform Identity Authentication supports the Identity Federation option. This option allows the application to check whether users who are authenticated by the corporate identity provider exist in the user store of SAP Cloud Platform Identity Authentication. The Identity Federation option is disabled by default. If Identity Federation is enabled, only the users that are imported in SAP Cloud Platform Identity Authentication can access the application.
6. To verify the outcome, select the SAP Cloud Platform Identity Authentication tile in the Access Panel. You should be automatically signed in to the SAP Cloud Platform Identity Authentication for which you set up SSO.




Integrating SAP HANA with Azure AD provides you with the following benefits:

- You can control in Azure AD who has access to SAP HANA.
- You can enable your users to be automatically signed in to SAP HANA (single sign-on) with their Azure AD accounts.
- You can manage your accounts in one central location - the Azure portal.

To configure Azure AD integration with SAP HANA, you need the following items:

- An Azure AD subscription.
- An SAP HANA subscription that's single sign-on (SSO) enabled.
- A HANA instance that's running on any public IaaS, on-premises, or Azure VM.
- The XSA Administration web interface, and HANA Studio installed on the HANA instance.

Azure AD integration within SAP HANA allows you to implement:

- SAP HANA supports IDP initiated SSO
- SAP HANA supports just-in-time user provisioning

## Add SAP HANA from the gallery

To configure the integration of SAP HANA into Azure AD, first add SAP HANA from the gallery to your list of managed SaaS apps.

## Configure Azure AD single sign-on

To configure Azure AD single sign-on with SAP HANA, complete the following steps:

1. Configure Azure AD single sign-on to enable users to use this feature.
2. Configure SAP HANA single sign-on to configure the single sign-on settings on application side.
3. Assign Azure AD users to allow them to use Azure AD single sign-on.
4. Create SAP HANA users to provision counterpart accounts in SAP HANA linked to the corresponding Azure AD user accounts.

### Configure Azure AD single sign-on in the portal

1. To configure Azure AD single sign-on with SAP HANA, in the Azure portal, on the SAP HANA application integration page, select **Single sign-on**.
2. In the **Select a Single sign-on method** dialog, select **SAML/WS-Fed** mode to enable single sign-on.
3. On the **Set up Single Sign-On with SAML** page, select the **Edit** icon to open the **Basic SAML Configuration** dialog.
4. On the **Set up Single Sign-On with SAML** page, perform the following steps:

    1. In the **Identifier** text box, type **HA100**.
    2. In the **Reply URL** text box, type a URL in the format `<https://Customer-SAP-instance-url/sap/hana/xs/saml/login.xscfunc>`. To obtain its actual value, you can contact the [SAP HANA Client support team](https://cloudplatform.sap.com/contact.html).
    3. SAP HANA application expects the SAML assertions in a specific format. Configure the following claims for this application: **givenname**, **surname**, **emailaddress**, **name**, and **Unique User Identifier**. You can manage the values of these attributes from the **User Attributes** section on the application integration page.
5. On the **Set up Single Sign-On with SAML** page, select the **Edit** button to open the **User Attributes** dialog.
6. In the **User attributes** section on the **User Attributes &amp; Claims** page, perform the following steps:

    1. Click the **Edit** icon to open the **Manage user claims** pane.
    2. From the **Transformation** list, select **ExtractMailPrefix()**.
    3. From the **Parameter 1** list, select **user.mail**.
    4. Save your changes.
7. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the Federation Metadata XML from the given options as per your requirement and save it on your computer.

### Configure SAP HANA single sign-on

1. To configure single sign-on on the SAP HANA side, sign in to your HANA XSA Web Console by going to the respective HTTPS endpoint.

    > [!NOTE]
    > In the default configuration, the URL redirects the request to a sign-in screen, which requires the credentials of an authenticated SAP HANA database user. The user who signs in must have permissions to perform SAML administration tasks.
2. In the XSA Web Interface, go to **SAML Identity Provider**. From there, select the **+** button on the bottom of the screen to display the **Add Identity Provider Info** pane.
3. In the **Add Identity Provider Info pane**, paste the contents of the Metadata XML (which you downloaded from the Azure portal) into the **Metadata** box.
4. If the contents of the XML document are valid, the parsing process extracts the information that's required for the Subject, Entity ID, and Issuer fields in the General data screen area. It also extracts the information that's necessary for the URL fields in the **Destination** screen area, for example, the Base URL and SingleSignOn URL (\*) fields.
5. In the **Name** box of the **General Data** screen area, enter a name for the new SAML SSO identity provider.

    > [!NOTE]
    > The name of the SAML IDP is mandatory and must be unique. It appears in the list of available SAML IDPs that is displayed when you select SAML as the authentication method for SAP HANA XS applications to use. For example, you can do this in the Authentication screen area of the XS Artifact Administration tool.
6. Select **Save** to save the details of the SAML identity provider and to add the new SAML IDP to the list of known SAML IDPs.
7. In HANA Studio, within the system properties of the **Configuration** tab, filter the settings by **saml**. Then adjust the **assertion\_timeout** from 10 sec to 120 sec.

### Assign Azure AD users

1. In the Azure portal, select **Enterprise Applications**, select **All applications**, then select **SAP HANA**.
2. In the applications list, select **SAP HANA**.

### Create SAP HANA users

To enable Azure AD users to sign in to SAP HANA, you must provision them in SAP HANA. SAP HANA supports just-in-time provisioning, which is by enabled by default.

If you need to create a user manually, take the following steps:

1. Open the SAP HANA Studio as an administrator, and then enable the DB-User for SAML SSO.
2. Select the check box to the left of SAML, and then select the **Configure** link.
3. Select **Add** to add the SAML IDP. Select the appropriate SAML IDP, and then select **OK**.
4. Add the **External Identity** or choose **Any**. Then select **OK**.

    > [!NOTE]
    > If the **Any** check box is not selected, then the user name in HANA needs to exactly match the name of the user in the UPN before the domain suffix.
5. Assign the relevant roles to the user.
6. To verify the outcome, select the **SAP HANA** tile in the Access Panel. You should be automatically signed in to the SAP HANA for which you set up SSO.

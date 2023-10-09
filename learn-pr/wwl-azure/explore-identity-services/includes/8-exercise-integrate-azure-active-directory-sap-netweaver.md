


Integrating SAP NetWeaver with Azure AD provides the following benefits:

- You can control in Azure AD who has access to SAP NetWeaver.
- You can enable your users to be automatically signed in to SAP NetWeaver (single sign-on) with their Azure AD accounts.
- You can manage your accounts in one central location - the Azure portal.

To configure Azure AD integration with SAP NetWeaver, you need the following items:

- An Azure AD subscription
- SAP NetWeaver single sign-on enabled subscription
- SAP NetWeaver V7.20 required at least

SAP NetWeaver supports SP initiated SSO.

## Add SAP NetWeaver from the gallery

To configure the integration of SAP NetWeaver into Azure AD, first add SAP NetWeaver from the gallery to your list of managed SaaS apps.

## Configure and test Azure AD single sign-on

To configure Azure AD single sign-on with SAP NetWeaver, you need to use the following steps:

1. Configure Azure AD single sign-on - to enable users to use this feature.
2. Configure SAP NetWeaver single sign-on - to configure the single sign-on settings on application side.
3. Assign the Azure AD test user to the Azure AD application.
4. Create SAP NetWeaver users linked to their Azure AD user accounts.

### Configure Azure AD single sign-on

To configure Azure AD single sign-on with SAP NetWeaver, perform the following steps:

1. Open a new web browser window and log into your SAP NetWeaver company site as an administrator.
2. Make sure that the http and https services are active and appropriate ports are assigned in SMICM T-Code.
3. sign in to the business client of SAP System (T01), where SSO is required, and activate HTTP Security session Management.
4. Go to **Transaction code SICF\_SESSIONS**. Review all profile parameters. Adjust per your organization requirements, and then restart the SAP system.
5. Double-click on the relevant client to enable an HTTP security session.
6. Activate the following SICF services:

     - **/sap/public/bc/sec/saml2**
     - **/sap/public/bc/sec/cdc\_ext\_service**
     - **/sap/bc/webdynpro/sap/saml2**
     - **/sap/bc/webdynpro/sap/sec\_diag\_tool** (This is only to enable / disable trace)
7. Go to **Transaction code SAML2** in the business client of SAP system \[T01/122\]. It opens a user interface in a browser.
8. Provide your username and password to enter the user interface and select **Edit**.
9. Change **Provider Name** from **T01122** to ``` <http://T01122> ``` and select **Save**.
10. By default, the provider name is formatted as **\[sid\]\[client\]** format, but Azure AD expects the name in the format **protocol://\[sid\]\[client\]**. We recommend that you maintain the provider name as **https://\[sid\]\[client\]** to allow multiple SAP NetWeaver ABAP engines to be configured in Azure AD.
11. Generate Service Provider Metadata: once you're done with configuring the Local Provider and Trusted Providers settings on SAML 2.0 User Interface, the next step involves generating the service provider’s metadata file (which would contain all the settings, authentication contexts, and other configurations in SAP).
12. On the **Local Provider** tab, select **Metadata**.
13. Save the generated Metadata XML file on your computer and upload it in Basic SAML Configuration section to autopopulate the **Identifier** and **Reply URL** values in the Azure portal.
14. In the Azure portal, on the **SAP NetWeaver application integration** page, select **Single sign-on**.
15. On the **Select a Single sign-on** method dialog, select **SAML/WS-Fed** mode to enable single sign-on.
16. On the **Set up Single Sign-On with SAML** page, select the **Edit** icon to open **Basic SAML Configuration** dialog.
17. On the **Basic SAML Configuration** section, perform the following steps:

    1. Select **Upload metadata** file to upload the Service Provider metadata file, which you obtained earlier.
    2. Select on the folder logo to select the metadata file, and then select **Upload**.
    3. After the metadata file is successfully uploaded, the **Identifier** and **Reply URL** values get auto populated in **Basic SAML Configuration** section textbox as shown:
    4. In the **Sign-on URL** text box, type a URL using the following pattern: **https://\[your company instance of SAP NetWeaver\]**
18. SAP NetWeaver application expects the SAML assertions in a specific format. The claims including **givenname**, **surname**, **emailaddress**, **name**, and **Unique User Identifier**. You can manage their values from the **User Attributes** section on application integration page.
19. On the **Set up Single Sign-On with SAML** page, select the **Edit** button to open the **User Attributes** dialog.
20. In the **User Claims** section on the **User Attributes** dialog, configure SAML token attribute and perform the following steps:

    1. Select the **Edit** icon to open the **Manage user claims** dialog.
    2. From the **Transformation** list, select **ExtractMailPrefix()**.
    3. From the **Parameter 1** list, select **user.userprinicipalname**.
    4. Select **Save**.
21. On the **Set up Single Sign-On with SAML** page, in the **SAML Signing Certificate** section, select **Download** to download the Federation Metadata XML from the given options as per your requirement and save it on your computer.
22. On the **Set up SAP NetWeaver** section, copy the appropriate URL(s) as per your requirement.

     - Login URL
     - Azure Ad Identifier
     - Logout URL

### Configure SAP NetWeaver single sign-on

1. Sign in to the SAP system and go to transaction code SAML2. It opens a new browser window to the SAML configuration screen.
2. For configuring End points for trusted Identity provider (Azure AD) go to the **Trusted Providers** tab.
3. Press **Add** and select **Upload Metadata File** from the context menu.
4. Upload the metadata file, which you downloaded from the Azure portal.
5. In the next screen, type an arbitrary **Alias** name. Make sure that your **Digest Algorithm** should be **SHA-256** and don’t require any changes and press **Next**.
6. On **Single Sign-On Endpoints**, use **HTTP POST** and select **Next** to continue.
7. On **Single Logout Endpoints**, select **HTTPRedirect** and select **Next** to continue.
8. On **Artifact Endpoints**, press **Next** to continue.
9. On **Authentication Requirements**, accept the default settings and select **Finish**.
10. Go to tab **Trusted Provider**, then **Identity Federation**.
11. Select **Edit**.
12. Select **Add** under the **Identity Federation** tab.
13. From the pop-up window, select **Unspecified** from the **Supported NameID** formats and select **OK**. User ID Source and user ID mapping mode values determine the link between SAP user and Azure AD claim.
14. There are two possible scenarios:

     - Scenario: SAP User to Azure AD user mapping.
     - Scenario: Select SAP user ID based on configured email address in SU01. In this case email ID should be configured in su01 for each user who requires SSO.
15. Select **Save** and then select **Enable** to enable identity provider.

### Assign Azure AD users

In the Azure portal, select **Enterprise Applications**, select **All applications**, then select **SAP NetWeaver**. In the applications list, select **SAP NetWeaver**.

### Create SAP NetWeaver users

1. To enable Azure AD users to sign in to SAP NetWeaver, you must provision them in SAP NetWeaver. Work with your in-house SAP expert team or your organization SAP partner to add the users in the SAP NetWeaver platform.
2. To verify the outcome, after the identity provider Azure AD was activated, access ``` <https://sapurl/sap/bc/bsp/sap/it00/default.htm> ``` (replace **`sapurl`** with actual SAP hostname) to check SSO. There should be no prompt for username and password.

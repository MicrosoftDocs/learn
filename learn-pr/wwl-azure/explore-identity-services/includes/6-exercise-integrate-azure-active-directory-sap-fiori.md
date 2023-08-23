


Integrating SAP Fiori with Azure AD gives you the following benefits:

- You can use Azure AD to control who has access to SAP Fiori.
- Users can be automatically signed in to SAP Fiori with their Azure AD accounts (single sign-on).
- You can manage your accounts in one central location, the Azure portal.

To configure Azure AD integration with SAP Fiori, you need the following items:

- An Azure AD subscription.
- An SAP Fiori subscription with single sign-on enabled.
- SAP Fiori 7.20 or later is required.

## Add SAP Fiori from the gallery

To integrate SAP Fiori with Azure AD, you must first add SAP Fiori from the SaaS application gallery to your list of managed SaaS apps.

## Configure Azure AD single sign-on with SAP Fiori

For single sign-on to work, you must establish a linked relationship between an Azure AD user and the related user in SAP Fiori. Complete the following tasks:

1. Configure Azure AD single sign-on to enable your users to use this feature.
2. Configure SAP Fiori single sign-on.
3. Assign Azure AD users to the SAP Fiori application.
4. Create SAP Fiori users linked to their Azure AD user accounts.

### Configure Azure AD single sign-on

1. Open a new web browser window and sign in to your SAP Fiori company site as an administrator. Make sure that http and https services are active and that the relevant ports are assigned to transaction code SMICM.
2. Sign in to SAP Business Client for SAP system T01, where single sign-on is required. Then, activate HTTP Security Session Management. Go to transaction code SICF\_SESSIONS and review the profile parameters. Adjust the parameters based on your organization requirements and restart the SAP system.
3. Activate the following SICF services:

     - **/sap/public/bc/sec/saml2**
     - **/sap/public/bc/sec/cdc\_ext\_service**
     - **/sap/bc/webdynpro/sap/saml2**
     - **/sap/bc/webdynpro/sap/sec\_diag\_tool** (This is only to enable / disable trace)
4. Go to transaction code SAML2 in Business Client for SAP system \[T01/122\]. The configuration UI opens in a new browser window. Enter your username and password, and then select **Log on**.
5. In the **Provider Name** box, replace **T01122** with ``` <http://T01122> ```, and then select **Save**.

    > [!NOTE]
    > By default, the provider name is in the format **\_sid-client\_**. Azure AD expects the name in the format **protocol://name**. We recommend that you maintain the provider name as **https:// \_sid-client\_** so you can configure multiple SAP Fiori ABAP engines in Azure AD.
6. Select **Local Provider** tab / **Metadata**. In the **SAML 2.0 Metadata** dialog box, download the generated metadata XML file and save it on your computer.
7. In the Azure portal, in the **SAP Fiori application integration** pane, select **Single sign-on**.
8. In the **Select a single sign-on method** pane, select **SAML** or **SAML/WS-Fed** mode to enable single sign-on.
9. In the **Set up Single Sign-On with SAML** pane, select **Edit** (the pencil icon) to open the **Basic SAML Configuration** pane.
10. In the **Basic SAML Configuration** section, select **Upload metadata file** and use the **Upload metadata file** option to upload the metadata file you downloaded earlier.
11. When the metadata file is successfully uploaded, the **Identifier** and **Reply URL** values are automatically populated in the **Basic SAML Configuration** pane. In the **Sign on URL** box, enter a URL that has the following pattern: **https://\[your company instance of SAP Fiori\]**.
12. The SAP Fiori application expects the SAML assertions to be in a specific format. The claims including **givenname**, **surname**, **emailaddress**, **name**, and **Unique User Identifier**. To manage their values, in the **Set up Single Sign-On with SAML** pane, select **Edit**.
13. In the **User Attributes &amp; Claims** pane, configure the SAML token attributes. Then, complete the following steps:

     - Select **Edit** to open the **Manage user claims** pane.
     - In the **Transformation** list, select **ExtractMailPrefix()**.
     - In the **Parameter 1** list, select **user.userprinicipalname**.
14. In the **Set up Single Sign-On with SAML** pane, in the **SAML Signing Certificate** section, select **Download** next to **Federation Metadata XML**.
15. Select a download option based on your requirements. Save the certificate on your computer.
16. In the **Set up SAP Fiori** section, copy the following URLs based on your requirements:

     - Login URL
     - Azure AD Identifier
     - Logout URL

### Configure SAP Fiori single sign-on

1. Sign in to the SAP system and go to transaction code SAML2. A new browser window opens with the SAML configuration page.
2. To configure endpoints for a trusted identity provider (Azure AD), select the **Trusted Providers** tab.
3. Select **Add**, and then select **Upload Metadata File** from the context menu.
4. Upload the metadata file that you downloaded in the Azure portal.
5. On the next page, in the **Alias** box, enter an arbitrary alias name.
6. Make sure that the value in the **Digest Algorithm** box is **SHA-256**.
7. Under **Single Sign-On Endpoints**, select **HTTP POST**.
8. Under **Single Logout Endpoints**, select **HTTP Redirect**.
9. Accept the default settings of **Artifact Endpoints** and **Authentication Requirements**.
10. Select **Trusted Provider** / **Identity Federation and Unspecified Supported NameID Formats**.
11. The values for **User ID Source** and **User ID Mapping Mode** determine the link between the SAP user and the Azure AD claim. There are two supported scenarios:

     - Scenario 1: SAP user to Azure AD user mapping
     - Scenario 2: Select the SAP user ID based on the configured email address in SU01. In this case, the email ID should be configured in SU01 for each user who requires SSO.

### Assign Azure AD users

1. In the Azure portal, select **Enterprise Applications**, select **All applications**, then select **SAP Fiori**.
2. In the applications list, select **SAP Fiori**.
3. To verify the outcome, after the identity provider Azure AD is activated in SAP Fiori, try to access one of the following URLs to test single sign-on as an assigned user (you shouldn't be prompted for a username and password):
```
     - **<https://sapurl/sap/bc/bsp/sap/it00/default.htm>**
     - **<https://sapurl/sap/bc/bsp/sap/it00/default.htm>**
```

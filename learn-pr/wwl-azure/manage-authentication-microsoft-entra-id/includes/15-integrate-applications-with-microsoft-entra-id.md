You can integrate your cloud-enabled software as service (SaaS) applications with Microsoft Entra ID. Refer to the Microsoft Entra ID Marketplace for a list of all SaaS apps that have been pre-integrated into Microsoft Entra ID. Use the application network portal to request a System for Cross-Domain Identity Management (SCIM) enabled application to be added to the gallery for automatic provisioning or n SAML / OpenID Connect (OIDC) enabled application to be added to the gallery for SSO. Once you add the application from the gallery, configure and test Microsoft Entra ID SSO for the application.

## Cloud-enabled software as a service (SaaS) providers

 -  Atlassian Cloud
 -  ServiceNow
 -  Slack
 -  SuccessFactors
 -  Workday

## Cloud Integrations

 -  Amazon Web Services (AWS) Console
 -  Alibaba Cloud (Role bases SSO)
 -  Google Cloud Platform
 -  Salesforce
 -  SAP (Systems, Applications, and Products in Data Processing) Cloud Identity Platform

## Example: Integrating Slack with Microsoft Entra ID enables you to:

 -  Control who has access to Slack in Microsoft Entra ID.
 -  Enable your users to be automatically signed in to Slack with their Microsoft Entra accounts.
 -  Manage your accounts in one central location.

## Prerequisites

To get started, you need the following items:

 -  A Microsoft Entra subscription. If you don't have a subscription, you can get a free account.<br>
 -  Slack single sign-on (SSO) enabled subscription.

> [!NOTE]
> If you need to integrate with more than one Slack instance in one tenant, the identifier for each application can be a variable.

> [!NOTE]
> This integration is also available to use from Microsoft Entra US Government Cloud environment. You can find this application in the Microsoft Entra US Government Cloud Application Gallery and configure it in the same way as you do from public cloud.

When you integrate Slack with Microsoft Entra ID, you can:

 -  Control in Microsoft Entra ID who has access to Slack.
 -  Enable your users to be automatically signed-in to Slack with their Microsoft Entra accounts.
 -  Manage your accounts in one central location.

## Adding Slack from the gallery

To configure the integration of Slack into Microsoft Entra ID, you need to add Slack from the gallery to your list of managed SaaS apps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as at least a [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator).

2. Browse to **Identity** &gt; **Applications** &gt; **Enterprise applications** &gt; **New application**.

3. In the **Add from the gallery** section, type **Slack** in the search box.

4. Select Slack from results panel and then add the app. Wait a few seconds while the app is added to your tenant.

Alternatively, you can also use the Enterprise App Configuration Wizard. In this wizard, you can add an application to your tenant, add users/groups to the app, assign roles, as well as walk through the SSO configuration as well. Alternatively, you can also use the [Enterprise App Configuration Wizard](https://portal.office.com/AdminPortal/home?Q=Docs#/azureadappintegration).

## Configure and test Microsoft Entra SSO for Slack

Configure and test Microsoft Entra SSO with Slack using a test user called B.Simon. For SSO to work, you need to establish a link relationship between a Microsoft Entra user and the related user in Slack.

To configure and test Microsoft Entra SSO with Slack, perform the following steps:

1. [Configure Microsoft Entra SSO](/entra/identity/saas-apps/slack-tutorial#configure-azure-ad-sso) \- to enable your users to use this feature.

 -  [Create a Microsoft Entra test user](/entra/identity/saas-apps/slack-tutorial#create-an-azure-ad-test-user) \- to test Microsoft Entra single sign-on with B.Simon.
 -  [Assign the Microsoft Entra test user](/entra/identity/saas-apps/slack-tutorial#assign-the-azure-ad-test-user) \- to enable B.Simon to use Microsoft Entra single sign-on.

2. [Configure Slack SSO](/entra/identity/saas-apps/slack-tutorial#configure-slack-sso) \- to configure the single sign-on settings on application side.

 -  [Create Slack test user](/entra/identity/saas-apps/slack-tutorial#create-slack-test-user) \- to have a counterpart of B.Simon in Slack that is linked to the Microsoft Entra representation of user.

3. [Test SSO](/entra/identity/saas-apps/slack-tutorial#test-sso) \- to verify whether the configuration works.

## Configure Microsoft Entra SSO

Follow these steps to enable Microsoft Entra SSO.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as at least a [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator).

2. Browse to **Identity** &gt; **Applications** &gt; **Enterprise applications** &gt; **Slack** &gt; **Single sign-on**.

3. On the **Select a single sign-on method** page, select **SAML**.

4. On the **Set up single sign-on with SAML** page, click the edit/pen icon for **Basic SAML Configuration** to edit the settings.

:::image type="content" source="../media/set-up-single-sign-on-with-saml-fc9f46b4.png" alt-text="Screenshot showing an example of the setup single sign-on with saml page.":::


5. On the **Basic SAML Configuration** section, enter the values for the following fields:

 -  In the **Identifier (Entity ID)** text box, type the URL: `https://slack.com`<br>
 -  In the **Reply URL** text box, type a URL using one of the following patterns:

**Reply URL**

`https://<DOMAIN NAME>.slack.com/sso/saml`

`https://<DOMAIN NAME>.enterprise.slack.com/sso/saml`

 -  In the Sign-on URL text box, type a URL using one of the following patterns:

**Sign on URL**

`https://<DOMAIN>.slack.com`

`https://<DOMAIN>.enterprise.slack.com`

> [!NOTE]
> These values aren't real. You need to update these values with the actual Sign-on URL and Reply URL. Contact Slack support team to get the value. You can also refer to the patterns shown in the Basic SAML Configuration section.

> [!NOTE]
> The value for Identifier (Entity ID) can be a variable if you have more than one Slack instance that you need to integrate with the tenant. Use the pattern `https://<DOMAIN NAME>.slack.com`. In this scenario, you also must pair with another setting in Slack by using the same value.

6. Slack application expects the SAML assertions in a specific format, which requires you to add custom attribute mappings to your SAML token attributes configuration. The following screenshot shows the list of default attributes.

:::image type="content" source="../media/default-attributes-7bda693c.png" alt-text="Screenshot showing an example of the attributes and claims page for a Slack application.":::


7. In addition to above, Slack application expects few more attributes to be passed back in SAML response which are shown below. These attributes are also pre populated but you can review them as per your requirements.

:::image type="content" source="../media/claims-8fb18a60.png" alt-text="Screenshot showing an example of the required claims page for a Slack application.":::


8. On the **Set up single sign-on with SAML** page, in the **SAML Signing Certificate** section, find **Certificate (Base64)** and select **Download** to download the certificate and save it on your computer.

:::image type="content" source="../media/certificate-base-64-5cca0458.png" alt-text="Screenshot showing an example of the small signing certification page.":::


9. On the **Set up Slack** section, copy the appropriate URL(s) based on your requirement.

:::image type="content" source="../media/copy-configuration-624d5dde.png" alt-text="Screenshot showing an example of the U R L configurations page.":::


## Create a Microsoft Entra test user

In this section, you'll create a test user called B.Simon.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as at least a [User Administrator](/entra/identity/role-based-access-control/permissions-reference#user-administrator).<br>

2. Browse to **Identity**, **Users**, **All users**.<br>

3. Select **New user**, **Create new user**, at the top of the screen.

4. In the User properties, follow these steps:

 -  In the Display name field, enter `B.Simon.`
 -  In the User principal name field, enter the username@companydomain.extension. For example, `B.Simon@contoso.com`.
 -  Select the **Show password** check box, and then write down the value that's displayed in the **Password** box.
 -  Select **Review + create**.

5. Select **Create**.

## Assign the Microsoft Entra test user

In this section, you'll enable B.Simon to use single sign-on by granting access to Slack.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as at least a [Cloud Application Administrator](/entra/identity/role-based-access-control/permissions-reference#cloud-application-administrator).

2. Browse to **Identity, Applications**, **Enterprise applications,** **Slack**.<br>

3. In the app's overview page, find the **Manage** section and select **Users and groups**.<br>

4. Select **Add user**, then select **Users and groups** in the **Add Assignment** dialog.<br>

5. In the **Users and groups** dialog, select **B.Simon** from the Users list, then click the **Select** button at the bottom of the screen.<br>

6. If you are expecting a role to be assigned to the users, you can select it from the **Select a role** dropdown. If no role has been set up for this app, you see "Default Access" role selected.<br>

7. In the **Add Assignment** dialog, click the **Assign** button.<br>

## Configure Slack SSO

1.  In a different web browser window, sign in to your up Slack company site as an administrator
2.  click on your workspace name in the top left, then go to **Settings and administration**, **Workspace settings**.<br>

:::image type="content" source="../media/tutorial-slack-team-settings-b2d349b6.png" alt-text="Screenshot showing an example of how to configure Slack single sign-on.":::


3. In the **Settings and permissions** section, click the **Authentication** tab, and then click **Configure** button at SAML authentication method.

:::image type="content" source="../media/tutorial-slack-authentication-fab942a6.png" alt-text="Screenshot showing an example of the workspace settings and permissions page.":::


4. On the **Configure SAML authentication for Azure** dialog, perform the below steps:

:::image type="content" source="../media/tutorial-slack-save-authentication-example-47397b8b.png" alt-text="Screenshot showing an example of how to configure saml authentication with Azure.":::


 -  In the top right, toggle **Test** mode on.
 -  In the **SAML SSO URL** textbox, paste the value of **Login URL**.<br>
 -  In the **Identity provider issuer** textbox, paste the value of **Microsoft Entra Identifier**.<br>
 -  Open your downloaded certificate file in Notepad, copy the content of it into your clipboard, and then paste it to the **Public Certificate** textbox.<br>

5. Expand the **Advanced options** and perform the below steps:<br>

:::image type="content" source="../media/advanced-settings-fd96169f.png" alt-text="Screenshot showing an example of  the advanced options page for certificates.":::


 -  If you need an end-to-end encryption key, tick the box **Sign Authn Request** to show the certificate.
 -  Enter`https://slack.com` in the **Service provider issuer** textbox.<br>
 -  Choose how the SAML response from your IDP is signed from the two options.

> [!NOTE]
> In order to set up the service provider (SP) configuration, you must click on Expand next to Advanced Options in the SAML configuration page. In the Service Provider Issuer box, enter the workspace URL. The default is slack.com.

6. Under **Settings**, decide if members can edit their profile information (like their email or display name) after SSO is enabled. You can also choose whether SSO is required, partially required or optional.

:::image type="content" source="../media/save-configuration-button-c7dde290.png" alt-text="Screenshot showing an example of a members profile information settings page.":::


7. Click **Save Configuration**.

> [!NOTE]
> If you have more than one Slack instance that you need to integrate with Microsoft Entra ID, set `https://<DOMAIN NAME>.slack.com` to **Service provider issuer** so that it can pair with the Azure application **Identifier** setting.

## Create Slack test user

The objective of this section is to create a user called B.Simon in Slack. Slack supports just-in-time provisioning, which is by default enabled. There is no action item for you in this section. A new user is created during an attempt to access Slack if it doesn't exist yet.

## Test SSO

In this section, you test your Microsoft Entra single sign-on configuration with following options.

 -  Click on **Test this application**, this will redirect to Slack Sign-on URL where you can initiate the login flow.<br>
 -  Go to Slack Sign-on URL directly and initiate the login flow from there.<br>
 -  You can use Microsoft My Apps. When you click the Slack tile in the My Apps, this will redirect to Slack Sign-on URL.<br>

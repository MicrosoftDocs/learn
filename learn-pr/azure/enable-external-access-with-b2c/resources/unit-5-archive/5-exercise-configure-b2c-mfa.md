You've been asked to integrate your healthcare application with Azure AD B2C. Azure AD B2C must handle all the patients' registration and sign-in processes for the application. Any user who attempts to access the healthcare application must also be challenged with multi-factor authentication.

You'll now create a B2C tenant, register an application, and put together a sign-up and sign-in user flow. You'll enable multi-factor authentication to take advantage of its protection. Also, you'll try out patient user experience by doing test runs for the user flow.

## Create your Azure AD B2C tenant

First, you create an Azure AD B2C tenant.

1. [Sign in](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true) to the Azure portal as a global administrator. If you're the person who signed up for the Azure account, you'll be the global administrator.

1. Create a new resource by selecting **Create a resource** on the left of the Azure portal.

    ![Create resource.](../media/5-portal-home.png)

1. Search for **Active Directory B2C**, then select the search result.

    ![Create a B2C resource.](../media/5-create-b2c-resource.png)

1. Select **Create**.

    ![text.](../media/5-choose-azure-active-b2c.png)

1. Select  **Create a new Azure AD B2C Tenant**. Fill in the form, then select **Create**.

    ![Create tenant form .](../media/5-create-tenant-form.png)

1. Select the **Create new B2C Tenant or Link to existing Tenant** link at the top of your form. 

    ![Select tenant link.](../media/5-select-tenant-link.png)

1. Select **Link an existing Azure AD B2C Tenant to my Azure subscription**.

    ![Link an existing tenant to your subscription.](../media/5-link-existing-tenant.png)

1. For the **Azure AD B2C Tenant** field, select the tenant you created. 

1. Select **<rgn>[sandbox resource group name]</rgn>** for the **Resource group**.

    ![Link existing tenant form.](../media/5-link-existing-tenant-form.png)

1. Select **Create**. In the confirmation dialog, select the new directory.

## Register your application

Register your application, using the following steps:

1. Switch to your newly created B2C tenant. Select **Directory + Subscription** at the top of the Azure portal, then select your tenant in the list.

    ![Azure AD B2C tenant.](../media/5-changeto-b2c-tenant.png)

1. Select the **Show portal menu** button at the top-left corner of the Azure portal to show the portal menu. Select **All services**, search for **Azure AD B2C**, then select the top search result.

    ![Search for AD B2C in all services.](../media/5-all-services.png)

1. Select **Applications > Add**.

    ![Add application.](../media/5-add-application.png)

1. In the form, provide a **Name** for your application. Select **Yes** for **Include web app/web API**, and select **Yes** for **Allow implicit flow**.

    ![The form that adds your application.](../media/5-add-application-form.png)
1. For the **Reply URL**, use `https://jwt.ms`. It points to a test web app. The app shows the data that's collected and returned to the user.

1. Select **Create**.

## Create user flow

You'll create a user flow that lets users sign up, and sign in to your application.

1. Go back to your Azure AD B2C. Select **All services**, look for Azure AD B2C, and select the top search result.

1. Select  **User flows(policies) > New user flow**.

    ![Add a user flow.](../media/5-add-user-flow.png)

1. Select the **Sign up and sign in** user flow.

    ![Select a user flow.](../media/5-select-user-signin-flow.png)

1. In the form that appears, give your user flow a name. Select **Email signup** in the **Identity providers** section. At this point, you could enable multi-factor authentication. However, we'll do it later to show how you enable multi-factor authentication on existing user flows.

    ![Configure your user flow.](../media/5-create-user-flow.png)

1. In the **User attributes and claims** section, select the attributes you need to collect from the user at sign-up, and what you want to return to them at sign-in. For this exercise, you'll select **Given Name**, **Surname**, and **Country/Region**.

1. Select **Create**.

## Enable multi-factor authentication

You can enable multi-factor authentication when you create a user flow. But you can also enable and disable multi-factor authentication on a user flow you've already created.

1. Select **User flows (policies)**, then select your user flow.

    ![Select your user flow.](../media/5-edit-user-flow.png)

1. Select **Properties**, then select **Enabled** under **Multifactor authentication**.

    ![Enable MFA.](../media/5-enable-mfa.png)

1. Select **Save**.

## Test the user experience

Now test the user flow to try the experience from the user's perspective.

### Test the sign-up process

1. Select **overview > Run user flow**.

    ![Test user flow.](../media/5-run-user-flow.png)

1. Select **Run user flow** in the form that appears.

    ![The form you use to run your user flow.](../media/5-run-user-flow-form.png)

1. Select **Sign up now** in the form that appears in the new tab or window.

    ![Select sign-up.](../media/5-select-signup.png)

1. Fill in the sign-up form that appears.

    ![Sign up form.](../media/5-signup-form.png)

1. Select **Send verification code**.

1. Go to the inbox of the email address you've provided. Open the verification code email, and copy the code.

    ![Verification code received.](../media/5-verification-code-received.png)

1. Copy the code into the **Verification code** box in your sign-up form. Select **Verify code**, then select **Create** at the bottom of the form.

1. Provide a phone number for multi-factor authentication in the **Phone Number** field. Select **Send Code** or **Call me** to receive the code.

1. When your authentication code is verified, your account will be created. You're forwarded to the test app at `https://jwt.ms`. The test app shows all the claims you chose to return to the application when you configured the user flow.

    ![Claims returned.](../media/5-claims-returned.png)

### Test the sign-in process

1. Run the user flow again by following step 1 and step 2 from the previous section. The sign-in form will appear.

1. Fill in the sign-in form, then select **Sign in**.

    ![Sign-in form.](../media/5-signin-form.png)

1. Complete the multi-factor authentication challenge that follows.

    ![MFA for sign-in.](../media/5-mfa-for-signin.png)

1. When you've been authorized, you'll be forwarded to the test app again.

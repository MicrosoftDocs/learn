To specify that this app is a public client and can use native authentication, enable public client and native authentication flows:

1. From the app registrations page, select the app registration for which you want to enable public client and native authentication flows.
1. Under **Manage**, select **Authentication**.
1. Under **Advanced settings**, allow public client flows:

    - For **Enable the following mobile and desktop flows** select **Yes**.
    - For **Enable native authentication**, select **Yes**.

1. Select **Save** button.

Follow these steps to create a user flow.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com/) as at least an [Application Developer](/entra/identity/role-based-access-control/permissions-reference).
1. If you have access to multiple tenants, make sure you use the directory that contains your external tenant:

    - Select the **Directories + subscriptions** icon in the toolbar.
    - On the **Portal settings | Directories + subscriptions** page, find your external tenant directory in the **Directory name** list, and then select **Switch**.

1. On the sidebar menu, select **Identity**.
1. Select **External Identities** > **User flows**.
1. Select **+ New user flow**.
1. On the **Create** page:

    - Enter a **Name** for the user flow, such as _SignInSignUpSample_.
    - In the **Identity providers** list, select **Email Accounts**. This identity provider allows users to sign-in or sign-up using their email address.
    - Under **Email accounts**, you can select one of the two options. For this tutorial, select **Email one-time passcode**.

      - **Email with password**: Allows new users to sign up and sign in using an email address as the sign-in name and a password as their first factor credential.
      - **Email one-time passcode**: Allows new users to sign up and sign in using an email address as the sign-in name and email one-time passcode as their first factor credential. For this option to be available at the user flow level, make sure you enable email one-time passcode (OTP) at the tenant level (select **All Identity Providers**, and then for **Email One-time passcode** select **Configured**, select the **Yes** option, and then select **Save**).

    - Under **User attributes**, you can choose the attributes you want to collect from the user upon sign-up. For this guide, select **Country/Region** and **City**.

1. Select **Create**. The new user flow appears in the **User flows** list. If necessary, refresh the page.

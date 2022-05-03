Identify an application that supports SAML-based single sign-on and add it to the Azure Active Directory (Azure AD) tenant.

A team asked for a new application to be added to help with company promotion. The application needs to be made available to team members as appropriate. To make the requested application available, it's found in the gallery and if it supports single sign-on, it's added to the Azure AD tenant. The Azure AD tenant is also referred to as the identity provider.

Employees in the retail company likely already have an account in the tenant for the organization. But, for testing single sign-on for the application, a test user account should be created. After successful testing of the application with single sign-on configured, it can be made available to the employees.

## Find and add an application

Azure AD has a gallery that contains thousands of pre-integrated applications. Many of the applications that the retail company uses are probably already in the gallery. When the administrator adds an application to the company's tenant, the following tasks are completed:

- Properties are configured for managing the application
- Users are assigned access
- Single sign-on is set up so that the employees can sign in with their Azure AD credentials

In this module, the **Azure AD SAML Toolkit** application represents the application that was requested by the team in the organization to help with company promotion.

### Access the application gallery

Sign in the Azure portal and then access the application gallery through the **Enterprise applications** pane.

1. Sign in to the [Azure portal](https://portal.azure.com/) using one of the roles listed in the prerequisites.
1. Select **Identity**, and then select **Azure Active Directory**.

    :::image type="content" source="../media/select-azure-ad.png" alt-text="Screenshot showing where to find Azure Active Directory in the Azure portal." border="false":::

1. On the **Azure Active Directory** pane, under **Manage**, select **Enterprise applications**.
1. On the **Enterprise applications** pane, select **All applications** and then select **+ New application**.

    :::image type="content" source="../media/new-application.png" alt-text="Screenshot showing browsing to the enterprise applications pane." border="true":::

## Find and add the requested application

When the administrator searches for an application to add from the gallery, the following filters can be used:

- **Single sign-on options** – Search for applications that support these SSO options: SAML, OpenID Connect (OIDC), Password, or Linked.
- **User account management** – The only option available is automated provisioning.
- **Categories** – When an application is added to the gallery it can be classified in a specific category. Many categories are available such as Business management, Collaboration, or Education.

In this case, the filters set to **All** are sufficient because the specific application name is being used.

Federated single sign-on support can be identified by looking for the **Federated SSO** icon. The specific single sign-on methods that the application supports are listed on its overview page.

1. In the **Search application** box, enter **Azure AD SAML Toolkit**, and then select the application in the list.

    :::image type="content" source="../media/add-application.png" alt-text="Screenshot showing the addition of a new enterprise application." border="true":::

1. In the application overview pane that appears, enter a name for the application. For this exercise, accept the default name.
1. Select **Create**

    :::image type="content" source="../media/create-application.png" alt-text="Screenshot showing the overview and creation of a new enterprise application." border="true":::

## Create and assign a test user account

To test single sign-on between the identity provider and the service provider, user accounts need to be created at both locations. In this unit, an account is created at the identity provider and assigned to the application.

### Create a test user account

1. On the **Azure Active Directory** pane, under **Manage**, select **Users**.
1. Select **New user** at the top of the pane.
1. In the **User name** field, enter the username of the user account. For example, `contosouser1@contoso.com`. Be sure to change `contoso.com` to the name of your tenant domain.
1. In the **Name** field, enter the name of the user of the account. For example, `contosouser1`.
1. Leave **Auto-generate password** selected, and then select **Show password**. Write down the value that's displayed in the **Password** box.
1. Select **Create**.

### Assign the test user account to the application

To test single sign-on for the application, assign a user account to it.

1. On the application overview pane, under **Getting Started**, select **Assign users and groups**. Alternatively, in the left menu, under **Manage**, select **Users and groups**.
1. On the **Users and groups** pane, on the menu, select **+Add user/group**.

    :::image type="content" source="../media/add-user-account.png" alt-text="Screenshot showing the assignment of a user account to an enterprise application." border="true":::

1. On the **Add Assignment** pane, under **Users and groups**, select **None Selected**.
1. In the **Users and groups** pane, select the test user account and then click **Select**.
1. Select **Assign**.

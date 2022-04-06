Identify an application that supports SAML-based single sign-on and add it from the application gallery to the Azure AD tenant.

A team asked for a new application to be added to help with company promotion. The application needs to be made available to team members as appropriate. To make the application available to the employees, the Azure AD application gallery is located, then after searching for the requested application and identifying whether it supports single sign-on, it is added to the Azure AD tenant.

Employees in the retail company likely already have an account in the Azure AD tenant for the organization and will eventually be assigned to the application. But, for the purpose of testing single sign-on for the application, the administrator account that you are using is assigned to the application for testing purposes.

## Locate the Azure AD application gallery

Azure AD has a gallery that contains thousands of pre-integrated applications. Many of the applications that the retail company uses are probably already in the gallery. If an application is added to the company's Azure AD tenant, properties can be configured for it, user access can be managed, and single sign-on can be set up so that the employees can sign in to it with their Azure AD credentials.

### Sign in to Azure and access the Azure AD tenant

To access the Azure AD tenant and add an enterprise application, sign in to the Azure portal with an appropriate role.

1. Sign in to the [Azure portal](https://portal.azure.com/) using one of the roles listed in the prerequisites.
1. Select **Identity**, and then select **Azure Active Directory**.

    :::image type="content" source="../media/select-azure-ad.png" alt-text="Screenshot showing where to find Azure Active Directory in the Azure portal." border="false":::

### Access the application gallery

The Azure AD application gallery is accessed through the **Enterprise applications** blade in the Azure portal.

1. On the **Azure Active Directory** blade, under **Manage**, select **Enterprise applications**.
1. In the **Enterprise applications** pane, select **All applications** and then select **+ New application**.

    :::image type="content" source="../media/new-application.png" alt-text="Screenshot showing browsing to the enterprise applications pane." border="true":::

## Search for and add the requested application

When searching for an application, the following filters can be used:

- **Single sign-on options** – Search for applications that support these SSO options: SAML, OpenID Connect (OIDC), Password, or Linked.
- **User account management** – The only option available is automated provisioning.
- **Categories** – When an application is added to the gallery it can be classified in a specific category. Many categories are available such as Business management, Collaboration, or Education.

In this case, the filters set to **All** are sufficient because the specific application name is being used.

Federated single sign-on support can be identified by looking for the **Federated SSO** icon. The specific single sign-on methods that the application supports are listed on its overview page.

1. In the **Search application** box, enter **Azure AD SAML Toolkit**, and then select the application in the list.

    :::image type="content" source="../media/add-application.png" alt-text="Screenshot showing the addition of a new enterprise application." border="true":::

1. In the application overview pane that appears, enter a name for the application.
1. Select **Create**

    :::image type="content" source="../media/create-application.png" alt-text="Screenshot showing the overview and creation of a new enterprise application." border="true":::

## Assign a user account to the application

To test single sign-on for the application, assign a user account account to it.

1. On the **Azure AD SAML Toolkit** blade, on the **Overview** pane, under **Getting Started**, select **Assign users and groups**. Alternatively, in the left menu, under **Manage**, select **Users and groups**.
1. On the **Users and groups** pane, on the menu, select **+Add user/group**.

    :::image type="content" source="../media/add-user-account.png" alt-text="Screenshot showing the assignment of a user account to an enterprise application." border="true":::

1. On the **Add Assignment** blade, under **Users and groups**, select **None Selected**.
1. In the **Users and groups** pane, select the administrator account and then click **Select**.
1. Select **Assign**.

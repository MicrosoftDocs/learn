Custom roles can be created in the **Roles and administrators** page of the Microsoft Entra admin center.

## Prerequisites

 -  Microsoft Entra ID P1 or P2 license
 -  Privileged Role Administrator or Global Administrator
 -  Microsoft Graph module when using PowerShell
 -  Admin consent when using Graph explorer for Microsoft Graph API

## Create a role in the Microsoft Entra admin center

**Create a new custom role to grant access to manage app registrations**

1. Sign in to the **Microsoft Entra admin center** as at least a **Privileged Role Administrator**.

2. Browse to **Identity**, **Roles & admins**, **Roles & admins**.

3. Select **New custom role**.

:::image type="content" source="../media/new-custom-role-7ad15f26.png" alt-text="Screenshot showing how to create a new custom role in the Microsoft Entra admin center.":::


4. On the **Basics** tab, provide a name and description for the role and then click **Next**.

:::image type="content" source="../media/azure-portal-new-custom-role-e7025bd2.png" alt-text="Screenshot showing the new custom role page in the Microsoft Entra admin center.":::


5. On the Permissions tab, select the permissions necessary to manage basic properties and credential properties of app registrations.<br>

 -  First, enter "credentials" in the search bar and select the `microsoft.directory/applications/credentials/update permission`.

:::image type="content" source="../media/permissions-tab-97a943dc.png" alt-text="Screenshot showing the permissions tab in the Microsoft Entra admin center.":::


 -  Next, enter "**basic**" in the search bar, select the `microsoft.directory/applications/basic/update permission`, and then click **Next**.

6. On the **Review** \+ **create** tab, review the permissions and select Create.<br>

Your custom role will show up in the list of available roles to assign.<br>

## Assign a custom role scoped to a resource

Like built-in roles, custom roles are assigned by default at the default organization-wide scope to grant access permissions over all app registrations in your organization. Additionally, custom roles and some relevant built-in roles (depending on the type of Microsoft Entra resource) can also be assigned at the scope of a single Microsoft Entra resource. This allows you to give the user the permission to update credentials and basic properties of a single app without having to create a second custom role.

1. Sign in to the **Microsoft Entra admin center** as at least a **Application Developer**.

2. Browse to **Identity**, **Applications**, **App registrations**.

3. Select the app registration to which you are granting access to manage. You might have to select **All applications** to see the complete list of app registrations in your Microsoft Entra organization.

:::image type="content" source="../media/application-registration-example-47457693.png" alt-text="Screenshot showing the applications registration page in the Microsoft Entra admin center.":::


4. In the app registration, select **Roles and administrators**. If you haven't already created one, instructions are in the preceding procedure.<br>

5. Select the role to open the **Assignments** page.<br>

6. Select **Add assignment** to add a user. The user will be granted any permissions over only the selected app registration.

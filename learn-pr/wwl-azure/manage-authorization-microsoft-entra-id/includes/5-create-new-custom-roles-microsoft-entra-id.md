You can create custom roles from the Roles and administrators tab on the Azure AD overview page. The role can be assigned either at the directory-level scope or an app registration resource scope only.

Custom roles can be created in the Roles and administrators page of the Microsoft Entra admin center.

## Create a role in the Microsoft Entra admin center

**Create a new custom role to grant access to manage app registrations**

1. Sign in to the **Microsoft Entra admin center** as at least a **Privileged Role Administrator**.

2. Browse to **Identity**, **Roles & admins**, **Roles & admins**.

3. Select **New custom role**.

4. On the **Basics** tab, provide a name and description for the role and then click **Next**.

5. On the Permissions tab, select the permissions necessary to manage basic properties and credential properties of app registrations.<br>

6. First, enter "credentials" in the search bar and select the `microsoft.directory/applications/credentials/update permission`.

7. Next, enter "**basic**" in the search bar, select the `microsoft.directory/applications/basic/update permission`, and then click **Next**.<br>

8. On the **Review** \+ **create** tab, review the permissions and select Create.<br>

9. Your custom role will show up in the list of available roles to assign.<br>

## Assign a custom role scoped to a resource

Like built-in roles, custom roles are assigned by default at the default organization-wide scope to grant access permissions over all app registrations in your organization. Additionally, custom roles and some relevant built-in roles (depending on the type of Microsoft Entra resource) can also be assigned at the scope of a single Microsoft Entra resource. This allows you to give the user the permission to update credentials and basic properties of a single app without having to create a second custom role.

1. Sign in to the **Microsoft Entra admin center** as at least a **Application Developer**.

2. Browse to **Identity**, **Applications**, **App registrations**.

3. Select the app registration to which you are granting access to manage. You might have to select **All applications** to see the complete list of app registrations in your Microsoft Entra organization.

4. In the app registration, select **Roles and administrators**. If you haven't already created one, instructions are in the preceding procedure.<br>

5. Select the role to open the **Assignments** page.<br>

6. Select **Add assignment** to add a user. The user will be granted any permissions over only the selected app registration.

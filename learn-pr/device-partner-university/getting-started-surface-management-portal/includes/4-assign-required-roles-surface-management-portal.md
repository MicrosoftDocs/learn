To use Surface Management Portal features, assign the required Surface-related roles. If a user needs to view warranty status in Surface Management Portal, assign the **Microsoft Hardware Warranty Administrator** role. This role is for users who need to:

- View warranty status.
- Manage service requests.
- Handle device replacement workflows.

>[!NOTE]
> On Surface Management Portal, the Global reader role must also be assigned.

Assign the required Surface-related admin roles using your organization's Microsoft admin role management tools. For example, you can open the Intune Admin Center and go to **Roles > Role assignments** to assign **Microsoft Hardware Warranty Administrator**.

:::image type="content" border="true" source="../media/microsoft-hardware-warranty-admin.svg" alt-text="Illustration of Microsoft Hardware Warranty Administrator role assignments.":::

In our scenario, you're an IT administrator for an organization with multiple managed Surface devices in the field.

A user can access Intune but can't view Surface warranty information.

**Correct action:** Assign this user the **Microsoft Hardware Warranty Administrator role**.

>[!IMPORTANT]
> Remember, to access Surface Management Portal a user needs to have an **Intune subscription** and a **Surface device enrolled in Intune**.

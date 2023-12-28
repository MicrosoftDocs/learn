The ability to manage resources is granted by assigning roles that provide the required permissions. Roles can be assigned to individual users or groups. To align with the Zero Trust guiding principles, use Just-In-Time and Just-Enough-Access policies when assigning roles.

## Assign roles

There are two main steps to the role assignment process. First you'll select the role to assign. Then you'll adjust the role settings and duration.

1. Sign in to the **Microsoft Entra admin center** as a **Privileged Role Administrator**.

2. Browse to **Identity**, **Users**, **All users**.

3. Search for and select the **user** getting the role assignment.

4. Select **Assigned roles** from the side menu, then select **Add assignments**.

5. Select a role to assign from the dropdown list and select the **Next** button.<br>

## Adjust the role settings

You can assign roles as either **eligible** or **active**. Eligible roles are assigned to a user but must be elevated Just-In-Time by the user through Privileged Identity Management (PIM).

1. From the Setting section of the **Add assignments** page, select an **Assignment type** option.

2. Leave the **Permanently eligible** option selected if the role should always be available to elevate for the user. If you uncheck this option, you can specify a date range for the role eligibility.

3. Select the **Assign** button.

Assigned roles appear in the associated section for the user, so eligible and active roles are listed separately.

## Update roles

You can change the settings of a role assignment, for example to change an active role to eligible.<br>

1. Browse to **Identity**, **Users**, **All users**.<br>

2. Search for and select the user getting their role updated.<br>

3. Go to the **Assigned roles** page and select the **Update** link for the role that needs to be changed.<br>

4. Change the settings as needed and select the **Save** button.

## Remove roles

You can remove role assignments from the **Administrative roles** page for a selected user.

1.  Browse to **Identity**, **Users**, **All users**.<br>
2.  Search for and select the user getting the role assignment removed.<br>
3.  Go to the **Assigned roles** page and select the **Remove** link for the role that needs to be removed. Confirm the change in the pop-up message.

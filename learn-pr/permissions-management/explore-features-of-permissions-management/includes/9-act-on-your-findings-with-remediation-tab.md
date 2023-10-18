Not only does Microsoft Entra Permissions Management provide you with insights into what is happening in your cloud environments, it also gives you the tools to act on them. Permissions Management offers a host of remediation features that allow you to easily right-size and manage permissions in your multicloud environments.

> [!NOTE]
> You must [enable the Controller](https://go.microsoft.com/fwlink/?linkid=2248073) in your environment to take advantage of the remediation capabilities in Permissions Management.

### Creating custom roles based on past activity

The first remediation tool that Permissions Management offers takes the guesswork out of right-sizing roles by allowing you to create custom roles based on the historical usage activity of users, groups, and applications in your environment.

:::image type="content" source="../media/custom-roles.png" alt-text="Screenshot of the Permissions Management Creating Custom Roles view."lightbox="../media/custom-roles.png":::

Permissions Management allows you to create right-sized roles that contain only permissions that users, groups, or apps should use within a specified time frame.

:::image type="content" source="../media/custom-roles-tasks.png" alt-text="Screenshot of the Permissions Management Creating Custom Roles task tab."lightbox="../media/custom-roles-tasks.png":::

Creating custom roles is useful to help right-size permissions, and in onboarding situations to create roles for new employees based on the activity of users on the same team, or users performing a similar job function.

If you want more control with creating custom controls, Permissions Management offers the ability to create from existing roles in your environment and customize them by manually selecting the permissions you want to include.

:::image type="content" source="../media/roles-policies.png" alt-text="Screenshot of the Permissions Management Roles and Policies tab."lightbox="../media/roles-policies.png":::

Existing custom roles in your environment can also be cloned, modified, or deleted directly in the Permissions Management product.

### Right-sizing access with the click of a button

The second remediation tool that Permissions Management provides is perhaps its most powerful, quick actions that allow you to right-size user access with the click of a button.

:::image type="content" source="../media/quick-actions-users.png" alt-text="Screenshot of the Permissions Management Quick Actions to manage users."lightbox="../media/quick-actions-users.png":::

There are four quick actions that can be used to manage users:

- Revoke Unused Tasks
- Revoke High-Risk Tasks
- Revoke Delete Tasks
- Assign Read-Only Status

To understand how these actions work, we’ll focus on the **Revoke Unused Tasks** action. If we want to perform this quick action, we first start by selecting the user we want to perform the action on. Then, we select **Revoke Unused Tasks**. These actions happen in the background:

- Permissions Management looks at the selected user’s historical usage and creates a custom role containing only the permissions that the user has used within the past 90 days.
- This custom role is assigned to the user and all other assignments are removed; leaving the user with a perfectly right-sized role assignment based on their 90-day history.

This process of creating a custom role assignment and then revoking all other assignments applies to all four of the quick action options.

If you would like to make smaller adjustments for any of your users, you can add and remove individual roles and tasks on a per-user basis using the **Add Role**, **Remove Role**, **Add Tasks**, **Remove Tasks** buttons located right above the quick actions.

### Automated remediation options with autopilot

The third remediation tool that Permissions Management provides is Autopilot: A set of prebuilt rules aimed at helping to enable automated remediation in your environment.

:::image type="content" source="../media/remediation-automation-autopilot.png" alt-text="Screenshot of the Permissions Management automating remediation tasks."lightbox="../media/remediation-automation-autopilot.png":::

Enabling an autopilot rule provides you with the ability to do these actions with a few clicks:  

- **Generate Recommendations:** Gives a list of recommended remediation actions that should be taken based on the criteria of the rule
- **Apply Recommendations:** Gives the ability to auto apply the recommended remediation actions  
- **Unapply Recommendations:** Gives the ability to go back and undo any of the recommended remediation actions that were applied

### Allowing users to request temporary time-bound permissions

Permissions On-Demand is a system that handles the requesting and granting of permissions on a temporary, time-bound basis. To better understand the Permissions On-Demand experience, let’s break it down into the user experience and the admin/approver experience.

**Request permissions as a user**

When requesting extra permissions, users specify the cloud environment, authorization system, and scope that they want to request permissions for. Users then specify the extra roles or tasks they want to be granted, and request the use of a template.

:::image type="content" source="../media/request-roles-user.png" alt-text="Screenshot of the Permissions Management request roles as a user."lightbox="../media/request-roles-user.png":::

- **Requesting Roles:** Requesting roles allows users to select more roles that they want granted. 
- **Requesting Tasks:** Requesting tasks allows users to select individual permissions they want granted. A useful option for users who know exactly what permissions they need to perform their desired tasks.
- **Requesting Using a Template:** Requesting using a template allows users to select a permission template they want granted. Templates can be thought of as prebuilt bundles of permissions that admins create.

After specifying which permissions to grant, users then specify when they want certain permissions to go into effect. Permissions can be granted immediately or granted based on a schedule.

:::image type="content" source="../media/schedule-permissions-immediate.png" alt-text="Screenshot of the Permissions Management schedule permissions for a user immediately."lightbox="../media/schedule-permissions-immediate.png":::

:::image type="content" source="../media/schedule-permissions-options.png" alt-text="Screenshot of the Permissions Management schedule permissions for varying timeframes."lightbox="../media/schedule-permissions-options.png":::

When requesting that permissions be granted on a schedule, users select the exact days and times for the permissions to be granted. For example, in the screen above we’re requesting that our desired permissions be granted at 8:00 a.m. for 8 hours every Monday through Friday.

**Granting permissions as an admin**

The **Requests** tab in Permissions Management is where you find all permissions requests made by users. Each request provides in depth details of the request (what permissions are being requested and when they’ll be granted). Admins can either Approve or Reject the request directly in the product.

:::image type="content" source="../media/request-tab-details.png" alt-text="Screenshot of the Permissions Management request tab details."lightbox="../media/request-tab-details.png":::

Permissions On-Demand hosts many admin tools to make the process more configurable, including autoapproval setup (available for AWS environments) of certain low-risk permissions, specifying exactly which roles your users can request, and configuring request duration limits.

:::image type="content" source="../media/az500-privileged-identity-management-settings-80da94b5.png" alt-text="Screenshot of the activation, assignment, and notification settings.":::


## Activation settings

 -  **Activation duration**. Set the maximum time, in hours, that a role stays active before it expires. This value can be from one to 24 hours.
 -  **Require multifactor authentication on activation**. You can require users who are eligible for a role to prove who they are using Azure Active Directory Multi-Factor Authentication (MFA) before they can activate. Multifactor authentication ensures that the user is who they say they are with reasonable certainty. Enforcing this option protects critical resources in situations when the user account might have been compromised.
 -  **Require justification**. You can require that users enter a business justification when they activate.
 -  **Require approval to activate**. If setting multiple approvers, approval completes as soon as one of them approves or denies. You can't require approval from at least two users.

## Assignment settings

 -  **Allow permanent eligible assignment**. Global admins and Privileged role admins can assign permanent eligible assignment. They can also require that all eligible assignments have a specified start and end date.
 -  **Allow permanent active assignment**. Global admins and Privileged role admins can assign active eligible assignment. They can also require that all active assignments have a specified start and end date.

> [!NOTE]
> In some cases, you might want to assign a user to a role for a short duration (one day, for example). In this case, the assigned users don't need to request activation. In this scenario, Privileged Identity Management can't enforce multifactor authentication when the user uses their role assignment because they are already active in the role from the time that it is assigned.

## Notification settings

 -  Notifications can be sent when members are assigned as eligible in a role, assigned as active in a role, and when the role is activated.
 -  Notifications can be sent to Admins, Requestors, and Approvers.

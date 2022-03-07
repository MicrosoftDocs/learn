With the Azure AD Privileged Identity Management (PIM) service, you can manage, control, and monitor access to important resources in your organization. This includes access to resources in Azure AD; Azure; and other Microsoft Online Services, like Microsoft 365 and Microsoft Intune. This control does not eliminate the need for users to carry out privileged operations in Azure AD, Azure, Microsoft 365, and Software as a Service (SaaS) apps.

Organizations can give users just-in-time (JIT) privileged access to Azure resources and Azure AD. Oversight is needed for what those users do with their administrator privileges. PIM helps mitigate the risk of excessive, unnecessary, or misused access rights.

## Key PIM features

 -  Providing **just-in-time** privileged access to Azure AD and Azure resources. IT administrators can pick an activation period between 0.5 and a role's maximum duration (max is 24 hours). They will only receive the privilege for that period of time. After the activation period admins will have to go through the activation process again.
 -  Assigning **time-bound** access to resources by using start and end dates. PIM allows you to set an end time for the role. This is particularly useful in a guest scenario. If your organization has guests that are working for a specific time the role privilege will expire automatically.
 -  Requiring **approval** to activate privileged roles. You can designate one or more approvers. These approvers will receive an email once a request is made. Approval is required to active the privilege.
 -  Enforcing **Azure Multi-Factor Authentication** (MFA) to activate any role. If your organization already has MFA enabled, PIM will not ask the user to sign in again.
 -  Using **justification** to understand why users activate. This benefits both internal and external auditors understanding why the role was activated. You can also require a service ticket number from whatever service product you are using.
 -  Getting **notifications** when a user is assigned a privilege and when that privilege is activated.
 -  Conducting **access reviews** to know which users have privileged roles in the organization and if they still need them.
 -  Downloading an **audit history** for an internal or external audit. This keeps tracks of all PIM events.

**Ways to use PIM**

We use Azure AD PIM in the following ways:

 -  View which users are assigned privileged roles to manage Azure resources, as well as which users are assigned administrative roles in Azure AD.
 -  Enable on-demand, “just in time” administrative access to Microsoft Online Services like Microsoft 365 and Intune, and to Azure resources of subscriptions, resource groups, and individual resources such as Virtual Machines.
 -  Review a history of administrator activation, including what changes administrators made to Azure resources.
 -  Get alerts about changes in administrator assignments.
 -  Require approval to activate Azure AD privileged admin roles.
 -  Review membership of administrative roles and require users to provide a justification for continued membership.

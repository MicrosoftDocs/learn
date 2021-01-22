Privileged access management allows granular access control over privileged admin tasks in Microsoft 365. It can help protect organizations from breaches that use existing privileged admin accounts with standing access to sensitive data, or access to critical configuration settings.

Enabling privileged access management in Microsoft 365 allows organizations to operate with **zero standing access**. This means that any user who needs privileged access must request permissions for access, and will receive only the level of access they need just when they need it, and with just-enough access to do the job at hand. Zero standing access provides a layer of protection against standing administrative access vulnerabilities.

Privileged access management requires users to request just-in-time access to complete elevated and privileged tasks through a highly scoped and time-bound approval workflow, described below:

1. **Configure a privileged access policy** - Configuring an approval policy allows the admin to define the specific approval requirements scoped at individual tasks.
1. **Access request** - Users can request access to elevated or privileged tasks. The privileged access feature sends the request to Microsoft 365 for processing against the configured privilege access policy and records the activity in the Security and Compliance Center logs.
1. **Access approval** - An approval request is generated, and the pending request notification is emailed to approvers. If approved, the privileged access request is processed as an approval and the task is ready to be completed. If denied, the task is blocked and no access is granted to the requestor. The requestor is notified of the request approval or denial via email message.
1. **Access processing** - For an approved request, the task is processed. The approval is checked against the privileged access policy and processed by Microsoft. All activity for the task is logged in the Security and Compliance Center.

Watch this six-minute video to get a tour of privileged access management:

> [!VIDEO https://www.microsoft.com/en-us/videoplayer/embed/RE4xqtC]

Privileged access management (PAM) sounds a lot like Privileged Identity Management (PIM), so what is the difference?

Privileged access management is defined and scoped at the task level, while Azure AD Privileged Identity Management applies protection at the role level with the ability to execute multiple tasks. Azure AD Privileged Identity Management primarily allows managing accesses for AD roles and role groups, while privileged access management in Microsoft 365 applies only at the task level.

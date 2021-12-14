By configuring Azure AD PIM to manage our elevated access roles in Azure AD, we now have JIT access for more than 28 configurable privileged roles. We can also monitor access, audit account elevations, and receive additional alerts through a management dashboard in the Azure portal.

Elevated access includes job roles that need greater access, including support, resource administrators, resource owners, service administrators, and global administrators. We manage role-based access at the resource level. Because elevated access accounts could be misused if they’re compromised, we rationalize new requests for elevated access and perform regular re-attestation for elevated roles.

The following diagram of the elevated access workflow.

:::image type="content" source="../media/az500-privileged-identity-management-workflow-934a8c36.png" alt-text="Elevated access PIM workflow.":::


## JIT administrator access

Historically, we could assign an employee to an administrative role through the Azure portal or through Windows PowerShell and that employee would be a permanent administrator; their elevated access would remain active in the assigned role.

Azure AD PIM introduced the concept of permanent and eligible administrators in Azure AD and Azure. Permanent administrators have persistent elevated role connections; whereas eligible administrators have privileged access only when they need it. The eligible administrator role is inactive until the employee needs access, then they complete an activation process and become an active administrator for a set amount of time. We’ve stopped using permanent administrators for named individual accounts, although we do have some automated service accounts that still use the role.

## Role activation in Azure Active Directory

Azure AD PIM uses administrative roles, such as tenant admin and global admin, to manage temporary access to various roles. With Azure AD PIM, you can manage the administrators by adding or removing permanent or eligible administrators to each role. Azure AD PIM includes several built-in Azure AD roles as well as Azure that we manage.

To activate a role, an eligible admin will initialize Azure AD PIM in the Azure portal and request a time-limited role activation. The activation is requested using the Activate my role option in Azure AD PIM. Users requesting activation must satisfy conditional access policies to ensure that they are coming from authorized devices and locations, and their identities must be verified through multifactor authentication.

To help secure transactions while enabling mobility, we use Azure AD PIM to customize role activation variables in Azure, including the number of sign-in attempts, the length of time the role is activated after sign-in, and the type of credentials required (such as single sign-in or multifactor authentication).

At Microsoft, when an individual joins a team or changes teams, they might need administrative rights for their new business role. For example, someone might join a team in which their user account will require Exchange Online Administrator privileged access rights in the future. That user makes a request, then their manager validates that user’s request, as does a service owner. With those approvals, Core Services Engineering and Operations (CSEO, formerly Microsoft IT) administrators in the Privileged Role Administrator role are notified. A CSEO administrator uses Azure AD PIM via the Azure portal to make that user eligible for that role. The user can then use Azure AD PIM to activate that role.

## Tracking the use of privileged roles using the dashboard

A dashboard through the Azure portal gives a centralized view of:

 -  Alerts that point out opportunities to improve security.
 -  The number of users who are assigned to each privileged role.
 -  The number of eligible and permanent admins.
 -  Ongoing access reviews.

We can track how employees and admins are using their privileged roles by viewing the audit history or by setting up a regular access review. Both options are available through the PIM dashboard in the Azure portal.

The PIM audit log tracks changes in privileged role assignments and role activation history. We use the audit log to view all user assignments and activations within a specified period. The audit history helps us determine, in real time, which accounts haven’t signed in recently, or if employees have changed roles.

Access reviews can be performed by an assigned reviewer, or employees can review themselves. This is an effective way to monitor who still needs access, and who can be removed.

We’re looking at the data that’s collected, and the monitoring team is assessing the best way to configure monitoring alerts to notify us about out-of-band changes—for example, if too many administrator roles are being created for an Azure resource. The information also helps us determine whether our current elevation time settings are appropriate for the various privileged admin roles.

Like all organizations, we want to minimize the number of people who have access to our secure information or resources, because that reduces the chance of a malicious user getting access or an authorized user inadvertently impacting a sensitive resource. However, our people still need to carry out privileged operations in Azure AD, Azure, Microsoft 365, and SaaS apps. We can give users privileged access to Azure resources like Subscriptions, and Azure AD. Oversight is needed for what our users are doing with their admin privileges. We use Azure AD PIM to mitigate the risk of excessive, unnecessary, and misused access rights.

In Azure AD, we use Azure AD PIM to manage the users we assign to built-in Azure AD organizational roles, such as Global Administrator. In Azure, we use Azure AD PIM to manage our users and groups that we assign via Azure RBAC roles, including Owner and Contributor.

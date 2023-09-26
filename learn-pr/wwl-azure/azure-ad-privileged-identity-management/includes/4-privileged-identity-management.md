Privileged Identity Management (PIM) is a service in Azure Active Directory (Azure AD) that enables you to manage, control, and monitor access to important resources in your organization. These resources include resources in Azure AD, Azure, and other Microsoft Online Services such as Microsoft 365 or Microsoft Intune. The following video explains important PIM concepts and features.

## Reasons to use

Organizations want to minimize the number of people who have access to secure information or resources because that reduces the chance of

 -  a malicious actor getting access
 -  an authorized user and inadvertently impacting a sensitive resource

However, users still need to carry out privileged operations in Azure AD, Azure, Microsoft 365, or SaaS apps. Organizations can give users just-in-time privileged access to Azure and Azure AD resources and can oversee what those users are doing with their privileged access.

## License requirements

Using this feature requires Azure AD Premium P2 licenses.

## What does it do?

Privileged Identity Management provides time-based and approval-based role activation to mitigate the risks of excessive, unnecessary, or misused access permissions on resources you care about. Here are some of the key features of Privileged Identity Management:

 -  Provide just-in-time privileged access to Azure AD and Azure resources
 -  Assign time-bound access to resources using start and end dates
 -  Require approval to activate privileged roles
 -  Enforce multi-factor authentication to activate any role
 -  Use justification to understand why users activate
 -  Get notifications when privileged roles are activated
 -  Conduct access reviews to ensure users still need roles
 -  Download audit history for internal or external audit
 -  Prevents removal of the last active Global Administrator and Privileged Role Administrator role assignments

## What can I do with it?

Once you set up Privileged Identity Management, you'll see Tasks, Manage, and Activity options in the left navigation menu. As an administrator, you'll choose between options such as managing Azure AD roles, managing Azure resource roles, or PIM for Groups. When you choose what you want to manage, you see the appropriate set of options for that option.

:::image type="content" source="../media/pim-quickstart-1-ba37b192.png" alt-text="Screenshot showing the Privileged Identity Management Quick start overview page.":::


## Who can do what?

For Azure AD roles in Privileged Identity Management, only a user who is in the Privileged Role Administrator or Global Administrator role can manage assignments for other administrators. Global Administrators, Security Administrators, Global Readers, and Security Readers can also view assignments to Azure AD roles in Privileged Identity Management.

For Azure resource roles in Privileged Identity Management, only a subscription administrator, a resource Owner, or a resource User Access administrator can manage assignments for other administrators. Users who are Privileged Role Administrators, Security Administrators, or Security Readers don't, by default, have access to view assignments to Azure resource roles in Privileged Identity Management.

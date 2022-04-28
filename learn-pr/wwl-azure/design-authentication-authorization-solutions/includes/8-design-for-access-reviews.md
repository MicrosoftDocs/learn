Over the time a user is employed by a company they may have several positions.

:::image type="content" source="../media/employee-access-lifecycle.png" alt-text="Employee hired with no access, first job, second job, employee leaves the company.":::


The Tailwind Traders CTO asks,

- As new employees join, how do we ensure they have the access they need to be productive?

- As users switch teams or leave the company, how do we make sure that their old access is removed?

## Determine the purpose of the access review

You’re considering using [Azure Active Directory access reviews](/azure/active-directory/governance/access-reviews-overview) to address the CTO’s concerns. An access review is a planned review of the access needs, rights, and history of user access. Access reviews mitigate risk by protecting, monitoring, and auditing access to critical assets. 

Access reviews help ensure that the right people have the right access to the right resources. For example, access reviews could be used to review:

- User access to applications integrated with Azure AD for single sign-on (such as SaaS, line-of-business).

- Group memberships (synchronized to Azure AD, or created in Azure AD or Microsoft 365, including Microsoft Teams).

- Access Packages that group resources (groups, apps, and sites) into a single package to manage access.

- Azure AD roles and Azure Resource roles as defined in Privileged Identity Management (PIM).

## Determine who will conduct the reviews

Access reviews are only as good as the person doing the reviewing. Selecting good reviewers is critical to your success. The creator of the access review decides who will conduct the review. This setting can't be changed once the review is started. Reviewers are represented by three personas:

- Resource Owners, who are the business owners of the resource.

- A set of individually selected delegates, as selected by the access reviews administrator.

- End users who will each self-attest to their need for continued access.

When creating an Access Review, administrators can choose one or more reviewers. All reviewers can start and carry out a review, choosing to grant users continued access to a resource or removing them.

## Create an access review plan

Before implementing your access reviews, you should plan the types of reviews relevant to your organization. To do so, you’ll need to make business decisions about what you want to review and the actions to take based on those reviews.

For example, here’s an access review plan for Microsoft Dynamics. 

| **Component**| **Value** |
| - | - |
| **Resources to review**| Access to Microsoft Dynamics |
| **Review frequency**| Monthly |
| **Who conducts the review**| Dynamics business group program managers |
| **Notification**| Email 24 hours prior to review to alias Dynamics-PMs  Include encouraging custom message to reviewers to secure their buy-in |
| **Timeline**| 48 hours from notification |
| **Automatic actions**| Remove access from any account that has no interactive sign-in within 90 days by removing the user from the security group dynamics-access. Perform actions if not reviewed within timeline. |
| **Manual actions**| Reviewers may perform removals approval prior to automated action if desired. |
| **Communications**| Send internal (member) users who are removed an email explaining they’re removed and how to regain access. |

An employee of a company might work in several different roles during their tenure. Each position they hold can require access to different resources or have varying levels of permissions requirements. When an employee is first hired, they need initial access to corporate resources and apps. For each position they hold, they can have specific access requirements and privileges. When the employee leaves the company, their access is removed.

:::image type="content" source="../media/employee-access-lifecycle.png" alt-text="Diagram that shows identity management for an employee from their hire date, to access for specific roles, to their access removed when they leave the company." border="false":::

To ensure employees and users always have the correct access, you can perform an _access review_. An [Microsoft Entra access review](/azure/active-directory/governance/access-reviews-overview) is a planned review of the access needs, rights, and history of user access.

As the Tailwind Traders CTO, you need to determine how you're going to do access reviews for your employees. You ask yourself:

- As new employees join, how can we ensure they have the access they need to be productive?

- As employees switch teams or leave the company, how do we make sure their existing access is removed?

<a name='things-to-know-to-determine-the-purpose-of-the-azure-ad-access-review'></a>

### Things to know to determine the purpose of the Microsoft Entra access review

While you consider how to use Microsoft Entra access reviews for Tailwind Traders, think about the following characteristics of an access review.

- Access reviews mitigate risk by protecting, monitoring, and auditing access to critical assets.
 
- You use access reviews to help ensure the correct users have the correct access to the correct resources.

- Confirm correct user access to apps integrated with Microsoft Entra ID for single sign-on, including SaaS apps and line-of-business apps.

- Verify group memberships that are synchronized to Microsoft Entra ID, or created in Microsoft Entra ID or Microsoft 365, including Microsoft Teams.
   
- Check access packages that group resources (groups, apps, and sites) into a single package to manage access.

- Access reviews can also be used for Microsoft Entra roles and Azure Resource roles as defined in Privileged Identity Management (PIM).

### Determine who will conduct the access reviews

Access reviews are only as good as the person doing the reviewing. Selecting good reviewers is critical to your success. The creator of the access review decides who will conduct the review. This setting can't be changed after the review is started. There are three types of reviewers:

- **Resource owners**: The business owners of a resource.

- **Delegates**: A group of individuals selected by the access reviews admin.

- **End user**: A user who self-attests to their need for continued access.

When you create an access review, admins can choose one or more reviewers. All reviewers can start and carry out a review, and choose to grant the user continued access to a resource or remove their access.

### Things to consider when creating an access review plan

Before you implement access reviews for Tailwind Traders, you should plan the types of reviews that are relevant to your organization. You need to make business decisions about what you want to review and the actions to take based on those reviews.

Review the following implementation scenario of an access review plan for Microsoft Dynamics resources. 

| Access review component | Implementation |
| --- | --- |
| **What are the resources to review** | Microsoft Dynamics resources |
| **How often should the access review be done** | Once a month |
| **Who are the reviewers** | Dynamics business group program managers |
| **How will reviewers be notified** | 24 hours before the start of the review, send email to the alias `Dynamics-PMs@tailwind-traders.org`. Include an encouraging custom message to secure reviewer cooperation. |
| **How long should the review take to complete** | At most, 24 hours, which is 48 hours after the reviewers are first notified. |
| **Are there automatic actions for these resources** | Yes. Automatic actions include: <br>- Remove access for any user account that has had no interactive sign-in within 90 days. <br>- Remove users from the security group `dynamics-access`. <br> - Perform access review actions for any user accounts that aren't reviewed within the specified time to complete. |
| **Are there manual actions available to the reviewers** | Yes. Reviewers can approve user account removals before the automated action is completed, as desired. |
| **How will affected users be notified** | Send email to internal (member) users who are removed, explain their removal, and how they can regain access. 

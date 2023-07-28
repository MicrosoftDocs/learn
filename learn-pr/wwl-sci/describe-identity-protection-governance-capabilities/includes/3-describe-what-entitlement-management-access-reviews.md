
Microsoft Entra access reviews enable organizations to efficiently manage group memberships, access to enterprise applications, and role assignment. Regular access reviews ensure that only the right people have access to resources. Excessive access rights are a known security risk. However, when people move between teams, or take on or relinquish responsibilities, access rights can be difficult to control.

Microsoft Entra enables you to collaborate with users from inside your organization and with external users. Users can join groups, invite guests, connect to cloud apps, and work remotely from their work or personal devices. This convenience has led to a need for better access management capabilities.  

There are many use cases in which Access reviews should be used, here are just a few examples.

- **Too many users in privileged roles**: It's a good idea to check how many users have administrative access and if there are any invited guests or partners that haven't been removed after being assigned to do an administrative task. You can recertify the role assignment of users in Microsoft Entra roles such as Global Administrators, or Azure resources roles such as User Access Administrator in the Microsoft Entra Privileged Identity Management (PIM) experience.
- **Business critical data access**: For certain resources, such as business critical applications, it might be required as part of compliance processes to ask people to regularly reconfirm and give a justification on why they need continued access.
- **To maintain a policy's exception list**: Sometimes there are business cases that require you to make exceptions to policies. As the IT admin, you can manage this task and provide auditors with proof that these exceptions are reviewed regularly.
- **Ask group owners to confirm they still need guests in their groups**: If a group gives guests access to business sensitive content, then it's the group owner's responsibility to confirm the guests still have a legitimate business need for access.
- **Have reviews recur periodically**: You can set up recurring access reviews of users at set frequencies such as weekly, monthly, quarterly or annually, and the reviewers will be notified at the start of each review. Reviewers can approve or deny access with a friendly interface and with the help of smart recommendations.

#### Manage user and guest user access with access reviews

With access reviews, you can easily ensure that users or guests have appropriate access. You can ask the users themselves or a decision maker to participate in an access review and recertify (or attest) to users' access. The reviewers can give their input on each user's need for continued access based on suggestions from Microsoft Entra ID. When an access review is finished, you can then make changes and remove access from users who no longer need it.

#### Multi-stage access reviews
Microsoft Entra Access Reviews support up to three review stages, in which multiple types of reviewers engage in determining who still needs access to company resources. These reviews could be for membership in groups or teams, access to applications, assignments to privileged roles, or access package assignments. When review administrators configure the review for automatic application of decisions, at the end of the review period, access is revoked for denied users.

Multi-stage access reviews allow you and your organization to enable complex workflows to meet recertification and audit requirements calling for multiple reviewers to attest to access for users in a particular sequence. It also helps you design more efficient reviews for your resource owners and auditors by reducing the number of decisions each reviewer is accountable for.

:::image type="content" source="../media/3-access-reviews-invite-users-to-review-access-rights.png" alt-text="Access reviews invite users to review access rights":::

Admins who create access reviews can track progress as the reviewers complete their process. No access rights are changed until the review is finished. You can, however, stop a review before it reaches its scheduled end.  

When the review is complete, it can be set to manually or auto-apply changes to remove access from a group membership or application assignment, except for a dynamic group or a group that originates on-premises.  In those cases, the changes must be applied directly to the group.

Access reviews are a feature of Microsoft Entra Premium licensing.

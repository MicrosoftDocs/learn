Entitlement management is an identity governance feature that enables organizations to manage identity and access lifecycle at scale. Entitlement management automates access request workflows, access assignments, reviews, and expiration.

The following video introduces entitlement management, and how access packages are used to give access to resources.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4JXQr ]

As discussed in the video, enterprise organizations often face challenges when managing employee access to resources such as:

- Users may not know what access they should have, and even if they do, they may have difficulty locating the right individuals to approve it.
- Once users find and receive access to a resource, they may hold on to access longer than is required for business purposes.
- Managing access for external users.

Entitlement management includes the following capabilities to address these challenges:

- Delegate the creation of access packages to non-administrators. These access packages contain resources that users can request. The delegated access package managers then define policies that include rules such as which users can request access, who must approve their access, and when access expires.
- Managing external users. When a user who is not yet in your directory requests access, and is approved, they are automatically invited into your directory and assigned access. When their access expires, if they have no other access package assignments, their B2B account in your directory can be automatically removed.

Entitlement management is a feature of Azure AD Premium.

As you learned in the video, entitlement management uses access packages to manage access to resources.

## Azure AD access reviews

Azure Active Directory (AD) access reviews enable organizations to efficiently manage group memberships, access to enterprise applications, and role assignment. Access reviews also allow user access to be reviewed on a regular basis to ensure that only the right people have access to resources. Excessive access rights are a known security risk. However, when people move between teams, take on or relinquish responsibilities, access rights can be difficult to control.

Access reviews are helpful when:

- You have too many users in privileged roles, such as global administrator.
- When automation is not possible, such as when HR data is not in Azure AD.
- You want to control business critical data access.
- Your governance policies require periodic reviews of access permissions.

Access reviews can be created through Azure AD access reviews, or Azure AD Privileged Identity Management (PIM).  Access reviews can be used to review and manage access for both users and guests. When an access review is created, it can be setup so that each user can review their own access or to have one or more users review everyone's access.  Similarly, for guests, each guest can be asked to review their own access or to have one or more users review every guest’s access.

:::image type="content" source="../media/3-access-reviews-invite-users-to-review-access-rights.png" alt-text="Access reviews invite users to review access rights":::

Admins who create access reviews can track progress as the reviewers complete their reviews. No access rights are changed until the review is complete. You can, however, stop a review before it reaches its scheduled end.  

Once the review is complete it can be set to manually or auto-apply changes to remove access from a group membership or application assignment, except in the case of a dynamic group or a group that originates on-premises.  In those cases, the changes must be applied directly to the group.

Access reviews are a feature of Azure AD Premium P2.

## Azure AD terms of use

Azure AD terms of use allow information to be presented to users, before they access data or an application. Terms of use ensure users read relevant disclaimers for legal or compliance requirements.

Terms of use can be used to require employees or guests to accept terms of use in the following situations:

- Before they gain access to sensitive data or an application.
- On a recurring schedule, so they are reminded of regulations.
- When terms of use are required in different languages.
- Based on user attributes, such as terms applicable to certain roles.
- Presenting terms for all users in your organization.

Terms of use are presented in a PDF format, using content that you create such as an existing contract document. Terms of use can also be presented to users on mobile devices.

Conditional Access policies are used to require a terms of use statement being displayed, and ensuring the user has agreed to those terms prior to being able to access an application. Admins can then view who has agreed to terms of use, and who has declined.

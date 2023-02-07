
Entitlement management is an identity governance feature that enables organizations to manage the identity and access lifecycle at scale. Entitlement management automates access request workflows, access assignments, reviews, and expiration.

The following video introduces entitlement management, and looks at how access packages are used for resources.

> [!VIDEO https://www.microsoft.com/videoplayer/embed/RE4JXQr ]

As discussed in the video, enterprise organizations often face challenges when managing employee access to resources such as:

- Users may not know what access they should have, and even if they do, they might have difficulty locating the right individuals to approve it.
- When users find and receive access to a resource, they may hold on to access longer than is required for business purposes.
- Managing access for external users.

Entitlement management includes the following capabilities to address these challenges:

- Delegate the creation of access packages to non-administrators. These access packages contain resources that users can request. The delegated access package managers then define policies that include rules such as which users can request access, who must approve their access, and when access expires.
- Managing external users. When a user who isn't yet in your directory requests access, and is approved, they're automatically invited into your directory and assigned access. When their access expires, if they have no other access package assignments, their B2B account in your directory can be automatically removed.

Entitlement management, a feature of Azure AD Premium P2, uses access packages to manage access to resources.

## Azure AD access reviews

Azure Active Directory (AD) access reviews enable organizations to efficiently manage group memberships, access to enterprise applications, and role assignment. Regular access reviews ensure that only the right people have access to resources. Excessive access rights are a known security risk. However, when people move between teams, or take on or relinquish responsibilities, access rights can be difficult to control.

Access reviews are helpful when:

- You have too many users in privileged roles, such as global administrator.
- When automation isn't possible, such as when HR data isn't in Azure AD.
- You want to control business critical data access.
- Your governance policies require periodic reviews of access permissions.

Access reviews can be created through Azure AD access reviews, or Azure AD Privileged Identity Management (PIM).  Access reviews can be used to review and manage access for both users and guests. When an access review is created, it can be set up so that each user reviews their own access, or to have one or more users review everyone's access.  Similarly, all guests can be asked to review their own access, or have it looked at by one or more users.

:::image type="content" source="../media/3-access-reviews-invite-users-to-review-access-rights.png" alt-text="Access reviews invite users to review access rights":::

Admins who create access reviews can track progress as the reviewers complete their process. No access rights are changed until the review is finished. You can, however, stop a review before it reaches its scheduled end.  

When the review is complete, it can be set to manually or auto-apply changes to remove access from a group membership or application assignment, except for a dynamic group or a group that originates on-premises.  In those cases, the changes must be applied directly to the group.

Access reviews are a feature of Azure AD Premium P2.

## Azure AD terms of use

Azure AD terms of use allow information to be presented to users, before they access data or an application. Terms of use ensure users read relevant disclaimers for legal or compliance requirements.

Example use cases where employees or guests may be required to accept terms of use include:

- Before they access sensitive data or an application.
- On a recurring schedule, so they're reminded of regulations.
- Based on user attributes, such as terms applicable to certain roles.
- Presenting terms for all users in your organization.

Terms of use are presented in a PDF format, using content that you create, such as an existing contract document. Terms of use can also be presented to users on mobile devices.

Conditional Access policies are used to require a terms of use statement being displayed, and ensuring the user has agreed to those terms before accessing an application. Admins can then view who has agreed to terms of use, and who has declined.

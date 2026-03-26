Entitlement management is an identity governance feature that enables organizations to manage the identity and access lifecycle at scale. Entitlement management automates access request workflows, access assignments, reviews, and expiration.

Enterprise organizations often face challenges when managing workforce access to resources such as:

- Users may not know what access they should have, and even if they do, they might have difficulty locating the right individuals to approve it.
- When users find and receive access to a resource, they may hold on to access longer than is required for business purposes.
- Managing access for external users adds complexity, as no one in the organization might remember to manage all of the external identities' access consistently.

Entitlement management includes the following capabilities to address these challenges:

- Delegate the creation of access packages to nonadministrators. These access packages contain resources that users can request. The delegated access package managers then define policies that include rules such as which users can request access, who must approve their access, and when access expires.
- Manage external users. When a user who isn't yet in your directory requests access, and is approved, they're automatically invited into your directory and assigned access. When their access expires, if they have no other access package assignments, their B2B account in your directory can be automatically removed.
- Give AI agent identities access to resources needed and allow sponsors of the agent identities to make sure access is maintained only while required. Entitlement management now supports governing access for both human and AI agent identities.

Entitlement management uses access packages to manage access to resources. An access package is a bundle of all the resources with the access a user needs to work on a project or perform their task. Access packages can include membership of security groups, Microsoft 365 Groups, enterprise applications, and SharePoint Online sites.

### Microsoft Entra terms of use

Microsoft Entra terms of use allow information to be presented to users, before they access data or an application. Terms of use ensure users read relevant disclaimers for legal or compliance requirements.

Example use cases where employees or guests may be required to accept terms of use include:

- Before they access sensitive data or an application.
- On a recurring schedule, so they're reminded of regulations.
- Based on user attributes, such as terms applicable to certain roles.
- Presenting terms for all users in your organization.

Terms of use are presented in a PDF format, using content that you create, such as an existing contract document. Terms of use can also be presented to users on mobile devices.

Conditional Access policies are used to require a terms of use statement being displayed, and ensuring the user has agreed to those terms before accessing an application. Admins can then view who has agreed to terms of use, and who has declined.

:::image type="content" source="../media/terms-of-use-inline.png" alt-text="Screen capture of a terms of use notification. User must accept the terms of use in order to continue or decline." lightbox="../media/terms-of-use-expanded.png":::

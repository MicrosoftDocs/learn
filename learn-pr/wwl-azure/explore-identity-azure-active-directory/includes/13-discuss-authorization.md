**Authorization** covers what an identity can access and what are they allowed to do once they gain access. Identity authorization provides:

- Methods of assigning entitlement allowing for increased security and less administration
- Ability to manage policy control
- Simplify enforcement by standardizing on a common approach

Authorization is all about giving access to a verified identity, what they should have access to. The tracking and enforcing that access and usage.  With authorization you focus on:

| Authorization concept | Description and usage |
| :----- | :----- |
| Entitlement Type | Entitlements focus on whether or not an identity has been granted (“entitled”) access to a particular resource. As such, entitlements are handled using many different types. The assignment of entitlements happens at the application level, centrally via groups, defined through role based access control or attributes (ABAC) or applied centrally using a policy based (PBAC) approach. |
| Access Policies | Access policies focus on a set of applications, data, and which users and groups can perform activities.  Think of it as the set of rules around getting your job done.  Focus on the least access you need. |
| Enforcement | The enforcement capability focuses on how an organization handles the enforcement of authorization activities. In most cases, organizations handle enforcement at the application layer. Meaning enforcement is completed by an API within the application itself. Some forms of enforcement consist of the use a reverse proxy (such as UAG) to externalize authorization enforcement. A current trend is to use an external policy source (such as XACML) to determine how the identity interacts with the resource. |

### What is authorization?
Authorization (sometimes abbreviated as AuthZ) is used to set permissions that are used to evaluate access to resources or functionality. In contrast, authentication (sometimes abbreviated as AuthN) is focused on proving that an entity like a user or service is indeed who they claim to be. Authorization can include specifying what functionality (or resources) an entity is allowed to access.  Or it focuses on what data that entity can access.  And finally, what they can do with that data. Giving a solid definition of **access control**.

#### Common types of authorization approaches:
- **Access Control Lists (ACLs)** - An explicit list of specific entities who do or don't have access to a resource or functionality.  Offers, fine control over resources, but often difficult to maintain with large groups of users and resources.
- **Role-based access control (RBAC)** - The most common approach to enforcing authorization. Roles are defined to describe the kinds of activities an entity can perform. Grant access to roles rather than to individual entities. An administrator can then assign roles to different entities to control which ones have access to what resources and functionality.
- **Attribute-based access control (ABAC)** - Rules are applied to attributes of the entity, the resources being accessed, and the current environment to determine whether access to some resources or functionality is permitted. An example might be only allowing users who are managers to access files identified with a metadata tag of “managers during working hours only” during the hours of 9AM - 5PM on working days. In this case, access is determined by examining the user’s attribute (status as manager), the resource’s attribute (metadata tag on a file), and also an environment attribute (the current time).
- **Policy-based access control (PBAC)** - A strategy for managing user access to one or more systems, where the business-role of the user is combined with policies to determine what access the user has.

### Authentication Context
A new capability in Microsoft Entra ID that is still in preview.  Authentication context can be used to further secure data and actions in applications. These applications can be your own custom applications, custom line of business (LOB) applications, applications like SharePoint, or applications protected by Microsoft Defender for Cloud Apps. For example, an organization can keep files in SharePoint sites like the lunch menu or their secret BBQ sauce recipe. Everyone has access to the lunch menu site. However, users who have access to the secret BBQ sauce recipe site are required to connect from a managed device. You can even enforce them to agree to specific terms of use.


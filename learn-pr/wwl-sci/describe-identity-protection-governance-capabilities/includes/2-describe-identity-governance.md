Microsoft Entra ID Governance allows you to balance your organization's need for security and employee productivity with the right processes and visibility. As employees' roles change within an organization, you can use Microsoft Entra ID Governance to automatically ensure that the right people have the right access to the right resources, with identity and access process automation, delegation to business groups, and increased visibility.

ID Governance gives organizations the ability to do the following tasks:

- Govern the identity lifecycle.
- Govern access lifecycle.
- Secure privileged access for administration.

These actions can be completed for employees, business partners and vendors, and across services and applications, both on-premises and in the cloud.

It's intended to help organizations address these four key questions:

- Which users should have access to which resources?
- What are those users doing with that access?
- Are there effective organizational controls for managing access?
- Can auditors verify that the controls are working?

### Identity lifecycle

Managing users’ identity lifecycle is at the heart of identity governance.

When planning identity lifecycle management for employees, for example, many organizations model the "join, move, and leave" process. When an individual first joins an organization, a new digital identity is created if one isn't already available. When an individual moves between organizational boundaries, more access authorizations may need to be added or removed to their digital identity. When an individual leaves, access may need to be removed, and the identity might no longer be required, other than for audit purposes.

The diagram that follows shows a simplified version of the identity lifecycle.

:::image type="content" source="../media/2-identify-lifecycle-management-v3.png" alt-text="Diagram showing identity lifecycle for employees. The lifecycle is represented as a circle that starts with no access followed by joining the organization then moving to a new role and then leaving the organization. The cycle repeats.":::

For many organizations, this identity lifecycle for employees is tied to the representation of that user in a human resources (HR) system such as Workday or SuccessFactors. The HR system is authoritative for providing the current list of employees, and some of their properties, such as name or department. Organizations need to automate the process of creating an identity for a new employee that is based on a signal from their HR system so that the employee can be productive on day 1.

In Microsoft Entra ID Governance, you can automate the identity lifecycle of users using:

- Inbound provisioning from your organization's HR sources, to automatically maintain user identities in both Microsoft Entra ID and Active Directory.
- Lifecycle workflows to automate workflow tasks that run at certain key events, such before a new employee is scheduled to start work at the organization, as they change status during their time in the organization, and as they leave the organization.
- Automatic assignment policies in entitlement management to add and remove a user's group memberships, application roles, and SharePoint site roles, based on changes to the user's attributes. Information on entitlement management is covered in a subsequent unit.
- User provisioning to create, update, and remove user accounts in other applications, with connectors to hundreds of cloud and on-premises applications.

In general, managing the lifecycle of an identity is about updating the access that users need, whether through integration with an HR system, or through user provisioning applications.

### Access lifecycle

Access lifecycle is the process of managing access throughout the user’s organizational life. Users require different levels of access from the point at which they join an organization to when they leave it. At various stages in between, they'll need access rights to different resources depending on their role and responsibilities.

Organizations need a process to manage access beyond what was initially provisioned for a user when that user's identity was created. Furthermore, enterprise organizations need to be able to scale efficiently to be able to develop and enforce access policy and controls on an ongoing basis.

With Microsoft Entra ID Governance, IT departments can establish what access rights users should have across various resources, and what enforcement checks are necessary.

Organizations can automate the access lifecycle process through technologies such as dynamic groups. Dynamic groups enable admins to create attribute-based rules to determine membership of groups.
When any attributes of a user or device change, the system evaluates all dynamic group rules in a directory to see if the change would trigger any users to be added or removed from a group. If a user or device satisfies a rule for a group, they're added as a member of that group. If they no longer satisfy the rule, they're removed.

Entitlement management enables organizations to define how users request access across packages of group and team memberships, app roles, and SharePoint Online roles, and enforce separation of duties checks on access requests.

Organizations can regularly review access rights using recurring Microsoft Entra access reviews for access recertification.

### Privileged access lifecycle

Monitoring privileged access is a key part of identity governance. When employees, vendors, and contractors are assigned administrative rights, there should be a governance process because of the potential for misuse.

Microsoft Entra Privileged Identity Management (PIM) provides extra controls tailored to securing access rights. PIM helps you minimize the number of people who have access to resources across Microsoft Entra ID, Azure, and other Microsoft online services. PIM provides a comprehensive set of governance controls to help secure your company's resources.

:::image type="content" source="../media/privileged-access-lifecycle.png" alt-text="Diagram showing the identity access rights lifecycle. The lifecycle is represented as a circle that starts with no admin followed a first admin role then a second admin role then leaving IT.":::

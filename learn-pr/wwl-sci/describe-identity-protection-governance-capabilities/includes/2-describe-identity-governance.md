
Microsoft Entra Identity Governance allows you to balance your organization's need for security and employee productivity with the right processes and visibility. It provides you with capabilities to ensure that the right people have the right access to the right resources.

Identity Governance gives organizations the ability to do the following tasks:

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

When planning identity lifecycle management for employees, for example, many organizations model the "join, move, and leave" process. When an individual first joins an organization, a new digital identity is created if one isn't already available. When an individual moves between organizational boundaries, more access authorizations may need to be added or removed to their digital identity.  When an individual leaves, access may need to be removed, and the identity might no longer be required, other than for audit purposes.

The diagram that follows shows a simplified version of the identity lifecycle.

:::image type="content" source="../media/2-identify-lifecycle-management-v3.png" alt-text="Circular diagram showing identity  lifecycle for employees. The lifecycle starts with no access followed by joining the organization then moving to a new role and then leaving the organization.":::

For many organizations, this identity lifecycle for employees is tied to the representation of that user in a human resources (HR) system such as Workday or SuccessFactors. The HR system is authoritative for providing the current list of employees, and some of their properties, such as name or department.

Microsoft Entra Premium offers integration with cloud-based HR systems.  When a new employee is added to an HR system, Microsoft Entra ID can create a corresponding user account. Similarly, when their properties, such as department or employment status, change in the HR system, synchronization of those updates to Microsoft Entra ID ensures consistency.

Microsoft Entra Premium also includes Microsoft Identity Manager, which can import records from on-premises HR systems such as SAP HCM, Oracle eBusiness, and Oracle PeopleSoft. For more information, see the Microsoft Identity Manager documentation that is listed in the Learn More section of the Summary and resources unit.

In general, managing the lifecycle of an identity is about updating the access that users need, whether through integration with an HR system, or through user provisioning applications.

### Access lifecycle

Access lifecycle is the process of managing access throughout the user’s organizational life. Users require different levels of access from the point at which they join an organization to when they leave it. At various stages in between, they'll need access rights to different resources depending on their role and responsibilities.

Organizations can automate the access lifecycle process through technologies such as dynamic groups.  Dynamic groups enable admins to create attribute-based rules to determine membership of groups.
When any attributes of a user or device change, the system evaluates all dynamic group rules in a directory to see if the change would trigger any users to be added or removed from a group. If a user or device satisfies a rule for a group, they're added as a member of that group. If they no longer satisfy the rule, they're removed.

### Privileged access lifecycle

Monitoring privileged access is a key part of identity governance. When employees, vendors, and contractors are assigned administrative rights, there should be a governance process because of the potential for misuse.

Microsoft Entra Privileged Identity Management (PIM) provides extra controls tailored to securing access rights. PIM helps you minimize the number of people who have access to resources across Microsoft Entra ID, Azure, and other Microsoft online services. PIM provides a comprehensive set of governance controls to help secure your company's resources.  PIM is a feature of Microsoft Entra Premium licensing.

:::image type="content" source="../media/privileged-access-lifecycle.png" alt-text="Circular diagram showing identity access rights lifecycle. The lifecycle starts with no admin followed a first admin role then a second admin role then leaving IT.":::

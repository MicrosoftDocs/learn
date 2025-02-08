Identity and access management (IAM) is the framework of permissions, processes, and systems for ensuring that security principals have correct access to organizational resources. IAM involves managing user identities and controlling their access to systems and data based on predefined roles and permissions.

In your role at a global cycling retailer, you're used to implementing IAM on Google Cloud. You're also accustomed to using role-based access control (RBAC) and policies to create a tightly implemented, least-privilege system. Now, you want to understand the permissions that your recently merged competitor implemented in Azure to assess whether they support your company's security policies.

In this unit, you see how identity and access are managed in Azure and compare that with the familiar methods from your Google Cloud experience.

:::image type="content" source="../media/iam-overview.png" alt-text="Diagram that shows the types of services provided by Microsoft Azure and Google Cloud, with identity and access management highlighted." border="false":::

## IAM mechanisms

IAM includes user authentication, authorization, and account provisioning. Organizations use IAM to help ensure that security principals can perform actions and access only the information that's necessary for their roles. By implementing IAM, organizations can enhance security, streamline compliance with regulations, and improve operational efficiency.

Google Cloud and Azure both provide mechanisms to control access to resources, and both encourage the principle of least privilege. However, there are differences in how the two platforms implement identity and access.

Before we cover the details of access control, let's first compare the terminologies that the platforms use:

| Azure | Google Cloud | Comments |
|---|---|---|
| RBAC | RBAC | Both Azure and Google Cloud use RBAC models, although some details differ. |
| Resource groups | Resource hierarchy | Both systems can group resources for easier management. |
| Microsoft Entra ID accounts | Service accounts | Both systems use security accounts to grant access to resources for users and services. In Azure, the Microsoft Entra ID directory provides flexible options. |
| Policies | Policies | In Google Cloud, resources can inherit policies from higher in the hierarchy to simplify management. Azure has a more flexible policy management system, with fewer limitations on custom roles. |

### Microsoft Entra ID

In Azure, user accounts, service accounts, and other security principals are stored in Microsoft Entra ID. Microsoft Entra ID was formerly known as Azure Active Directory (Azure AD). It's a cloud-based directory service that enables organizations to manage user identities, help secure access to applications and resources, and implement multifactor authentication. By providing a unified platform for managing identities across cloud and on-premises environments, Microsoft Entra ID helps streamline user access while enforcing compliance and security.

In Google Cloud, you can create user accounts and assign them permissions to cloud resources. But there's no equivalent to Microsoft Entra ID.

### Resource groups and resource hierarchies

In Google Cloud, there's a hierarchy of objects that you can use to organize resources and control access. These objects include:

- **Organizations**: Organizations are the largest, root-level object.
- **Folders**: Within each organization, use folders to segregate resources.
- **Projects**: Within each folder, you can create multiple projects. Each project contains the resources that you need to address a single purpose.

In Azure, the largest object that can contain resources is the *subscription*. Within a subscription, use *resource groups* to organize resources according to the access level that you want to assign. All the resources in a group can be managed as a single unit.

### Security accounts for system components

In cloud services, users need identities to authenticate and access services. Similarly, when one system, such as a virtual machine (VM), accesses another, such as a database, it must positively identify itself. Service accounts are security principals that services use to authenticate with each other.

> [!IMPORTANT]
> Good security practices require the regular replacement of the credentials associated with service accounts. When you change the password or other credentials on a service account, you must reconfigure your services with the new details. Making these changes manually can take time.

In Google Cloud, you can assign roles to service accounts to ensure least privilege while enabling the intended functionality. Each Google Cloud project automatically creates a default service account, but you can modify this arrangement to implement more complex security models.

In Azure, service accounts are security principals stored in Microsoft Entra ID. You manage and assign security principals to system components for authentication with others.

Both cloud services also have types of service accounts with automatically managed credentials. Using these accounts reduces the load on your administrators while maintaining best practices for security. In Google Cloud, use *service agents* to create service accounts with automatically rotated credentials. In Azure, the equivalent service accounts are called *managed identities*.

### Policies

In Google Cloud, you can use policies to associate user accounts and service accounts with roles that assign permissions to resources. Policies can be applied at different levels of the hierarchy. For example, when policies are applied to a folder, the lower objects (such as the projects in that folder) inherit the policies.

Azure policies aren't used for role management. Instead, they implement governance. We'll examine them in the next unit.

## Learn more

- [What is identity and access management (IAM)?](/entra/fundamentals/introduction-identity-access-management)
- [What is Microsoft Entra ID?](/entra/fundamentals/whatis)
- [What are managed identities for Azure resources?](/entra/identity/managed-identities-azure-resources/overview)
- [What is Azure Policy?](/azure/governance/policy/overview)

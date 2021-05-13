An Enterprise Agreement (EA) enrollment represents the commercial relationship between Microsoft and how your organization uses Azure. It provides the basis for billing across all your subscriptions and affects the administration of your digital estate. Your EA enrollment is managed via an Azure EA portal. An enrollment often represents an organization's hierarchy, which includes departments, accounts, and subscriptions. This hierarchy represents cost-enrollment groups within an organization.

This module focuses on organizations with EAs that will be deploying into an enterprise-scale architecture. Pay-as-you-go subscriptions, Visual Studio subscriptions, and Cloud Solution Provider (CSP) subscriptions can be used, and guidance will be provided in later revisions.

:::image type="content" source="../media/2-enterprise-agreement.png" alt-text="Diagram that shows an Azure EA enrollment hierarchy." lightbox="../media/2-enterprise-agreement-large.png":::

## Azure EA portal

The Azure EA portal can help to manage hierarchy and reconcile the cost for your EA services. Within the portal, you can create departments, accounts, and subscriptions. You can also create and manage API keys for your enrollment to consume financial data in external systems.

**Departments** help to segment costs into logical groupings and to set a budget or quota at the department level. The quota isn't enforced firmly and is used for reporting purposes.

**Accounts** are organizational units in the Azure EA portal. They're used to manage subscriptions and access reports.

**Subscriptions** are the smallest unit in the Azure EA portal. Subscriptions act as containers for Azure services managed by the account owner. Your organization deploys Azure services into its subscriptions.

## Enterprise user roles

EA enrollment roles link users with their functional role. The users can be used in both the enterprise portal and the Azure portal. These EA portal roles are:

**Enterprise administrator**

This role has the highest level of access and can manage account owners, enterprise admins, and department admins. The account can also view usage across departments and accounts as well as billed and unbilled charges. This role can also manage notification contacts.

**Department administrator**

This role allows you to manage your departments, create new account owners under a department, view usage details for departments that are managed by the department admin, and view cost. Department admins can be granted read-only access. You might have multiple department admins for each enterprise enrollment.

**Account owner**

Account owners can create and manage subscriptions and view usage for subscriptions. Account Owner is the only EA portal role with direct access to all resources in a subscription. This user will be assigned as service admin on the subscription scope.

**Service administrator**

The service admin role has permissions to manage services in the Azure portal and assign users to the co-admin role.

**Notification contact**

This account receives notifications about usage and general communication such as enrollment lifecycle information related to enrollment.

### Enterprise enrollment design recommendations and considerations

Review these design recommendations and considerations for designing your enterprise enrollment:

**Recommendations**

- Only use the authentication type _work or school account_ for all account types. Avoid using the _Microsoft account_ type.
- Set up the notification contact email address to ensure that notifications are sent to an appropriate group mailbox.
- Assign a budget for each account, and establish an alert associated with the budget.
- An organization can have a variety of structures, such as functional, divisional, geographic, matrix, or team structure. Use organizational structure to map your organization structure to your enrollment hierarchy.
- Create a new department for IT if business domains have independent IT capabilities.
- Restrict and minimize the number of account owners within the enrollment to avoid the proliferation of privileged access to subscriptions and associated Azure resources.
- If multiple Azure Active Directory (Azure AD) tenants are used, verify that the account owner is associated with the same tenant as where subscriptions for the account are provisioned.
- Set up enterprise dev/test and production environments at an EA account level to support holistic isolation.
- Don't ignore notification emails sent to the notification account email address. Microsoft sends important EA-wide communications to this account.
- Don't move or rename an EA account in Azure AD.
- Periodically audit the EA portal to review who has access, and avoid using a Microsoft account when possible.

**Considerations**

- The enrollment provides a hierarchical organizational structure to govern the management of subscriptions.
- Multiple environments can be separated at an EA-account level to support holistic isolation.
- There can be multiple admins appointed to a single enrollment.
- Each subscription must have an associated account owner.
- Each account owner will be made a subscription owner for any subscriptions provisioned under that account.
- A subscription can belong to only one account at any given time.
- A subscription can be suspended based on a specified set of criteria.

## Azure AD tenants

An Azure AD tenant provides identity and access management, which is an important part of your security posture. An Azure AD tenant ensures that authenticated and authorized users have access to only the resources for which they have access permissions. Azure AD provides these services to applications and services deployed in Azure and also to services and applications deployed outside of Azure (such as on-premises or third-party cloud providers).

Azure AD is also used by software as a service (SaaS) applications such as Microsoft 365 and Azure Marketplace. Organizations already using on-premises Active Directory can use their existing infrastructure and extend authentication to the cloud by integrating with Azure AD. Each Azure AD directory has one or more domains. A directory can have many subscriptions associated with it but only one Azure AD tenant.

Ask basic security questions during the Azure AD design phase, such as how your organization manages credentials and how it controls human, application, and programmatic access.

### Azure AD tenants design recommendations and considerations

Review these design recommendations and considerations for designing your Azure AD tenants:

**Recommendations**

- Use Azure AD seamless single sign-on based on the selected planning topology.
- If your organization doesn't have an identity infrastructure, start by implementing an Azure AD-only identity deployment. Such deployment with Azure Active Directory Domain Services and Microsoft Enterprise Mobility + Security provides end-to-end protection for SaaS applications, enterprise applications, and devices.
- Multifactor authentication provides another layer of security the second barrier of authentication. Enforce multifactor authentication and conditional access policies for all privileged accounts for greater security.
- Plan for and implement emergency-access or break-glass accounts to prevent tenant-wide account lockout.
- Use Azure AD Privileged Identity Management for identity and access management.
- If dev/test and production are going to be isolated environments from an identity perspective, separate them at a tenant level via multiple tenants.
- Avoid creating a new Azure AD tenant unless there's a strong identity and access management justification and processes are already in place.

**Considerations**

- Multiple Azure AD tenants can function in the same enrollment.

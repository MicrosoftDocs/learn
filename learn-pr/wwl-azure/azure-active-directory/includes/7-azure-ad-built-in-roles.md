
## Azure AD built-in roles

In Azure Active Directory (Azure AD), if another administrator or non-administrator needs to manage Azure AD resources, you assign them an Azure AD role that provides the permissions they need. For example, you can assign roles to allow adding or changing users, resetting user passwords, managing user licenses, or managing domain names.

## All Roles

:::row:::
  :::column:::
    

### **Role**


  :::column-end:::
  :::column:::
    

### **Description**


  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Application Administrator**
  :::column-end:::
  :::column:::
    Users in this role can create and manage all aspects of enterprise applications, application registrations, and application proxy settings. Note that users assigned to this role are not added as owners when creating new application registrations or enterprise applications.This role also grants the ability to consent for delegated permissions and application permissions, with the exception of application permissions for Microsoft Graph.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Application Developer
  :::column-end:::
  :::column:::
    Can create application registrations independent of the Users can register applications setting.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Attack Payload Author
  :::column-end:::
  :::column:::
    Users in this role can create attack payloads but not actually launch or schedule them. Attack payloads are then available to all administrators in the tenant, who can use them to create a simulation.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Attack Simulation Administrator
  :::column-end:::
  :::column:::
    Users in this role can create and manage all aspects of attack simulation creation, launch/scheduling of a simulation, and the review of simulation results. Members of this role have this access for all simulations in the tenant.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Attribute Assignment Administrator
  :::column-end:::
  :::column:::
    Users with this role can assign and remove custom security attribute keys and values for supported Azure AD objects such as users, service principals, and devices.By default, Global Administrator and other administrator roles do not have permissions to read, define, or assign custom security attributes. To work with custom security attributes, you must be assigned one of the custom security attribute roles.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Attribute Assignment Reader
  :::column-end:::
  :::column:::
    Users with this role can read custom security attribute keys and values for supported Azure AD objects.By default, Global Administrator and other administrator roles do not have permissions to read, define, or assign custom security attributes. To work with custom security attributes, you must be assigned one of the custom security attribute roles.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Attribute Definition Administrator
  :::column-end:::
  :::column:::
    Users with this role can define a valid set of custom security attributes that can be assigned to supported Azure AD objects. This role can also activate and deactivate custom security attributes.By default, Global Administrator and other administrator roles do not have permissions to read, define, or assign custom security attributes. To work with custom security attributes, you must be assigned one of the custom security attribute roles.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Authentication Administrator**
  :::column-end:::
  :::column:::
    Assign the Authentication Administrator role to users who need to do the following:

 -  Set or reset any authentication method (including passwords) for non-administrators and some roles. For a list of the roles that an Authentication Administrator can read or update authentication methods, see Who can reset passwords.
    
 -  Require users who are non-administrators or assigned to some roles to re-register against existing non-password credentials (for example, **Multifactor authentication (MFA)** or **Fast ID Online (FIDO)**, and can also revoke remember MFA on the device, which prompts for MFA on the next sign-in.
 -  Perform sensitive actions for some users.
 -  Create and manage support tickets in Azure and the Microsoft 365 admin center.

Users with this role cannot do the following:

 -  Cannot change the credentials or reset MFA for members and owners of a role-assignable group.
    
 -  Cannot manage MFA settings in the legacy MFA management portal or Hardware OATH tokens. The same functions can be accomplished using the Set-MsolUser commandlet Azure AD PowerShell module.


  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Authentication Policy Administrator
  :::column-end:::
  :::column:::
    Assign the Authentication Policy Administrator role to users who need to do the following:

Configure the authentication methods policy, tenant-wide MFA settings, and password protection policy that determine which methods each user can register and use.


Manage Password Protection settings: smart lockout configurations and updating the custom banned passwords list.

Create and manage verifiable credentials.

Create and manage Azure support tickets.

Users with this role cannot do the following:


Cannot update sensitive properties.


Cannot delete or restore users.

Cannot manage MFA settings in the legacy MFA management portal or Hardware OATH tokens.


  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure AD Joined Device Local Administrator
  :::column-end:::
  :::column:::
    This role is available for assignment only as an additional local administrator in Device settings. Users with this role become local machine administrators on all Windows 10 devices that are joined to Azure Active Directory. They do not have the ability to manage devices objects in Azure Active Directory.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure DevOps Administrator
  :::column-end:::
  :::column:::
    Users with this role can manage all enterprise Azure DevOps policies, applicable to all Azure DevOps organizations backed by the Azure AD. Users in this role can manage these policies by navigating to any Azure DevOps organization that is backed by the company's Azure AD. Additionally, users in this role can claim ownership of orphaned Azure DevOps organizations. This role grants no other Azure DevOps-specific permissions (for example, Project Collection Administrators) inside any of the Azure DevOps organizations backed by the company's Azure AD organization.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Azure Information Protection Administrator
  :::column-end:::
  :::column:::
    Users with this role have all permissions in the Azure Information Protection service. This role allows configuring labels for the Azure Information Protection policy, managing protection templates, and activating protection. This role does not grant any permissions in Identity Protection Center, Privileged Identity Management, Monitor Microsoft 365 Service Health, or Office 365 Security and Compliance Center.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Business-to-Consumer (B2C) Identity Experience Framework (IEF) Keyset Administrator
  :::column-end:::
  :::column:::
    User can create and manage policy keys and secrets for token encryption, token signatures, and claim encryption/decryption. By adding new keys to existing key containers, this limited administrator can roll over secrets as needed without impacting existing applications. This user can see the full content of these secrets and their expiration dates even after their creation.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Business-to-Consumer (B2C) Identity Experience Framework (IEF) Policy Administrator
  :::column-end:::
  :::column:::
    Users in this role have the ability to create, read, update, and delete all custom policies in Azure AD B2C and therefore have full control over the Identity Experience Framework in the relevant Azure AD B2C organization. By editing policies, this user can establish direct federation with external identity providers, change the directory schema, change all user-facing content (HyperText Markup Language (HTML), Cascading Style Sheets ( CSS), JavaScript), change the requirements to complete an authentication, create new users, send user data to external systems including full migrations, and edit all user information including sensitive fields like passwords and phone numbers. Conversely, this role cannot change the encryption keys or edit the secrets used for federation in the organization.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Billing Administrator
  :::column-end:::
  :::column:::
    Makes purchases, manages subscriptions, manages support tickets, and monitors service health.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Cloud App Security Administrator
  :::column-end:::
  :::column:::
    Users with this role have full permissions in Defender for Cloud Apps. They can add administrators, add Microsoft Defender for Cloud Apps policies and settings, upload logs, and perform governance actions.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Cloud Application Administrator
  :::column-end:::
  :::column:::
    Users in this role have the same permissions as the Application Administrator role, excluding the ability to manage application proxy. This role grants the ability to create and manage all aspects of enterprise applications and application registrations. Users assigned to this role are not added as owners when creating new application registrations or enterprise applications.This role also grants the ability to consent for delegated permissions and application permissions, with the exception of application permissions for Microsoft Graph.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Cloud Device Administrator
  :::column-end:::
  :::column:::
    Users in this role can enable, disable, and delete devices in Azure AD and read Windows 10 BitLocker keys (if present) in the Azure portal. The role does not grant permissions to manage any other properties on the device.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Compliance Administrator
  :::column-end:::
  :::column:::
    Users with this role have permissions to manage compliance-related features in the Microsoft Purview compliance portal, Microsoft 365 admin center, Azure, and Office 365 Security and Compliance Center. Assignees can also manage all features within the Exchange admin center and create support tickets for Azure and Microsoft 365.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Compliance Data Administrator
  :::column-end:::
  :::column:::
    Users with this role have permissions to track data in the Microsoft Purview compliance portal, Microsoft 365 admin center, and Azure. Users can also track compliance data within the Exchange admin center, Compliance Manager, and Teams and Skype for Business admin center and create support tickets for Azure and Microsoft 365.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Conditional Access Administrator**
  :::column-end:::
  :::column:::
    Users with this role have the ability to manage Azure Active Directory Conditional Access settings.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Customer LockBox Access Approver
  :::column-end:::
  :::column:::
    Manages Microsoft Purview Customer Lockbox requests in your organization. They receive email notifications for Customer Lockbox requests and can approve and deny requests from the Microsoft 365 admin center. They can also turn the Customer Lockbox feature on or off. Only Global Administrators can reset the passwords of people assigned to this role.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Desktop Analytics Administrator
  :::column-end:::
  :::column:::
    Users in this role can manage the Desktop Analytics service. This includes the ability to view asset inventory, create deployment plans, and view deployment and health status.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Directory Readers
  :::column-end:::
  :::column:::
    Users in this role can read basic directory information. This role should be used for:

 -  Granting a specific set of guest users read access instead of granting it to all guest users.
    
 -  Granting a specific set of non-admin users access to Azure portal when "**Restrict access to Azure AD portal to admins only**" is set to "**Yes**".
 -  Granting service principals access to directory where Directory.Read.All is not an option.


  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Directory Synchronization Accounts
  :::column-end:::
  :::column:::
    Do not use. This role is automatically assigned to the Azure AD Connect service, and is not intended or supported for any other use.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Directory Writers
  :::column-end:::
  :::column:::
    Users in this role can read and update basic information of users, groups, and service principals.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Domain Name Administrator
  :::column-end:::
  :::column:::
    Users with this role can manage (**read**, **add**, **verify**, **update**, and **delete**) domain names. They can also read directory information about users, groups, and applications, as these objects possess domain dependencies. For on-premises environments, users with this role can configure domain names for federation so that associated users are always authenticated on-premises. These users can then sign into Azure AD-based services with their on-premises passwords via single sign-on. Federation settings need to be synced via Azure AD Connect, so users also have permissions to manage Azure AD Connect.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Dynamics 365 Administrator
  :::column-end:::
  :::column:::
    Users with this role have global permissions within Microsoft Dynamics 365 Online, when the service is present, as well as the ability to manage support tickets and monitor service health.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Edge Administrator
  :::column-end:::
  :::column:::
    Users in this role can create and manage the enterprise site list required for Internet Explorer mode on Microsoft Edge. This role grants permissions to create, edit, and publish the site list and additionally allows access to manage support tickets.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Exchange Administrator
  :::column-end:::
  :::column:::
    Users with this role have global permissions within Microsoft Exchange Online, when the service is present. Also has the ability to create and manage all Microsoft 365 groups, manage support tickets, and monitor service health.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Exchange Recipient Administrator
  :::column-end:::
  :::column:::
    Users with this role have read access to recipients and write access to the attributes of those recipients in Exchange Online.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    External ID User Flow Administrator
  :::column-end:::
  :::column:::
    Users with this role can create and manage user flows (also called "**built-in**" policies) in the Azure portal. These users can customize HTML/CSS/JavaScript content, change MFA requirements, select claims in the token, manage API connectors and their credentials, and configure session settings for all user flows in the Azure AD organization. On the other hand, this role does not include the ability to review user data or make changes to the attributes that are included in the organization schema. Changes to Identity Experience Framework policies (also known as custom policies) are also outside the scope of this role.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    External ID User Flow Attribute Administrator
  :::column-end:::
  :::column:::
    Users with this role add or delete custom attributes available to all user flows in the Azure AD organization. As such, users with this role can change or add new elements to the end-user schema and impact the behavior of all user flows and indirectly result in changes to what data may be asked of end users and ultimately sent as claims to applications. This role cannot edit user flows.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    External Identity Provider Administrator
  :::column-end:::
  :::column:::
    This administrator manages federation between Azure AD organizations and external identity providers. With this role, users can add new identity providers and configure all available settings (e.g. authentication path, service ID, assigned key containers). This user can enable the Azure AD organization to trust authentications from external identity providers. The resulting impact on end-user experiences depends on the type of organization:

 -  Azure AD organizations for employees and partners: The addition of a federation (e.g. with Gmail) will immediately impact all guest invitations not yet redeemed. See Adding Google as an identity provider for B2B guest users.
    
 -  Azure Active Directory B2C organizations: The addition of a federation (for example, with Facebook, or with another Azure AD organization) does not immediately impact end-user flows until the identity provider is added as an option in a user flow (also called a built-in policy).


  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Global Administrator**
  :::column-end:::
  :::column:::
    Users with this role have access to all administrative features in Azure Active Directory, as well as services that use Azure Active Directory identities like the Microsoft 365 Defender portal, the Microsoft Purview compliance portal, Exchange Online, SharePoint Online, and Skype for Business Online. Furthermore, Global Administrators can elevate their access to manage all Azure subscriptions and management groups. This allows Global Administrators to get full access to all Azure resources using the respective Azure AD Tenant. The person who signs up for the Azure AD organization becomes a Global Administrator. There can be more than one Global Administrator at your company. Global Administrators can reset the password for any user and all other administrators.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Global Administrator**
  :::column-end:::
  :::column:::
    As a best practice, Microsoft recommends that you assign the Global Administrator role to **fewer than five people** in your organization.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Global Reader
  :::column-end:::
  :::column:::
    Users in this role can read settings and administrative information across Microsoft 365 services but can't take management actions. Global Reader is the read-only counterpart to Global Administrator. Assign Global Reader instead of Global Administrator for planning, audits, or investigations. Use Global Reader in combination with other limited admin roles like Exchange Administrator to make it easier to get work done without the assigning the Global Administrator role. Global Reader works with Microsoft 365 admin center, Exchange admin center, SharePoint admin center, Teams admin center, Security center, Compliance center, Azure AD admin center, and Device Management admin center.Users with this role cannot do the following:


 -  Cannot access the Purchase Services area in the Microsoft 365 admin center.
    


  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Groups Administrator**
  :::column-end:::
  :::column:::
    Users in this role can create/manage groups and its settings like naming and expiration policies. It is important to understand that assigning a user to this role gives them the ability to manage all groups in the organization across various workloads like Teams, SharePoint, Yammer in addition to Outlook. Also the user will be able to manage the various groups settings across various admin portals like Microsoft admin center, Azure portal, as well as workload specific ones like Teams and SharePoint admin centers.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Guest Inviter
  :::column-end:::
  :::column:::
    Users in this role can manage Azure Active Directory B2B guest user invitations when the Members can invite user setting is set to **No**.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Helpdesk Administrator
  :::column-end:::
  :::column:::
    Users with this role can change passwords, invalidate refresh tokens, create and manage support requests with Microsoft for Azure and Microsoft 365 services, and monitor service health. Invalidating a refresh token forces the user to sign in again. Whether a Helpdesk Administrator can reset a user's password and invalidate refresh tokens depends on the role the user is assigned. For a list of the roles that a Helpdesk Administrator can reset passwords for and invalidate refresh tokens, see Who can reset passwords.Users with this role **cannot** do the following:


 -  Cannot change the credentials or reset MFA for members and owners of a **role-assignable group**.
    


  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Hybrid Identity Administrator
  :::column-end:::
  :::column:::
    Users in this role can create, manage and deploy provisioning configuration setup from AD to Azure AD using Cloud Provisioning as well as manage Azure AD Connect, Pass-through Authentication (PTA), Password hash synchronization (PHS), Seamless Single Sign-On (Seamless SSO), and federation settings. Users can also troubleshoot and monitor logs using this role.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Identity Governance Administrator
  :::column-end:::
  :::column:::
    Users with this role can manage Azure AD identity governance configuration, including access packages, access reviews, catalogs and policies, ensuring access is approved and reviewed and guest users who no longer need access are removed.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Insights Administrator
  :::column-end:::
  :::column:::
    Users in this role can access the full set of administrative capabilities in the Microsoft Viva Insights app. This role has the ability to read directory information, monitor service health, file support tickets, and access the Insights Administrator settings aspects.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Insights Analyst
  :::column-end:::
  :::column:::
    Assign the Insights Analyst role to users who need to do the following:

 -  Analyze data in the Microsoft Viva Insights app, but can't manage any configuration settings
    
 -  Create, manage, and run queries
 -  View basic settings and reports in the Microsoft 365 admin center
 -  Create and manage service requests in the Microsoft 365 admin center


  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Insights Business Leader
  :::column-end:::
  :::column:::
    Users in this role can access a set of dashboards and insights via the Microsoft Viva Insights app. This includes full access to all dashboards and presented insights and data exploration functionality. Users in this role do not have access to product configuration settings, which is the responsibility of the Insights Administrator role.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Intune Administrator
  :::column-end:::
  :::column:::
    Users with this role have global permissions within Microsoft Intune Online, when the service is present. Additionally, this role contains the ability to manage users and devices in order to associate policy, as well as create and manage groups.This role can create and manage all security groups. However, Intune Administrator does not have admin rights over Office groups. That means the admin cannot update owners or memberships of all Office groups in the organization. However, he/she can manage the Office group that he creates which comes as a part of his/her end-user privileges. So, any Office group (not security group) that he/she creates should be counted against his/her quota of 250.

  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Kaizala Administrator
  :::column-end:::
  :::column:::
    Users with this role have global permissions to manage settings within Microsoft Kaizala, when the service is present, as well as the ability to manage support tickets and monitor service health. Additionally, the user can access reports related to adoption and usage of Kaizala by Organization members and business reports generated using the Kaizala actions.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Knowledge Administrator
  :::column-end:::
  :::column:::
    Users in this role have full access to all knowledge, learning and intelligent features settings in the Microsoft 365 admin center. They have a general understanding of the suite of products, licensing details and has responsibility to control access. Knowledge Administrator can create and manage content, like topics, acronyms and learning resources. Additionally, these users can create content centers, monitor service health, and create service requests.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Knowledge Manager
  :::column-end:::
  :::column:::
    Users in this role can create and manage content, like topics, acronyms and learning content. These users are primarily responsible for the quality and structure of knowledge. This user has full rights to topic management actions to confirm a topic, approve edits, or delete a topic. This role can also manage taxonomies as part of the term store management tool and create content centers.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    License Administrator
  :::column-end:::
  :::column:::
    Users in this role can add, remove, and update license assignments on users, groups (using group-based licensing), and manage the usage location on users. The role does not grant the ability to purchase or manage subscriptions, create or manage groups, or create or manage users beyond the usage location. This role has no access to view, create, or manage support tickets.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Lifecycle Workflows Administrator
  :::column-end:::
  :::column:::
    Assign the Lifecycle Workflows Administrator role to users who need to do the following tasks:

 -  Create and manage all aspects of workflows and tasks associated with Lifecycle Workflows in Azure AD
    
 -  Check the execution of scheduled workflows
 -  Launch on-demand workflow runs
 -  Inspect workflow execution logs


  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Message Center Privacy Reader
  :::column-end:::
  :::column:::
    Users in this role can monitor all notifications in the Message Center, including data privacy messages. Message Center Privacy Readers get email notifications including those related to data privacy and they can unsubscribe using Message Center Preferences. Only the Global Administrator and the Message Center Privacy Reader can read data privacy messages. Additionally, this role contains the ability to view groups, domains, and subscriptions. This role has no permission to view, create, or manage service requests.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Message Center Reader
  :::column-end:::
  :::column:::
    Users in this role can monitor notifications and advisory health updates in Message center for their organization on configured services such as Exchange, Intune, and Microsoft Teams. Message Center Readers receive weekly email digests of posts, updates, and can share message center posts in Microsoft 365. In Azure AD, users assigned to this role will only have read-only access on Azure AD services such as users and groups. This role has no access to view, create, or manage support tickets.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Microsoft Hardware Warranty Administrator
  :::column-end:::
  :::column:::
    Assign the Microsoft Hardware Warranty Administrator role to users who need to do the following tasks:

 -  Create new warranty claims for Microsoft manufactured hardware, like Surface and HoloLens
    
 -  Search and read opened or closed warranty claims
 -  Search and read warranty claims by serial number
 -  Create, read, update, and delete shipping addresses
 -  Read shipping status for open warranty claims
 -  Create and manage service requests in the Microsoft 365 admin center
 -  Read Message center announcements in the Microsoft 365 admin center


  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Microsoft Hardware Warranty Specialist
  :::column-end:::
  :::column:::
    Assign the Microsoft Hardware Warranty Specialist role to users who need to do the following tasks:\-Create new warranty claims for Microsoft manufactured hardware, like Surface and HoloLens
\-Read warranty claims that they created
\-Read and update existing shipping addresses
\-Read shipping status for open warranty claims they created
\-Create and manage service requests in the Microsoft 365 admin center
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Modern Commerce User
  :::column-end:::
  :::column:::
    **Do not use**. This role is automatically assigned from Commerce, and is not intended or supported for any other use. See details below.The Modern Commerce User role gives certain users permission to access Microsoft 365 admin center and see the left navigation entries for Home, Billing, and Support. The content available in these areas is controlled by commerce-specific roles assigned to users to manage products that they bought for themselves or your organization. This might include tasks like paying bills, or for access to billing accounts and billing profiles.
Users with the Modern Commerce User role typically have administrative permissions in other Microsoft purchasing systems, but do not have Global Administrator or Billing Administrator roles used to access the admin center.

  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Network Administrator**
  :::column-end:::
  :::column:::
    Users in this role can review network perimeter architecture recommendations from Microsoft that are based on network telemetry from their user locations. Network performance for Microsoft 365 relies on careful enterprise customer network perimeter architecture which is generally user location specific. This role allows for editing of discovered user locations and configuration of network parameters for those locations to facilitate improved telemetry measurements and design recommendations
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Office Apps Administrator
  :::column-end:::
  :::column:::
    Users in this role can manage Microsoft 365 apps' cloud settings. This includes managing cloud policies, self-service download management and the ability to view Office apps related report. This role additionally grants the ability to manage support tickets, and monitor service health within the main admin center. Users assigned to this role can also manage communication of new features in Office apps.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Organizational Messages Writer
  :::column-end:::
  :::column:::
    Assign the Organizational Messages Writer role to users who need to do the following tasks:

 -  **Write**, **publish**, and **delete** organizational messages using Microsoft 365 admin center or Microsoft Endpoint Manager
    
 -  **Manage** organizational message delivery options using Microsoft 365 admin center or Microsoft Endpoint Manager
 -  **Read** organizational message delivery results using Microsoft 365 admin center or Microsoft Endpoint Manager
 -  **View** usage reports and most settings in the Microsoft 365 admin center, but can't make changes


  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Partner Tier1 Support
  :::column-end:::
  :::column:::
    **Do not use**. This role has been deprecated and will be removed from Azure AD in the future. This role is intended for use by a small number of Microsoft resale partners, and is not intended for general use.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Partner Tier2 Support
  :::column-end:::
  :::column:::
    **Do not use**. This role has been deprecated and will be removed from Azure AD in the future. This role is intended for use by a small number of Microsoft resale partners, and is not intended for general use.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Password Administrator**
  :::column-end:::
  :::column:::
    Users with this role have limited ability to manage passwords. This role does not grant the ability to manage service requests or monitor service health. Whether a Password Administrator can reset a user's password depends on the role the user is assigned.Users with this role **cannot** do the following:


 -  Cannot change the credentials or reset MFA for members and owners of a role-assignable group.
    


  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Permissions Management Administrator
  :::column-end:::
  :::column:::
    Assign the Permissions Management Administrator role to users who need to do the following tasks:

 -  **Manage** all aspects of Entra Permissions Management, when the service is present


  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Power Business Intelligence (BI) Administrator
  :::column-end:::
  :::column:::
    Users with this role have global permissions within Microsoft Power BI, when the service is present, as well as the ability to manage support tickets and monitor service health.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Power Platform Administrator
  :::column-end:::
  :::column:::
    Users in this role can create and manage all aspects of environments, Power Apps, Flows, Data Loss Prevention policies. Additionally, users with this role have the ability to manage support tickets and monitor service health.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Printer Administrator
  :::column-end:::
  :::column:::
    Users in this role can register printers and manage all aspects of all printer configurations in the Microsoft Universal Print solution, including the Universal Print Connector settings. They can consent to all delegated print permission requests. Printer Administrators also have access to print reports.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Printer Technician
  :::column-end:::
  :::column:::
    Users with this role can register printers and manage printer status in the Microsoft Universal Print solution. They can also read all connector information. Key task a Printer Technician cannot do is set user permissions on printers and sharing printers.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Privileged Authentication Administrator
  :::column-end:::
  :::column:::
    Assign the Privileged Authentication Administrator role to users who need to do the following:

 -  **Set** or **reset** any authentication method (including passwords) for any user, including Global Administrators.
    
 -  **Delete** or **restore** any users, including Global Administrators. For more information, see Who can perform sensitive actions.
 -  Force users to re-register against existing non-password credential (such as MFA or FIDO) and revoke remember MFA on the device, prompting for MFA on the next sign-in of all users.
 -  **Update** sensitive properties for all users. For more information, see Who can perform sensitive actions.
 -  **Create** and **manage** support tickets in Azure and the Microsoft 365 admin center.

Users with this role cannot do the following

 -  Cannot manage per-user MFA in the legacy MFA management portal. The same functions can be accomplished using the Set-MsolUser commandlet Azure AD PowerShell module.
    


  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Privileged Role Administrator
  :::column-end:::
  :::column:::
    Users with this role can manage role assignments in Azure Active Directory, as well as within Azure AD Privileged Identity Management. They can create and manage groups that can be assigned to Azure AD roles. In addition, this role allows management of all aspects of Privileged Identity Management and administrative units.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **Privileged Role Administrator**
  :::column-end:::
  :::column:::
    **This role grants the ability to manage assignments for all Azure AD roles including the Global Administrator role**. This role does not include any other privileged abilities in Azure AD like creating or updating users. However, users assigned to this role can grant themselves or others additional privilege by assigning additional roles.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Reports Reader
  :::column-end:::
  :::column:::
    Users with this role can view usage reporting data and the reports dashboard in Microsoft 365 admin center and the adoption context pack in Power Business Intelligence (Power BI). Additionally, the role provides access to all sign-in logs, audit logs, and activity reports in Azure AD and data returned by the Microsoft Graph reporting API. A user assigned to the Reports Reader role can access only relevant usage and adoption metrics. They don't have any admin permissions to configure settings or access the product-specific admin centers like Exchange. This role has no access to view, create, or manage support tickets.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Search Administrator
  :::column-end:::
  :::column:::
    Users in this role have full access to all Microsoft Search management features in the Microsoft 365 admin center. Additionally, these users can view the message center, monitor service health, and create service requests.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Search Editor
  :::column-end:::
  :::column:::
    Users in this role can create, manage, and delete content for Microsoft Search in the Microsoft 365 admin center, including bookmarks, questions and answers, and locations.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Security Administrator
  :::column-end:::
  :::column:::
    Users with this role have permissions to manage security-related features in the Microsoft 365 Defender portal, Azure Active Directory Identity Protection, Azure Active Directory Authentication, Azure Information Protection, and Office 365 Security and Compliance Center.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Security Operator
  :::column-end:::
  :::column:::
    Users with this role can manage alerts and have global read-only access on security-related features, including all information in Microsoft 365 security center, Azure Active Directory, Identity Protection, Privileged Identity Management and Office 365 Security & Compliance Center.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Security Reader
  :::column-end:::
  :::column:::
    Users with this role have global read-only access on security-related feature, including all information in Microsoft 365 security center, Azure Active Directory, Identity Protection, Privileged Identity Management, as well as the ability to read Azure Active Directory sign-in reports and audit logs, and in Office 365 Security and Compliance Center.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Service Support Administrator
  :::column-end:::
  :::column:::
    Users with this role can create and manage support requests with Microsoft for Azure and Microsoft 365 services, and view the service dashboard and message center in the Azure portal and Microsoft 365 admin center.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    SharePoint Administrator
  :::column-end:::
  :::column:::
    Users with this role have global permissions within Microsoft SharePoint Online, when the service is present, as well as the ability to create and manage all Microsoft 365 groups, manage support tickets, and monitor service health.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Skype for Business Administrator
  :::column-end:::
  :::column:::
    Users with this role have global permissions within Microsoft Skype for Business, when the service is present, as well as manage Skype-specific user attributes in Azure Active Directory. Additionally, this role grants the ability to manage support tickets and monitor service health, and to access the Teams and Skype for Business admin center. The account must also be licensed for Teams or it can't run Teams PowerShell cmdlets.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Teams Administrator
  :::column-end:::
  :::column:::
    Users in this role can manage all aspects of the Microsoft Teams workload via the Microsoft Teams and Skype for Business admin center and the respective PowerShell modules. This includes, among other areas, all management tools related to telephony, messaging, meetings, and the teams themselves. This role additionally grants the ability to create and manage all Microsoft 365 groups, manage support tickets, and monitor service health.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Teams Communications Administrator
  :::column-end:::
  :::column:::
    Users in this role can manage aspects of the Microsoft Teams workload related to voice and telephony. This includes the management tools for telephone number assignment, voice and meeting policies, and full access to the call analytics toolset.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Teams Communications Support Engineer
  :::column-end:::
  :::column:::
    Users in this role can troubleshoot communication issues within Microsoft Teams and Skype for Business using the user call troubleshooting tools in the Microsoft Teams and Skype for Business admin center. Users in this role can view full call record information for all participants involved. This role has no access to view, create, or manage support tickets.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Teams Communications Support Specialist
  :::column-end:::
  :::column:::
    Users in this role can troubleshoot communication issues within Microsoft Teams and Skype for Business using the user call troubleshooting tools in the Microsoft Teams and Skype for Business admin center. Users in this role can only view user details in the call for the specific user they have looked up. This role has no access to view, create, or manage support tickets.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Teams Devices Administrator
  :::column-end:::
  :::column:::
    Users with this role can manage Teams-certified devices from the Teams admin center. This role allows viewing all devices at single glance, with ability to search and filter devices. The user can check details of each device including logged-in account, make and model of the device. The user can change the settings on the device and update the software versions. This role does not grant permissions to check Teams activity and call quality of the device.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Tenant Creator
  :::column-end:::
  :::column:::
    Assign the Tenant Creator role to users who need to do the following tasks:

 -  **Create** both Azure Active Directory and Azure Active Directory B2C tenants even if the tenant creation toggle is turned off in the user settings
    


  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Usage Summary Reports Reader
  :::column-end:::
  :::column:::
    Users with this role can access tenant level aggregated data and associated insights in Microsoft 365 admin center for Usage and Productivity Score but cannot access any user level details or insights. In Microsoft 365 admin center for the two reports, we differentiate between tenant level aggregated data and user level details. This role gives an extra layer of protection on individual user identifiable data, which was requested by both customers and legal teams.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **User Administrator**
  :::column-end:::
  :::column:::
    Assign the User Administrator role to users who need to do the following:

 -  Create users
 -  Update most user properties for all users, including all administrators
 -  Update sensitive properties (including user principal name) for some users
 -  Disable or enable some users
 -  Delete or restore some users
 -  Create and manage user views
 -  Create and manage all groups
 -  Assign licenses for all users, including all administrators
 -  Reset passwords
 -  Invalidate refresh tokens
 -  Update (FIDO) device keys
 -  Update password expiration policies
 -  Create and manage support tickets in Azure and the Microsoft 365 admin center
 -  Monitor service health

Users with this role **cannot** do the following:

 -  Cannot manage MFA.
 -  Cannot change the credentials or reset MFA for members and owners of a role-assignable group.
 -  Cannot manage shared mailboxes


  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    **User Administrator**
  :::column-end:::
  :::column:::
    Users with this role can **change passwords** for people who may have access to sensitive or private information or critical configuration inside and outside of Azure Active Directory. Changing the password of a user may mean the ability to assume that user's identity and permissions. For example:

 -  **Application Registration and Enterprise Application owners**, who can manage credentials of apps they own. Those apps may have privileged permissions in Azure AD and elsewhere not granted to User Administrators. Through this path a User Administrator may be able to assume the identity of an application owner and then further assume the identity of a privileged application by updating the credentials for the application.
 -  **Azure subscription owners**, who may have access to sensitive or private information or critical configuration in Azure.
 -  **Security Group and Microsoft 365 group owners**, who can manage group membership. Those groups may grant access to sensitive or private information or critical configuration in Azure AD and elsewhere.
 -  **Administrators in other services outside of Azure AD like Exchange Online**, Office Security and Compliance Center, and human resources systems.
 -  **Non-administrators** like executives, legal counsel, and human resources employees who may have access to sensitive or private information.


  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Virtual Visits Administrator
  :::column-end:::
  :::column:::
    Users with this role can do the following tasks:

 -  Manage and configure all aspects of Virtual Visits in Bookings in the Microsoft 365 admin center, and in the Teams Electronic Health Record (EHR) connector
    
 -  View usage reports for Virtual Visits in the Teams admin center, Microsoft 365 admin center, and PowerBI
 -  View features and settings in the Microsoft 365 admin center, but can't edit any settings


  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Windows 365 Administrator
  :::column-end:::
  :::column:::
    Users with this role have global permissions on Windows 365 resources, when the service is present. Additionally, this role contains the ability to manage users and devices in order to associate policy, as well as create and manage groups.This role can create and manage security groups, but does not have administrator rights over Microsoft 365 groups. That means administrators cannot update owners or memberships of Microsoft 365 groups in the organization. However, they can manage the Microsoft 365 group they create, which is a part of their end-user privileges. So, any Microsoft 365 group (not security group) they create is counted against their quota of 250.
Assign the Windows 365 Administrator role to users who need to do the following tasks:


 -  Manage Windows 365 Cloud PCs in Microsoft Endpoint Manager
    
 -  Enroll and manage devices in Azure AD, including assigning users and policies
 -  Create and manage security groups, but not role-assignable groups
 -  View basic properties in the Microsoft 365 admin center
 -  Read usage reports in the Microsoft 365 admin center
 -  Create and manage support tickets in Azure and the Microsoft 365 admin center


  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Windows Update Deployment Administrator
  :::column-end:::
  :::column:::
    Users in this role can create and manage all aspects of Windows Update deployments through the Windows Update for Business deployment service. The deployment service enables users to define settings for when and how updates are deployed, and specify which updates are offered to groups of devices in their tenant. It also allows users to monitor the update progress.
  :::column-end:::
:::row-end:::
:::row:::
  :::column:::
    Yammer Administrator
  :::column-end:::
  :::column:::
    Assign the Yammer Administrator role to users who need to do the following tasks:

 -  **Manage** all aspects of Yammer
    
 -  **Create**, **manage**, and **restore** Microsoft 365 Groups, but not role-assignable groups
 -  View the hidden members of Security groups and Microsoft 365 groups, including role assignable groups
 -  **Read usage reports** in the Microsoft 365 admin center
 -  **Create** and **manage** service requests in the Microsoft 365 admin center
 -  **View announcements** in the Message center, but not security announcements
 -  **View** service health


  :::column-end:::
:::row-end:::

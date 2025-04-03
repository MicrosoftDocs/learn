
To start using Microsoft Security Copilot, organizations need to take steps to onboard the service and users. These include:

1. Provision Copilot capacity
2. Set up the default environment
3. Assign role permissions

### Provision capacity

Microsoft Security Copilot is sold as a consumptive offering, meaning that customers are billed monthly based on a provisioned capacity that is billed by the hour. The capacity that is provisioned is referred to as a security compute unit (SCU). An SCU is the unit of measure of computing power used to run Copilot in both the standalone and embedded experiences.

Before users can start using Copilot, admins need to provision and allocate capacity. To provision capacity:

- You must have an Azure subscription.
- You need to be an Azure owner or Azure contributor, at a resource group level, as a minimum.
  
    *Keep in mind that a global Microsoft Entra administrator role doesn't necessarily have the Azure owner or Azure contributor role by default. Microsoft Entra role assignments don't grant access to Azure resources. As a global Microsoft Entra administrator, you can enable access management for Azure resources through the Azure portal. For details, see [Elevate access to manage all Azure subscriptions and management groups](/azure/role-based-access-control/elevate-access-global-admin). Once you've enabled access management to Azure resources, you can configure the appropriate Azure role.*

There are two options for provisioning capacity:

- Provision capacity within Security Copilot (recommended) - When you first open Security Copilot as an admin, a wizard guides you through the steps in setting up capacity. The wizard prompts you for information including your Azure subscription, resource group, region, capacity name, and the quantity of SCUs.
- Provision capacity through Azure - The Azure portal now includes Security Copilot as a service. Selecting the service, opens the page where you input information including your Azure subscription, resource group, region, capacity name, and the quantity of SCUs.

> [!NOTE]
> Regardless of the method you choose, you'll need to purchase a minimum of 1 and a maximum of 100 SCUs.

# [Provision through Copilot](#tab/provision-through-copilot)
:::image type="content" source="../media/set-up-capacity-new-v2.png" lightbox="../media/set-up-capacity-new-v2.png" alt-text="Screen capture showing the page for capacity provisioning through Copilot.":::

# [Provision through Azure portal](#tab/provision-through-azure)
:::image type="content" source="../media/set-up-capacity-azure-portal.png" lightbox="../media/set-up-capacity-azure-portal.png" alt-text="Screen capture showing the page for capacity provisioning through Azure.":::

---

Regardless of the approach you choose to provision capacity, the process takes the information and establishes a resource group for the Microsoft Security Copilot service, within your Azure subscription. The SCUs are an Azure resource within that resource group. Deployment of the Azure resource can take a few minutes.

Once admins complete the steps to onboard to Copilot, they can manage capacity by increasing or decreasing provisioned SCUs within the Azure portal or the Microsoft Security Copilot product itself.

Security Copilot provides a usage monitoring dashboard for capacity owners allowing them to track usage over time and make informed decisions about capacity provisioning. The usage monitoring dashboard provides visibility, for a selected workspace, into the number of units used, the specific plugins employed during sessions, and the initiators of those sessions. The dashboard also allows you to apply filters and export usage data seamlessly. The dashboard includes up to 90 days of data.

:::image type="content" source="../media/usage-monitoring-v2.png" lightbox="../media/usage-monitoring-v2.png" alt-text="Screen capture showing the usage monitoring dashboard.":::

### Set up the default environment

To set up the default environment, you need to have, at least, a Security Administrator role.

During the setup of Security Copilot, you're prompted to configure settings. These include:

- SCU capacity - Select the capacity of SCUs previously provisioned. Each workspace must have its own capacity.

- Data storage - When an organization onboards to Copilot, one of the available settings determines where your customer data will be stored. Configuration of the data storage location applies at a workspace level. Microsoft Security Copilot operates in the Microsoft Azure data centers in the European Union (EUDB), the United Kingdom, the United States, Australia and New Zealand, Japan, Canada, and South America.

- Decide where your prompts are evaluated - You can restrict the evaluation within your geo or allow evaluation anywhere in the world.

- Logging audit data in Microsoft Purview - As part of the initial setup and listed under Owner settings in the standalone experience, you can choose to allow Microsoft Purview to process and store admin actions, user actions, and Copilot responses. This includes data from any Microsoft and non-Microsoft Integrations. If you opt in and you already use Microsoft Purview, no further action is needed. If you opt in but aren't already using Purview, you need to follow the Microsoft Purview guides to set up a limited experience. This configuration applies to all workspaces in a tenant.

    :::image type="content" source="../media/owner-settings-logging-audit-data.png" lightbox="../media/owner-settings-logging-audit-data.png" alt-text="Screen capture showing the settings for how you can configure audit logging.":::

- Your organization's data - The admin must also opt in or opt out of data sharing options. These options are part of the initial setup and also listed under Owner settings in the standalone experience and can be configured per workspace. Turn the toggles on or off for any of the following options:

  - Allow Microsoft to capture data from Security Copilot to validate product performance using human review: When turned on, customer data is shared with Microsoft for product improvement. Prompts and responses are evaluated to understand whether the right plugins were selected, if the output is what was expected, how responses, latency, and output format can be improved.

  - Allow Microsoft to capture and human review data from Security Copilot to build and validate Microsoft's security AI model: When turned on, customer data is shared with Microsoft for Copilot AI improvement. Opting in does NOT allow Microsoft to use customer data to train foundational models. Prompts and responses are evaluated to enhance responses and to ensure they're what's expected and useful to you.
  
    For more information about how Microsoft handles your data, see [Data security and privacy](/security-copilot/privacy-data-security).
  
    :::image type="content" source="../media/help-improve-copilot.png" lightbox="../media/help-improve-copilot.png" alt-text="Screen capture showing the settings for how you can configure data sharing to help improve Copilot.":::

- Plugin settings - The admin manages plugins and configures whether to allow Security Copilot to access data from your Microsoft 365 services. These settings are configured per workspace.
  - Configure who can add and manage their own custom plugins and who can add and manage custom plugins for everyone in the organization.
  - Manage plugin availability and restrict access. When enabled, admins decide which new and existing plugins will be available to everyone in your organization, and which will be restricted to owners only.
  - Allow Security Copilot to access data from your Microsoft 365 services. If this option is turned off, your organization won't be able to use plugins that access Microsoft 365 services. Currently, this option is required for use of the Microsoft Purview plugin. Setting and/or changing this setting requires a user with a Copilot owner role or a global Microsoft Entra administrator role.
  
    :::image type="content" source="../media/plugin-settings-no-restrictions.png" lightbox="../media/plugin-settings-no-restrictions.png" alt-text="Screen capture showing the plugin settings and the setting to allow Security Copilot to access data from your Microsoft 365 services.":::

### Role permissions

To ensure that the users can access the features of Copilot, they need to have the appropriate role permissions. Role permissions are configured per workspace.

Permissions can be assigned using Microsoft Entra ID roles or Security Copilot roles. As a best practice, provide the least privileged role applicable for each user.

The Microsoft Entra ID roles are:

- Global administrator
- Security administrator
- Security operator
- Security reader

Although these Microsoft Entra ID roles grant users varying levels of access to Copilot, the scope of these roles extends beyond Copilot. For this reason, Security Copilot introduces two roles that function like access groups but aren't Microsoft Entra ID roles. Instead, they only control access to the capabilities of the Security Copilot platform.

The Microsoft Security Copilot roles are:

- Copilot owner
- Copilot contributor

The Security Administrator and Global Administrator roles in Microsoft Entra automatically inherit Copilot owner access.

:::image type="content" source="../media/role-assignments-new-edited.png" lightbox="../media/role-assignments-new-edited.png" alt-text="Screen capture showing the role assignment settings.":::

Only users that have the global administrator, security administrator, or Copilot owner roles can make role assignments in Copilot by adding/removing members from the Owner and Contributor roles.

A group that admins/owners can include as a member of the Contributor role is the **Recommended Microsoft Security roles** group. This group exists only in Security Copilot and is a bundle of existing Microsoft Entra roles. When you add this group as a member of the Contributor role, all users that are members of the Entra ID roles that are included in the recommended Microsoft Security roles group get access to the Copilot platform. This option provides a quick, secure way to give users in your organization, who already have access to security data used by Copilot through a Microsoft plugin, access to the Copilot platform.

For a detailed listing of the permissions granted for each of these roles, refer to the Assign roles section in [Understand authentication in Microsoft Security Copilot](/security-copilot/authentication).

#### Copilot plugins and role requirements

Your role controls what activities you have access to, such as configuring settings, assigning permissions, or performing tasks. Copilot doesn't go beyond the access you have. Additionally, individual Microsoft plugins may have their own role requirements for accessing the service and data it represents. As an example, an analyst that has been assigned a security operator role or a Copilot workspace contributor role is able to access the Copilot portal and create sessions, but to utilize the Microsoft Sentinel plugin would need an appropriate role like Microsoft Sentinel Reader to access incidents in the workspace. To access the devices, privileges, and policies available through the Microsoft Intune plugin, that same analyst would need another service-specific role like the Intune Endpoint Security Manager role.

Generally speaking, Microsoft plugins in Copilot use the OBO (on behalf of) model – meaning that  Copilot knows that a customer has licenses to specific products and is automatically signed into those products. Copilot can then access the specific products when the plugin is enabled and, where applicable, parameters are configured. Some Microsoft plugins that require setup may include configurable parameters that are used for authentication in-lieu of the OBO model.

Enabling of individual plugins and configuration of plugins is done per workspace.

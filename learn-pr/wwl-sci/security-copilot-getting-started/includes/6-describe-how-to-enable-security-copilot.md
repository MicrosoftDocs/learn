
To start using Microsoft Copilot for Security, organizations need to take steps to onboard the service and users. These include:

1. Provision Copilot capacity
2. Set up the default environment
3. Assign role permissions

### Provision capacity

Microsoft Copilot for Security is sold as a consumptive offering, meaning that customers are billed monthly based on a provisioned capacity that is billed by the hour. The capacity that is provisioned is referred to as a security compute unit (SCU). An SCU is the unit of measure of computing power used to run Copilot in both the standalone and embedded experiences.

Before users can start using Copilot, admins need to provision and allocate capacity. To provision capacity:

- You must have an Azure subscription.
- You must be assigned one of the following roles:
  - Azure owner
  - Azure contributor

There are two options for provisioning capacity:

- Provision capacity within Copilot for Security (recommended)
- Provision capacity through Azure

> [!NOTE]
> Regardless of the method you choose, you will need to purchase a minimum of 1 and a maximum of 100 SCUs.

  ***Provision capacity within Copilot for Security***. When you first open Copilot for Security as an admin, a wizard guides you through the steps in setting up capacity for your organization. The wizard prompts you for information including your Azure subscription, resource group, region, capacity name, and the quantity of SCUs.

   :::image type="content" source="../media/copilot-capacity-provisioning-v2.png" lightbox="../media/copilot-capacity-provisioning-v2.png" alt-text="Screen capture showing the page for capacity provisioning through Copilot.":::

  ***Provision capacity through Azure***. The Azure portal now includes Copilot for Security as a service. Selecting the service, opens the page where you input information including your Azure subscription, resource group, region, capacity name, and the quantity of SCUs.

  :::image type="content" source="../media/azure-capacity-provisioning-v2.png" lightbox="../media/azure-capacity-provisioning-v2.png" alt-text="Screen capture showing the page for capacity provisioning through Azure.":::

Regardless of the approach you choose to provision capacity, the process takes the information and establishes a resource group for the Microsoft Copilot for Security service, within your Azure subscription. The SCUs are an Azure resource within that resource group. Deployment of the Azure resource can take a few minutes.

Once admins complete the steps to onboard to Copilot, they can manage capacity by increasing or decreasing provisioned SCUs within the Azure portal or the Microsoft Copilot for Security product itself. Copilot for Security provides a usage monitoring dashboard for capacity owners allowing them to track usage over time and make informed decisions about capacity provisioning.

:::image type="content" source="../media/usage-monitoring.png" lightbox="../media/usage-monitoring.png" alt-text="Screen capture showing the usage monitoring dashboard.":::

### Set up the default environment

To set up the default environment, you need to have one of the following Microsoft Entra ID roles:

- Global administrator
- Security administrator

During the setup of Copilot for Security, you're prompted to configure settings. These include:

- SCU capacity - Select the capacity of SCUs previously provisioned.

- Data storage - When an organization onboards to Copilot, the admin must confirm the geographic location of the tenant as the customer data collected by the services is stored there. Microsoft Copilot for Security operates in the Microsoft Azure data centers in the European Union (EUDB), the United Kingdom, the United States, Australia and New Zealand, Japan, Canada, and South America.

- Your organization's data - The admin must also opt in or opt out of data sharing options. Turn the toggles on or off for any of the following options:

  - Allow Microsoft to capture data from Copilot for Security to validate product performance using human review: When turned on, customer data is shared with Microsoft for product improvement. Prompts and responses are evaluated to understand whether the right plugins were selected, if the output is what was expected, how responses, latency, and output format can be improved.

  - Allow Microsoft to capture and human review data from Copilot for Security to build and validate Microsoft's security AI model: When turned on, customer data is shared with Microsoft for Copilot AI improvement. Opting in does NOT allow Microsoft to use customer data to train foundational models. Prompts and responses are evaluated to enhance responses and to ensure they're what's expected and useful to you.
  
  - Allow Copilot for Security to access data from your Microsoft 365 services. If this option is turned off, your organization won't be able to use plugins that access Microsoft 365 services. Currently, this option is required for use of the Microsoft Purview plugin. Setting and/or changing this setting requires a user with a Global administrator role.
  
      For more information about how Microsoft handles your data, see [Data security and privacy](/security-copilot/privacy-data-security).
  
    :::image type="content" source="../media/owner-settings-with-microsoft-365-slider.png" lightbox="../media/owner-settings-with-microsoft-365-slider.png" alt-text="Screen capture showing the settings for how you can configure data sharing to help improve Copilot.":::

- Decide where your prompts are evaluated - You can restrict the evaluation within your geo or allow evaluation anywhere in the world. For more information on the list of mapped locations for your geo, see Data security and privacy.

- Roles - You are informed of the required roles that need to be assigned for users in your organization to use Copilot for Security.

### Role permissions

To ensure that the users can access the features of Copilot, they need to have the appropriate role permissions.

  :::image type="content" source="../media/role-assignment.png" lightbox="../media/role-assignment.png" alt-text="Screen capture showing the role assignment settings.":::

Permissions can be assigned using Microsoft Entra ID roles or Copilot for Security roles. As a best practice, provide the least privileged role applicable for each user.

The Microsoft Entra ID roles are:

- Global administrator
- Security administrator
- Security operator
- Security reader

Although these roles grant users varying levels of access to Copilot, the scope of these roles extends beyond Copilot. For this reason, Copilot for Security roles were defined. The Copilot roles are defined and managed within Copilot and grant access only to Copilot for Security features.

The Microsoft Copilot for Security roles are:

- Copilot workspace owner
- Copilot workspace contributor
- Copilot workspace reader

Copilot for Security will add “All Users” in the tenants to the Workspace Contributor Role, by default as part of the first run experience or initial setup.  
- Any user within a licensed tenant (purchased Copilot via the consumption model) will be allowed to create a session/prompt by default.
- If the admin doesn't wish to provide access to everyone in the licensed tenant to be able to run prompts, they can restrict access to run prompts by removing “All users” from the Workspace Contributor Role assignments and adding an existing security group from the Copilot for Security portal.
- All experiences where Copilot for Security is used (embedded or standalone) will follow the updates made by the admin.
-	Admin/Owner permissions are required for any privileged operations like associating the workspace to SCU capacity, owner settings, plugin settings, and more.
-	Provisioning Capacity operations continue to require Azure owner or Azure contributor roles, enabled through Azure IAM.

For a detailed listing of the permissions granted for each of these roles, refer to the Assign roles article in the Summary and resources unit of this module.

Your role controls what activities you have access to, such as configuring settings, assigning permissions, or performing tasks. Copilot doesn't go beyond the access you have. Additionally, individual Microsoft plugins may have their own role requirements for accessing the service and data it represents. As an example, an analyst that has been assigned a security operator role or a Copilot workspace contributor role is able to access the Copilot portal and create sessions, but to utilize the Microsoft Sentinel plugin would need an appropriate role like Microsoft Sentinel Reader to access incidents in the workspace. To access the devices, privileges, and policies available through the Microsoft Intune plugin, that same analyst would need another service-specific role like the Intune Endpoint Security Manager role.

For Microsoft plugins, Copilot uses the OBO (on behalf of) model – meaning that  Copilot knows that a customer has licenses to specific products and is automatically signed into those products. Copilot can then access the specific products when the plugin is enabled and, where applicable, parameters are configured.

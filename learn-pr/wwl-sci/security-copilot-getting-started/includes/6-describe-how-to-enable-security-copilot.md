
To start using Microsoft Copilot for Security, organizations need to ensure the following are configured:

- Licensing
- Assigning role permissions
- Configuring the geographic location for data storage
- Opt-in or opt-out of data sharing

### Licensing

To start using Copilot, your environment must have the following licenses deployed  as a minimal requirement:

- Copilot licensing: Copilot licensing is tenant wide (not per user). If users have the right role permissions and the environment licensing requirements are satisfied they can get access to Copilot.
- Microsoft Entra: To access Copilot, configure settings, or perform tasks, appropriate permissions must be assigned. Role permissions are configured through Microsoft Entra.

The minimal requirements are just that, the minimum requirements. The value really lies in augmenting the data sources used by Copilot. The augmenting of data sources occurs by enabling plugins that widen the insights that are available to Copilot. Use of Microsoft and non-Microsoft plugins generally requires customers to have licenses on the corresponding solutions. More details on plugins are covered in the subsequent module.

### Assign Role permissions

To access the Copilot, configure settings, or perform tasks, appropriate permissions must be assigned. Admins with any of the following roles can perform the task of assigning the appropriate permissions to allow access to Copilot.

- Groups Administrator
- User Administrator
- Privileged Role Administrator
- Global Administrator

For users to access Copilot they must be assigned one of the following roles. The role determines what the user can do within Copilot. As a best practice, provide the least privileged role applicable for each user.

- Global administrator - Global admins can perform all kinds of tasks. They have the keys to the kingdom. The person who signed up your organization for Microsoft Copilot for Security is a global administrator by default and can access to the following administrative, and session creation functionalities:
  - Manage plugins.
  - Opt in or opt out on product improvements and model improvements.
  - Configure Microsoft security product availability for users in the tenant.
- Global reader - A Global reader role is the read-only version of the Global administrator role. Users in this role can read settings and administrative information but can't take management actions. This role has access to the session creation functionality such as asking questions and invoking prompts.
- Security administrator - Security administrators have access to the following administrative and session creation functionalities:
  - Manage plugins.
  - Opt in or opt out on product improvements and model improvements.
  - Configure Microsoft security product availability for users in the tenant.
- Security operator or security reader - Security operators or readers have access to session creation functionality such as asking questions and invoking prompts.

Copilot doesn't go beyond the access you have. Additionally, individual Microsoft plugins may have their own role requirements for accessing the service and data it represents.  

As an example, an analyst that has been assigned a Security Reader role is able to access the Copilot portal, but to utilize the Microsoft Sentinel plugin would need an appropriate role like Microsoft Sentinel Reader to access incidents in the workspace. To access the devices, privileges, and policies available through the Microsoft Intune plugin, that same analyst would need another service-specific role like the Intune Endpoint Security Manager role.

### Configure settings

When an organization onboards to Copilot, the admin (global administrator or security administrator) must configure certain settings. These settings include the preferences associated with custom plugins and data and privacy settings. The settings page is accessed by selecting the home menu icon on the top-right corner of the Copilot landing page and then selecting settings from the side panel that opens.

:::image type="content" source="../media/home-menu-settings.png" lightbox="../media/home-menu-settings.png" alt-text="Screen capture showing the home menu icon that when selected opens a side panel that includes the settings option.":::

#### Preferences

Copilot preferences that can be configured include theme preferences and configuring who can add and manage custom plugins. Theme preferences are configured by the end-user, but only admins can configure who can add and manage plugins, which have a tenant-wide scope. The options are:

- Allow only Global administrators and Security administrators the permission to add and manage plugins.
- Allow anyone with access to Copilot to add and manage custom plugins.

In the case where anyone with access to Copilot can add and manage custom plugins, the user who adds a custom plugin has the option to make it private or available to anyone in the organization.

Any configuration that is required of a custom plugin must be done by the user of that plugin, unless an admin configures it organization-wide.

:::image type="content" source="../media/preferences-v2.png" lightbox="../media/preferences-v2.png" alt-text="Screen capture showing preferences that can be configured. These are theme settings and custom plugin settings.":::

#### Data and privacy

The data and privacy settings is where admins configure options for:

- Data storage
- Your organization's data

***Data storage***. When an organization onboards to Copilot, the admin (global administrator or security administrator) must confirm the geographic location of the tenant as the customer data collected by the services is stored there. This setting is configured by  Microsoft Copilot for Security operates in the Microsoft Azure data centers in the European Union (EUDB), the United Kingdom, the United States, Australia and New Zealand, Japan, Canada, and South America.

:::image type="content" source="../media/secruity-copilot-geo-location.png" alt-text="A screen capture of the Microsoft Copilot for Security setting for geographic location where data is stored.":::

***Your organization's data***. The admin (global administrator or security administrator) must also opt in or opt out of sharing their customer data with Microsoft. Turn the toggles on or off for any of the following options:

- Allow Microsoft to use data gathered to improve Copilot: When turned on, customer data is shared with Microsoft for product improvement. Prompts and responses are evaluated by automatic tools or manual methods to understand:
  
  - Whether the right plugins were selected
  - If the output is what was expected
  - How responses, latency, and output format can be improved

  Sharing this data helps Microsoft personnel to access information faster when addressing bugs and resolving specific issues.

- Allow Microsoft to use data gathered to train the security AI model: When turned on, customer data is shared with Microsoft for Copilot AI improvement. Opting in does NOT allow Microsoft to use customer data to train foundational models. Prompts and responses are evaluated to enhance responses and to ensure they're what's expected and useful to you.

:::image type="content" source="../media/secruity-copilot-data-sharing.png" alt-text="A screen capture of the setting in Copilot for sharing your organization's data. Settings can be enabled or disabled to allow Microsoft to use data gathered to improve Copilot and to train the security AI model.":::

For more information about how Microsoft handles your data, see [Data security and privacy](/security-copilot/privacy-data-security).


===========

To start using Microsoft Copilot for Security, organizations need to take steps to onboard the service and users. These include:

- Provision Copilot capacity
- Set up the default environment
- Assign role permissions

### Provision capacity

Microsoft Copilot for Security is sold as a consumptive offering, meaning that Customers will be billed monthly based on a provisioned capacity that is billed by the hour.  The capacity that is provisioned is referred to as a security compute unit (SCU).  An SCU is the unit of measure of computing power used to run Copilot in both the standalone and embedded experiences.

Before users can start using Copilot, admins need to provision and allocate capacity. To provision capacity, you need to have an Azure subscription.

There are two ways to provision capacity:

- Provision capacity within Copilot
- Provision capacity through Azure

In either case, you must have one of the following Microsoft Entra ID roles to accomplish this task:

- Azure owner
- Azure contributor

***Provision capacity within Copilot***

When you first open Copilot for Security (https://securitycopilot.microsoft.com) as an admin, a wizard will guide you through the steps in setting up capacity for your organization.

1. Sign in to Copilot for Security (https://securitycopilot.microsoft.com).

1. Set up your organization's Azure subscription by entering the following values:

   1. Azure subscription
   1. Resource group
   1. Capacity name
   1. Azure region

1. Select the number of compute units your organization needs.

1. Confirm that you acknowledge and have read the terms and conditions, then select Continue. After creating the capacity, it will take a few minutes to deploy the Azure resource.

After creating the capacity, it will take a few minutes to deploy the Azure resource on the back end.

***Provision capacity through Azure***

- Sign in to the Azure portal.

- Search for Copilot for Security in the list of services, then select Copilot for Security.

- Select Resource groups.

- Select Create.

- Enter the following values:

  - Subscription: Select your Azure subscription.
  - Resource group: Enter a new resource group name.
  - Capacity details: Enter a capacity name.
  - Security compute units: Enter the number of units.

- Confirm that you acknowledge and have read the terms and conditions, then select Review + create.

- Verify that all the information is correct, then select Create. A confirmation page is displayed.

***Manage capacity***

Admins can easily manage capacity by increasing or decreasing provisioned SCUs within the Azure portal or the Security Copilot product itself. Copilot for Security provides a usage monitoring dashboard for capacity owners, allowing them to track usage over time and make informed decisions about capacity provisioning.

### Set up the default environment

To set up the default environment, you need to have one of the following Microsoft Entra ID roles:

- Global administrator
- Security administrator

During the set up of Copilot for Security, you'll be prompted to configure settings.

1. You'll be prompted to select the capacity. Select the capacity you created from the drop-down menu.

1. View the location where your data is stored, then select Continue.

1. Decide where your prompts are evaluated in terms of GPU availability. You can restrict the evaluation within your geo or allow evaluation anywhere in the world. For more information on the list of mapped locations for your geo, see Data security and privacy. Then select Continue.

1. You'll be informed of the required roles that need to be assigned for users in your organization to use Copilot for Security. Select Continue.

1. A confirmation page is displayed. Select Finish.



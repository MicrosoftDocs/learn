
To start using Microsoft Copilot for Security, organizations need to ensure the following are configured:

- Licensing
- Assigning role permissions
- Configuring the geographic location for data storage
- Opt-in or opt-out of data sharing

### Licensing

To start using Copilot, your environment must have the following licenses deployed  as a minimal requirement:

- Copilot licensing: Copilot licensing is tenant wide (not per user). If users have the right role permissions and the environment licensing requirements are satisfied they can get access to Copilot.
- Microsoft Entra Premium 1: To access Copilot, configure settings, or perform tasks, appropriate permissions must be assigned. Role permissions are configured through Microsoft Entra Premium 1.

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

### Select Geography

As an example, an analyst that has been assigned a Security Reader role is able to access the Copilot portal, but to utilize the Microsoft Sentinel plugin would need an appropriate role like Microsoft Sentinel Reader to access incidents in the workspace. To access the devices, privileges, and policies available through the Microsoft Intune plugin, that same analyst would need another service-specific role like the Intune Endpoint Security Manager role.

When an organization onboards to Copilot, the admin (global administrator or security administrator) must confirm the geographic location of the tenant as the customer data collected by the services will be stored there. Microsoft Copilot for Security operates in the Microsoft Azure data centers in the European Union (EUDB), the United Kingdom, the United States, Australia and New Zealand, Japan, Canada, and South America.

:::image type="content" source="../media/secruity-copilot-geo-location.png" alt-text="A screen capture of the Microsoft Copilot for Security setting for geographic location where data is stored.":::

### Opt in or opt out of data sharing

Lastly, the admin (global administrator or security administrator) must also opt-in or opt-out of sharing their customer data with Microsoft. Turn the toggles on or off for any of the following options:

- Allow Microsoft to use data gathered to improve Copilot: When turned on, customer data is shared with Microsoft for product improvement. Prompts and responses are evaluated by automatic tools or manual methods to understand:
  - Whether the right plugins were selected.
  - If the output is what was expected.
  - How responses, latency, and output format can be improved.

    Sharing this data helps Microsoft personnel to access information faster when addressing bugs and resolving specific issues.

- Allow Microsoft to use data gathered to train the security AI model: When turned on, customer data is shared with Microsoft for Copilot AI improvement. Opting in does NOT allow Microsoft to use customer data to train foundational models. Prompts and responses are evaluated to enhance responses and to ensure they're what's expected and useful to you.

    Sharing this data helps Microsoft improve Copilot.

:::image type="content" source="../media/secruity-copilot-data-sharing.png" alt-text="A screen capture of the setting in Copilot for sharing your organization's data. Settings can be enabled or disabled to allow Microsoft to use data gathered to improve Copilot and to train the security AI model.":::

For more information about how Microsoft handles your data, see [Data security and privacy](/security-copilot/privacy-data-security).

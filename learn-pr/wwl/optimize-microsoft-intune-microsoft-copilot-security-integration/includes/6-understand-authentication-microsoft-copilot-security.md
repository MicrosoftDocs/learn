Microsoft Copilot for Security uses on-behalf-of authentication to securely access security-related data via active Microsoft plugins. Specific roles within Copilot for Security must be assigned to individuals or groups to access the platform. Once authenticated, your data access determines which plugins are available, and your role controls what other activities you can perform, such as configuring settings, assigning permissions, and executing tasks.

#### Real-Life scenarios

**Scenario 1: IT Administrator Jane**  
Jane, an IT administrator, is assigned a Copilot for Security role that allows her to configure settings and manage permissions. After authenticating, Jane accesses plugins related to threat intelligence and device management, enabling her to set security policies and monitor threats effectively.

**Scenario 2: Security Analyst John**  
John, a security analyst, is given access to specific security plugins after authentication. His role lets him use tools for incident response and threat hunting, but he can't alter platform settings, ensuring a focused and secure workflow.

### Roles in Copilot for Security vs. Entra and Azure

**Copilot for Security Roles**  
These roles are unique to Copilot for Security, providing access to specific features within the platform.

**Microsoft Entra Roles**  
Entra roles grant access to various Microsoft products and are managed through the Microsoft Entra admin center. For more information, see [Assign Microsoft Entra roles to users](/entra/identity/role-based-access-control/manage-roles-portal).

**Azure IAM Roles**  
Azure IAM roles control access to Azure resources, like Security Capacity Units (SCU) within a resource group. For more information, see [Assign Azure roles](/azure/role-based-access-control/role-assignments-portal).


## Access Copilot for Security platform

After Copilot for Security is [onboarded](/copilot/security/get-started-security-copilot#onboarding-to-copilot-for-security) for your organization, the following roles determine a user's access to the Copilot for Security platform.

### Copilot for Security roles

Copilot for Security introduces two roles that function like access groups but aren't Microsoft Entra ID roles. Instead, they only control access to the capabilities of the Copilot for Security platform.

- Copilot owner
- Copilot contributor

By default, all users in the Microsoft Entra tenant are given **Copilot contributor** access.

### Microsoft Entra roles

The following Microsoft Entra roles automatically inherit **Copilot owner** access.

- Security Administrator
- Global Administrator

## Access the capabilities of Microsoft plugins

Copilot for Security doesn't go beyond the access you have. Each Microsoft plugin has its own role requirements for calling the plugin's service and its data. Verify that you have the proper service roles and licenses assigned to use the capabilities of the Microsoft plugins that are activated.

Consider these examples:

- **Copilot contributor**

   As an analyst, you're assigned **Copilot contributor** access, which gives you access to the Copilot platform with the ability to create sessions. Following the least privilege model, you don't have any Microsoft Entra roles like **Security Administrator**. However, in order to utilize the Microsoft Sentinel plugin, you still need an appropriate role like **Microsoft Sentinel Reader** for Copilot to access incidents in the Microsoft Sentinel workspace. You need another service-specific role like the **Endpoint Security Manager** for Copilot to access the devices, privileges, policies, and postures available through the Intune plugin. For Microsoft Defender XDR, you're assigned a custom role that gives you access to the embedded Copilot for Security experience and Copilot access to Microsoft Defender XDR data.

   For more information on Defender XDR custom roles, see [Microsoft Defender XDR Unified RBAC](/microsoft-365/security/defender/manage-rbac).

- **Microsoft Entra security group**

   Although the **Security Administrator** role inherits access to Copilot and certain plugin capabilities, this role includes :::image type="icon" source="../media/privileged-label.png"::: permissions. Assigning this role purely for Copilot access isn't recommended. Instead, create a security group and add that group to the appropriate Copilot role (Owner or Contributor).

   For more information, see [Best practices for Microsoft Entra roles](/entra/identity/role-based-access-control/best-practices#1-apply-principle-of-least-privilege).

## Access embedded experiences

In addition to the Copilot contributor role, verify the requirements for each Copilot for Security embedded experience to understand what extra roles and licenses are required.

For more information, see [Copilot for Security experiences](/copilot/security/experiences-security-copilot#standalone-and-embedded-experiences).

## Shared sessions

Copilot contributor role is the only requirement for sharing a session link or viewing it from that tenant.

When you share a session link, consider these access implications:

- Copilot for Security needs to access a plugin's service and data to generate a response, but that same access isn't evaluated when viewing the shared session. For example, if you have access to devices and policies in Intune, and the Intune plugin is utilized to generate a response that you share, the recipient of the shared session link doesn't need Intune access to view the full results of the session.
- A shared session contains all the prompts and responses included in the session, whether it was shared after the first prompt or the last.
- Only the user that creates a session controls which Copilot users can access that session. If you receive a link for a shared session from the session creator, you have access. If you forward that link to someone else, it doesn't grant them access.
- Shared sessions are read only.
- Sessions can only be shared with users in the same tenant that have access to Copilot.
- Some regions don't support session sharing via email.
  - `SouthAfricaNorth`
  - `UAENorth`

For more information on shared sessions, see [Navigating Copilot for Security](/copilot/security/navigating-security-copilot#share-a-session).

## Assign roles

The following table illustrates the default access granted to starting roles.

>[!NOTE]
>By default, **Everyone** has **Copilot contributor** access. Consider replacing this broad access with specific users or groups.

| Capability | Copilot owner | Copilot contributor |
|:---|:---|:---|
| [**Create sessions**](/copilot/security/prompting-security-copilot) | Yes | Yes |
| [**Manage personal custom plugins**](/copilot/security/authentication#manage-plugins) | Yes | Default No |
| [**Allow contributors to manage personal custom plugins**](/copilot/security/authentication#manage-plugins) | Yes | No |
| [**Allow contributors to publish custom plugins for the tenant**](/copilot/security/authentication#manage-plugins) | Yes | No |
| [**Upload files**](/copilot/security/authentication#manage-plugins) | Yes | Yes |
| [**Run promptbooks**](/copilot/security/using-promptbooks) | Yes | Yes |
| [**Manage personal promptbooks**](/copilot/security/authentication#manage-promptbooks) | Yes | Yes |
| [**Share promptbooks with tenant**](/copilot/security/authentication#manage-promptbooks) | Yes | Yes |
| [**Update data sharing and feedback options**](/copilot/security/authentication#configure-owner-settings) | Yes | No |
| [**Capacity management**](/copilot/security/authentication#capacity-management) | Yes[*](#capacity-management) | No |
| [**Data evaluation**](/copilot/security/authentication#data-evaluation) | Yes | No |
| [**View usage dashboard**](/copilot/security/manage-usage#monitor-security-compute-units-use) | Yes | No |
| [**Select language**](/copilot/security/supported-languages) | Yes | Yes |

### Assign Copilot for Security access

Assign Copilot roles within Copilot for Security settings.

1. Select the :::image type="icon" source="../media/home-menu-hamburger.png"::: home menu.
1. Select **Role assignment** > **Add members**.
1. Start typing the name of the person or group in the **Add members** dialog box.
1. Select the person or group.
1. Select the Copilot for Security role to assign (Copilot owner or Copilot contributor).
1. Select **Add**.

:::image type="content" source="../media/copilot-role-assignment.png" alt-text="Screenshot showing assigning Copilot roles."  lightbox="../media/copilot-role-assignment.png":::

>[!NOTE]
> We recommend using security groups to assign Copilot for Security roles instead of individual users. This reduces administrative complexity.
>
> **Global Administrator** and **Security Administrator** roles can't be removed from Owner access, but the **Everyone** group is removable from Contributor access. It's also a valid group to add back if you want to. 

Entra role membership is only manageable from the Microsoft Entra admin center. For more information, see [Manage Microsoft Entra user roles](/entra/fundamentals/users-assign-role-azure-portal).

## Configure owner settings

Here are configuration options available to users with the **Copilot owner** role:

- [Manage capacity](/copilot/security/authentication#capacity-management) - security compute unit association and creation
- Data sharing and feedback options
- [Data evaluation](/copilot/security/authentication#data-evaluation) - location options
- [Manage plugins](/copilot/security/authentication#manage-plugins)

:::image type="content" source="../media/copilot-admin-role.png" alt-text="Screenshot showing configuration options in owner settings.":::

### Capacity management

Manage capacity association and geo location evaluation options. Keep in mind, purchasing new security capacity units (SCUs), changing capacity, or associating with a different capacity all require Azure Owner or Contributor access to the capacity resource in the Azure portal.

:::image type="content" source="../media/owner-settings-capacity-association.png" alt-text="Screenshot showing capacity association configuration menu.":::
<br>*Figure shows owner setting for associating SCUs.*

For more information on purchasing SCUs, see [Provision capacity](/copilot/security/get-started-security-copilot#step-1-provision-capacity).

### Data evaluation

Evaluate all prompts for your tenant strictly in your designated geography, or optionally allow Copilot to evaluate prompts anywhere.

:::image type="content" source="../media/owner-settings-evaluation-location.png" alt-text="Screenshot showing the data evaluation geolocation options.":::
<br>*Figure shows owner setting for prompt evaluation location options.*

### Manage plugins

Preinstalled plugins, like **ServiceNow** and **Azure AI Search**, require more setup. When the setup includes configuring authentication, the plugin provider determines the type of authentication. Any plugin with the :::image type="icon" source="../media/gear-setup.png"::: or **Set up** buttons are configured per user. This means all users, including owners, only configure that plugin for themselves.

>[!NOTE]
> Website plugins use anonymous authentication to access content.

In **Preferences**, the following plugin options are configurable:

- control whether other roles can add custom plugins for their sessions
- control whether other roles can publish custom plugins to the tenant
- control whether all roles can upload files

:::image type="content" source="../media/owner-settings-preferences-manage-plugins.png" alt-text="Screenshot showing control options for custom plugins and first party plugins in preview.":::

For more information, see [Manage plugins](/copilot/security/manage-plugins) and [Add a source by uploading a file](/copilot/security/upload-file).

### Manage promptbooks

Promptbook creation is available to all roles, including the ability to publish a custom promptbook for the tenant. Choose whether to publish a promptbook for yourself or the tenant at the time of creation.

For more information, see [Build your own promptbook](/copilot/security/build-promptbooks).

## Multitenant

If your organization has multiple tenants, Copilot for Security can accommodate authentication across them to access security data where Copilot for Security is provisioned. The tenant that is provisioned for Copilot for Security doesn't need to be the tenant that your security analyst logs in from. For more information, see [Navigating Copilot for Security tenant switching](/copilot/security/navigating-security-copilot#home-menu).

### Cross tenant sign-in example

Contoso recently merged with Fabrikam. Both tenants have security analysts, but only Contoso purchased and provisioned Copilot for Security. Angus MacGregor, an analyst from Fabrikam wants to use their Fabrikam credential to use Copilot for Security. Here are the steps to accomplish this access:

1. Ensure Angus MacGregor's Fabrikam account has an external member account in the Contoso tenant.
1. Assign the external member account the necessary roles to access Copilot for Security and the desired Microsoft plugins.
1. Sign in to the Copilot for Security portal with the Fabrikam account.
1. Switch tenants to Contoso.

    :::image type="content" source="../media/tenant-switch.png" alt-text="Screenshot showing Fabrikam account switched to the Contoso tenant.":::

For more information, see [Grant MSSP access](/copilot/security/grant-access-external-users).
The organization you work for wants to increase the efficiency and capabilities of its security analyst to improve security outcomes. In support of that objective, the office of the CISO determined that deploying Microsoft Security Copilot is a key step towards that objective. As the Security administrator for your organization, you're tasked with setting up Copilot.

In this exercise, you go through the first run experience of Security Copilot to provision Copilot with one security compute unit (SCU).

> [!NOTE]
>The environment for this exercise is a simulation generated from the product. As a limited simulation, links on a page may not be enabled and text-based inputs that fall outside of the specified script may not be supported. A pop-up message displays stating, "This feature is not available within the simulation." When this occurs, select OK and continue the exercise steps. 
>:::image type="content" source="../media/simulation-pop-up-error.png" alt-text="Screenshot of pop-up screen indicating that this feature isn't available within the simulation.":::

### Exercise

For this exercise, you're logged in as Avery Howard and you have the global administrator role in Microsoft Entra. You'll work in both the Azure portal and Security Copilot.

This exercise should take approximately **15** minutes to complete.

> [!NOTE]
> When a lab instruction calls for opening a link to the simulated environment, it's recommended that you open the link in a new browser window so that you can simultaneously view the instructions and the exercise environment. To do so, select the right mouse key and select the option.

#### Task: Set role permissions

Before users can start using Copilot, admins need to provision and allocate capacity. To provision capacity:

- You must have an Azure subscription.
- You need to be an Azure owner or Azure contributor, at a resource group level, as a minimum.

In this task, you walk through the process of ensuring you have the appropriate role permissions. This starts by enabling access management for Azure resources.

Why is this needed? As a Global Administrator in Microsoft Entra ID, you might not have access to all subscriptions and management groups in your directory. Microsoft Entra ID and Azure resources are secured independently from one another. That is, Microsoft Entra role assignments don't grant access to Azure resources, and Azure role assignments don't grant access to Microsoft Entra ID. When you elevate your access, you're assigned the User Access Administrator role in Azure at root scope (/). This allows you to view all resources and assign access in any subscription or management group in the directory. For details, see [Elevate access to manage all Azure subscriptions and management groups.](/azure/role-based-access-control/elevate-access-global-admin).

Once you're assigned the User Access Administrator role in Azure, you can assign a user the necessary access to provision SCUs for Copilot. In this exercise only, which is to show you the steps involved, you are assigning yourself the necessary access. The steps that follow guide you through the process.

1. Open the simulated environment by selecting this link: **[Azure portal](https://app.highlights.guide/start/6d7270b9-7187-456a-ac16-97bc227d5c27?token=045faae1-1078-4eac-bf56-e12472eddaf9&link=1&azure-portal=true)**.

1. You start by enabling Access management for Azure resources. To access this setting:
    1. From the Azure portal, select **Microsoft Entra ID**.
    1. From the left navigation panel, expand **Manage**.
    1. From the left navigation panel, scroll down and select **Properties**.
    1. Enable the toggle switch for **Access management for Azure resources**, then select **Save**.

1. Now that you can view all resources and assign access in any subscription or management group in the directory, assign yourself the Owner role for the Azure subscription.
    1. From the blue banner on the top of the page, select **Microsoft Azure** to return to the landing page of the Azure portal.
    1. Select **Subscriptions** then select the subscription listed **Woodgrove - GTP Demos (External/Sponsored)**.
    1. Select **Access control (IAM)**.
    1. Select **Add**, then **Add role assignment**.
    1. From the Role tab, select **Privileged administrator roles**.
    1. Select **Owner**, then select **Next**.
    1. Select **+ Select members**.
    1. Avery Howard is the first name on this list, select the **+** to the right of the name. Avery Howard is now listed under selected members. Select the **Select** button, then select **Next**.
    1. Select **Allow user to assign all roles except privileged administrator roles, Owner, UAA, RBAC (Recommended)**.
    1. Select **Review + assign**, then select **Review + assign** one last time.

As an owner to the Azure subscription, you'll now be able to provision capacity within Copilot.

#### Task: First run experience

When you first open Security Copilot, a wizard guides you through the steps in setting up capacity for your organization and some and initial configuration of settings.

In order to start using Security Copilot, you must provision the capacity, which is defined in terms of security compute units. There are two options for provisioning capacity:

- Provision capacity within Security Copilot (recommended)
- Provision capacity through Azure

For this exercise, you provision capacity through Security Copilot. When you first open Security Copilot (the first run experience), a wizard guides you through the steps in setting up capacity for your organization and the initial configuration of some settings.

1. Open the simulated environment by selecting this link: **[Microsoft Security Copilot](https://app.highlights.guide/start/6d7270b9-7187-456a-ac16-97bc227d5c27?token=045faae1-1078-4eac-bf56-e12472eddaf9&azure-portal=true)**.

1. The first page you see in the wizard is to set up your security capacity.
    1. For any of the fields listed, you can select the information icon for more information.
    1. Azure subscription: From the drop-down, select **Woodgrove - GTP Demos (External/Sponsored)**.
    1. Resource group: From the drop-down, select **RG-1**. Alternatively, you can select **Create a new resource group** and enter resource group name.
    1. Capacity name: The default capacity name is prepopulated. Leave the default capacity name.
    1. Prompt evaluation location [Geo]: From the drop-down, select your region.
    1. You can choose whether you want to select the option, "If this location has too much traffic, allow Copilot to evaluate prompts anywhere in the world (recommended for optimal performance).
    1. Capacity region is set based on location selected.
    1. Security compute: This field is automatically populated with the minimum required SCU units, which is 1. Leave the field with the value of **1**.
    1. Use overage units when needed: You can enable the option for overage units. If the setting is enabled, you can select the option for no limit or set a max-limit by selecting the number of overage units per hour. 
    1. Select the box, **"I acknowledge that I have read, understood, and agree to the Terms and Conditions**.
    1. Select **Continue** on the bottom right corner of the page.
1. Help improve Copilot: You can select the toggle based on your preferences. Select **Continue**.
1. Copilot's access and storage of Microsoft 365 service data: Although there's no setting to configure on this page, it provides guidance on where you can configure the option to share your Microsoft 365 service data Copilot and the implication of not sharing our Microsoft 365 dates with Copilot. Select **Continue**. 
1. Logging audit data in Microsoft Purview: The audit logging feature in Security Copilot uses Microsoft Purview to process and store admin actions, user actions, and Copilot responses. This includes data from any Microsoft and non-Microsoft integrations. You can choose to disable this option. It's important to note that this option is applied to any workspace that is created. Select **Continue**.
1. Copilot access: As part of the initial setup, Copilot gives you the option to add the **Recommended Microsoft Security roles** to the contributor group. If you choose to not add it during the setup, you can add them later. The owners group includes the Global administrator and Security administrator role as Copilot owners, by default. In your production environment, you can change who has access to Copilot, once you've completed the initial setup. Select **Continue**.
1. You're all set! Select **Finish**.
1. Leave the browser tab open for the next task.

#### Task 2: Review owner settings

In the previous task, you provisioned capacity and some initial settings. Now that you completed the first run experience, you'll do some brief navigation within Copilot to view where some of those settings are found and can be updated. More detailed exploration of the Security Copilot standalone experience is covered in a subsequent unit.

1. Select the **Menu** icon ![home menu icon](../media/home-menu-icon.png), which is sometimes referred to as the hamburger icon.
1. Select **Owner settings**. These settings are available to you as a Copilot owner. A Copilot contributor doesn't have access to these menu options.
    1. The Help improve Copilot settings you configured as part of the first run experience can be viewed and modified.
    1. The Logging audit data in Microsoft Purview settings you configured as part of the first run experience can be viewed and modified.
    1. Select the Menu icon to return to the home menu.

1. Select **Plugin settings**.
    1. There are several settings, but of particular interest for this exercise is the setting for Accessing data from Microsoft 365 services. Select the **information icon**.
    1. If not already disabled, toggle the switch so that it's **Disabled**.
    1. To see the impact of this setting disabled:
        1. Select **Microsoft Security Copilot** from breadcrumb (next to the menu icon).
        1. From the prompt bar, select the **sources icon** ![sources icon](../media/sources-icon.png).
        1. Select **Show 13 more** for the Microsoft plugins.
        1. Scroll down until to view the Microsoft Purview plugin. Note how the plugin is greyed out. Select the **information icon**.
        1. Select the **X** to close the plugins window.
        1. Now repeat the steps to access the plugin settings from the home menu and enable the toggle for Accessing data from Microsoft 365 services.
        1. Return to the landing page and select the sources icon to view the status of the Microsoft Purview plugin.

1. Select the Menu icon to return to the home menu.
1. Select **Role assignment**.
    1. Expand owner. Here you can view the members of the Owner group. As mentioned in the previous task, the Global Administrator and Security Administrator role as included by default.
    1. Expand contributor. The recommended security roles are listed, if you included it in the previous task. If not, you can add it in this step.

1. Close the browser tab to close out of this exercise

#### Review

In this exercise, you successfully went through the first run experience that included provisioning capacity for Security Copilot, configured initial settings, and briefly explored where those settings are found and can be updated, in the Copilot user interface. You're now ready to move to the next exercise where you'll explore, in more detail, the core functionality of Microsoft Security Copilot.

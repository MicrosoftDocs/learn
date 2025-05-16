The security administrator for your organization provisioned Copilot. Since you're the senior analyst on the team, the administrator added you as a Copilot owner and asked you to familiarize yourself with the solution.

In this exercise, you explore all the key landmarks in the landing page of the standalone experience of Security Copilot. The tasks are organized by landmark and start with the landmark at the top left corner of the screen (the home menu) and then progress from left to right and top to bottom, but you can choose to go do the tasks in any order, just make sure you access the simulated environment in first step of the first task.

**As you explore, keep in mind that unless otherwise stated, the information displayed and the configuration settings are for the currently selected workspace**. For this exercise, all your exploration is done in the SecurityCopilot_Workspace, which is shown at the top of the page, next to where it says Microsoft Security Copilot.

> [!NOTE]
> The environment for this exercise is a simulation generated from the product. As a limited simulation, links on a page may not be enabled and text-based inputs that fall outside of the specified script may not be supported. A pop-up message displays stating, "This feature isn't available within the simulation." When this occurs, select OK and continue the exercise steps. 
>
>
>:::image type="content" source="../media/simulation-pop-up-error.png" alt-text="Screenshot of pop-up screen indicating that this feature is not available within the simulation.":::


### Exercise

For this exercise, you're logged in as Avery Howard and have the Copilot owner role for the active workspace, SecurityCopilot_Workspace. In this exercise, you explore the standalone experience of Microsoft Security Copilot.

This exercise should take approximately **15** minutes to complete.

> [!NOTE]
> When a lab instruction calls for opening a link to the simulated environment, it is generally recommended that you open the link in a new browser window so that you can simultaneously view the instructions and the exercise environment. To do so, select the right mouse key and select the option.

#### Task: Explore the menu options

In this task, you start your exploration in the home menu. 

1. Open the simulated environment by selecting this link: **[Microsoft Security Copilot](https://app.highlights.guide/start/7608581a-ee3a-4fe0-be03-309a58b78c60?token=045faae1-1078-4eac-bf56-e12472eddaf9&azure-portal=true)**.

1. Select the **Menu** icon ![home menu icon](../media/home-menu-icon.png), which is sometimes referred to as the hamburger icon.

1. Select **My sessions** and note the available options. 
    1. Select recent to view the most recent sessions
    1. Select filter and note the available options, then close the filer.
    1. Select the home menu icon to open the home menu.

1. Select **Promptbook library**. 
    1. Select My promptbooks. A subsequent task dives deeper into promptbooks.
    1. Select Woodgrove.
    1. Select Microsoft.
    1. Select the filter icon, then select **Tag** to view the available options. In this simulation, only the cveid tag is enabled.
        1. Select the Tag drop-down, then scroll-down and select cveid.
        1. Select Apply. Note: If you don't see the Apply button, use your mouse to select the space outside of the drop-down, then select Apply.
        1. To clear that filter, select the X next to cveid.
    1. Select the home menu icon to open the home menu.

1. Select **Owner settings**. These settings are available to you as a Copilot owner. A Copilot contributor doesn't have access to these menu options.

    1. Azure resource links: This section includes information that shows the capacity assigned to the specific workspace. 
        1. Selecting the Switch capacity button opens a window where you as the owner could select another available capacity. For this simulation, there's no other preconfigured capacity.
        1. Alternatively, you could create a new capacity. Select Create a new capacity to explore the parameters, then select Cancel.
        1. Select Cancel again or the X to close the window.
    1. Security Compute units - Copilot runs on SCUs. 
        1. Select Change, to explore the options then select Cancel or X to close the window.
        1. Selecting See usage takes you to the Usage monitoring dashboard. You'll explore that in a subsequent step. If you selected it, return to the home menu and owner settings, there's more to explore here.
    1. Help improve Copilot - Select the information icon next to each configurable item. Configure the toggle buttons as desired
    1. Logging audit data in Microsoft Purview - Review the description. This setting applies to all workspaces for the tenant in which you are using Copilot. Select the information icon next to the toggle for an information tip. Configure as desired.
    1. Files - using File uploads is one of the mechanisms by which you can integrate your organization’s knowledge base as another source of information. Select the drop-down arrow to view options for who can upload files. Configure as desired.
    1. Select the home menu icon to open the home menu.

1. Select **Plugin settings**

    1. For plugins for Security Copilot, select the drop-down for Who can add and manage their own custom plugins to view the available options. Select each available option to see how it impacts the option below.
    1. Select drop-down for Who can add and manage custom plugins for users of this workspace to view the available options. Note, this option is grayed out if Who can add and manage their own custom plugins is set to owners only.
    1. Manage plugin availability and restrict access:
        1. Review the description. Selecting the toggle opens a new window, review the description and enable the toggle. All plugins are restricted to owners only. You can manually change this for each plugin. 
        1. Disable the toggle to remove the restriction.
    1. Accessing data from Microsoft 365 services:
        1. Select the information icon to get information that describes the impact of this setting. With this toggle disabled, the Microsoft Purview plugin is not available to use. To ensure the use of the Purview plugin, this toggle must be enabled. You'll explore this more in the Purview unit. 

1. Select **Role assignment**.
    1. Select Add members, then close.
    1. Expand the Owner and Contributor roles. There are no users in the contributor role.
    1. Select the + Add recommended roles
        1. Review the description and expand each of the roles listed to view details.
        1. Select Add to add the recommended security roles, then select Ok. Once added, users in any of the roles included become Copilot contributors.
    1. Select the home menu icon to open the home menu.

1. Select **Manage workspaces**
    1. There's only one workspace available. Select the button on the top right corner of page that says + New workspace to view the parameters required. There's a subsequent exercise in this module that explores this option in more detail. Select Cancel.

1. Select **Usage monitoring**.
    1. Hovering over any of the blue bars in the bar graph opens a small window with information.
    1. Note the information available for each session.
    1. There are several options for filtering on the usage monitoring dashboard
        1. You can filter by date. Select the drop-down next to where it says Last 24 hours to view the available options.
        1. Other filtering options are available by selecting the filter icon next to the date filter. This opens many other filter options, including Users, Plugins used, type, and category. Expand each to view available options. For this simulation, filter options won't be applied. Select Cancel.
    1. Select the home menu icon to open the home menu.

1. Select **Settings**.
    1. Select preferences. Scroll down to view available options.
    1. Select data and privacy.
    1. Select About.
    1. Select the X to close the preferences window.

1. Select where it says **Woodgrove** at the bottom left of the home menu.
    1. When you select this option, you see your tenants. This option is referred to as the tenant switcher. In this case, Woodgrove is the only available tenant.
    1. Select the **Home** to return to the landing page.

1. Keep the browser tab open for the next task.

#### Task: Explore Prompts to try

In this task, you start exploration in the center portion of the landing page, where it says Prompts to try.

1. If you previously closed the browser tab, reopen the simulated environment by selecting this link: **[Microsoft Security Copilot](https://app.highlights.guide/start/7608581a-ee3a-4fe0-be03-309a58b78c60?token=045faae1-1078-4eac-bf56-e12472eddaf9&azure-portal=true)**.

1. Note the options available beneath where it says Prompts to try. Here you can search for prompts or promptbooks, and based on the option you select you can filter for a specific role and/or plugin. In this simulation, you can filter for role or plugin. Filtering for both role and plugin is limited to the SOC Analyst role and the Microsoft Sentinel Plugin. Also, running a prompt or promptbook is not enabled. You will run prompts and promptbooks is subsequent exercises.
1. Select **Prompts** to view available prompts. Selecting a prompt automatically updates the information displayed in the prompt bar. Select X to cancel. 
1. Select the title or Get started button on promptbook to view the prompts included in that promptbook. To exit out of that promptbook, select Microsoft Security Copilot from the breadcrumb.
1. Keep the browser tab open for the next task.

#### Task: Explore the prompts and sources icon in the prompt bar

At the bottom center of the page is the prompt bar. The prompt bar includes the prompts and sources icon, which you explore in this task. In subsequent exercises, you enter inputs directly in the prompt bar.

1. If you previously closed the browser tab, reopen the simulated environment by selecting this link: **[Microsoft Security Copilot](https://app.highlights.guide/start/7608581a-ee3a-4fe0-be03-309a58b78c60?token=045faae1-1078-4eac-bf56-e12472eddaf9&azure-portal=true)**.

1. From the prompt bar, you can select the prompts icon to select a built-in prompt or a promptbook. Select the **prompts icon** ![prompts icon](../media/prompt-icon.png).
    1. Select **See all promptbooks**
        1. Scroll to view all the available promptbooks.
        1. Select the **back-arrow** next to the search bar to go back.
    1. Select **See all system  capabilities**. The list shows all available system capabilities (these capabilities are in effect prompts that you can run). Many system capabilities are associated with specific plugins and as such they're only listed if the corresponding plugin is enabled.
        1. Scroll to view all the available promptbooks.
        1. Select the **back-arrow** next to the search bar to go back.

1. Select the **sources icon** ![sources icon](../media/sources-icon.png).
    1. The **Manage sources** window opens. From here, you can access Plugins or Files. The **Plugins** tab is selected by default.
        1. Select whether you want to view all plugins, the plugins that are enabled (on), the plugins that are disabled (off), or the plugins that are not set up.
        1. Expand/collapse list of Microsoft, non-Microsoft, and custom plugins.
        1. Some plugins require configuring parameters. Select the **Set up** button for the Microsoft Sentinel plugin, to view the settings window. Select **cancel** to close the settings window. In a separate exercise, you configure the plugin.
    1. You should still be in the **Manage sources** window. Select **Files**.
        1. Review the description.
        1. Files can be uploaded and used as a knowledge base by Copilot. In a subsequent exercise, you work with file uploads.
        1. Select **X** to close the **Manage sources** window.

1. Keep the browser tab open for the next task.

#### Task:  Explore the help feature

At the bottom right corner of the window is the help icon where you can easily access documentation and find solutions to common problems. From the help icon, you also submit a support case to the Microsoft support team if you have the appropriate role permissions.

1. Select the **Help (?)** icon.
    1. Select **Documentation**. This selection opens a new browser tab to the Security Copilot documentation. Return to the Microsoft Security Copilot browser tab. Close the newly opened tab and return the Microsoft Security Copilot tab.
    1. Select **Training**. This selection opens a new browser tab to the YouTube channel for Microsoft Security Copilot Instructional Demo Videos. Close the newly opened tab and return the Microsoft Security Copilot tab.
    1. Select **Help**.
        1. Anyone with access to Security Copilot can access the self help widget by selecting the help icon. The help page opens to the search option. Here you can find solutions to common problems by entering something about the problem. For this simulation, enter **Describe Security Copilot** then select **Get Help**.
        1. Users with a minimum role of Service Support Administrator or Helpdesk Administrator role can submit a support case to the Microsoft support team. If you have this role, a headset icon is displayed. Close the contact support page.

#### Review

In this exercise, you explored Microsoft Security Copilot standalone experience. You explored the key landmarks of Copilot landing page including the owner settings, your past sessions, prompts and promptbooks, and the help option.